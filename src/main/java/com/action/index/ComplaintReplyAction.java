package com.action.index;

import javax.servlet.http.HttpServletRequest;

import com.action.ActionInterface;
import com.common.EntityOperation;
import com.entity.index.Complaint;

public class ComplaintReplyAction extends ActionInterface{
	@Override
	public String getResult(HttpServletRequest request) {
		String res = "";
		String res0 ="";
		String action = request.getParameter("act");
		
		EntityOperation eo = new EntityOperation();
		if (action != null && action.equals("add"))
		{
			
			String entity=request.getParameter("entity");
			eo.setEntity(entity);
			res0 = eo.Add(request);
			new Complaint().modifyComplaint(request.getParameter("TBM_COMPLAINTREPLY.COMPLAINTNO"));
			res += "window.close();";
		}
		return res;
	}
}
