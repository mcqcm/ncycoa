package edu.cqu.ncycoa.common.dto;

import java.util.List;

import edu.cqu.ncycoa.util.SystemUtils;


/**
 * easyui的datagrid向后台传递参数使用的dto
 */
public class DataGrid {

	private int page = 1;					// 当前页
	private int rows = 10;					// 每页显示记录数
	private String sort = null;				// 排序字段名
	private String order = "asc";	// 方向 asc, desc
	private String field;			// 字段
	
	@SuppressWarnings("rawtypes")
	private List results;			// 结果集
	private int total;				// 总记录数
	private String footer;			// 合计列

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public String getField() {
		return field;
	}

	@SuppressWarnings("rawtypes")
	public List getResults() {
		return results;
	}

	public void setResults(@SuppressWarnings("rawtypes") List results) {
		this.results = results;
	}

	public void setField(String field) {
		this.field = field;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		if (SystemUtils.getRequest() != null && SystemUtils.getRequest().getParameter("rows") != null) {
			return rows;
		}
		return 10000;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getFooter() {
		return footer;
	}

	public void setFooter(String footer) {
		this.footer = footer;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

}
