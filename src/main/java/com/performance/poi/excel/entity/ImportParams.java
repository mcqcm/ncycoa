package com.performance.poi.excel.entity;

/**
 * 导入参数设置
 */
public class ImportParams {
	/**
	 * 表格标题行数,默认0
	 */
	private int titleRows = 0;
	/**
	 * 表格副标题行数,默认1
	 */
	private int secondTitleRows = 1;
	/**
	 * 字段真正值和列标题之间的距离 默认0
	 */
	private int startRows = 0;
	/**
	 * 主键设置,如果这个cell没有??就跳??
	 * 或??认为这个是list的下面的??
	 */
	private int keyIndex = 0;
	/**
	 * 上传表格????读取的sheet 数量,默认??
	 */
	private int sheetNum = 1;
	/**
	 * 是否需要保存上传的Excel,默认为false
	 */
	private boolean needSave = false;
	/**
	 * 保存上传的Excel目录,默认：
	 * TestEntity这个类保存路径就是
	 * upload/excelUpload/Test/yyyyMMddHHmss_*****
	 * 保存名称上传时间_五位随机数
	 */
	private String saveUrl = "upload/excelUpload";

	public int getTitleRows() {
		return titleRows;
	}

	public void setTitleRows(int titleRows) {
		this.titleRows = titleRows;
	}

	public int getSecondTitleRows() {
		return secondTitleRows;
	}

	public void setSecondTitleRows(int secondTitleRows) {
		this.secondTitleRows = secondTitleRows;
	}

	public int getStartRows() {
		return startRows;
	}

	public void setStartRows(int startRows) {
		this.startRows = startRows;
	}

	public int getSheetNum() {
		return sheetNum;
	}

	public void setSheetNum(int sheetNum) {
		this.sheetNum = sheetNum;
	}

	public int getKeyIndex() {
		return keyIndex;
	}

	public void setKeyIndex(int keyIndex) {
		this.keyIndex = keyIndex;
	}

	public boolean isNeedSave() {
		return needSave;
	}

	public void setNeedSave(boolean needSave) {
		this.needSave = needSave;
	}

	public String getSaveUrl() {
		return saveUrl;
	}

	public void setSaveUrl(String saveUrl) {
		this.saveUrl = saveUrl;
	}

}
