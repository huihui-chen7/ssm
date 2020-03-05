package com.java.mapper;

import com.java.pojo.OneMenu;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

/**
 * description：
 * author：丁鹏
 * date：15:37
 */
public interface AuthorityMapper {

    /**
     * 获取某个用户拥有的所有一级权限
     * @param username
     * @param password
     * @return
     */
    List<OneMenu> selectAuthority(String username,String password);

    /**
     * 判断用户是否登录成功
     * @param username
     * @param password
     * @return
     */
    @Select("SELECT COUNT(*) FROM SYSTEM_USER WHERE username=#{0} AND pwd=#{1} AND use_status='1'")
    int selectIsLoginSuccess(String username,String password);

    /**
     * 查询所有角色信息
     * @return
     */
    @Select("SELECT id,role_name,DATE_FORMAT(create_date,'%Y-%m-%d %H:%i:%s') AS create_date,\n" +
            "`status`,flag\n" +
            "FROM `system_roles` ORDER BY create_date DESC ")
    List<Map<String,Object>> selectRoleList();

    /**
     * 查询所有可以被授权的普通权限
     * @return
     */
    List<OneMenu> selectPTAuthority();

    /**
     * 往system_roles表中添加一条数据
     * @return
     */
    @Insert("INSERT INTO `system_roles` VALUES(NULL,#{roleName},NOW(),#{roleStatus},'0')")
    @Options(useGeneratedKeys = true,keyProperty = "roleId",keyColumn = "id")
    int insertRole(Map<String,Object> paramMap);

    /**
     * 插入角色和权限的映射关系
     * @param roleId
     * @param authId
     * @return
     */
    int insertManyRoleAuth(@Param("roleId") Long roleId,@Param("authId") Object[] authId);

    /**
     * 查询角色的基本信息(不包含角色对应的权限信息)
     * @param roleId
     * @return
     */
    @Select("SELECT id,role_name,status FROM `system_roles` WHERE id=#{0}")
    Map<String,Object> selectRoleInfo(Long roleId);

    /**
     * 查询指定id角色拥有的所有权限
     * @param roleId
     * @return
     */
    @Select("SELECT auth_id FROM `role_auth` WHERE role_id=#{0}")
    List<Long> selectRoleOwnAuth(Long roleId);

    /**
     * 修改指定Id的角色信息
     * @param role_name
     * @param roleStatus
     * @param roleId
     * @return
     */
    @Update("UPDATE system_roles SET role_name=#{0},create_date=NOW(),STATUS=#{1} WHERE id=#{2}")
    int updateRoleById(String role_name,String roleStatus,Long roleId);

    /**
     * 删除指定id的角色与权限的映射关系
     * @param roleId
     * @return
     */
    @Delete("DELETE FROM role_auth WHERE role_id=#{0}")
    int deleteRoleAuthRelation(Long roleId);

    /**
     * 查询角色
     * @return
     */
    @Select("SELECT id AS roleId,role_name AS roleName FROM system_roles WHERE flag='0' AND STATUS='1'")
    List<Map<String,Object>> selectRoles();

    /**
     * 添加系统用户
     * @param username
     * @param pwd
     * @param useStatus
     * @param roleId
     * @return
     */
    @Insert("INSERT INTO SYSTEM_USER VALUES(NULL,#{0},#{1},NOW(),#{2},'0',#{3})")
    int insertSystemUser(String username,String pwd,String useStatus,Long roleId);

    /**
     * 判断某个指定的用户名子啊数据库中的表中是否存在
     * @param username
     * @return
     */
    @Select("SELECT COUNT(*) FROM `system_user` WHERE username=#{0}")
    int selectUNameIsExist(String username);
}
