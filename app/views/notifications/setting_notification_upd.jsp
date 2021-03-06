<!-- Final -->

<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Set" %>
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
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	AccountObject loginAccountObj = (AccountObject)session.getAttribute("loginAccountObj");
	Map<String,String[]>  paramsMap = request.getParameterMap();
   String ss = (String)loginAccountObj.getFullname();
 String pict = ss.substring(0, 1);
%>
<!DOCTYPE html>
<html>
 <head>
  <jsp:include page="/WEB-INF/views/common/index_header.jsp" flush="false" />
  <title>くじら応募</title>
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


				document.getElementById("txt_start_date").value = app_start_date;
				document.getElementById("txt_end_date").value = app_end_date;
				document.getElementById("txt_title").value = app_title;
				document.getElementById("txt_purpose").value = app_purpose;
			}

			$(function() {
				
				//setting date time picker
				$("#txt_start_date").datepicker({ 
    				dateFormat: 'yy/mm/dd'
    			});
    			$("#txt_end_date").datepicker({ 
    				dateFormat: 'yy/mm/dd'
    			});
    			$(".ui-datepicker").css("font-size", $(".ui-datepicker").width() / 22 + "px");

    			//setting keybord event
    			$("#txt_title").keyup(function(){
    				var text_length = $("#txt_title").val().length;
    				$("#span_title_total_char").html(text_length);
    			});
    			$("#txt_purpose").keyup(function(){
    				var text_length = $("#txt_purpose").val().length;
    				$("#span_purpose_total_char").html(text_length);
    			});

    			//initial function call
				initialize_screen();
				clear_all_input_field();
				take_get_parameter();

    			//action before submit data
    			$("#btn_confirm_data_change").click(function (){

    				if ( validate_empty_text() != 1 ) {
    					redirect_to_confirm_page();
    				}
    			});

    			//delete notification event
    			$("#btn_delete").click(function () {
    				//var del_row_no = S_GET("del_row_no");
    				var id				= '${param.app_id}';
    				var conf = confirm("削除します。よろしいですか？");
    				
    				if (conf == true){
						toDeleteServlet(id);
    					//window.location.href = "setting_notification.html?del_row_no=" + del_row_no;
    				}
    			});
			});	
			
			function toDeleteServlet(deleteArr){
				var inputDeleteArr = setParam('delete_id_arr',deleteArr);
				var pageNum			= '${param.page_num}';
				var inputPageNum = setParam('page_num',pageNum);
				var f = document.createElement("form");
                f.setAttribute('method',"post");
                f.setAttribute('action',"/setting_notification_delete");
				f.appendChild(inputDeleteArr);
                f.appendChild(inputPageNum);
				var bodyElement = document.body ;
                bodyElement.append(f);
                f.submit();
			}	
			
			function setParam(name,value){
				var input = document.createElement('input');
				input.setAttribute('type','hidden');
				input.setAttribute('name',name);
				input.setAttribute('value',value);
				return input;
			}

			//redirect to confirmation page
			function redirect_to_confirm_page() {			
				var app_start_date = document.getElementById("txt_start_date").value,
					app_end_date = document.getElementById("txt_end_date").value,
					app_title = document.getElementById("txt_title").value,
					app_purpose = document.getElementById("txt_purpose").value;

/*				var link = "setting_notification_upd_conf.html?";

				link += "app_start_date=" + app_start_date + "&app_end_date=" + app_end_date + "&app_title=" + app_title + 
						"&app_purpose=" + app_purpose ;

				window.location.href = link;*/

				var pageNum			= '${param.page_num}';
				var	onePageLimit	= '${param.one_page_limit}';
				var id				= '${param.app_id}';			
					
				var f = document.createElement("form");
				f.setAttribute('method','post');
				f.setAttribute('action','/setting_notification_upd_conf');

				var inputStartDate	= setParam('app_start_date',app_start_date);
				var inputEndDate	= setParam('app_end_date',app_end_date);
				var inputTitle		= setParam('app_title',app_title);

				var inputPurpose	= setParam('app_purpose',app_purpose);
				var inputPageNum	= setParam('page_num',pageNum);
				var inputOnePageLimit	= setParam('one_page_limit',onePageLimit);
				var inputId			= setParam('app_id',id);
				
				f.appendChild(inputStartDate);
				f.appendChild(inputEndDate);
				f.appendChild(inputTitle);
				f.appendChild(inputPurpose);
				f.appendChild(inputPageNum);
				f.appendChild(inputOnePageLimit);
				f.appendChild(inputId);
				
				var bodyElement		= document.body;
				bodyElement.append(f);

				f.submit();
			}

			//validation 
			function validate_empty_text() {
				var txt_start_date = document.getElementById("txt_start_date").value;
				var txt_end_date = document.getElementById("txt_end_date").value;
				var txt_title = document.getElementById("txt_title").value;
				var txt_purpose = document.getElementById("txt_purpose").value;
				
				var status = 0;

        window.location.hash = '#check';

				$("#div_publish_date_error").html("");
				$("#div_title_error").html("");
				$("#div_purpose_error").html("");
				
				if (txt_start_date == "" || txt_end_date == "") {
					$("#div_publish_date_error").html("掲載期間は必須です。");
					status = 1;
				}

				if (txt_title == "") {
					$("#div_title_error").html("タイトルは必須です。");
					status = 1;	
				}

				if (txt_purpose == "") {
					$("#div_purpose_error").html("内容は必須です。");
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
     <h1>お知らせ設定</h1>
     <ol class="breadcrumb">
      <li><a href="/"><i class="fa fa-home"></i> ホーム</a></li>
      <li><a href="/setting_notification"><i class="fa fa-cogs"></i> 設定</a></li>
      <li class="active">お知らせ設定</li>
     </ol>
    </section>
    <section class="content">
     <div class="row">
      <section class="col-md-12 col-xs-12">
       <div class="callout callout-warning">
        <h4 style="font-size:16px;">採用責任者からのお知らせ編集</h4>
       </div>
       <div class="row">
        <div class="col-md-12 col-xs-12">
         <div class="box box-kujira box-solid">
          <div class="box-header with-border">
           お知らせ情報
          </div>
          <div class="box-body">
           <div class="form-group">
            <h6 class="col-lg-2 col-md-4 col-sm-12 col-xs-12" style="font-size:12px;">掲載期間 <span style="font-size:12px; background-color: #d9534f; border-color: #d43f3a; padding:5px; border-radius: 3px; color: #fff;">必須</span></h6>
            <div class="col-lg-9 col-md-12 col-sm-12 col-xs-12">
             <h6 style="font-size:12px;">お知らせの掲載期間を登録して下さい。開始日を<span style="color:red;">当日、もしくは当日以前</span>にした場合はすぐにお知らせが掲載されます。</h6>
            </div>
            <div class="col-lg-offset-2 col-lg-2 col-md-6 col-sm-12 col-xs-12">
             <input type="date" id="txt_start_date" class="form-control" style="margin-top: 5px;"/>
            </div>
            <div class="col-lg-2 col-md-6 col-sm-12 col-xs-12" style="margin-top: 5px;">
             <input type="date" id="txt_end_date" class="form-control"/>
            </div>
            <div id="div_publish_date_error" style="color: red;" class="error_msg"></div>
           </div>
          </div>
          <div class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
           <div class="form-group">
            <h6 class="col-lg-2 col-md-3 col-sm-12 col-xs-12" style="font-size:12px;">タイトル <span style="font-size:12px; background-color: #d9534f; border-color: #d43f3a; padding:5px; border-radius: 3px; color: #fff;">必須</span></h6>
            <div class="col-lg-6 col-md-9 col-sm-12 col-xs-12">
             <input type="text" id="txt_title" class="form-control"/>
             (<span id="span_title_total_char" >0</span> / 100文字)
            </div>
            <div id="div_title_error" style="color: red;" class="error_msg"></div>
           </div>
          </div>
          <div class="box-body">
           <div class="form-group">
            <h6 class="col-lg-2 col-md-3 col-sm-12 col-xs-12" style="font-size:12px;">内容 <span style="font-size:12px; background-color: #d9534f; border-color: #d43f3a; padding:5px; border-radius: 3px; color: #fff;">必須</span></h6>
            <div class="col-lg-6 col-md-9 col-sm-12 col-xs-12">
             <textarea id="txt_purpose" class="form-control" style="resize:none;"></textarea>
             (<span id="span_purpose_total_char" >0</span> / 100文字)
            </div>
            <div id="div_purpose_error" style="color: red;" class="error_msg"></div>
           </div>
          </div>
         </div>
        </div>
       </div>
       <br>
       <div class="row">
        <div class="col-md-12 col-xs-12" id="footer_go_to_confirmation">
         <div class="pull-left">
          <a class="btn btn-warning btn-rounded" href="/setting_notification">< 戻る</a>
         </div>
         <div class="pull-right">
          <a class="btn btn-rounded btn-danger" id="btn_delete">削除</a>
         </div>
         <div class="text-center">
          <a class="btn btn-rounded  btn-warning" id="btn_confirm_data_change">入力内容を確認</a>
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
   function clear_all_input_field(){
    //document.getElementById("").value = "";
   }
  </script>
  <script src="/dist/js/jquery.js"></script>
  <script src="/dist/js/bootstrap.js"></script>
  <script src="/dist/js/adminlte.js?v=1"></script>
  <script>
$(document).ready(function() {
    // get current URL path and assign 'active' class
    var pathname = window.location.pathname;
    $('.setting').parent().addClass('active') && $('.setting > li > a[href="/setting_notification"]').parent().addClass('active');
})
  </script>
 </body>
</html>
