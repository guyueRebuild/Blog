package com.blog.util;
/**
 * 翻页工具类
 *
 */
public class PageUtil {

	/**
	 * 翻页方法
	 */
	public static String getPagination(String targetUrl, long totalNum, int currentPage, int pageSize, String param) {
		//总共页数
		if(totalNum==0) {
			return "未查询到数据";
		}
		long totalPage;
		if (totalNum%pageSize==0) {
			totalPage = totalNum/pageSize;
		}else {
			totalPage = totalNum/pageSize+1;
		}
		
		StringBuilder pageCode = new StringBuilder();
		pageCode.append("<li><a href='").append(targetUrl).append("?page=1&").append(param).append("'>首页</a></li>");
		//上一页
		if(currentPage>1) {			//当前页不是第一页，显示上一页并且能点击
			pageCode.append("<li><a href='").append(targetUrl).append("?page=").append(currentPage - 1).append("&").append(param).append("'>上一页</a></li>");
		}else {						//当前页是第一页，显示上一页但不能点击击
			pageCode.append("<li class='disabled'> <a href='#'>上一页</a></li>");
		}
		
		//显示页数
		for(int i=1;i<=totalPage;i++) {
			if(i==currentPage) {
				pageCode.append("<li class='active'> <a href='").append(targetUrl).append("?page=").append(i).append("&").append(param).append("'>").append(i).append("</a></li>");
			}else {
				pageCode.append("<li> <a href='").append(targetUrl).append("?page=").append(i).append("&").append(param).append("'>").append(i).append("</a></li>");
			}
		}
		//下一页
		if(currentPage<totalPage) {
			pageCode.append("<li><a href='").append(targetUrl).append("?page=").append(currentPage + 1).append("&").append(param).append("'>下一页</a></li>");
		}else {
			pageCode.append("<li class='disabled'> <a href='#'>下一页</a></li>");
		}
		//尾页
		pageCode.append("<li> <a href='").append(targetUrl).append("?page=").append(totalPage).append("&").append(param).append("'>尾页</a></li>");
	
		return pageCode.toString();
	}
}
