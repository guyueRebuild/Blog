package com.blog.controller;


import com.blog.entity.Blogger;
import com.blog.service.BlogService;
import com.blog.service.BloggerService;
import com.blog.util.CryptographyUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 博主登录
 */
@Controller
@RequestMapping("/blogger")
public class BloggerController {

    final
    BloggerService bloggerService;

    public BloggerController(BloggerService bloggerService) {
        this.bloggerService = bloggerService;
    }

    @RequestMapping(path = "/login",method = RequestMethod.POST)
    public String login(Blogger blogger, HttpServletRequest request){
        //TODO:验证
        String userName = blogger.getUserName();
        String password = blogger.getPassword();
        System.out.println("userName："+userName+"password "+password);
        String pw = CryptographyUtil.md5(password,"java1234");

        /* Subject*/
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(userName,pw);

        try {
            //传递token给shiro的realm
           subject.login(token);
            return "redirect:/admin/main.jsp";
        } catch (AuthenticationException e) {
            e.printStackTrace();
            request.setAttribute("blogger",blogger);
            request.setAttribute("erroInfo","用户名或密码错误");
        }
        return "login";
    }

    /**
     * 关于博主
     * @return
     */
    @RequestMapping("/aboutMe")
    public ModelAndView aboutMe(){
        ModelAndView mav = new ModelAndView();
        mav.addObject("blogger", bloggerService.find());
        mav.addObject("mainPage","foreground/blogger/info.jsp");
        mav.addObject("pagePitle","关于博主_个人博客系统");
        mav.setViewName("index");
        return mav;
    }

}


