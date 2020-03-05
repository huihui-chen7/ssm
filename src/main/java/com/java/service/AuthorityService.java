package com.java.service;

import com.java.pojo.OneMenu;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * description：
 * author：丁鹏
 * date：16:34
 */
public interface AuthorityService {

    /**
     *
     * @param username
     * @param password
     * @param session
     * @return登录
     */
    boolean findLogin(String username, String password, HttpSession session);

    /**
     * 分页查看角色信息列表
     * @param pageNum
     * @param pageSize
     * @return
     */
    List<Map<String,Object>> findRoleList(Integer pageNum,Integer pageSize);

    /**
     * 查询所有可以被授予的普通权限
     * @return
     */
    List<OneMenu> findPTAuthority();

    boolean saveRole(String roleName,String roleStatus,String authIdStr) throws Exception;

    /**
     * 查看指定id角色拥有的所有信息,包括权限信息
     * @param roleId
     * @return
     */
    Map<String,Object> findRoleDetailInfo(Long roleId);

    /**
     * 修改角色信息
     * @param role_name
     * @param roleStatus
     * @param roleId
     * @param authIdStr
     * @return
     */
    boolean modifyRoleInfo(String role_name,String roleStatus,Long roleId,String authIdStr) throws Exception;

    /**
     * 查询角色信息
     * @return
     */
    List<Map<String,Object>> findRoles();

    /**
     * 添加系统用户
     * @param username
     * @param pwd
     * @param useStatus
     * @param roleId
     * @return
     */
    boolean saveSystemUser(String username,String pwd,String useStatus,Long roleId);
}
