package com.blog.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.blog.entity.Blog;
import com.blog.entity.PageBean;
import com.blog.service.BlogService;
import com.blog.util.PageUtil;
import com.blog.util.StringUtil;

/**
 * 首页
 */
@Controller
public class IndexController {

    @Resource
    private BlogService blogService;

    @RequestMapping({"/index"})
    public ModelAndView index(@RequestParam(value = "page", required = false) String page,
                              @RequestParam(value = "typeId", required = false) String typeId,
                              @RequestParam(value = "releaseDateStr", required = false) String releaseDateStr,
                              HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("title", "菜蛙的Blog");
        if (StringUtils.isBlank(page)) {
            page = "1";
        }
        PageBean pageBean = new PageBean(Integer.parseInt(page), 10);
        Map<String, Object> map = new HashMap<>();
        map.put("start", pageBean.getStart());
        map.put("size", pageBean.getPageSize());
        map.put("typeId", typeId);
        map.put("releaseDateStr", releaseDateStr);

        //根据类型与时间查询博客
        List<Blog> list = blogService.list(map);

        StringBuilder param = new StringBuilder();
        if (StringUtil.isNotEmpty(typeId)) {
            param.append("typeId=").append(typeId).append("&");
        }

        if (StringUtil.isNotEmpty(releaseDateStr)) {
            param.append("releaseDateStr=").append(releaseDateStr).append("&");
        }

        //获取该条件下博客总数
        long total = blogService.getTotal(map);
        mav.addObject("mainPage", "foreground/blog/k.jsp");

        //组装分页模块
        String pageCode = PageUtil.getPagination(request.getContextPath() + "/index.html", total, Integer.parseInt(page), 10, param.toString());
        mav.addObject("pageCode", pageCode);
        mav.addObject("blogList", list);
        return mav;
    }
}
