<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="es.hyrax.object.AccountObject" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Set"%>
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
      
	Map<String,String[]> paramsMap = request.getParameterMap();

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
		    document.addEventListener('DOMContentLoaded',
				function(){
				    initialize_screen();
				    clear_all_input_field();	
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

			
			function take_get_parameter(){
					
				var app_site_id = '${param.app_site_id}',
					app_site_name = '${param.app_site_name}',
					app_job_offer_name = '${param.app_job_offer_name}',
					app_id = '${param.app_user_id}',
					app_password = '${param.app_password}',
					app_url = '${param.app_url}',
					app_no_scraping_flg = '${param.app_no_scraping_flg}' ,
					app_no_scraping_txt = '${param.app_no_scraping_txt}';
					
				document.getElementById("span_site_name").innerHTML = app_site_name;
				document.getElementById("span_job_offer_name").innerHTML = app_job_offer_name;
				document.getElementById("span_id").innerHTML = app_id;
				document.getElementById("txt_password").value = app_password;
				document.getElementById("span_url").innerHTML = app_url;
				document.getElementById("span_no_scraping_txt").innerHTML = app_no_scraping_txt;
				
				if(app_no_scraping_flg > 1){
					$('#div_id_box').hide();
					$('#div_password_box').hide();
					$('#div_url_box').hide();
					$('#div_no_scraping_txt_box').hide();
				} else {
					$('#div_id_box').show();
					$('#div_password_box').show();
					$('#div_url_box').show();
					$('#div_no_scraping_txt_box').show();
				}
			}
			
			
			function back(){
				var f = document.createElement("form");
				f.setAttribute('method',"post");
				f.setAttribute('action',"/setting_site_upd");                                         
				<%
				for(Map.Entry<String, String[]> e : paramsMap.entrySet()){      
				%>                   
					f.appendChild(setParam('<%=e.getKey()%>','<%=((String[])e.getValue())[0]%>'));                  
				<%
				}
				%>
				f.appendChild(setParam('from_which','back'));
				var bodyElement = document.body ;
				bodyElement.append(f);
				f.submit();	
			}
					
			function sendConfirmedData(){
				var f = document.createElement("form");
				f.setAttribute('method',"post");
				f.setAttribute('action',"/setting_site_update");

				
				<%
				for(Map.Entry<String, String[]> e : paramsMap.entrySet()){      
				%>
				f.appendChild(setParam('<%=e.getKey()%>','<%=((String[])e.getValue())[0]%>'));
				//alert("<%=e.getKey()%>"+'<%=e.getKey()%>'+"'<%=((String[])e.getValue())[0]%>'"+'<%=((String[])e.getValue())[0]%>');
				<%
				}
				%>  
				var bodyElement = document.body ;
				bodyElement.append(f);

				f.submit();
			}
  </script>
 </head>
 <body class="hold-transition skin-kujira sidebar-mini <%=sidebar_collapse%>">
  <div class="wrapper">
   <jsp:include page="/WEB-INF/views/common/top_bar.jsp" flush="false" />
   <jsp:include page="/WEB-INF/views/common/side_bar.jsp" flush="false" />
   <div class="content-wrapper">
    <section class="content-header">
     <h1>求人掲載サイト登録</h1>
     <ol class="breadcrumb">
      <li><a href="/"><i class="fa fa-home"></i> ホーム</a></li>
      <li><a href="/setting_site"><i class="fa fa-cogs"></i> 設定</a></li>
      <li class="active">求人掲載サイト登録</li>
     </ol>
    </section>
    <section class="content">
     <div class="row">
      <section class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
       <div class="callout callout-warning">
        <h4 style="font-size:16px;">求人掲載サイト編集確認</h4>
       </div>
       <div class="row">
        <div class="col-md-12 col-xs-12">
         <div class="box box-kujira">
         
          <div class="box-body">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">掲載サイト</h6>
            <div class="col-sm-10 col-xs-12" id="span_site_name"></div>
           </div>
          </div>
          
          <div class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">求人案件名</h6>
            <div class="col-sm-10 col-xs-12" id="span_job_offer_name"></div>
           </div>
          </div>
          
          <div id="div_id_box" class="box-body">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">ID</h6>
            <div class="col-sm-10 col-xs-12" id="span_id"></div>
           </div>
          </div>
          
          <div id="div_password_box" class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">パスワード</h6>
            <div class="col-lg-3 col-sm-10 col-xs-12">
             <input type="password" id="txt_password" class="form-control" disabled="true"/>
            </div>
           </div>
          </div>
          
          <div id="div_url_box" class="box-body">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">サイトアドレス</h6>
            <div class="col-sm-10 col-xs-12" id="span_url"></div>
           </div>
          </div>
          
          <div id="div_no_scraping_txt_box" class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">自動取込</h6>
            <div class="col-sm-10 col-xs-12" id="span_no_scraping_txt"></div>
           </div>
          </div>
          
          
         </div>
        </div>
       </div>
       <br/>
       <div class="row">
        <div class="col-md-12 col-xs-12">
         <div id="footer_go_to_confirmation">
          <div class="pull-left">
           <a class="btn btn-warning" style="font-size: 12px;" onClick="back()">< 戻る</a>
          </div>
          <div class="text-center">
           <a class="btn btn-warning" id="btn_confirm_data_change" style="font-size: 12px;" onClick="sendConfirmedData()">登録</a>
          </div>
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
  <script>
$(document).ready(function() {
    // get current URL path and assign 'active' class
    var pathname = window.location.pathname;
    $('.setting').parent().addClass('active') && $('.setting > li > a[href="/setting_site"]').parent().addClass('active');
})
  </script>
 </body>
</html>
