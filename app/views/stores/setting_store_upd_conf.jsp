<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="es.hyrax.object.singleton.PrefectureStrGetter"%>
<%@ page import="es.hyrax.object.singleton.CityStrGetter"%>
<%@ page import="es.hyrax.object.singleton.RouteStrGetter"%>
<%@ page import="es.hyrax.object.singleton.StationStrGetter"%>
<%@ page import="es.hyrax.object.singleton.TrainCompanyStrGetter"%>
<%@ page import="es.hyrax.object.singleton.GroupStrGetter"%>
<%@ page import="es.hyrax.object.singleton.DivisionStrGetter"%>
<%@ page import="es.hyrax.object.singleton.AccountStrGetter"%>
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
      
      AccountObject loginAccountObj = (AccountObject)session.getAttribute("loginAccountObj"); 
      

      PrefectureStrGetter prefStrGetter = PrefectureStrGetter.getInstance();
      CityStrGetter       cityStrGetter = CityStrGetter.getInstance();
      TrainCompanyStrGetter    trainCompanyStrGetter= TrainCompanyStrGetter.getInstance();
      RouteStrGetter      routeStrGetter = RouteStrGetter.getInstance();
      StationStrGetter    stationStrGetter = StationStrGetter.getInstance();
      GroupStrGetter      groupStrGetter   = GroupStrGetter.getInstance();
      DivisionStrGetter   divisionStrGetter = DivisionStrGetter.getInstance();
      AccountStrGetter    accountStrGetter = AccountStrGetter.getInstance();
      
      
      request.setAttribute("app_store_name",(String)request.getParameter("app_store_name"));
      
      String workLocTodofuken =  prefStrGetter.getPrefectureStr((String)request.getParameter("app_work_loc_todoufuken"));
      String workLocShikuchouson = cityStrGetter.getCityStr((String)request.getParameter("app_work_loc_shikuchouson"));
      String accessTodofuken  = prefStrGetter.getPrefectureStrWithArray((String)request.getParameter("app_access_todofuken"));
      String accessTrainCompany  = trainCompanyStrGetter.getTrainCompanyStrWithArray((String)request.getParameter("app_access_train_company"));
      String accessTrainLine   = routeStrGetter.getRouteStrWithArray((String)request.getParameter("app_access_train_line"));
      String accessTrainStation  = stationStrGetter.getStationStrWithArray((String)request.getParameter("app_access_train_station"));
      String appDivisionTodofuken = prefStrGetter.getPrefectureStr((String)request.getParameter("app_division_todofuken"));
      String appDivisionShikuchoson = cityStrGetter.getCityStr((String)request.getParameter("app_division_shikuchouson"));
      
      String divisionStr  = divisionStrGetter.getDivisionStr((String)request.getParameter("app_division"));
      
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
			function setParam(name,value){
				    var input = document.createElement('input');
                     input.setAttribute('type', 'hidden');
                     input.setAttribute('name', name);
                     input.setAttribute('value', value);
                     return input;
		    }
			
			function initialize_screen(){
				
			}
			


			//function take get_parameter from link
			function take_get_parameter(){

				var app_store_id   =  '${param.app_store_id}',
				    app_store_name = '${param.app_store_name}',
					app_company_name = '${param.app_company_name}', 
					app_company_furigana = '${param.app_company_furigana}',
					app_store_manager = '${param.app_store_manager}', 
					app_group = '${param.app_group}', 
					app_work_loc_todoufuken = '<%=workLocTodofuken%>', 
					app_work_loc_shikuchouson = '<%=workLocShikuchouson%>', 
					app_access_todofuken = '<%=accessTodofuken%>',
					app_access_train_company = '<%=accessTrainCompany%>', 
					app_access_train_line = '<%=accessTrainLine%>', 
					app_access_train_station = '<%=accessTrainStation%>', 
					app_access_from_station = '${param.app_access_from_station}', 
					app_access_by = '${param.app_access_by}', 
					app_access_by_time = '${param.app_access_by_time}', 
					app_access_comment = '${param.app_access_comment}',
					app_division = '<%=divisionStr%>',//'${param.app_division}',
					app_division_todofuken = '<%=appDivisionTodofuken%>', 
					app_division_shikuchouson = '<%=appDivisionShikuchoson%>',
					app_division_house_number = '${param.app_division_house_number}',
					app_division_building_name = '${param.app_division_building_name}',
					app_division_comment = '${param.app_division_comment}',
					app_telephone_0 = '${param.app_telephone_0}', 
					app_telephone_1 = '${param.app_telephone_1}', 
					app_telephone_2 = '${param.app_telephone_2}',
					app_telephone_comment = '${param.app_telephone_comment}', 
					app_telephone_more_comment = '${param.app_telephone_more_comment}', 
					app_admin_comment = '${param.app_admin_comment}',
					app_store_term = '${param.app_store_term}'; 
                   
                   document.getElementById("span_store_id").innerHTML = app_store_id;
				   document.getElementById("span_store_name").innerHTML = app_store_name;
				   document.getElementById("span_company_name").innerHTML = app_company_name;
				   document.getElementById("span_company_furigana").innerHTML = app_company_furigana;

				if (app_store_manager != "") {

					var store_manager_list = new Array();
					
					var accountStrGetter =  <%=accountStrGetter.getAccountStrGetterJson()%>;
					
					document.getElementById("div_store_manager").innerHTML = "";
					var div_store_manager = document.getElementById("div_store_manager").innerHTML;

					store_manager_list = app_store_manager.split(",");
					
					div_store_manager += "<ul class='ul_access_2'>";
					for (var i = 0; i < store_manager_list.length; i++) {
						div_store_manager += "<li>" + accountStrGetter[store_manager_list[i] - 1] + "</li>"	
					};
					div_store_manager += "</ul>";

					document.getElementById("div_store_manager").innerHTML = div_store_manager;
				}

				if (app_group != "") {
					var group_list = new Array();
					
					var groupStrGetter = <%=groupStrGetter.getGroupStrGetterJson()%>;
					
					document.getElementById("div_store_group").innerHTML = "";
					var div_store_group = document.getElementById("div_store_group").innerHTML;

					group_list = app_group.split(",");
					
					div_store_group += "<ul class='ul_access_2'>";
					for (var i = 0; i < group_list.length; i++) {
						div_store_group += "<li>" + groupStrGetter[group_list[i] - 1] + "</li>"	
					};
					div_store_group += "</ul>";

					document.getElementById("div_store_group").innerHTML = div_store_group;	
				}

				document.getElementById("span_work_loc_todoufuken").innerHTML = 
												"<span style='display:inline-block;padding-right:10px;'>" + app_work_loc_todoufuken + "</span>";
				document.getElementById("span_work_loc_shikuchouson").innerHTML = 
												"<span style='display:inline-block;padding-right:10px;'>" + app_work_loc_shikuchouson + "</span>";
				

				if (app_access_todofuken != "" || app_access_train_company != "" || app_access_train_line != "" || app_access_train_line != "" || app_access_train_station != "" || app_access_from_station != "" || app_access_by != "" || app_access_by_time != "") {

					var div_access = "",
					access_todofuken = new Array(),
					access_train_company = new Array(),
					access_train_line = new Array(),
					access_train_station = new Array(),
					access_from_station = new Array(),
					access_by = new Array(),
					access_by_time = new Array();

					access_todofuken = app_access_todofuken.split(","),
					access_train_company = app_access_train_company.split(","),
					access_train_line = app_access_train_line.split(","),
					access_train_station = app_access_train_station.split(","), 
					access_from_station = app_access_from_station.split(","),
					access_by = app_access_by.split(","),
					access_by_time = app_access_by_time.split(",");

					div_access = "<ul class='ul_access_2'>";
					for (var i = 0; i < access_todofuken.length; i++) {
						div_access += "<li><span style='padding-right:10px;'>" + access_todofuken[i] + "</span><span style='padding-right:10px;'>" + access_train_company[i] + "</span><span style='padding-right:10px;'>" + access_train_line[i] + "</span><span style='padding-right:10px;'>" + access_train_station[i] + "</span><span style='padding-right:10px;'>" + access_from_station[i] + "</span><span style='padding-right:10px;'>" + access_by[i] + "</span><span style='padding-right:10px;'>" + access_by_time[i] + "</span></li>";
					};
					div_access += "</ul>";

					document.getElementById("div_access").innerHTML = div_access;
				}
				document.getElementById("div_access_more_comment").innerHTML = app_access_comment;
				document.getElementById("span_division").innerHTML = app_division;
				document.getElementById("div_division_detail").innerHTML = app_division_todofuken + app_division_shikuchouson + app_division_house_number + app_division_building_name;
				document.getElementById("div_division_comment").innerHTML = app_division_comment;
				document.getElementById("span_telephone").innerHTML = app_telephone_0 + " - " + app_telephone_1 + " - " + app_telephone_2;
				document.getElementById("p_telephone_detail").innerHTML = app_telephone_comment;
				document.getElementById("p_telephone_more_detail").innerHTML = app_telephone_more_comment;

				document.getElementById("p_admin_comment").innerHTML = app_admin_comment;

				if (app_store_term != "") {
					var store_term = new Array(),
						store_term = app_store_term.split(","),
						div_store_term = "";

					div_store_term = "<ul class='ul_access_2'>";
					for (var i = 0; i < store_term.length; i++) {
						div_store_term += "<li>" + store_term[i] + "</li>"
					};
					div_store_term += "</ul>";

					document.getElementById("div_store_term").innerHTML = div_store_term;
				}
			}

			$(function() {
				//initialize combo box and other field value when the screen is loaded
				//initialize_screen();
				//clear_all_input_field();
				
			//	alert('init');
				
				take_get_parameter();

				$("#btn_back").click(function(){
										
					var f = document.createElement("form");
                    f.setAttribute('method',"post");
                    f.setAttribute('action',"/setting_store_upd");  
                    
                                                       
                    <%
                    for(Map.Entry<String, String[]> e : paramsMap.entrySet()){      
                    %>                   
                        f.appendChild(setParam('<%=e.getKey()%>','<%=((String[])e.getValue())[0]%>'));                  
                    <%
				    }
                    %> 
                    
                    f.appendChild(setParam('from_which','setting_store_upd_conf.jsp'));                                      
                    var bodyElement = document.body ;
                    bodyElement.append(f);
                    f.submit();

				});
				
				
			});	


			//redirect to confirmation page
			function sendConfirmedData() {			
				
					
					var f = document.createElement("form");
                    f.setAttribute('method',"post");
                    f.setAttribute('action',"/setting_store_update");                  
                    
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
 <body class="hold-transition skin-kujira sidebar-mini <%=sidebar_collapse%>">
  <div class="wrapper">
   <jsp:include page="/WEB-INF/views/common/top_bar.jsp" flush="false" />
   <jsp:include page="/WEB-INF/views/common/side_bar.jsp" flush="false" />
   <div class="content-wrapper">
    <section class="content-header">
     <h1>店舗編集</h1>
     <ol class="breadcrumb">
      <li><a href="/"><i class="fa fa-home"></i> ホーム</a></li>
      <li><a href="/setting_store"><i class="fa fa-cogs"></i> 設定</a></li>
      <li class="active">店舗編集</li>
     </ol>
    </section>
    <section class="content">
     <div class="row">
      <section class="col-md-12 col-xs-12">
       <div class="callout callout-warning">
        <h4 style="font-size:16px;">店舗編集</h4>
       </div>
       <div class="row">
        <div class="col-md-12 col-xs-12">
         <div class="box box-kujira">
          <div class="box-body">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">店舗ID</h6>
            <h6 class="col-sm-4 col-xs-12" id="span_store_id" style="font-size:12px;"></h6>
           </div>
          </div>
          <div class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">店舗マスタ名</h6>
            <div class="col-lg-10 col-sm-10 col-xs-12">
             <span id="span_store_name"></span>
            </div>
           </div>
          </div>
          <div class="box-body">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">会社・店舗名</h6>
            <div class="col-lg-10 col-sm-10 col-xs-12">
             <span id="span_company_name"></span>
            </div>
           </div>
          </div>
          <div class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">会社・店舗名（ふりがな）</h6>
            <div class="col-lg-10 col-sm-10 col-xs-12">
             <span id="span_company_furigana"></span>
            </div>
           </div>
          </div>
          <div class="box-body">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">ご担当者様</h6>
            <div class="col-lg-10 col-sm-10 col-xs-12">
             <span id="div_store_manager"></span>
            </div>
           </div>
          </div>
          <div class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">グループ</h6>
            <div class="col-lg-10 col-sm-10 col-xs-12">
             <span id="div_store_group"></span>
            </div>
           </div>
          </div>
          <div class="box-body">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">勤務地</h6>
            <div class="col-lg-10 col-sm-10 col-xs-12">
             <span id="span_work_loc_todoufuken"></span><span id="span_work_loc_shikuchouson"></span>
            </div>
           </div>
          </div>
          <div class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">アクセス</h6>
            <div class="col-lg-10 col-sm-10 col-xs-12">
             <span id="div_access"></span> <span id="div_access_more_comment"></span>
            </div>
           </div>
          </div>
          <div class="box-body">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">公開住所</h6>
            <div class="col-lg-10 col-sm-10 col-xs-12">
             <span id="span_division"></span> <span>　：　</span> <span id="div_division_detail"></span>
            </div>
            <div class="col-lg-10 col-sm-10 col-xs-12">
             <span id="div_division_comment"></span>
            </div>
           </div>
          </div>
          <div class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">店舗連絡先</h6>
            <div class="col-lg-10 col-sm-10 col-xs-12">
             <h6 id="span_telephone"></h6> - <h6 id="p_telephone_detail"></h6> - <h6 id="p_telephone_more_detail"></h6>
            </div>
           </div>
          </div>
          <div class="box-body">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">管理者コメント<br/>(求職者に非公開の項目です)</h6>
            <div class="col-lg-10 col-sm-10 col-xs-12">
             <span id="p_admin_comment"></span>
            </div>
           </div>
          </div>
          <div class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">店舗マッチング条件</h6>
            <div class="col-lg-10 col-sm-10 col-xs-12">
             <span id="div_store_term"></span>
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
         	<a class="btn btn-warning btn-rounded" id="btn_back">< 戻る</a>
         </div>
         <div class="text-center">
         	<a class="btn btn-rounded  btn-warning" id="btn_confirm_data_change" onClick="sendConfirmedData()">　登録　</a>
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
    $('.setting').parent().addClass('active') && $('.setting > li > a[href="/setting_store"]').parent().addClass('active');
})
  </script>
 </body>
</html>
