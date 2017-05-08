function createwindow(title, url, width, height) {
		width = width ? width : 700;
		height = height ? height : 400;
		if (width == "100%" || height == "100%") {
			width = document.body.offsetWidth;
			height = document.body.offsetHeight - 100;
		}
		if (typeof (windowapi) == 'undefined') {
			$.dialog({
				//data:returnValue,
				content : 'url:' + url,
				lock : false,
				width : width,
				height : height,
				title : title,
				opacity : 0.3,
				cache : false,
				button: [
        		{
            			name: '����',
            			callback: function(){
                			$('#F8', this.iframe.contentWindow.document).click();
                   			disabled: false
                   			      setTimeout(function(){
                   			      window.location.reload();
                   			      return true;
                   			       },1000);
               				 return false;
            			}	
        		}
        		],
				cancelVal : '�ر�',

				cancel :function(){
				window.location.reload();
				},
				close:function(){
				//window.location.reload();
				return true;
				}
				
			});
		}
	}
function createwindowIframe(title, url, width, height,siframe) {
		width = width ? width : 700;
		height = height ? height : 400;
		if (width == "100%" || height == "100%") {
			width = document.body.offsetWidth;
			height = document.body.offsetHeight - 100;
		}
		if (typeof (windowapi) == 'undefined') {
			$.dialog({
				//data:returnValue,
				content : 'url:' + url,
				lock : true,
				width : width,
				height : height,
				title : title,
				opacity : 0.3,
				cache : false,
				button: [
        		{
            			name: '����',
            			callback: function(){
                			$('#F8', this.iframe.contentWindow.document.getElementById(siframe).contentWindow.document).click();
                   			disabled: false
                   			      setTimeout(function(){
                   			      window.location.reload();
                   			      return true;
                   			       },1000);
               				 return false;
            			}	
        		}
        		],
				cancelVal : '�ر�',

				cancel :function(){
				window.location.reload();
				},
				close:function(){
				//window.location.reload();
				return true;
				}
				
			});
		}
	}

function createwindowNoRefresh(title, url, width, height) {
		width = width ? width : 700;
		height = height ? height : 400;
		if (width == "100%" || height == "100%") {
			width = document.body.offsetWidth;
			height = document.body.offsetHeight - 100;
		}
		if (typeof (windowapi) == 'undefined') {
			$.dialog({
				//data:returnValue,
				content : 'url:' + url,
				lock : true,
				width : width,
				height : height,
				title : title,
				opacity : 0.3,
				cache : false,
				button: [
        		{
            			name: '����',
            			callback: function(){
                			$('#F8', this.iframe.contentWindow.document).click();
                   			disabled: false
               				 return true;
            			}	
        		}
        		],
				cancelVal : '�ر�',

				cancel :function(){
				//window.location.reload();
				},
				close:function(){
				//window.location.reload();
				return true;
				}
				
			});
		}
	}
function createwindowNoSave(title, url, width, height) {
		width = width ? width : 700;
		height = height ? height : 400;
		if (width == "100%" || height == "100%") {
			width = document.body.offsetWidth;
			height = document.body.offsetHeight - 100;
		}
		if (typeof (windowapi) == 'undefined') {
			$.dialog({
				//data:returnValue,
				content : 'url:' + url,
				lock : true,
				width : width,
				height : height,
				title : title,
				opacity : 0.3,
				cache : false,
				cancelVal : '�ر�',
				cancel :function(){
				window.location.reload();
				},
				close:function(){
				//window.location.reload();
				return true;
				}
				
			});
		}
	}
function createwindowNoButton(title, url, width, height) {
		width = width ? width : 700;
		height = height ? height : 400;
		if (width == "100%" || height == "100%") {
			width = document.body.offsetWidth;
			height = document.body.offsetHeight - 100;
		}
		if (typeof (windowapi) == 'undefined') {
			$.dialog({
				content : 'url:' + url,
				lock : false,
				modal:true, 
				width : width,
				height : height,
				title : title,
				opacity : 0.3,
				cache : false,
				close:function(){
				//window.location.reload();
				return true;
				}
				
			});
		}
	}
function createwindowUpFile(title, url, width, height) {
		width = width ? width : 700;
		height = height ? height : 400;
		if (width == "100%" || height == "100%") {
			width = document.body.offsetWidth;
			height = document.body.offsetHeight - 100;
		}
		if (typeof (windowapi) == 'undefined') {
			$.dialog({
				//data:returnValue,
				content : 'url:' + url,
				lock : true,
				width : width,
				height : height,
				title : title,
				opacity : 0.3,
				cache : false,
				button: [
        		{
            			name: '�ϴ�',
            			callback: function(){
                			$('#F8', this.iframe.contentWindow.document).click();
                			$.dialog.tips('�ļ��ϴ��С�������ȴ�',600,'loading.gif');
                   			disabled: false
               				 return false;
            			},
            			focus:true
        		}
        		],
				cancelVal : '�ر�',

				cancel :function(){
				//window.location.reload();
				},
				close:function(){
				window.location.reload();
				return true;
				}
				
			});
		}
	}