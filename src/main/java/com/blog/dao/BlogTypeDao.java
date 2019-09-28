package com.blog.dao;

import com.blog.entity.BlogType;
import com.blog.entity.Blogger;

import java.util.List;
import java.util.Map;

public interface BlogTypeDao {

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
    public BlogType findByOption(Map<String,Object> paramMap);

    /**
     * 不固定参数查询博客类型数量
     */
    public Long getTotal(Map<String,Object> paramMap);

    /**
     * 添加一天博客类型
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
