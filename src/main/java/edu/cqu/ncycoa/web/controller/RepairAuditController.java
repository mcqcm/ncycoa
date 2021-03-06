package edu.cqu.ncycoa.web.controller;


import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.HistoryService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.ManagementService;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.common.CodeDictionary;
import com.common.Format;
import com.common.Util;
import com.common.WordUtils;
import com.dao.system.UnitDao;
import com.entity.system.UserInfo;

import edu.cqu.ncycoa.common.dto.AjaxResultJson;
import edu.cqu.ncycoa.common.dto.DataGrid;
import edu.cqu.ncycoa.common.dto.QueryDescriptor;
import edu.cqu.ncycoa.common.service.CommonService;
import edu.cqu.ncycoa.common.service.SystemService;
import edu.cqu.ncycoa.common.tag.TagUtil;
import edu.cqu.ncycoa.common.util.dao.QueryUtils;
import edu.cqu.ncycoa.common.util.dao.TQOrder;
import edu.cqu.ncycoa.common.util.dao.TypedQueryBuilder;
import edu.cqu.ncycoa.domain.ActivityComment;
import edu.cqu.ncycoa.domain.RepairAudit;
import edu.cqu.ncycoa.util.ConvertUtils;
import edu.cqu.ncycoa.util.Globals;
import edu.cqu.ncycoa.util.MyBeanUtils;
import edu.cqu.ncycoa.util.SystemUtils;

@Controller
@RequestMapping("/repair_management")
public class RepairAuditController {

	@Resource(name="systemService")
	SystemService systemService;
	
	@Resource(name="wfRtService")
	RuntimeService runtimeService;
	
	@Resource(name="wfRepoService")
	RepositoryService repositoryService;
	
	@Resource(name="wfTaskService")
	TaskService taskService;
	
	@Resource(name="wfHistoryService")
	HistoryService historyService;
	
	@Resource(name="wfManagementService")
	ManagementService managementService;
	
	@Resource(name="processEngine")
	ProcessEngine processEngine;
	
	@RequestMapping(params="add")
	public String add(HttpServletRequest request) {
		return "repair_management/repair";
	}
	
	@RequestMapping(params="del")
	@ResponseBody
	public void del(HttpServletRequest request, HttpServletResponse response) {
		AjaxResultJson j = new AjaxResultJson();
		String message;
		String id = request.getParameter("id");
		if(StringUtils.isEmpty(id)) {
			return;
		}
		Long[] ids;
		try {
			ids = ConvertUtils.toLongs(id.split(","));
		} catch (Exception e) {
			message = "数据不合法";
			j.setSuccess(false);
			SystemUtils.jsonResponse(response, j);
			return;
		}
		
		systemService.removeEntities(ids, RepairAudit.class);
		message = "维修申请删除成功";
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		j.setMsg(message);
		SystemUtils.jsonResponse(response, j);
	}
	
	@RequestMapping(params = "save")
	@ResponseBody
	public void save(RepairAudit repairAudit, HttpServletRequest request, HttpServletResponse response) {
		AjaxResultJson j = new AjaxResultJson();
		String message;
		if (repairAudit.getId() != null) {
			message = "维修申请更新成功";
			RepairAudit t = systemService.findEntityById(repairAudit.getId(), RepairAudit.class);
			try {
				MyBeanUtils.copyBeanNotNull2Bean(repairAudit, t);
				if(t.getAuditFlag().equals("1")){
					message = "维修申请不能更新";
				}else{
					systemService.saveEntity(t);
					systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
				}
				
			} catch (Exception e) {
				message = "维修申请更新失败";
			}
		} else {
			message = "维修申请添加成功";
		    repairAudit.setAppDate(Format.strToDate(Format.getNowtime()));
		    repairAudit.setAuditFlag("0");
			systemService.addEntity(repairAudit);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}
		
		j.setMsg(message);
		SystemUtils.jsonResponse(response, j);
	}
	
	@RequestMapping(params="update")
    public ModelAndView update(HttpServletRequest request, HttpServletResponse response){
		String id = request.getParameter("id"); 
		RepairAudit repairAudit = systemService.findEntityById(Long.parseLong(id), RepairAudit.class);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("repair_management/repair");
		mav.addObject("repairAudit",repairAudit);
		mav.addObject("orgname",CodeDictionary.syscode_traslate("base_org","orgcode", "orgname", repairAudit.getApporgCode()));
		return mav;
	}
	
