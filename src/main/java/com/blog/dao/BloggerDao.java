package com.blog.dao;

import com.blog.entity.Blogger;
import org.apache.ibatis.annotations.Param;

public interface BloggerDao {


    public Blogger getByUserName(@Param("userName") String userName);


    /**更新博主对象*/
    public Integer update(Blogger blogger);

    /**查询博主*/
    public Blogger find();
}
