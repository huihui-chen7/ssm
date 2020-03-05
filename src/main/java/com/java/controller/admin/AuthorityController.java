package com.java.controller.admin;

import com.github.pagehelper.PageInfo;
import com.java.pojo.OneMenu;
import com.java.service.AuthorityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * description：
 * author：丁鹏
 * date：16:44
 */
@Controller
@RequestMapping("/authority")
public class AuthorityController {

    @Autowired
    private AuthorityService authorityService;

    /**
     * 登录
     * @param username
     * @param password
     * @param session
     * @return
     */
    @RequestMapping("/login.do")
    public String login(String username, String password, HttpSession session){
        boolean flag = authorityService.findLogin(username, password,session);
        if(flag){
            return "redirect:/pages/admin/index.jsp";
        }else{
            return "redirect:/pages/admin/login.jsp";
        }
    }

    /**
     * 点击“角色信息管理”二级菜单时
     * @param pageNum
     * @param pageSize
     * @return
     */
    @RequestMapping("/toRoleList.do")
    public String toRoleList(@RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize,
                             Model model){
        //1、调用业务层，查询所有角色信息
        List<Map<String, Object>> roleList = authorityService.findRoleList(pageNum, pageSize);
        PageInfo<Map<String, Object>> pageInfo = new PageInfo<>(roleList);
        //2、将数据保存到model中去
        model.addAttribute("pageInfo",pageInfo);
        //3、带授权信息过去  List<OneMenu>
        List<OneMenu> ptAuthList = authorityService.findPTAuthority();
        model.addAttribute("ptAuthList",ptAuthList);
        return "/pages/admin/user/roleList.jsp";
    }

    /**
     * 添加角色
     * @return
     */
    @RequestMapping("/addRole.do")
    public @ResponseBody boolean addRole(String roleName,String roleStatus,String authIdStr){
        try {
            return authorityService.saveRole(roleName,roleStatus,authIdStr);
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 查看指定id角色拥有的所有信息,包括权限信息
     * @param roleId
     * @return
     */
    @RequestMapping("/getRoleDetailInfo.do")
    public @ResponseBody Map<String,Object> getRoleDetailInfo(Long roleId){
        return authorityService.findRoleDetailInfo(roleId);
    }

    /**
     * 编辑角色信息，将数据保存到数据库中去
     * @param role_name
     * @param roleStatus
     * @param roleId
     * @param authIdStr
     * @return
     */
    @RequestMapping("/updateRoleInfo.do")
    public @ResponseBody  boolean updateRoleInfo(String role_name,String roleStatus,Long roleId,String authIdStr){
        try {
            return authorityService.modifyRoleInfo(role_name,roleStatus,roleId,authIdStr);
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 点击系统后台中的添加用户菜单按钮，跳转到addUser.jsp页面
     * @return
     */
    @RequestMapping("/toAddUserPage.do")
    public String toAddUserPage(Model model){
        //调用业务层，将数据带过去
        model.addAttribute("roleList",authorityService.findRoles());
        return "/pages/admin/user/addUser.jsp";
    }

    /**
     * 添加系统用户，并且给系统用户授予角色
     * @return
     */
    @RequestMapping("/addSystemUser.do")
    public String addSystemUser(String username,String pwd,String useStatus,Long roleId){
        //调用业务层保存数据
        boolean flag = authorityService.saveSystemUser(username, pwd, useStatus, roleId);
        if(flag){
            return "/pages/admin/user/userInfoList.jsp";
        }else{
            return "redirect:/authority/toAddUserPage.do";
        }
    }

}