	/**
	 * 更新台账
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params="updaterec")
    public ModelAndView updaterec(HttpServletRequest request, HttpServletResponse response){
		String id = request.getParameter("id"); 
		RepairAudit repairAudit = systemService.findEntityById(Long.parseLong(id), RepairAudit.class);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("repair_management/repairupdate");
		mav.addObject("repairAudit",repairAudit);
		return mav;
	}
	
	@RequestMapping(params="dgview")
	public String dgView(HttpServletRequest request) {
		return "repair_management/repairlist";
	}
	
	@RequestMapping(params="officedgview")
	public String officedgView(HttpServletRequest request) {
		return "repair_management/repair_office_audit_list";
	}
	
	@RequestMapping(params="directordgview")
	public String directordgView(HttpServletRequest request) {
		return "repair_management/repair_director_audit_list";
	}
	
	@RequestMapping(params="auditresdgview")
	public String auditresdgView(HttpServletRequest request) {
		return "repair_management/repairreslist";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params="dgdata")
	@ResponseBody
	public void dgData(RepairAudit repairAudit, DataGrid dg, HttpServletRequest request, HttpServletResponse response) {
		QueryDescriptor<RepairAudit> cq = new QueryDescriptor<RepairAudit>(RepairAudit.class, dg);
		CommonService commonService = SystemUtils.getCommonService(request);
		
		//查询条件组装器
		TypedQueryBuilder<RepairAudit> tqBuilder = QueryUtils.getTQBuilder(repairAudit, request.getParameterMap());
		if (StringUtils.isNotEmpty(dg.getSort())) {
			tqBuilder.addOrder(new TQOrder(tqBuilder.getRootAlias() + "." + dg.getSort(), dg.getOrder().equals("asc")));
		}
		tqBuilder.addOrder(new TQOrder("appDate", false));
		cq.setTqBuilder(tqBuilder);
		commonService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dg);
	}
	
	@RequestMapping(params="dgview_audit")
	public String dgViewAudit(HttpServletRequest request) {
		return "repair_management/repair_audit_list";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params="dgdata_audit")
	@ResponseBody
	public void dgDataAudit(RepairAudit repairAudit, DataGrid dg, HttpServletRequest request, HttpServletResponse response) {
		QueryDescriptor<RepairAudit> cq = new QueryDescriptor<RepairAudit>(RepairAudit.class, dg);
		CommonService commonService = SystemUtils.getCommonService(request);
		
		//查询条件组装器
		TypedQueryBuilder<RepairAudit> tqBuilder = QueryUtils.getTQBuilder(repairAudit, request.getParameterMap());
		if (StringUtils.isNotEmpty(dg.getSort())) {
			tqBuilder.addOrder(new TQOrder(tqBuilder.getRootAlias() + "." + dg.getSort(), dg.getOrder().equals("asc")));
		}
		tqBuilder.addRestriction(tqBuilder.getRootAlias() + ".status", "=", (short)0);
		cq.setTqBuilder(tqBuilder);
		commonService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dg);
	}
	
	@RequestMapping(params="audit")
	@ResponseBody
	public void audit(HttpServletRequest request, HttpServletResponse response) {
		AjaxResultJson j = new AjaxResultJson();
		String message;
		String id = request.getParameter("id");
		if(StringUtils.isEmpty(id)) {
			return;
		}
		Long[] ids;
		try {
			ids = ConvertUtils.toLongs(id.split(","));
		} catch (Exception e) {
			message = "数据不合法";
			j.setSuccess(false);
			SystemUtils.jsonResponse(response, j);
			return;
		}
		
		RepairAudit repairAudit;
		for(Long tmp : ids) {
			repairAudit = systemService.findEntityById(tmp, RepairAudit.class);
			
			//办公室审核
			if(request.getParameter("auditor").equals("office")){
				if(request.getParameter("res").equals("yes")){
					repairAudit.setAuditFlag("11");
				}else{
					repairAudit.setAuditFlag("10");
				}
			}
			//局长审核
			if(request.getParameter("auditor").equals("director")){
				if(request.getParameter("res").equals("yes")){
					repairAudit.setAuditFlag("21");
				}else{
					repairAudit.setAuditFlag("20");
				}
			}
			systemService.saveEntity(repairAudit);
			systemService.addLog("维修申请审核", Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		}
		
		message = "审核完成";
		j.setMsg(message);
		SystemUtils.jsonResponse(response, j);
	}
	
	@RequestMapping(params = "repairAudit")
	@ResponseBody
	public void repairAudit(HttpServletRequest request, HttpServletResponse response) {
		AjaxResultJson j = new AjaxResultJson();
		String message = "";
		String id = request.getParameter("id");
		try {
			String processID = RepairAudit.class.getSimpleName();
			String objId = processID + ":" +id;
			Map<String, Object> paras =new HashMap<String, Object>();
			paras.put("inputUser", ((UserInfo)request.getSession().getAttribute("UserInfo")).getStaffcode());
			RepairAudit repairAudit = systemService.findEntityById(Long.parseLong(id), RepairAudit.class);
		/*	String orgcode = repairAudit.getApporgCode(); 
			Org org = new Org(orgcode);
			String orgaudit = "";
			String companyaudit = "";
			String companycode = AllMeritCollection.getcompanyByobject(orgcode);*/
			/*if(repairAudit.getRepairFree() > 20000){
				//市局
				orgaudit = UnitDao.getOfficeAudit();
				companyaudit = UnitDao.getCityAudit();
			}else{
				if(org.getAdminClass().equals("0")){
					orgaudit = UnitDao.getOfficeAudit();
					companyaudit = UnitDao.getCityAudit();
				}else{
					
					if(Integer.parseInt((companycode.split("\\.")[2])) >= 20){
						//区县
						orgaudit = UnitDao.getQXOfficeAudit(companycode);
						companyaudit = UnitDao.getComanyAudit(companycode);
					}else{
						//市局
						orgaudit = UnitDao.getOfficeAudit();
						companyaudit = UnitDao.getCityAudit();
					}
					
				}
			}*/
			String orgaudit = UnitDao.getOfficeAudit();
			String companyaudit = UnitDao.getCityAudit();
			
