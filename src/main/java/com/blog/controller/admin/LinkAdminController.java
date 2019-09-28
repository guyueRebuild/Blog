package com.blog.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.blog.entity.Link;
import com.blog.entity.PageBean;
import com.blog.service.LinkService;
import com.blog.util.ResponseUtil;

/**
 * 友情链接管理
 *
 */
@Controller
@RequestMapping({"/admin/link"})
public class LinkAdminController {
	@Resource
	private LinkService linkService;
	/**
	 * 友情链接列表
	 */
	@RequestMapping({"/list"})
	public String list(@RequestParam(value="page",required=false)String page,
			@RequestParam(value="rows",required=false)String rows,
			HttpServletResponse response) throws Exception {
		PageBean pageBean = new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String,Object> map = new HashMap<>();
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		//查询友情链接列表
		List<Link> linkList = linkService.list(map);
		//查询总共有多少条数据
		Long total = linkService.getTotal(map);
		//将数据写入response
		JSONObject result = new JSONObject();
		Object json = JSONArray.toJSON(linkList);
		result.put("rows",json);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	/**
	 * 保存友情链接信息
	 */
	@RequestMapping({"/save"})
	public String save(Link link,HttpServletResponse response) throws Exception {
		int resultTotal;
		//添加
		if(link.getId()==null) {
			resultTotal = linkService.add(link);
		}else {
			//更新
			resultTotal = linkService.update(link);
		}
		
		JSONObject result = new JSONObject();
		if(resultTotal>0) {
			result.put("success", Boolean.TRUE);
		}else {
			result.put("success", Boolean.FALSE);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	
	/**
	 * 删除友情链接
	 */
	@RequestMapping({"/delete"})
	public String delete(@RequestParam("ids")String ids,HttpServletResponse response) throws Exception {
		String[] idsStr = ids.split(",");
		JSONObject result = new JSONObject();
		for (String s : idsStr) {
			linkService.delete(Integer.valueOf(s));
		}
		result.put("success", Boolean.TRUE);
		ResponseUtil.write(response, result);
		return null;
	}
}
