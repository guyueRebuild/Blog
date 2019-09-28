package com.blog.realm;

import com.blog.entity.Blogger;
import com.blog.service.BloggerService;
import jdk.nashorn.internal.parser.Token;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import javax.annotation.Resource;

public class MyRealm extends AuthorizingRealm {

    @Resource
    private BloggerService bloggerService;
    /**
     * 获取授权信息
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }

    /**
     * 登录验证
     * @param authenticationToken 基于用户名密码的令牌
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        //取出用户名
        String userName = (String)authenticationToken.getPrincipal();
        //让Shiro去验证账户密码
        Blogger blogger = bloggerService.getByUserName(userName);
        //验证
        if(blogger!=null){
            //把用户信息放到Session
            SecurityUtils.getSubject().getSession().setAttribute("currentUser",blogger);
            AuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(blogger.getUserName(),blogger.getPassword(),getName());
            return authenticationInfo;
        }
        return null;
    }
}
