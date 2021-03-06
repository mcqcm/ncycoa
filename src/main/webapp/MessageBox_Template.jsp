<%@page contentType="text/html;charset=gb2312" language="java" errorPage=""%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title></title>
<script language="javascript" src="js/public/MessageBox.js"></script>
</head>
<style type="text/css">
/*定义界面主体包括（字体、边距、滚动条样式）*/
body { 
    font-family: "arial", "helvetica", "sans-serif", ""; 
	font-size: 9pt; 
    margin: 0px;
	scrollbar-face-color:#efefe7;
    scrollbar-highlight-color:#ffffff;
    scrollbar-3dlight-color:#a5a5a5;
    scrollbar-darkshadow-color:#a5a5a5;
    scrollbar-shadow-color:#d6d6ce;
    scrollbar-arrow-color:#003184;
    scrollbar-track-color:#deded6;
	}
/*表格缺省样式*/
table { 
    font-family: "arial", "helvetica", "sans-serif",""; 
	font-size: 9pt; 
	line-height: 150%; 
	color: #000000;
	 }
/**按钮组合样式**/
/*初始状态 */ 
.button
    {
	border-bottom: #596CA5 1px solid;
	border-left: #8596CA 1px solid;
	border-right: #596CA5 1px double;
	border-top: #8596CA 1px solid;
	padding-left: 6px;
	padding-right: 6px;
	font-size:9pt;
	text-align:center;
	vertical-align:top;
	height:19px;
	cursor:pointer;
	background-image: url(images/button_fill_up.gif);
	status:expression(
						onmouseover == null?
							(onmouseover = function()
							{
								this.style.borderRight=this.style.borderBottom = "solid 1px #CE6B00";
								this.style.borderLeft=this.style.borderTop = "solid 1px #FFB56B";
								this.style.backgroundImage="url(images/button_fill_up.gif)";
							}):true,
						onmouseout == null?
							(onmouseout = function()
							{
								if(this.gotFocus)
								{
									this.style.borderLeft=this.style.borderTop = "solid 1px #5198dd";
									this.style.borderRight = this.style.borderBottom = "solid 1px #003074";
								}
								else
								{
									this.style.borderRight=this.style.borderBottom = "solid 1px #596CA5";
									this.style.borderLeft=this.style.borderTop = "solid 1px #8596CA";
								}
								this.style.backgroundImage="url(images/button_fill_up.gif)";
							}):true,
						onfocus == null?
							(onfocus = function()
							{
								this.gotFocus = true;
								this.style.borderLeft=this.style.borderTop = "solid 1px #5198dd";
								this.style.borderRight = this.style.borderBottom = "solid 1px #003074";
							}):true,
						onblur == null?
							(onblur = function()
							{
								this.gotFocus = false;
								this.style.borderRight=this.style.borderBottom = "solid 1px #596CA5";
								this.style.borderLeft=this.style.borderTop = "solid 1px #8596CA";
							}):true,
						onmousedown == null?
							(onmousedown = function()
							{
								this.style.borderRight=this.style.borderBottom = "solid 1px #CE6B00";
								this.style.borderLeft=this.style.borderTop = "solid 1px #FFB56B";
								this.style.backgroundImage="url(images/button_fill_down.gif)";								
							}):true,
						onmouseup == null?
							(onmouseup = function()
							{
								this.style.borderRight=this.style.borderBottom = "solid 1px #CE6B00";
								this.style.borderLeft=this.style.borderTop = "solid 1px #FFB56B";
								this.style.backgroundImage="url(images/button_fill_up.gif)";
							}):true,
						this.setDisable?
							(disabled?(this.className="buttonforbid"):false,this.setDisable=true):true
					);
    }
</style>
<script language="javascript">

	self.buttons = new Array();

	function PageLoad()
	{
		var caption = dialogArguments.userArgs.caption;
		caption = caption == null?"":caption;

		var text = dialogArguments.userArgs.text;
		text = text == null?"":text;

		var icon = dialogArguments.userArgs.icon;
		icon = icon == null?"":icon;

		var buttons = dialogArguments.userArgs.buttons;
		buttons = buttons == null?"": MessageBoxButtons[buttons];

		var defaultButton = dialogArguments.userArgs.defaultButton;
		defaultButton = defaultButton == null?0:defaultButton;

		var info = dialogArguments.userArgs.info;

		if(info != null)
		{
		    //begin-end之间是修改后的版本
			//------begin------
			var msg =info;
			//-------end---
			 
			/*此处作为保留信息，有谁能研究的，最好研究一下
			var text = "[" + info.actionName + "]\n";
			text += "成功："+info.successCounts+"记录，失败："+info.failCounts+"记录";

			var infoList = document.getElementById("infoList");
			
			var msg = "";
			for (var i = 0; i < info.objectList.length; i++)
			{	
				msg += "[" + info.actionName + "] ";
				msg += info.objectList[i].modelName + "(" +info.objectList[i].modelCode + ")<br>";
				if(info.objectList[i].failReason != null) msg += info.objectList[i].failReason;
				else msg += "操作成功!";
				msg += "<br>";
			}
			*/
			infoList.innerHTML = msg;
		}

		self.document.body.innerHTML = self.document.body.innerHTML
										.replace(/\{\$text\}/g,text)
										.replace(/\{\$icon\}/g,icon)
										.replace(/\{\$buttons\}/g,buttons)
										.replace(/\{\$caption\}/g,caption);
		
		var buttonList = document.getElementById("_buttons").childNodes;

		for (var i = 0; i < buttonList.length; i++)
		{
			if(buttonList[i].name == "__msgbox_button") self.buttons.push(buttonList[i]);
		}
		self.document.body.style.display = "block";
		self.focus();
		self.buttons[defaultButton].focus();
		self.buttons.activeButton = defaultButton;

	}
	function KeyUp()
	{
		if(event.keyCode == 27)
			MessageBoxAction.MB_Cancel();
		else if(event.keyCode == 13)
			self.buttons[self.buttons.activeButton].click();
		else if(event.keyCode == 9)
		{
			self.buttons.activeButton = (++self.buttons.activeButton) % self.buttons.length;
			self.buttons[self.buttons.activeButton].focus();
			return false;
		}
	}
</script>
<body bgcolor="E7E7E7" style="overflow:hidden" onload="PageLoad()" style="display:none" onkeyup="KeyUp()">
<table width="429" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="150" valign="top" background="images/info_fill.gif"><img id="_icon" src="{$icon}" width="150" height="138"></td>
    <td valign="top" background="images/info_fill.gif" style="padding-top:28px;padding-right:10px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>{$text}</td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="429" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td background="info_compart.gif" width="2px"></td>
  </tr>
</table>
<table width="429" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="right" bgcolor="E7E7E7" style="padding:10px;">
	<table border="0" cellspacing="0" cellpadding="0">
        <tr id="_buttons">
          {$buttons}
        </tr>
      </table></td>
  </tr>
</table>
 <div align=center id="infoList" style="height:128;width:100%;overflow:auto;border:thin inset;background:#E3E3E3;text-align:left">
 </div>
</body>
</html>
