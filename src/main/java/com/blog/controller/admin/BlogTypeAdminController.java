package com.blog.controller.admin;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.blog.entity.BlogType;
import com.blog.entity.PageBean;
import com.blog.service.BlogService;
import com.blog.service.BlogTypeService;
import com.blog.util.ResponseUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 博客类型管理
 */
@Controller
@RequestMapping("/admin/blogType")
public class BlogTypeAdminController {

    private final BlogTypeService blogTypeService;

    private final BlogService blogService;

    public BlogTypeAdminController(BlogTypeService blogTypeService, BlogService blogService) {
        this.blogTypeService = blogTypeService;
        this.blogService = blogService;
    }



    @RequestMapping("/findList")
    public String list(@RequestParam(value = "page",required = false) String page, @RequestParam(value = "rows",required = false) String rows, HttpServletResponse response) throws IOException {
        PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
        Map<String,Object> map = new HashMap<>();
        map.put("start",pageBean.getStart());
        map.put("size",pageBean.getPageSize());
        //查询博客类型列表
        List<BlogType> blogTypeList = blogTypeService.findList();
        for (BlogType blogType : blogTypeList) {
            System.out.println(blogType);
        }
        //查询数量
        Long total = blogTypeService.getTotal(map);
        //将数据写入response
        JSONObject result = new JSONObject();
        Object json = JSONArray.toJSON(blogTypeList);
        result.put("rows",json);
        result.put("total",total);
        ResponseUtil.write(response,result);
        return null;
    }

    /**
     * 保存博客类别信息
     */
    @RequestMapping({"/save"})
    public String save(BlogType blogType,HttpServletResponse response) throws Exception {
        int resultTotal;
        //添加
        if(blogType.getId()==null) {
            resultTotal = blogTypeService.add(blogType);
        }else {
            //更新
            resultTotal = blogTypeService.update(blogType);
        }

        JSONObject result = new JSONObject();
        if(resultTotal>0) {
            result.put("success", Boolean.TRUE);
        }else {
            result.put("success", Boolean.FALSE);//Boolean.valueOf(false)
        }
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 删除博客类型
     */
    @RequestMapping({"/delete"})
    public String delete(@RequestParam("ids")String ids,HttpServletResponse response) throws Exception {
        String[] idsStr = ids.split(",");
        JSONObject result = new JSONObject();
        for (String s : idsStr) {
            int sum = blogService.getBlogByTypeId(Integer.valueOf(s));
            if (sum > 0) {
                result.put("exist", "博客类别下有博客，不能删除");
            } else {
                blogTypeService.delete(Integer.valueOf(s));
            }
        }
        result.put("success", Boolean.TRUE);
        ResponseUtil.write(response, result);
        return null;
    }
}
