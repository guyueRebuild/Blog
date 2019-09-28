package com.blog.entity;

public class PageBean {

    /**
     * 当前页，从1开始
     */
    private int page;

    private int pageSize;

    private int start;

    public PageBean(int page, int pageSize) {
        this.page = page;
        this.pageSize = pageSize;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getStart() {
        return (this.page-1)*pageSize;
    }

    public void setStart(int start) {
        this.start = start;
    }
}
