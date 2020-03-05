package com.java.service.impl;

import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.github.pagehelper.PageHelper;
import com.java.mapper.AuthorityMapper;
import com.java.pojo.OneMenu;
import com.java.service.AuthorityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * description：
 * author：丁鹏
 * date：16:35
 */
@Service
@Transactional(readOnly = false)
public class AuthorityServiceImpl implements AuthorityService{

    @Autowired
    private AuthorityMapper authorityMapper;

    @Override
    public boolean findLogin(String username, String password, HttpSession session) {
        //数据格式判断
        if(username==null || StrUtil.isBlank(username) || password==null || StrUtil.isBlank(password))
            return false;
        //1、判断登录是否成功
        int flag = authorityMapper.selectIsLoginSuccess(username, SecureUtil.md5(password));
        //2、如果成功则查询此用户拥有的权限
        if(flag==1){
            List<OneMenu> oneMenuList = authorityMapper.selectAuthority(username, SecureUtil.md5(password));
            //3、将权限数据存放到session域中
            session.setAttribute("oneMenuList",oneMenuList);
            return true;
        }
        //如果失败，则立马终止代码，返回false。
        return false;
    }

    @Override
    public List<Map<String, Object>> findRoleList(Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        return authorityMapper.selectRoleList();
    }

    @Override
    public List<OneMenu> findPTAuthority() {
        return authorityMapper.selectPTAuthority();
    }

    @Override
    public boolean saveRole(String roleName, String roleStatus, String authIdStr) throws Exception {
        //1、判断数据是否满足格式要求
        if(roleName==null || roleStatus==null || authIdStr==null){
            return false;
        }
        //2、判断数据的格式
        ///3、判断roleName是否已经存在
        //4、首先往角色表中插入数据，然后获取roleId
        Map<String,Object> paramMap = new HashMap<>();
        paramMap.put("roleName",roleName);
        paramMap.put("roleStatus",roleStatus);
        int flag1 = authorityMapper.insertRole(paramMap);
        if(flag1!=1){//角色插入失败
            return false;
        }
        //5、连环插
        //1)获取roleId
        Long roleId = (Long) paramMap.get("roleId");
        //2)将authIdStr="1,7,1,8,1,9,1,"去重
        String[] authIdArr = authIdStr.split(",");
        List<String> authIdArrList = Arrays.asList(authIdArr);
        Set<String> tempSet = new HashSet<>();
        tempSet.addAll(authIdArrList);
        //将set转数组
        Object[] objects = tempSet.toArray();
        int flag2 = authorityMapper.insertManyRoleAuth(roleId,objects);
        if(flag2>=1){
            return true;
        }else{
            throw new Exception("连环插失败了");
        }
    }

    @Override
    public Map<String, Object> findRoleDetailInfo(Long roleId) {
        //查询角色的基本信息
        Map<String, Object> roleInfoMap  = authorityMapper.selectRoleInfo(roleId);
        //查询某个角色的权限信息
        List<Long> roleAuthList = authorityMapper.selectRoleOwnAuth(roleId);
        //将两个查询的结果综合
        roleInfoMap.put("roleAuthList",roleAuthList);
        return roleInfoMap;
    }

    @Override
    public boolean modifyRoleInfo(String role_name, String roleStatus, Long roleId, String authIdStr) throws Exception {
        //1、修改system_roles表中角色的基本信息
        int flag1 = authorityMapper.updateRoleById(role_name, roleStatus, roleId);
        //2、删除role_auth角色权限中间表中的映射关系
        int flag2 = authorityMapper.deleteRoleAuthRelation(roleId);
        //3、添加角色与权限的映射关系
        //将authIdStr="1,7,1,8,1,9,1,"去重
        String[] authIdArr = authIdStr.split(",");
        List<String> authIdArrList = Arrays.asList(authIdArr);
        Set<String> tempSet = new HashSet<>();
        tempSet.addAll(authIdArrList);
        //将set转数组
        Object[] objects = tempSet.toArray();
        int flag3 = authorityMapper.insertManyRoleAuth(roleId, objects);
        if(flag1==1 && flag2>=1 && flag3>=1){//操作全部成功
            return true;
        }else{//让事务自动回滚
            throw  new Exception("修改角色信息失败");
        }
    }

    @Override
    public List<Map<String, Object>> findRoles() {
        return authorityMapper.selectRoles();
    }

    @Override
    public boolean saveSystemUser(String username, String pwd, String useStatus, Long roleId) {
        //1、校验数据格式
        if(username==null || pwd==null || useStatus==null || roleId==null){
            return false;
        }
        //对明文密码进行加密
        pwd = SecureUtil.md5(pwd);
        //2、判断username在数据库中是否存在
        int flag = authorityMapper.selectUNameIsExist(username);
        //3如果系统用户不存在，则开始插入
        if(flag==1){
            return false;
        }
        return authorityMapper.insertSystemUser(username,pwd,useStatus,roleId)==1;
    }
}
