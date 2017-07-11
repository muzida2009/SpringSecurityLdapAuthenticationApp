Ext.define('voLte.view.main.MainController', {
    extend: 'Ext.app.ViewController',

    alias: 'controller.main',

    init: function(view) {
    	gv_mainCtr = this;
    	gv_mpcMapList = [];

    	var tabpanel = this.lookupReference('tabpanel');
    	var newTab = tabpanel.add({
       		id : 'ov',
            title : '概览',
	            xtype: 'oVPanel',
	            closable: true
	        });
		tabpanel.setActiveTab(newTab);

		sessionStorage.menuCollapsed = false;
		sessionStorage.trendExpand = true;
    },
    fn_checkLogin: function () {
    	var loggedIn = sessionStorage.getItem("LoggedIn");
    	if(loggedIn == undefined)
    		window.location.href = '../views/login.jsp'
    },
    onClickLogout: function () {
    	sessionStorage.removeItem('LoggedIn');
    	window.location.href = '../views/login.jsp'
    },
    panel_main_onResize: function () {
    	this.getView().updateLayout();
    },
    tree_left_onCollapse: function () {
    	//us map
    	if(!isEmpty(usMap)){
    		$('#map').css("width",document.body.clientWidth*0.45);
        	usMap.resize();
    	}
    	//mpc map
    	if(!isEmpty(gv_mpcMapList)){
    		if(sessionStorage.trendExpand == 'true'){
    			$(".mapContainer").css("width",document.body.clientWidth*0.465);
    		}else{
    			$(".mapContainer").css("width",document.body.clientWidth*0.95);
    		}
    		for(var i=0,len = gv_mpcMapList.length; i < len; i++){
    			gv_mpcMapList[i].myMap.resize();
    		}
    	}
    	sessionStorage.menuCollapsed = true;
    },
    tree_right_onExpand: function () {
    	//us map
    	if(!isEmpty(usMap)){
    		$('#map').css("width",document.body.clientWidth*0.4);
        	usMap.resize();
    	}
    	//mpc map
    	if(!isEmpty(gv_mpcMapList)){
    		if(sessionStorage.trendExpand == 'true'){
    			$(".mapContainer").css("width",document.body.clientWidth*0.41);
    		}else{
    			$(".mapContainer").css("width",document.body.clientWidth*0.8);
    		}
    		for(var i=0,len = gv_mpcMapList.length; i < len; i++){
    			gv_mpcMapList[i].myMap.resize();
    		}
    	}
    	sessionStorage.menuCollapsed = false;
    },
    fn_menuFilter: function () {
    	var treeStore = this.getStore('treeStore');

//    	session menulist filter
    	var chilNodes = [];
    	for(var i=0,le=menulist.length; i<le; i++){

	    		if(menulist[i] == '概览'){
		    			chilNodes.push({ text: '概览', id:'ov', expanded: false, leaf: true, children: []
		        		});
	        	}else if(menulist[i] == 'KQI指标统计分析'){
		        		chilNodes.push({ text: 'KQI指标统计分析', id:'st', expanded: true, children: [
				        		                        			    	                { text: '接入性指标', id:'st-1',expanded: true,children: [
				        		                        										    	                { text: 'VoLTE语音接通率',id:'st-1-1', leaf: true },
				        		                        										    	                { text: 'VoLTE视频接通率',id:'st-1-2', leaf: true},
				        		                        										    	                { text: 'VoLTE始呼接入时长',id:'st-1-3', leaf: true}
				        		                        									    	                ]
				        		                        									    	                },
				        		                        			    	                { text: '移动性指标',id:'st-2', expanded: true,children: [
				        		                        										    	                { text: 'SRVCC切换成功率',id:'st-2-1', leaf: true },
				        		                        										    	                { text: 'SRVCC切换时长',id:'st-2-2', leaf: true}
				        		                        									    	                ]
				        		                        									    	                },
			                    									    	                { text: '保持性指标',id:'st-3', expanded: true,children: [
		                    									    	                                                { text: 'VoLTE应答率',id:'st-3-1', leaf: true},
				        		                        										    	                { text: 'VoLTE语音掉话率',id:'st-3-2', leaf: true },
				        		                        										    	                { text: 'VoLTE视频掉话率',id:'st-3-3', leaf: true}
				        		                        									    	                ]
				        		                        									    	                },
			                    									    	                { text: '附着',id:'st-4', expanded: true,children: [
				        		                        										    	                { text: 'Attach成功率',id:'st-4-1', leaf: true }
				        		                        									    	                ]
				        		                        									    	                },
			                    									    	                { text: '注册',id:'st-5', expanded: true,children: [
				        		                        										    	                { text: 'IMS注册成功率',id:'st-5-1', leaf: true }
				        		                        									    	                ]
				        		                        									    	                }
				        		                        		    	                ]
		        		  });
	        	}else if(menulist[i] == 'MPC定界'){
		        		chilNodes.push({ text: 'MPC定界', id:'mpc', expanded: false, leaf: true, children: []
		        		});
	        	}else if(menulist[i] == 'VoLte端到端信令回溯'){
		        		chilNodes.push({ text: 'VoLte端到端信令回溯', id:'us', expanded: false, leaf: true, children: []
		        		 });
	          	}else if(menulist[i] == '系统管理'){
		          		chilNodes.push({ text: '系统管理', id:'admin', expanded: true, children: [
				        		                     			    	                { text: '系统管理', children: [
				        		                    										    	                { text: '系统管理1', leaf: true },
				        		                    										    	                { text: '系统管理2', leaf: true}
				        		                    									    	                ]
				        		                    									    	                },
				        		                    			    	                { text: '用户管理', children: [
				        		                    										    	                { text: '用户管理1', leaf: true },
				        		                    										    	                { text: '用户管理2', leaf: true}
				        		                    									    	                ]
				        		                    									    	                }
				        		                    		    	                ]
		        		});
	            }
    	}
    	var treeStore = Ext.create('Ext.data.TreeStore', {
    	    root: {
    	        expanded: true,
    	        children: [
		    	            { text: 'EOP', id:'eop', expanded: true, children: [{ text: 'VoLte', id:'volte', expanded: true, children: chilNodes }] }
		    	          ]
    	    }
    	});

    	this.lookupReference('treepanel').bindStore(treeStore);
    },

    lk_tree_onClick: function(v,r,item){
    	var tabpanel = this.lookupReference('tabpanel');

    	var n = tabpanel.getComponent(r.raw.id);

    	if(r.raw.id=='ov'){
			if (n == undefined) {
				var newTab = tabpanel.add({
	           		id : r.raw.id,
	                title : r.raw.text,
       	            xtype: 'oVPanel',
       	            closable: true
       	        });
				tabpanel.setActiveTab(newTab);
	    	}else{
	    		tabpanel.setActiveTab(n);
	    	}
    	}else if(r.raw.id=='mpc'){
    	   if (n == undefined) {
				var newTab = tabpanel.add({
					id : r.raw.id,
	                title : r.raw.text,
	   	            xtype: 'mPCPanel',
	   	            closable: true
	   	        });
				tabpanel.setActiveTab(newTab);
	    	}else{
	    		tabpanel.setActiveTab(n);
	    	}
    	}else if(r.raw.id=='us'){
	   	   if (n == undefined) {
					var newTab = tabpanel.add({
		           		id : r.raw.id,
		                title : r.raw.text,
		   	            xtype: 'uSPanel',
		   	            closable: true
		   	        });
					tabpanel.setActiveTab(newTab);
		    	}else{
		    		tabpanel.setActiveTab(n);
		    	}
    	}else if(r.raw.id=='admin'){

    		//指标统计子节点单击打开对应的tabpanel
    	}else if(r.raw.id == 'st-1-1'){	//1.
			  if (n == undefined) {
					var newTab = tabpanel.add({
						id : r.raw.id,
		                title : r.raw.text,
		   	            xtype: 'sTPanel',
		   	            closable: true,
		   	        });
					tabpanel.setActiveTab(newTab);
		    	}else{
		    		tabpanel.setActiveTab(n);
		    	}
		  }else if(r.raw.id == 'st-1-2'){	//2.
			  if (n == undefined) {
				var newTab = tabpanel.add({
					id : r.raw.id,
	                title : r.raw.text,
	   	            xtype: 'sTPanel',
	   	            closable: true
	   	        });
				tabpanel.setActiveTab(newTab);
	    	}else{
	    		tabpanel.setActiveTab(n);
	    	}
		  }else if(r.raw.id == 'st-1-3'){	//3.
			if (n == undefined) {
				var newTab = tabpanel.add({
					id : r.raw.id,
	                title : r.raw.text,
	   	            xtype: 'sTPanel',
	   	            closable: true
	   	        });
				tabpanel.setActiveTab(newTab);
	    	}else{
	    		tabpanel.setActiveTab(n);
	    	}
		  }else if(r.raw.id == 'st-2-1'){	//4.
			  if (n == undefined) {
				var newTab = tabpanel.add({
					id : r.raw.id,
	                title : r.raw.text,
	   	            xtype: 'sTPanel',
	   	            closable: true
	   	        });
				tabpanel.setActiveTab(newTab);
	    	}else{
	    		tabpanel.setActiveTab(n);
	    	}
		  }else if(r.raw.id == 'st-2-2'){	//5.
			  if (n == undefined) {
				var newTab = tabpanel.add({
					id : r.raw.id,
	                title : r.raw.text,
	   	            xtype: 'sTPanel',
	   	            closable: true
	   	        });
				tabpanel.setActiveTab(newTab);
	    	}else{
	    		tabpanel.setActiveTab(n);
	    	}
		  }else if(r.raw.id == 'st-3-1'){	//6.
			  if (n == undefined) {
				var newTab = tabpanel.add({
					id : r.raw.id,
	                title : r.raw.text,
	   	            xtype: 'sTPanel',
	   	            closable: true
	   	        });
				tabpanel.setActiveTab(newTab);
	    	}else{
	    		tabpanel.setActiveTab(n);
	    	}
		  }else if(r.raw.id == 'st-3-2'){	//7.
			  if (n == undefined) {
				var newTab = tabpanel.add({
					id : r.raw.id,
	                title : r.raw.text,
	   	            xtype: 'sTPanel',
	   	            closable: true
	   	        });
				tabpanel.setActiveTab(newTab);
	    	}else{
	    		tabpanel.setActiveTab(n);
	    	}
		  }else if(r.raw.id == 'st-3-3'){	//8.
			  if (n == undefined) {
				var newTab = tabpanel.add({
					id : r.raw.id,
	                title : r.raw.text,
	   	            xtype: 'sTPanel',
	   	            closable: true
	   	        });
				tabpanel.setActiveTab(newTab);
	    	}else{
	    		tabpanel.setActiveTab(n);
	    	}
		  }else if(r.raw.id == 'st-4-1'){	//9.
			  if (n == undefined) {
				var newTab = tabpanel.add({
					id : r.raw.id,
	                title : r.raw.text,
	   	            xtype: 'sTPanel',
	   	            closable: true
	   	        });
				tabpanel.setActiveTab(newTab);
	    	}else{
	    		tabpanel.setActiveTab(n);
	    	}
		  }else if(r.raw.id == 'st-5-1'){	//10.
			  if (n == undefined) {
				var newTab = tabpanel.add({
					id : r.raw.id,
	                title : r.raw.text,
	   	            xtype: 'sTPanel',
	   	            closable: true
	   	        });
				tabpanel.setActiveTab(newTab);
	    	}else{
	    		tabpanel.setActiveTab(n);
	    	}
		  }
     },
     gfn_getPanelElement: function (me,reference) {
    	 if(!isEmpty(me.lookupReference(reference))){
    		 var el = me.lookupReference(reference).el.dom.childNodes[0].childNodes[0];
		 }
    	 return el;
     },
     gfn_getInnerElement: function (me,reference,i) {
    	 if(i == null){
    		 if(!isEmpty(me.lookupReference(reference))){
    			 var el = me.lookupReference(reference).body.dom.childNodes[0].childNodes[0].childNodes[0];
    		 }
    	 }else{
    		 if(!isEmpty(me.lookupReference(reference))){
    			 var el = me.lookupReference(reference).body.dom.childNodes[0].childNodes[0].childNodes[i];
    		 }
    	 }
    	 return el;
     }
});
