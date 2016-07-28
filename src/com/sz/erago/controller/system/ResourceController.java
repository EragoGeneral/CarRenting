package com.sz.erago.controller.system;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sz.erago.framework.constant.GlobalConstant;
import com.sz.erago.model.common.Json;
import com.sz.erago.model.common.ResourceTree;
import com.sz.erago.model.common.SessionInfo;
import com.sz.erago.model.common.Tree;
import com.sz.erago.model.system.SystemResource;
import com.sz.erago.service.IResourceService;

@Controller
@RequestMapping("/resource")
public class ResourceController{

	@Autowired
	private IResourceService resourceService;

	@RequestMapping("/manage")
	public String manager() {
		return "/system/resource";
	}

	@RequestMapping("/tree")
	@ResponseBody
	public List<Tree> tree(HttpSession session) {
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute(GlobalConstant.SESSION_INFO);
		return resourceService.queryResourceByOwner(sessionInfo, true);
	}

	@RequestMapping("/allTree")
	@ResponseBody
	public List<Tree> allTree(boolean flag) {// true获取全部资源,false只获取菜单资源
		return resourceService.queryResourceByCondition(flag);
	}
	
	@RequestMapping("/treeGrid")
	@ResponseBody
	public List<ResourceTree> treeGrid(HttpServletRequest request) {
		SessionInfo sessionInfo = (SessionInfo)request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
		
		return resourceService.treeGrid(sessionInfo);
	}
	
	@RequestMapping("/mainMenu")
	@ResponseBody
	public List<SystemResource> loadMainMenu(HttpServletRequest request) {
		SessionInfo sessionInfo = (SessionInfo)request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
		
		return resourceService.createMainMenu(sessionInfo);
	}
	
	@RequestMapping("/get")
	@ResponseBody
	public SystemResource get(Integer id) {
		return resourceService.getResourceInfo(id);
	}
	
	@RequestMapping("/addPage")
	public String addPage() {
		return "/system/resourceAdd";
	}

	@RequestMapping("/add")
	@ResponseBody
	public Json add(SystemResource resource, HttpServletRequest request) {
		Json j = new Json();
		SessionInfo sessionInfo = (SessionInfo)request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
		try {
			int flag = resourceService.addResource(resource, sessionInfo);
			if(flag == 1){
				j.setSuccess(true);
				j.setMsg("添加成功！");
			}else{
				j.setSuccess(false);
				j.setMsg("添加失败！");
			}
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}
	
	@RequestMapping("/editPage")
	public String editPage(HttpServletRequest request, Integer id) {
		SystemResource r = resourceService.getResourceInfo(id);
		request.setAttribute("resource", r);
		return "/system/resourceEdit";
	}

	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(HttpServletRequest request, SystemResource resource) throws InterruptedException {
		Json j = new Json();
		SessionInfo sessionInfo = (SessionInfo)request.getSession().getAttribute(GlobalConstant.SESSION_INFO);
		try {
			resourceService.updateResource(resource, sessionInfo);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}

	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		Json j = new Json();
		try {
			resourceService.deleteResource(id);
			j.setMsg("删除成功！");
			j.setSuccess(true);
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}
}
