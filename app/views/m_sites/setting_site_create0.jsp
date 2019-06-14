<!-- Final -->

<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Set"%>
<%@ page import="es.hyrax.object.RecruitmentSiteObject" %>

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
      
      RecruitmentSiteObject[] recruitmentSiteArray = (RecruitmentSiteObject[])request.getAttribute("recruitmentSiteArray");
            
%>
<!DOCTYPE html>
<html>
 <head>
  <jsp:include page="/WEB-INF/views/common/index_header.jsp" flush="false" />
  <title>くじら応募</title>
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
			
			function setCmbInit(){
				 
			}
			
			function change_site(){
				var site_id = $("#cmb_site_id").val();
				var site_type = $("#cmb_site_id option:selected").data("type");
				var site_url = $("#cmb_site_id option:selected").data("url");
				
				if(site_type == 1){
					$('#txt_url').val(site_url);
					
					$('#div_id_box').show();
					$('#div_password_box').show();
					$('#div_conf_password_box').show();
					$('#div_url_box').show();
					$('#div_no_scraping_flg_box').show();
				} else {
					$('#txt_job_offer_name').val("");
					$('#txt_id').val("");
					$('#txt_password').val("");
					$('#txt_conf_password').val("");
					$('#txt_url').val("");
					$('#cmb_no_scraping_flg').val(site_type);
					
					$('#div_id_box').hide();
					$('#div_password_box').hide();
					$('#div_conf_password_box').hide();
					$('#div_url_box').hide();
					$('#div_no_scraping_flg_box').hide();
				}
			}

			//function take get_parameter from link
			function take_get_parameter(){
				var app_site_id = '${param.app_site_id}',
					app_job_offer_name = '${param.app_job_offer_name}',
					app_id = '${param.app_id}',
					app_password = '${param.app_password}',
					app_url = '${param.app_url}',
					app_no_scraping_flg = '${param.app_no_scraping_flg}';
					
				document.getElementById("cmb_site_id").value = app_site_id;
				document.getElementById("txt_job_offer_name").value = app_job_offer_name;
				document.getElementById("txt_id").value = app_id;
				document.getElementById("txt_password").value = app_password;
				document.getElementById("txt_url").value = app_url;
				document.getElementById("cmb_no_scraping_flg").value = app_no_scraping_flg;
				
				if(app_no_scraping_flg > 1){
					$('#div_id_box').hide();
					$('#div_password_box').hide();
					$('#div_conf_password_box').hide();
					$('#div_url_box').hide();
					$('#div_no_scraping_flg_box').hide();
				} else {
					$('#div_id_box').show();
					$('#div_password_box').show();
					$('#div_conf_password_box').show();
					$('#div_url_box').show();
					$('#div_no_scraping_flg_box').show();
				}
			}
			
			function setParam(name,value){
				var input = document.createElement('input');
                    input.setAttribute('type', 'hidden');
                    input.setAttribute('name', name);
                    input.setAttribute('value', value);
                    return input;
		    }
			
			function redirect_to_confirm_page() {
				
			　　if ( validate_empty_text() == 1 ) {
    				return;
    			}
    			
    			var inputSiteId = setParam('app_site_id',document.getElementById('cmb_site_id').value);
    			
    			var select_box = document.getElementById( "cmb_site_id" ) ;
    			var idx = select_box.selectedIndex;
    			var site_name = select_box.options[idx].text;
    			var inputSiteName = setParam('app_site_name',site_name);
    			
    			var job_offer_name = document.getElementById("txt_job_offer_name").value;
				var inputJobOfferName = setParam('app_job_offer_name',job_offer_name);
				
				var id = document.getElementById("txt_id").value;
				var inputId = setParam('app_id',id);
				
				var password = document.getElementById("txt_password").value;
				var inputPassword = setParam('app_password',password);
				
				var url = document.getElementById("txt_url").value;
				var inputUrl = setParam('app_url',url);
				
				var inputNoScrapingFlg = setParam('app_no_scraping_flg',document.getElementById('cmb_no_scraping_flg').value);
				
				select_box = document.getElementById( "cmb_no_scraping_flg" ) ;
    			idx = select_box.selectedIndex;
    			var no_scraping_txt = select_box.options[idx].text;
    			var inputNoScrapingTxt = setParam('app_no_scraping_txt',no_scraping_txt);

				var f = document.createElement("form");
                f.setAttribute('method',"post");
                f.setAttribute('action',"/setting_site_create_conf");
                f.appendChild(inputSiteId);
                f.appendChild(inputSiteName);
                f.appendChild(inputJobOfferName);
                f.appendChild(inputId);
                f.appendChild(inputPassword);
                f.appendChild(inputUrl);
                f.appendChild(inputNoScrapingFlg);
                f.appendChild(inputNoScrapingTxt);
 		
				var bodyElement = document.body ;
                bodyElement.append(f);

                f.submit();
			}
			
			//validation 
			function validate_empty_text() {
				var cmb_site_id = document.getElementById("cmb_site_id").value;
				var txt_job_offer_name = document.getElementById("txt_job_offer_name").value;
				var txt_id = document.getElementById("txt_id").value;
				var txt_password = document.getElementById("txt_password").value;
				var txt_conf_password = document.getElementById("txt_conf_password").value;
				var txt_url = document.getElementById("txt_url").value;
				var cmb_no_scraping_flg = document.getElementById("cmb_no_scraping_flg").value;

				var status = 0;

				window.location.hash = '#check';

				$("#div_site_id_error").html("");
				$("#div_job_offer_name_error").html("");
				$("#div_id_error").html("");
				$("#div_password_error").html("");
				$("#div_conf_password_error").html("");
				$("#div_url_error").html("");
				$("#div_no_scraping_flg_error").html("");
				
				if (cmb_site_id == "-1" || cmb_site_id == "") {
					$("#div_site_id_error").html("掲載サイトは必須です。");
					status = 1;
				}

				if (txt_job_offer_name == "") {
					$("#div_job_offer_name_error").html("求人案件名は必須です。");
					status = 1;
				}
				
				var site_type = $("#cmb_site_id option:selected").data("type");
				
				if(site_type == 1){
				
					if (txt_id == "") {
						$("#div_id_error").html("IDは必須です。");
						status = 1;
					}
				
					if (txt_password == "") {
						$("#div_password_error").html("パスワードは必須です。");
						status = 1;
					}

					if (txt_conf_password == "") {
						$("#div_conf_password_error").html("パスワード（確認用）は必須です。");
						status = 1;	
					} else {
						if (txt_conf_password != txt_password) {
							$("#div_conf_password_error").html("確認用のパスワードが間違っています。");
							status = 1;			
						}
					}

					if (txt_url == "") {
						$("#div_url_error").html("サイトアドレスは必須です。");
						status = 1;
					}

					if (cmb_no_scraping_flg == "-1" || cmb_no_scraping_flg == "") {
						$("#div_no_scraping_flg_error").html("利用可否は必須です。");
						status = 1;
					}
					
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
     <h1>求人掲載サイト登録</h1>
     <ol class="breadcrumb">
      <li><a href="/"><i class="fa fa-home"></i> ホーム</a></li>
      <li><a href="/setting_account"><i class="fa fa-cogs"></i> 設定</a></li>
      <li class="active">求人掲載サイト登録</li>
     </ol>
    </section>
    <section class="content">
     <div class="row">
      <section class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
       <div class="callout callout-warning">
        <h4 style="font-size:16px;">求人掲載サイト登録</h4>
       </div>
       <div class="row">
       	<div class="col-md-12 col-xs-12">
       	 <div class="box box-kujira">
       	 
       	  <div class="box-body">
       	   <div class="form-group">
       	   	<h6 class="col-lg-2 col-md-3 col-sm-12 col-xs-12" style="font-size:12px;">掲載サイト</h6>
       	   	<h6 class="col-lg-1 col-md-1 col-sm-12 col-xs-12 text-center"><span style="font-size:10px; background-color: #d9534f; border-color: #d43f3a; padding:3px; border-radius: 3px; color: #fff;">必須</span></h6>
       	   	<div class="col-md-4 col-xs-12">
       	   	 <select id="cmb_site_id" class="form-control" onchange="change_site()">
       	   	  <option value="">選択してください</option>
       	   	  <%for(int i =0 ; i < recruitmentSiteArray.length;i++){%>
       	   	  <option value="<%=recruitmentSiteArray[i].getId()%>" data-type="<%=recruitmentSiteArray[i].getScrapingType()%>" data-url="<%=recruitmentSiteArray[i].getUrl()%>"><%=recruitmentSiteArray[i].getSiteName()%></option>
       	   	  <%}%>
       	   	 </select>
       	   	 <h6 id="div_site_id_error" style="font-size:12px; color:red;"></h6>
       	   	</div>
       	   </div>
       	  </div>
       	  
       	  <div class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
       	   <div class="form-group">
       	   	<h6 class="col-lg-2 col-md-3 col-sm-12 col-xs-12" style="font-size:12px;">求人案件名</h6>
       	   	<h6 class="col-lg-1 col-md-1 col-sm-12 col-xs-12 text-center"><span style="font-size:10px; background-color: #d9534f; border-color: #d43f3a; padding:3px; border-radius: 3px; color: #fff;">必須</span></h6>
       	   	<div class="col-md-4 col-xs-12">
       	   	 <input type="text" id="txt_job_offer_name" class="form-control" maxlength="20"/>
       	   	 <h6 id="div_job_offer_name_error" style="font-size:12px; color:red;"></h6>
       	   	</div>
       	   	<div class="col-md-4 col-xs-12">
       	   	 <h6 style="font-size:12px;">（全角２０文字以内）</h6>
       	   	</div>
       	   </div>
       	  </div>
       	  
       	  <div id="div_id_box" class="box-body">
       	   <div class="form-group">
       	   	<h6 class="col-lg-2 col-md-3 col-sm-12 col-xs-12" style="font-size:12px;">ID</h6>
       	   	<h6 class="col-lg-1 col-md-1 col-sm-12 col-xs-12 text-center"><span style="font-size:10px; background-color: #d9534f; border-color: #d43f3a; padding:3px; border-radius: 3px; color: #fff;">必須</span></h6>
       	   	<div class="col-md-6 col-xs-12">
       	   	 <input type="text" id="txt_id" class="form-control" maxlength="100"/>
       	   	 <h6 id="div_id_error" style="font-size:12px; color:red;"></h6>
       	   	</div>
       	   	<div class="col-md-2 col-xs-12">
       	   	 <h6 style="font-size:12px;">（半角１００文字以内）</h6>
       	   	</div>
       	   </div>
       	  </div>
       	  
       	  <div id="div_password_box" class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
       	   <div class="form-group">
       	   	<h6 class="col-lg-2 col-md-3 col-sm-12 col-xs-12" style="font-size:12px;">パスワード</h6>
       	   	<h6 class="col-lg-1 col-md-1 col-sm-12 col-xs-12 text-center"><span style="font-size:10px; background-color: #d9534f; border-color: #d43f3a; padding:3px; border-radius: 3px; color: #fff;">必須</span></h6>
       	   	<div class="col-md-4 col-xs-12">
       	   	 <input type="password" id="txt_password" class="form-control"/>
       	   	 <h6 id="div_password_error" style="font-size:12px; color:red;"></h6>
       	   	</div>
       	   </div>
       	  </div>
       	  
       	  <div id="div_conf_password_box" class="box-body">
       	   <div class="form-group">
       	   	<h6 class="col-lg-2 col-md-3 col-sm-12 col-xs-12" style="font-size:12px;">パスワード（確認用）</h6>
       	   	<h6 class="col-lg-1 col-md-1 col-sm-12 col-xs-12 text-center"><span style="font-size:10px; background-color: #d9534f; border-color: #d43f3a; padding:3px; border-radius: 3px; color: #fff;">必須</span></h6>
       	   	<div class="col-md-4 col-xs-12">
       	   	 <input type="password" id="txt_conf_password" class="form-control"/>
       	   	 <h6 id="div_conf_password_error" style="font-size:12px; color:red;"></h6>
       	   	</div>
       	   	<div class="col-md-4 col-xs-12">
       	   	 <h6 style="font-size:12px;">確認のため同じパスワードを入力してください。</h6>
       	   	</div>
       	   </div>
       	  </div>
       	  
       	  <div id="div_url_box" class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
       	   <div class="form-group">
       	   	<h6 class="col-lg-2 col-md-3 col-sm-12 col-xs-12" style="font-size:12px;">サイトアドレス</h6>
       	   	<h6 class="col-lg-1 col-md-1 col-sm-12 col-xs-12 text-center"><span style="font-size:10px; background-color: #d9534f; border-color: #d43f3a; padding:3px; border-radius: 3px; color: #fff;">必須</span></h6>
       	   	<div class="col-md-6 col-xs-12">
       	   	 <input type="text" id="txt_url"  class="form-control" maxlength="100"/>
       	   	 <h6 id="div_url_error" style="font-size:12px; color:red;"></h6>
       	   	</div>
       	   	<div class="col-md-2 col-xs-12">
       	   	 <h6 style="font-size:12px;">（半角１００文字以内）</h6>
       	   	</div>
       	   </div>
       	  </div>
       	  
       	  <div id="div_no_scraping_flg_box" class="box-body">
       	   <div class="form-group">
       	   	<h6 class="col-lg-2 col-md-3 col-sm-12 col-xs-12" style="font-size:12px;">自動取込</h6>
       	   	<h6 class="col-lg-1 col-md-1 col-sm-12 col-xs-12 text-center"><span style="font-size:10px; background-color: #d9534f; border-color: #d43f3a; padding:3px; border-radius: 3px; color: #fff;">必須</span></h6>
       	   	<div class="col-md-4 col-xs-12">
       	   	 <select id="cmb_no_scraping_flg" class="form-control">
       	   	  <option value="">選択してください。</option>
       	   	  <option value="0">利用中</option>
       	   	  <option value="1">不利用</option>
       	   	  <option value="5" style="display:none">応募者入力</option>									
       	   	  <option value="9" style="display:none">利用不可</option>									
       	   	 </select>
       	   	 <h6 id="div_no_scraping_flg_error" style="font-size:12px; color:red;"></h6>
       	   	</div>
       	   </div>
       	  </div>
       	  
       	 </div>
       	</div>
       </div>
       <br>
       <div class="row">
        <div class="col-md-12 col-xs-12" id="footer_go_to_confirmation">
         <div class="pull-left">
          <a class="btn btn-warning btn-rounded" href="/setting_site">< 戻る</a>
         </div>
         <div class="text-center">
          <a class="btn btn-rounded  btn-warning"  onClick="redirect_to_confirm_page()">入力内容を確認</a>
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
    $('.setting').parent().addClass('active') && $('.setting > li > a[href="/setting_site"]').parent().addClass('active');
})
  </script>
 </body>
</html>
