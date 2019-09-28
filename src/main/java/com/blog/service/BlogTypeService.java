package com.blog.service;

import com.blog.entity.BlogType;

import java.util.List;
import java.util.Map;

public interface BlogTypeService {


    /**
     * 查询所有博客类型列表
     * @return
     */
    public List<BlogType> findList();

    /**
     * 根据id查询一条博客类型
     */
    public BlogType findById(Integer id);

    /**
     * 不固定参数查询博客类型列表
     */
    public BlogType findByOption(Map<String,Object> paraMap);

    /**
     * 不固定参数查询博客类型数量
     */
    public Long getTotal(Map<String,Object> paraMap);

    /**
     * 添加一条博客类型
     */
    public Integer add(BlogType blogType);

    /**
     * 修改一条博客类型
     */
    public Integer update(BlogType blogType);

    /**
     * 删除一条博客类型
     */
    public void delete(Integer id);
}
