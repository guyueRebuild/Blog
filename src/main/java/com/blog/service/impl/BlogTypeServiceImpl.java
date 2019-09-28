package com.blog.service.impl;

import com.blog.dao.BlogTypeDao;
import com.blog.entity.BlogType;
import com.blog.service.BlogTypeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("blogTypeService")
public class BlogTypeServiceImpl implements BlogTypeService {

    @Resource
    private BlogTypeDao blogTypeDao;
    /**
     * 查询所有博客类型列表
     *
     * @return
     */
    @Override
    public List<BlogType> findList() {
        return blogTypeDao.findList();
    }

    /**
     * 根据id查询一条博客类型
     *
     * @param id
     */
    @Override
    public BlogType findById(Integer id) {
        return blogTypeDao.findById(id);
    }

    /**
     * 不固定参数查询博客类型列表
     *
     * @param paramMap
     */
    @Override
    public BlogType findByOption(Map<String, Object> paramMap) {
        return blogTypeDao.findByOption(paramMap);
    }

    /**
     * 不固定参数查询博客类型数量
     *
     * @param paramMap
     */
    @Override
    public Long getTotal(Map<String, Object> paramMap) {
        return blogTypeDao.getTotal(paramMap);
    }

    /**
     * 添加一天博客类型
     *
     * @param blogType
     */
    @Override
    public Integer add(BlogType blogType) {
        return blogTypeDao.add(blogType);
    }

    /**
     * 修改一条博客类型
     *
     * @param blogType
     */
    @Override
    public Integer update(BlogType blogType) {
        return blogTypeDao.update(blogType);
    }

    /**
     * 删除一条博客类型
     *
     * @param id
     */
    @Override
    public void delete(Integer id) {
        blogTypeDao.delete(id);
    }
}
