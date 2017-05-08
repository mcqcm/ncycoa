package edu.cqu.ncycoa.safety.web.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import edu.cqu.ncycoa.common.dto.AjaxResultJson;
import edu.cqu.ncycoa.common.dto.DataGrid;
import edu.cqu.ncycoa.common.dto.QueryDescriptor;
import edu.cqu.ncycoa.common.service.CommonService;
import edu.cqu.ncycoa.common.service.SystemService;
import edu.cqu.ncycoa.common.tag.TagUtil;
import edu.cqu.ncycoa.common.util.dao.QueryUtils;
import edu.cqu.ncycoa.common.util.dao.TQOrder;
import edu.cqu.ncycoa.common.util.dao.TypedQueryBuilder;
import edu.cqu.ncycoa.safety.domain.HiddenDangerImprovement;
import edu.cqu.ncycoa.util.ConvertUtils;
import edu.cqu.ncycoa.util.Globals;
import edu.cqu.ncycoa.util.MyBeanUtils;
import edu.cqu.ncycoa.util.SystemUtils;

@Controller
@RequestMapping("/hiddendangerimprovement_management")
public class HiddenDangerImprController {
	@Resource(name="systemService")
	SystemService systemService;
	@RequestMapping(params="add")
	public String add(HttpServletRequest request) {
		return "safeproduction_management/addhiddendangermark";
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
			message = "���ݲ��Ϸ�";
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
			j.setSuccess(false);
			SystemUtils.jsonResponse(response, j);
			return;
		}
		
		systemService.removeEntities(ids, HiddenDangerImprovement.class);
		message = "������ɾ���ɹ�";
		j.setMsg(message);
		SystemUtils.jsonResponse(response, j);
	}
	
	@RequestMapping(params="update_mark")
    public ModelAndView updateMark(HttpServletRequest request, HttpServletResponse response){
		String id = request.getParameter("id"); 
		HiddenDangerImprovement hiddenDangerImprovement = systemService.findEntityById(Long.parseLong(id), HiddenDangerImprovement.class);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("safeproduction_management/addhiddendangermark");
		mav.addObject("hiddenDangerImprovement",hiddenDangerImprovement);
		return mav;
	}
	
	@RequestMapping(params="update")
    public ModelAndView update(HttpServletRequest request, HttpServletResponse response){
		String id = request.getParameter("id"); 
		HiddenDangerImprovement hiddenDangerImprovement = systemService.findEntityById(Long.parseLong(id), HiddenDangerImprovement.class);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("safeproduction_management/addhiddendangerimprovement");
		mav.addObject("hiddenDangerImprovement",hiddenDangerImprovement);
		return mav;
	}
	
	@RequestMapping(params = "save")
	@ResponseBody
	public void save(HiddenDangerImprovement hiddenDangerImprovement, HttpServletRequest request, HttpServletResponse response) {
		AjaxResultJson j = new AjaxResultJson();
		String message;
		if (hiddenDangerImprovement.getId() != null) {
			message = "�����Ҹ��³ɹ�";
			HiddenDangerImprovement t = systemService.findEntityById(hiddenDangerImprovement.getId(), HiddenDangerImprovement.class);
			try {
				MyBeanUtils.copyBeanNotNull2Bean(hiddenDangerImprovement, t);
				
				systemService.saveEntity(t);
				
			} catch (Exception e) {
				message = "�����Ҹ���ʧ��";
				systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
			}
		} else {
			message = "���������ӳɹ�";
			
			systemService.addEntity(hiddenDangerImprovement);
			
		}
		
		j.setMsg(message);
		SystemUtils.jsonResponse(response, j);
	}
	
	@RequestMapping(params="dgview_mark") //�鿴�����Ǽ�
	public String dgViewMark(HttpServletRequest request) {
		
		return "safeproduction_management/hiddendangermarklist";
		
	}
	
	@RequestMapping(params="dgview") //�鿴�������
	public String dgView(HttpServletRequest request) {
		
		return "safeproduction_management/hiddendangerimprovementlist";
		
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params="dgdata_mark")
	@ResponseBody
	public void dgDataMark(HiddenDangerImprovement hiddenDangerImprovement, DataGrid dg, HttpServletRequest request, HttpServletResponse response) {
		QueryDescriptor<HiddenDangerImprovement> cq = new QueryDescriptor<HiddenDangerImprovement>(HiddenDangerImprovement.class, dg);
		
		CommonService commonService = SystemUtils.getCommonService(request);
		//��ѯ������װ��
		TypedQueryBuilder<HiddenDangerImprovement> tqBuilder = QueryUtils.getTQBuilder(hiddenDangerImprovement, request.getParameterMap());
		
		if (StringUtils.isNotEmpty(dg.getSort())) {
			tqBuilder.addOrder(new TQOrder(tqBuilder.getRootAlias() + "." + dg.getSort(), dg.getOrder().equals("asc")));
		}
		cq.setTqBuilder(tqBuilder);
		commonService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dg);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params="dgdata")
	@ResponseBody
	public void dgData(HiddenDangerImprovement hiddenDangerImprovement, DataGrid dg, HttpServletRequest request, HttpServletResponse response) {
		QueryDescriptor<HiddenDangerImprovement> cq = new QueryDescriptor<HiddenDangerImprovement>(HiddenDangerImprovement.class, dg);
		
		CommonService commonService = SystemUtils.getCommonService(request);
		//��ѯ������װ��
		TypedQueryBuilder<HiddenDangerImprovement> tqBuilder = QueryUtils.getTQBuilder(hiddenDangerImprovement, request.getParameterMap());
		
		if (StringUtils.isNotEmpty(dg.getSort())) {
			tqBuilder.addOrder(new TQOrder(tqBuilder.getRootAlias() + "." + dg.getSort(), dg.getOrder().equals("asc")));
		}
		cq.setTqBuilder(tqBuilder);
		commonService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dg);
	}


}