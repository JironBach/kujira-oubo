<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="es.hyrax.object.GroupObject" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Set"%>
<%@ page import="es.hyrax.object.singleton.AccountStrGetter"%>
<%@ page import="es.hyrax.object.AccountObject" %>
<%

      request.setCharacterEncoding("utf-8");
      response.setCharacterEncoding("utf-8");
      AccountObject loginAccountObj = (AccountObject)session.getAttribute("loginAccountObj");
      Map<String,String[]> paramsMap = request.getParameterMap();
      
      
      AccountStrGetter    accountStrGetter = AccountStrGetter.getInstance();
%>
<html>
	<head>
		<!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
		<jsp:include page="/WEB-INF/views/common/meta_header.jsp" flush="false" />
		<!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
		
		<script src="lib/js/external/jquery/jquery.js"></script>
		<script src="lib/js/foundation-datepicker.js"></script>
		<script src="lib/js/jquery-ui.js"></script>
		<script src="lib/js/js_basic_fm.js"></script>
		<script>
			var app_store_id		= new Array("S0000001","S0000002","S0000003"); 
			var app_store_name		= new Array("あ　店","い　店","う　店");
			var app_store_group 	= new Array("心斎橋拠点","梅田拠点","難波拠点");
			
			
			document.addEventListener('DOMContentLoaded',
				function(){
					initialize_screen();
					take_get_parameter();
				}
			);
			
			function initialize_screen(){
				
			}	
			function setParam(name,value){
				var input = document.createElement('input');
				input.setAttribute('type','hidden');
				input.setAttribute('name',name);
				input.setAttribute('value',value);
				return input;
				
			}	


			//function take get parameter
			function take_get_parameter() {
				/*var app_group_name = S_GET("app_group_name"),
					app_group_manager = S_GET("app_group_manager"),
					app_admin_comment = S_GET("app_admin_comment"),
					app_group_store_id = S_GET("app_group_store_id"),
					app_group_store_name = S_GET("app_group_store_name"),
					app_group_store_group = S_GET("app_group_store_group");*/
					
				var app_group_store_id	= '${param.app_group_store_id}',
					app_group_store_name	= '${param.app_group_store_name}',
					app_group_store_group	= '${param.app_group_store_group}',
					app_name 		='${param.app_group_name}',//'<%=request.getParameter("app_brand_name")%>' S_GET("app_brand_name"),
					app_group_manager		='${param.app_group_manager}', 
					app_admin_comment			='${param.app_admin_comment}';//S_GET("app_memo");
					
				document.getElementById("span_group_name").innerHTML = app_name;
				//document.getElementById("div_group_manager").innerHTML = app_job_type;
				document.getElementById("div_admin_comment").innerHTML = app_admin_comment;	
					
					

				var div_group_manager = "";

				document.getElementById("span_group_name").innerHTML = app_name;

			/*	if (app_group_manager != "") {
					var group_manager = new Array();

					group_manager = app_group_manager.split(",");
					
					div_group_manager = document.getElementById("div_group_manager").innerHTML;		
					div_group_manager += "<ul class='ul_access_2'>";					
					for (var i = 0; i < group_manager.length; i++) {
						div_group_manager += "<li>" + group_manager[i] + "</li>"
					};
					div_group_manager += "</ul>";
					document.getElementById("div_group_manager").innerHTML = div_group_manager;
				}*/
				
				if (app_group_manager != "") {

					var group_manager_list = new Array();
					
					//alert('group_manager_list===='  + group_manager_list);
					
					var accountStrGetter =  <%=accountStrGetter.getAccountStrGetterJson()%>;
					
					document.getElementById("div_group_manager").innerHTML = "";
					var div_group_manager = document.getElementById("div_group_manager").innerHTML;

					group_manager_list = app_group_manager.split(",");
					
					div_group_manager += "<ul class='ul_access_2'>";
					for (var i = 0; i < group_manager_list.length; i++) {
						div_group_manager += "<li>" + accountStrGetter[group_manager_list[i] - 1] + "</li>"	
					};
					div_group_manager += "</ul>";

					document.getElementById("div_group_manager").innerHTML = div_group_manager;
				}

				document.getElementById("div_admin_comment").innerHTML = app_admin_comment;

				if (app_group_store_id != "") {
					var group_store_name = new Array(),
						group_store_group = new Array(),
						div_group_store = "";

					group_store_name = app_group_store_name.split(",");
					group_store_group = app_group_store_group.split(",");
					div_group_store = "<ul class='ul_access_2'>";
					for (var i = 0; i < group_store_name.length; i++) {
						div_group_store += "<li>" + group_store_name[i] + " " + group_store_group[i] + "</li>"; 
					};
					div_group_store += "</ul>";
					document.getElementById("div_group_store").innerHTML = div_group_store;
				}
			}
			
		    function back(){
				
				var f = document.createElement("form");
				f.setAttribute('method',"post");
				f.setAttribute('action',"/setting_group_create");                                         
				<%
				for(Map.Entry<String, String[]> e : paramsMap.entrySet()){      
				%>                   
					f.appendChild(setParam('<%=e.getKey()%>','<%=((String[])e.getValue())[0]%>'));                  
				<%
				}
				%>                                          
				var bodyElement = document.body ;
				bodyElement.append(f);
				f.submit();
				
			}
			
			function toServlet(){
				/*var inputName = setParam("name",S_GET("app_brand_name"));
				var f = document.createElement("form");
				f.setAttribute('method',"post");
				f.setAttribute('action',"/setting_group_submit");
				f.appendChild(inputName);
				alert("+++++++setting_brand_create_conf.jsp+++++++++setting_brand_submitへ行くよ");
				var bodyElement = document.body;
				bodyElement.append(f);
				f.submit();*/
				
					var f = document.createElement("form");
					f.setAttribute('method',"post");
					f.setAttribute('action',"/setting_group_submit"); 
					<%
					for(Map.Entry<String, String[]> e : paramsMap.entrySet()){      
					%>
					f.appendChild(setParam('<%=e.getKey()%>','<%=((String[])e.getValue())[0]%>'));
					<%
					}
					%>  
					var bodyElement = document.body ;
					bodyElement.append(f);

					f.submit();
				
			}
		</script>
	</head>
	<body>
         <section class="section section-header bg-kujira-orange">
			<section class="grid-header container grid-1280">
				<div class="text-left">
					<h3><img src="/res/img/logo.png?v=1" width="221"/> </h3>
				</div>
				<div id="header-rigth" class="text-right">
					<!--<a id="hdr_help_nav" href="/applicant#">ヘルプ</a>　-->
					<a id="hdr_logout_nav" href="/login">ログアウト</a>
					<br/>
					<p id="hdr_text_login">ログイン：<span id="hdr_usr_login"><%=loginAccountObj.getFullname()%>様</span></p>
				</div>
			<!-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& -->
					<jsp:include page="/WEB-INF/views/common/nav.jsp" flush="false" />
			<!-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& -->		
				</section>
          </section>
          
          <br><br><br><br><br><br><br><br>
      <section class="container grid-1280">
			<h4 class="page_title">グループ登録・編集</h4>
			<div class="mail_modal_body">
				<ul class="mail_modal_body_ul">
					<li class="mail_modal_body_li">グループ情報</li>
				</ul>
				<table class="app_mail_table_layout">
					<tbody>
						<tr>
							<td class="app_mail_cap_field app_mail_cap_field_w">グループID</td>
							<td colspan="3">
								システムにより自動採番されます。
							</td>
						</tr>
						<tr>
							<td class="app_mail_cap_field app_mail_cap_field_w">
								<ul class="mandatory_field_cap">
									<li>グループ名</li>								
								</ul> 
							</td>
							<td colspan="3">
								<span id="span_group_name"></span>
							</td>
						</tr>
						<tr>
							<td class="app_mail_cap_field app_mail_cap_field_w">
								<ul class="mandatory_field_cap">
									<li>グループ担当者</li>
								</ul> 
							</td>
							<td colspan="3">
								<div id="div_group_manager"></div>
							</td>
						</tr>
						<tr>
							<td class="app_mail_cap_field app_mail_cap_field_w">
								<ul class="mandatory_field_cap">
									<li>管理者コメント</li>
								</ul> 
							</td>
							<td colspan="3">
								<div id="div_admin_comment"></div>
							</td>
						</tr>
						<tr>
							<td class="app_mail_cap_field app_mail_cap_field_w">
								<ul class="mandatory_field_cap">
									<li>登録済み店舗</li>
								</ul> 
							</td>
							<td colspan="3">
								<div id="div_group_store"></div>
							</td>
						</tr>
					</tbody>
				</table>	
				<br/><br/>
		<div id="footer_go_to_confirmation">
			<div><a class="edit_data_back_btn" id="btn_back" onClick="back()">＜戻る</a></div>
			<div><a class="confirm_data_btn" id="btn_confirm_data_change" onClick="toServlet()">登録</a></div>
			<!--div><a class="delete_data_btn" id="delete_applicant_data">削除</a></div-->
		</div>
		</section>
	    <!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->	
			<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false" />
		<!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
	</body>
</html>
