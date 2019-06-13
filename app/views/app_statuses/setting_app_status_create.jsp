<!-- Final -->

<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="es.hyrax.util.Integer107" %>
<%@ page import= "es.hyrax.object.AppStatusObject" %>
<%@ page import="es.hyrax.object.AccountObject" %>
<%
  String  sidebar_collapse  = "nonsidebar-collapse";
  Cookie[] cookies = request.getCookies();
  if (cookies != null) {
     for (Cookie cookie : cookies) {
              if("sidebar-collapse".equals(cookie.getName())) {
                          sidebar_collapse = cookie.getValue();
               }
     }
 }
    AccountObject loginAccountObj = (AccountObject)session.getAttribute("loginAccountObj");
	String op = (String)request.getAttribute("op");
	String app_id = (String)request.getAttribute("app_id");
	String app_status_name = (String)request.getAttribute("app_status_name");
	String app_follow_up = (String)request.getAttribute("app_follow_up");
 String ss = (String)loginAccountObj.getFullname();
 String pict = ss.substring(0, 1);
%>
<!DOCTYPE html>
<html>
 <head>
  <jsp:include page="/WEB-INF/views/common/index_header.jsp" flush="false" />
  <title>くじら応募</title>
  <script src="/dist/js/jquery.js"></script>
  <script src="/dist/js/bootstrap.js"></script>
  <script src="/dist/js/adminlte.js?v=1"></script>
  <script>
			function initialize_screen(){
				
			}
			
			//function take get_parameter from link
			function take_get_parameter(){
				//var op = S_GET("op");
				var op = <%= op %>;

				if (op == "1") {
					$("#delete_applicant_data").hide();
					//$("#btn_confirm_data_change").html("登録"); 
				}
				else {
					/*var app_code 		= S_GET("app_code"), 
						app_status_name = S_GET("app_status_name"),
						app_follow_up 	= S_GET("app_follow_up");*/
						
					var app_id = <%=app_id %>;
					var app_code = app_id;
					var app_status_name = '<%=app_status_name %>';
					var app_follow_up = <%=app_follow_up %>;

					$("#delete_applicant_data").show();
					//$("#btn_confirm_data_change").html("更新"); 

					document.getElementById("span_code").innerHTML = app_code;
					document.getElementById("txt_status_name").value = app_status_name;
					
					if (app_follow_up != "")
						document.getElementById("cmb_follow_up").value = app_follow_up;
				}
			}	
			
			function setParam(name,value){
				var input = document.createElement('input');
				input.setAttribute('name',name);
				input.setAttribute('value',value);
				return input;
			}
			function toDeleteServlet(deleteId){
				var inputDeleteId = setParam('delete_id',deleteId);
				var f = document.createElement("form");
                f.setAttribute('method',"post");
                f.setAttribute('action',"/setting_app_status_delete");
				f.appendChild(inputDeleteId);
				var bodyElement = document.body ;
                bodyElement.append(f);
                f.submit();
			}

			$(function() {
				//initialize combo box and other field value when the screen is loaded
				initialize_screen();
				take_get_parameter();
				
    			//action before submit data
    			$("#btn_confirm_data_change").click(function (){   				
    				if (validate_empty_text() != 1) {
    					//var op = S_GET("op");   
    					var op = <%= op %>;
    					 					
    					if (op == "1") {
	    					var conf = confirm("登録します。よろしいですか？");
	    					if(conf == true) {
	    						var app_status_name 	= document.getElementById("txt_status_name").value,
	    							app_follow_up 		= document.getElementById("cmb_follow_up").value,
	    							app_code 			= "00";
	    						/*window.location.href = 	"setting_app_status.html?new_line=1" + "&app_code=" + app_code + 
	    												"&app_status_name=" + app_status_name + 
	    												"&app_follow_up=" + app_follow_up;*/
	    												    												
								var inputStatusName = setParam('app_status_name',app_status_name);
								var inputFollowUp   = setParam('app_follow_up',app_follow_up);
								var f = document.createElement("form");
								f.setAttribute('method',"post");
								f.setAttribute('action',"/setting_app_status_submit");
								f.appendChild(inputStatusName);
								f.appendChild(inputFollowUp);
								var bodyElement = document.body ;
								bodyElement.append(f);
								f.submit();
	    					}
    					}
    					else {
    						var conf = confirm("更新します。よろしいですか？");
    						if (conf == true) {
    							var app_status_name 	= document.getElementById("txt_status_name").value,
    								app_follow_up 		= document.getElementById("cmb_follow_up").value,
    								app_code	 		= document.getElementById("span_code").innerHTML,
    								//edit_row_no			= S_GET("edit_row_no");
    								edit_row_no			= document.getElementById("span_code").value;
								var inputId = setParam('app_id',<%=app_id %>);
								var inputStatusName = setParam('app_status_name',app_status_name);
								var inputFollowUp   = setParam('app_follow_up',app_follow_up);
								var f = document.createElement("form");
								f.setAttribute('method',"post");
								f.setAttribute('action',"/setting_app_status_update");
								f.appendChild(inputId);
								f.appendChild(inputStatusName);
								f.appendChild(inputFollowUp);
								var bodyElement = document.body ;
								bodyElement.append(f);
								f.submit();
																
    							/*window.location.href 	= "setting_app_status.html?edit_row_no=" + edit_row_no + "&app_code=" + app_code +
    													  "&app_status_name=" + app_status_name + "&app_follow_up=" + app_follow_up;*/
    						}
    					}
    				}
    			});

    			$("#delete_applicant_data").click(function(){    			
    				//var del_row_no 	= S_GET("edit_row_no");
    				//var link 		= "setting_app_status.html?del_row_no=" + del_row_no;
    				var deleteId = <%=app_id %>;

    				var conf 		= confirm("削除します。よろしですか？");
    				if( conf == true) {
    					//window.location.href = link;
    					toDeleteServlet(deleteId);
    				}
    			});
			});	

			//validation 
			function validate_empty_text() {
				var txt_status_name = document.getElementById("txt_status_name").value;

				var status = 0;

        window.location.hash = '#check';

				$("#div_error_msg").html("");

				if (txt_status_name == "") {
					$("#div_error_msg").html("選考ステータス名は必須です。");
					status = 1;
				}

				return status;
			}

  </script>
 </head>
 <body class="hold-transition skin-kujira sidebar-mini <%=sidebar_collapse%>" id="check">
  <div class="wrapper">
   <jsp:include page="/WEB-INF/views/common/top_bar.jsp" flush="false" />
   <jsp:include page="/WEB-INF/views/common/side_bar.jsp" flush="false" />
   <div class="content-wrapper">
    <section class="content-header">
     <h1>選考ステータス設定</h1>
     <ol class="breadcrumb">
      <li><a href="/"><i class="fa fa-home"></i> ホーム</a></li>
      <li><a href="/setting_app_status"><i class="fa fa-cogs"></i> ト設定</a></li>
      <li class="active">選考ステータス登録</li>
     </ol>
    </section>
    <section class="content">
     <div class="row">
      <section class="col-md-12 col-xs-12">
       <div class="callout callout-warning">
        <h4 style="font-size:16px;">選考ステータス登録</h4>
       </div>
       <div class="row">
        <div class="col-md-12 col-xs-12">
         <div class="box box-kujira">
          <div class="box-body">
           <div class="form-group">
           	<h6 class="col-lg-2 col-md-4 col-sm-12 col-xs-12" style="font-size:12px;">コード (<span id="span_code">ー</span>)</h6>
           	<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
           	 <label style="font-size: 12px;">選考ステータス名</label>
           	 <input type="text" id="txt_status_name" class="form-control" />
           	</div>
           	<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
           	 <label style="font-size: 12px;">紐付け先の選考フロー</label>
           	 <select id="cmb_follow_up" class="form-control">
           	  <option value="-1">紐付けなし</option>
           	  <option value="1">面接予約</option>
           	  <option value="2">面接実施</option>
           	  <option value="3">採用</option>
           	  <option value="4">入社</option>
           	  <option value="5">保留</option>
           	</select>
           	</div>
           	<div id="div_error_msg" style="color: red;" class="error_msg"></div>
           </div>
          </div>
         </div>
        </div>
       </div>
       <br>
       <div class="row">
        <div class="col-md-12 col-xs-12" id="footer_go_to_confirmation">
         <div class="pull-left">
          <a class="btn btn-warning btn-rounded" href="/setting_app_status">< 戻る</a>
         </div>
         <div class="pull-right">
          <a class="btn btn-rounded btn-warning" id="delete_applicant_data">削除</a>
         </div>
         <div class="text-center">
          <a class="btn btn-rounded  btn-warning" id="btn_confirm_data_change">登録</a>
         </div>
        </div>
       </div>
      </section>
     </div>
    </section>
   </div>
   <jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false" />
  </div>
  <script>
$(document).ready(function() {
    // get current URL path and assign 'active' class
    var pathname = window.location.pathname;
    $('.setting').parent().addClass('active') && $('.setting > li > a[href="'+pathname+'"]').parent().addClass('active');
})
  </script>
 </body>
</html>
