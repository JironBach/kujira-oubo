<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Map" %>
<%@ page import="es.hyrax.object.AccountObject" %>
<%
      request.setCharacterEncoding("utf-8");
      response.setCharacterEncoding("utf-8");
      AccountObject loginAccountObj = (AccountObject)session.getAttribute("loginAccountObj");
      Map<String,String[]> paramsMap = request.getParameterMap();
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
			function initialize_screen(){
				
			}

			//function take get_parameter from link
			function take_get_parameter(){
				/*var app_start_date 	= S_GET("app_start_date"),
					app_end_date	= S_GET("app_end_date"),
					app_title		= S_GET("app_title"),
					app_purpose		= S_GET("app_purpose");*/
					
				var app_start_date		= '${param.app_start_date}';
				var app_end_date		= '${param.app_end_date}';
				var app_title			= '${param.app_title}';
				var app_purpose			= '${param.app_purpose}';

				document.getElementById("span_start_date").innerHTML = app_start_date;
				document.getElementById("span_end_date").innerHTML = app_end_date;
				document.getElementById("span_title").innerHTML = app_title;
				document.getElementById("span_purpose").innerHTML = app_purpose;
			}

			$(function() {
    			//initial function call
				initialize_screen();
				take_get_parameter();

				//button back event
				$("#btn_back").click(function(){
					
					var f = document.createElement("form");
                    f.setAttribute('method',"post");
                    f.setAttribute('action',"/setting_notification_create");                                         
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
					
					/*var link = window.location.href;
					var new_link = "setting_notification_create.html?" + link.substring((link.indexOf("?") + 1),link.length);

					window.location.href = new_link;*/
				});
			});
			function setParam(name,value){
				var input = document.createElement('input');
				input.setAttribute('type','hidden');
				input.setAttribute('name',name);
				input.setAttribute('value',value);
				return input;
			}	
			
			function sendConfirmedData(){

				var f = document.createElement("form");
				f.setAttribute('method',"post");
				f.setAttribute('action',"/setting_notification_submit");

			
				<%
				for(Map.Entry<String, String[]> e : paramsMap.entrySet()){      
				%>
				f.appendChild(setParam('<%=e.getKey()%>','<%=((String[])e.getValue())[0]%>'));

				//alert("<%=e.getKey()%>"+'<%=e.getKey()%>'+"'<%=((String[])e.getValue())[0]%>'"+'<%=((String[])e.getValue())[0]%>');
				<%
				}
				%>  
				var bodyElement = document.body ;
				//alert("sendConfirm4");
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
			<h4 class="page_title">採用責任者からのお知らせ登録・編集</h4>
			<div class="mail_modal_body">
				<ul class="mail_modal_body_ul">
					<li class="mail_modal_body_li">お知らせ情報</li>
				</ul>
				<table class="app_mail_table_layout">
					<tbody>
						<tr>
							<td class="app_mail_cap_field app_mail_cap_field_w">
								<ul class="mandatory_field_cap">
									<li>掲載期間</li>								
								</ul>
							</td>
							<td>
								<span id="span_start_date"></span> ~ <span id="span_end_date"> (掲載前) </span>
							</td>						
						</tr>
						<tr>
							<td class="app_mail_cap_field">
								<ul class="mandatory_field_cap">
									<li>タイトル</li>							
								</ul>
							</td>
							<td>
								<span id="span_title"></span>
							</td>
						</tr>
						<tr>
							<td class="app_mail_cap_field">
								<ul class="mandatory_field_cap">
									<li>内容</li>									
								</ul>
							</td>
							<td>
								<span id="span_purpose"></span>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		<div id="footer_go_to_confirmation">
			<div><a class="edit_data_back_btn　btn btn-primary" id="btn_back">＜戻る</a></div>
			<!--<div><a class="confirm_data_btn" id="btn_confirm_data_change" href="setting_notification.html">登録</a></div>-->
			<div><a class="confirm_data_btn  btn btn-lg  btn-primary" onClick="sendConfirmedData()">　登録　</a></div>
			<!--div><a class="delete_data_btn" id="delete_applicant_data">削除</a></div-->
		</div>

		</section>
	    <!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->	
			<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false" />
		<!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
	</body>
</html>
