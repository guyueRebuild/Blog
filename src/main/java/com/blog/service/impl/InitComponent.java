package com.blog.service.impl;

import com.blog.entity.Blog;
import com.blog.entity.BlogType;
import com.blog.entity.Blogger;
import com.blog.entity.Link;
import com.blog.service.BlogService;
import com.blog.service.BlogTypeService;
import com.blog.service.BloggerService;
import com.blog.service.LinkService;
import com.blog.util.Const;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.List;

/**
 * 监听器
 */
@Component
public class InitComponent implements ServletContextListener, ApplicationContextAware {

    /**
     * 设置成静态变量，不然会报空指针
     */
    private static ApplicationContext applicationContext;

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        ServletContext servletContext =  servletContextEvent.getServletContext();
        //博客类别
        BlogTypeService blogTypeService = (BlogTypeService) applicationContext.getBean("blogTypeService");
        List<BlogType> blogTypeCountList = blogTypeService.findList();
        servletContext.setAttribute(Const.BLOG_TYPE_COUNT_LIST,blogTypeCountList);

        //博主信息
        BloggerService bloggerService = applicationContext.getBean("bloggerService", BloggerService.class);
        Blogger blogger = bloggerService.find();
        blogger.setPassword("");
        servletContext.setAttribute(Const.BLOGGER,blogger);

        //按年月分类的博客数量
        BlogService blogService = applicationContext.getBean("blogService",BlogService.class);
        List<Blog> blogCountList = blogService.countList();
        servletContext.setAttribute(Const.BLOG_COUNT_LIST,blogCountList);

        //友情链接
        LinkService linkService = applicationContext.getBean("linkService",LinkService.class);
        List<Link> linkList = linkService.list(null);
        servletContext.setAttribute(Const.LINK_LIST,linkList);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }
}