			paras.put("orgcode", orgaudit);
			paras.put("ysorgcode", UnitDao.getCityComanyAudit("NC.01.05"));
			paras.put("company", companyaudit);
			paras.put("objId", objId);
			//runtimeService.startProcessInstanceByKey(processID, objId, paras);
			
			processEngine.getRuntimeService().startProcessInstanceByKey(processID, objId, paras);
			String processinstanceid = processEngine.getRuntimeService().
					createProcessInstanceQuery().processInstanceBusinessKey(objId,processID).list().get(0).getProcessInstanceId();
			
			repairAudit.setProcessInstanceId(processinstanceid);//存入流程实例号
			
			IdentityService identityService=processEngine.getIdentityService();
			identityService.setAuthenticatedUserId(((UserInfo)request.getSession().getAttribute("UserInfo")).getStaffcode());
			message = "维修申请提交成功";
			//更新维修申请状态
			repairAudit.setAuditFlag("1");
			systemService.saveEntity(repairAudit);
			UserInfo userinfo = (UserInfo)request.getSession().getAttribute("UserInfo");
			List<Task> task_tmp = processEngine.getTaskService().createTaskQuery().taskAssignee(userinfo.getStaffcode()).processInstanceId(processinstanceid).orderByDueDate().desc().list();
			Map<String, Object> paras_tmp =new HashMap<String, Object>();
			paras_tmp.put("outcome", true);
			processEngine.getTaskService().complete(task_tmp.get(0).getId(),paras_tmp);
			
		} catch (Exception e) {
		}
		
		j.setMsg(message);
		SystemUtils.jsonResponse(response, j);
	}
	
	@RequestMapping(params="taskList")
    public ModelAndView taskList(HttpServletRequest request, HttpServletResponse response){
		
		UserInfo userInfo = (UserInfo)request.getSession().getAttribute("UserInfo");
	    List<Task> tasks = taskService.createTaskQuery()
	    		.taskCandidateUser(userInfo.getStaffcode())/*
	    		                      .taskAssignee(userInfo.getStaffcode())*/
	    		                      .list();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("repair_management/tasklist");
		
		mav.addObject("tasks",tasks);
		return mav;
	}
	@RequestMapping(params = "exetask")
	@ResponseBody
	public void exetask(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		AjaxResultJson j = new AjaxResultJson();
		String message = "";
		String id = request.getParameter("id");
		String taskId = request.getParameter("taskId");
		String outcome = request.getParameter("outcome"); 
		
		String comment = request.getParameter("comment");
		if(comment==null||comment.equals("")){
			comment="同意";
		}
		RepairAudit repairAudit = systemService.findEntityById(Long.parseLong(id), RepairAudit.class);
		
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		String pi = task.getProcessInstanceId();
		//添加审核人
		Authentication.setAuthenticatedUserId(((UserInfo)request.getSession().getAttribute("UserInfo")).getStaffcode());
		taskService.addComment(taskId, pi, comment);//增加批准信息
		
		Map<String, Object> paras =new HashMap<String, Object>();
		paras.put("outcome", outcome);
		
		taskService.complete(taskId,paras);
		
		boolean flag = true;
		List<ProcessInstance> processInstances = processEngine.getRuntimeService().createProcessInstanceQuery().list();

		for(ProcessInstance processInstance : processInstances){
			if(processInstance.getProcessInstanceId().equals(repairAudit.getProcessInstanceId())){
				flag = false;
			}
		}
		
		if(flag){
			repairAudit.setAuditFlag("2");
			systemService.saveEntity(repairAudit);
		}
		
		
		try {
			message = "维修申请提交成功";
			
		} catch (Exception e) {
		}
		
		j.setMsg(message);
		SystemUtils.jsonResponse(response, j);
	}
	
	
	@RequestMapping(params="submitTask")
	public ModelAndView submitTask(HttpServletRequest request, HttpServletResponse response) {
		List<String> list = new ArrayList<String>();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("repair_management/repairaudit");
		String taskId = request.getParameter("taskId");
		
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		String processDefId = task.getProcessDefinitionId();
		String pi = task.getProcessInstanceId();
		
		ProcessDefinitionEntity processDefinitionEntity = (ProcessDefinitionEntity)repositoryService.getProcessDefinition(processDefId);
		
		ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(pi)
	              .singleResult();
	   
		
		String activityId = processInstance.getActivityId();
		ActivityImpl activityImpl = processDefinitionEntity.findActivity(activityId);
		
		/**
		 * 获取下一个当前活动后面的Sequence line
		 */
		List<PvmTransition> pvmTransitions = activityImpl.getOutgoingTransitions();
		
		if(pvmTransitions != null && pvmTransitions.size() > 0){
			for(PvmTransition pvmTransition : pvmTransitions){
				String name = (String)pvmTransition.getProperty("name");
				if(StringUtils.isNotBlank(name)){
					list.add(name);
				}else{
					list.add("默认提交");
				}
			}
		}
		
		
		String repairId = runtimeService.createProcessInstanceQuery().processInstanceId(pi)
		              .singleResult().getBusinessKey().split(":")[1];
		RepairAudit repairAudit = systemService.findEntityById(Long.parseLong(repairId), RepairAudit.class);
		
		
		/**
		 * 获取历史批注
		 */
		List<Comment> comments = new ArrayList<Comment>();
		List<HistoricTaskInstance> historicTaskInstances = historyService.createHistoricTaskInstanceQuery()
				                                                         .processInstanceId(pi)
				                                                         .list();
		if(historicTaskInstances !=null && historicTaskInstances.size() > 0){
			for(HistoricTaskInstance historicTaskInstance : historicTaskInstances){
				String htaskId = historicTaskInstance.getId();
				List<Comment> taskList = taskService.getTaskComments(htaskId);
				comments.addAll(taskList);
			}
		}
		
        List<ActivityComment> accomment = new ArrayList<ActivityComment>();
		
		for(Comment comment : comments){
			ActivityComment activityComment = new ActivityComment();
			activityComment.setTime(Format.dateToStr(comment.getTime()));
			activityComment.setUsername(CodeDictionary.syscode_traslate("base_staff", "staffcode", "staffname", comment.getUserId()));
			activityComment.setMsg(comment.getFullMessage());
			accomment.add(activityComment);
			
		}
		mav.addObject("orgname",CodeDictionary.syscode_traslate("base_org", "orgcode", "orgname", repairAudit.getApporgCode()));
		mav.addObject("repairAudit",repairAudit);
		mav.addObject("outcomelist", list);
		mav.addObject("taskId",taskId);
		mav.addObject("comments", accomment);
		return mav;
	}
	
	
	@RequestMapping(params = "produceContract")
	@ResponseBody
	public void produceContract(HttpServletRequest request, HttpServletResponse response) throws IOException{
		AjaxResultJson j = new AjaxResultJson();
		boolean flag = true;
		String message;
		String id = request.getParameter("id");
		
		RepairAudit repairAudit = systemService.findEntityById(Long.parseLong(id), RepairAudit.class);
		if(null !=repairAudit.getAudittable()&&!repairAudit.getAudittable().equals("")){
			message = "审核表已经存在!!!";
		}else{
			List<ProcessInstance> processInstances = processEngine.getRuntimeService().createProcessInstanceQuery().list();

			for(ProcessInstance processInstance : processInstances){
				if(processInstance.getProcessInstanceId().equals(repairAudit.getProcessInstanceId())){
					flag = false;
				}
			}
			
			if(flag){
				/**
				 * 获取历史批注
				 */
				List<Comment> comments = new ArrayList<Comment>();
				List<HistoricTaskInstance> historicTaskInstances = processEngine.getHistoryService().createHistoricTaskInstanceQuery()
						                                                         .processInstanceId(repairAudit.getProcessInstanceId())
						                                                         .list();
				if(historicTaskInstances !=null && historicTaskInstances.size() > 0){
					for(HistoricTaskInstance historicTaskInstance : historicTaskInstances){
						String htaskId = historicTaskInstance.getId();
						List<Comment> taskList = processEngine.getTaskService().getTaskComments(htaskId);
						comments.addAll(taskList);
					}
				}
				String tempfilename = Util.getName();
				File f = new File(Util.getfileCfg().get("uploadfilepath")+tempfilename+".doc");
				if (!f.getParentFile().exists())
					f.getParentFile().mkdirs();

				WordUtils.produceWord(Util.getfileCfg().get("uploadfilepath")+tempfilename+".doc", Util.getFilepath("wordtemplate/repairaudit_template.doc"), getCommentMap(repairAudit,comments));
				
				repairAudit.setAudittable(tempfilename+".doc");
				systemService.saveEntity(repairAudit);
			}
			if(flag){
				message = "合同生成成功";
			}else{
				message = "合同还在审核中，无法生成";
			}
			
		}
		
		j.setMsg(message);
		SystemUtils.jsonResponse(response, j);
		
		
		
	}
	
	public Map<String, String> getCommentMap(RepairAudit repairAudit,List<Comment> comments){
		Map<String, String> map = new HashMap<String, String>();
		Calendar c = Calendar.getInstance();
		c.setTime(repairAudit.getAppDate());
		map.put("y0", c.get(Calendar.YEAR)+"");
		map.put("m0", (c.get(Calendar.MONTH)+1)+"");
		map.put("d0", c.get(Calendar.DAY_OF_MONTH)+"");
		map.put("projectName", Format.NullToBlank(repairAudit.getProjectName()));
		map.put("apporgCode", CodeDictionary.syscode_traslate("base_org", "orgcode", "orgname", Format.NullToBlank(repairAudit.getApporgCode())));
		map.put("repairFree", repairAudit.getRepairFree()+"");
		map.put("repairContent", repairAudit.getRepairContent());
		map.put("apporgOpinion", repairAudit.getApporgOpinion());
		for(Comment comment : comments){

			if(comment.getUserId().equals(UnitDao.getOfficeAudit())){
				map.put("gkorgOpinion", comment.getFullMessage());
			}
			
			if(comment.getUserId().equals(UnitDao.getOfficeAudit())){
				map.put("ysorgOpinion", comment.getFullMessage());
			}
			if(comment.getUserId().equals(UnitDao.getCityComanyAudit("NC.01.05"))){
				map.put("sxborgOpinion", comment.getFullMessage());
			}
		}
		
	
		return map;
	}
}
