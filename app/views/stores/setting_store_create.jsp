<!-- Final -->

<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Set"%>
<%@ page import="es.hyrax.object.StoreObject"%>
<%@ page import="es.hyrax.object.GroupObject"%>
<%@ page import="es.hyrax.object.PrefObject"%>
<%@ page import="es.hyrax.object.CityObject"%>
<%@ page import="es.hyrax.object.singleton.GroupStrGetter"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="es.hyrax.object.DivisionObject"%>
<%@ page import="es.hyrax.object.singleton.AccountStrGetter" %>
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
    StoreObject storeObj = (StoreObject)request.getAttribute("storeObj");
	GroupStrGetter groupStrGetter  = GroupStrGetter.getInstance();
	DivisionObject[] divisionArray = (DivisionObject[])request.getAttribute("divisionArray");
    PrefObject[] prefObjArray     = (PrefObject[])request.getAttribute("prefObjArray");
	JSONArray groupJsonArray = (JSONArray)request.getAttribute("groupJsonArray");
	JSONArray groupStoreJsonArray = (JSONArray)request.getAttribute("groupStoreJsonArray");
	JSONArray prefJsonArray = (JSONArray)request.getAttribute("prefJsonArray");
	
	
	
	JSONArray accountJsonArray = (AccountStrGetter.getInstance()).getAccountJson();
	//JSONArray accountJsonArray = (JSONArray)request.getAttribute("accountJsonArray");
	
	
	
	
	/*
	      request.setAttribute("accessTrainCompanyJsonArray",accessTrainCompanyJsonArray);
      request.setAttribute("accessTrainLineJsonArray",accessTrainLineJsonArray);
      request.setAttribute("accessTrainStationJsonArray",accessTrainStationJsonArray);*/
      
     //Confから戻るでかえって来た時のため 
    CityObject[] workCityObjArray = (CityObject[])request.getAttribute("workCityObjArray");
	CityObject[] divCityObjArray = (CityObject[])request.getAttribute("divCityObjArray");
   // JSONArray appWorkLocCityJsonArray =       (JSONArray)request.getAttribute("appWorkLocCityJsonArray");
   // JSONArray appDivisionCityJsonArray =      (JSONArray)request.getAttribute("appDivisionCityJsonArray");
      
    JSONArray accessTrainCompanyJson2dArray = (JSONArray)request.getAttribute("accessTrainCompanyJson2dArray");
    JSONArray accessTrainLineJson2dArray    = (JSONArray)request.getAttribute("accessTrainLineJson2dArray");
    JSONArray accessTrainStationJson2dArray = (JSONArray)request.getAttribute("accessTrainStationJson2dArray");
    
    
    
    
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
		    prefJsonArray = <%=prefJsonArray.toString()%>;
					
			prefOptions = "<option value=''>選択してください</option>";
					
			for(var i = 0; i < prefJsonArray.length;i++){
				prefOptions += "<option value='" + prefJsonArray[i].id + "'>" + prefJsonArray[i].name + "</option>";
			}
			
			
		    accountJsonArray = <%=accountJsonArray.toString()%>;
			accountOptions = "<option value=''>選択してください</option>";
		    for(var i = 0; i < accountJsonArray.length;i++){
				accountOptions += "<option value='" + accountJsonArray[i].id + "'>" + accountJsonArray[i].fullname + "</option>";
			}
		
		
			function initialize_screen(){
				
			}
			
		    function setParam(name,value){
				var input = document.createElement('input');
                    input.setAttribute('type', 'hidden');
                    input.setAttribute('name', name);
                    input.setAttribute('value', value);
                    return input;
		    }
		    
		    function addStoreManagerInput(){
				var last_counter = parseInt(document.getElementById("hidden_store_manager").value);
				    var addInnerHtml = "";
    				var addDiv = document.createElement('div');
				
					//var	div_store_manager_all = document.getElementById("div_store_manager_all").innerHTML;

					last_counter += 1; 
					addInnerHtml += "<div class='div_dynamic_input_text' id='div_store_manager_" + last_counter + "'>" + 
										  " <select name='cmb_store_manager' class='form-control' id='cmb_store_manager_"+ last_counter + "'>" + 
										     accountOptions +
										     "</select><label style='font-size: 10px;'>設定して頂いた担当者の方はこちらの店舗の応募者情報を閲覧することができます。担当者は20人まで登録することができます。</label><br>" +  "<a class='btn btn-rounded btn-danger' style='float:left; margin-top:5px; margin-right:5px; margin-bottom:5px;' onclick='delete_manager(" + last_counter + ")' id='btn_del_store_manager_" 
										  + last_counter + "' class='a_nav_link'>削除</a></div>";
										  
					addDiv.innerHTML = addInnerHtml;

					document.getElementById("div_store_manager_all").appendChild(addDiv);
					document.getElementById("hidden_store_manager").value = last_counter;
			
			}
		    
		    function addGroupInput(){
				    var last_counter = parseInt(document.getElementById("hidden_group").value);
					
					var addInnerHtml = "";
    				var addDiv = document.createElement('div');
					
					var groupRow = <%=groupJsonArray.toString()%>;
				    var groupOptions = "";
				    for(var i = 0; i < groupRow.length;i++){
						groupOptions += "<option value='" + groupRow[i].id + "'>" + groupRow[i].name + "</option>"
					}

					last_counter += 1; 
					addInnerHtml += "<div class='div_dynamic_input_text' id='div_group_" + last_counter + "'>" + 
									 "<select name='cmb_group' id='cmb_group_" + last_counter + "' class='form-control'>" + 
									 "<option value=''>選択してください</option>" + 
                                      groupOptions +
									 "</select><label style='font-size: 10px;'>あらかじめグループ（エリア）が登録されていればこちらの店舗をグループに分類することができます。(設定できるグループ数は5個までです。)</label><br>"+ " <a class='btn btn-rounded btn-danger' style='float:left; margin-top:5px; margin-right:5px; margin-bottom:5px;' onclick='delete_group(" + last_counter + ")' id='btn_del_group_" + last_counter + 
									 "' class='a_nav_link'>削除</a></div>";
                    addDiv.innerHTML = addInnerHtml;
					document.getElementById("div_group_all").appendChild(addDiv);
					document.getElementById("hidden_group").value = last_counter;
								
				
			}

			//function take get_parameter from link
			function take_get_parameter(){
				var app_store_name = '${param.app_store_name}',
					app_company_name = '${param.app_company_name}',
					app_company_furigana = '${param.app_company_furigana}',
					app_store_manager = '${param.app_store_manager}',
					app_group = '${param.app_group}',
					app_work_loc_todoufuken = '${param.app_work_loc_todoufuken}',
					app_work_loc_shikuchouson = '${param.app_work_loc_shikuchouson}',
					app_access_todofuken = '${param.app_access_todofuken}',
					app_access_train_company = '${param.app_access_train_company}',
					app_access_train_line = '${param.app_access_train_line}', 
					app_access_train_station = '${param.app_access_train_station}',
					app_access_from_station = '${param.app_access_from_station}',
					app_access_by = '${param.app_access_by}',
					app_access_by_time = '${param.app_access_by_time}',
					app_access_comment = '${param.app_access_comment}',
					app_division = '${param.app_division}',
					app_division_todofuken = '${param.app_division_todofuken}',
					app_division_shikuchouson = '${param.app_division_shikuchouson}',
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
					
					app_access_comment = app_access_comment.replace(/<br>/g, '\r\n');
					app_division_comment = app_division_comment.replace(/<br>/g, '\r\n');
					app_telephone_comment = app_telephone_comment.replace(/<br>/g, '\r\n');
					app_telephone_more_comment = app_telephone_more_comment.replace(/<br>/g, '\r\n');
					app_admin_comment = app_admin_comment.replace(/<br>/g, '\r\n');

				document.getElementById("txt_store_name").value = app_store_name;		
				document.getElementById("txt_company_name").value = app_company_name;
				document.getElementById("txt_company_furigana").value = app_company_furigana;

				if (app_store_manager != "") {
					var store_manager = new Array(),
						store_manager = app_store_manager.split(",");

					var div_store_manager_all = "";

					for (var i = 0; i < store_manager.length; i++) {
					     div_store_manager_all += "<div class='div_dynamic_input_text' id='div_store_manager_" + i + "'>" + 
										  " <select name='cmb_store_manager' class='form-control' id='cmb_store_manager_"+ i + "'>" + 
										     accountOptions +
										     "</select><label style='font-size: 10px;'>設定して頂いた担当者の方はこちらの店舗の応募者情報を閲覧することができます。担当者は20人まで登録することができます。</label><br>" + "<a class='btn btn-rounded btn-danger' style='float:left; margin-top:5px; margin-right:5px; margin-bottom:5px;' onclick='delete_manager(" + i + ")' id='btn_del_store_manager_" 
										  + i + "' class='a_nav_link'>削除</a></div>";
					};

					document.getElementById("div_store_manager_all").innerHTML = div_store_manager_all;
					
					for (var i = 0; i < store_manager.length; i++) {
						document.getElementById("cmb_store_manager_" + i + "").value = store_manager[i];
					}
				}else{
					 addStoreManagerInput();
				}	
				 //  alert("app_group===" + app_group);
				if (app_group != "" ) {
					
					var group = new Array(),
						group = app_group.split(",");
					//	alert("group[o]==" + group[i]);
						
					var groupRow = <%=groupJsonArray.toString()%>;
				    
				    
				    var groupOptions = "";
				    
				    for(var i = 0; i < groupRow.length;i++){
						groupOptions += "<option value='" + groupRow[i].id + "'>" + groupRow[i].name + "</option>"
					}

					var div_group_all = "";

					for (var i = 0; i < group.length; i++) {
							div_group_all += "<div class='div_dynamic_input_text' id='div_group_" + i + "'>" + 
										     "<select class='form-control' name='cmb_group' id='cmb_group_" + i + "'>" + 
										     "<option value=''>選択してください</option>" + 
										     groupOptions +

										     "</select><label style='font-size: 10px;'>あらかじめグループ（エリア）が登録されていればこちらの店舗をグループに分類することができます。(設定できるグループ数は5個までです。)</label><br>" + "<a class='btn btn-rounded btn-danger' style='float:left; margin-top:5px; margin-right:5px; margin-bottom:5px;' onclick='delete_group(" + i + ")' id='btn_del_group_" + i + 
										     "' class='a_nav_link'>削除</a></div>";
					};

					document.getElementById("div_group_all").innerHTML = div_group_all;

					//set cmb group value                                                                                        
					for (var i = 0; i < group.length; i++) {
						//alert(group[]);
						document.getElementById("cmb_group_" + i + "").value = group[i];
					}
					
					if(group.length == 0){
						addGroupInput();
					}
				}else{
					addGroupInput();
				}
						    
			/*	    var group = <%=groupStoreJsonArray%>;
				    if(null == group){
						group = [];
					}
				    
				    var groupRow = <%=groupJsonArray.toString()%>;
				    
				    
				    var groupOptions = "";
				    
				    for(var i = 0; i < groupRow.length;i++){
						groupOptions += "<option value='" + groupRow[i].id + "'>" + groupRow[i].name + "</option>"
					}

					var div_group_all = "";

					for (var i = 0; i < group.length; i++) {
							div_group_all += "<div class='div_dynamic_input_text' id='div_group_" + i + "'>" + 
										     "<select class='normal_combobox' name='cmb_group' id='cmb_group_" + i + "'>" + 
										     "<option value=''>選択をしてください</option>" + 
										     groupOptions +

										     "</select> " + "<a onclick='delete_group(" + i + ")' id='btn_del_group_" + i + 
										     "' class='a_nav_link'>削除</a></div>";
					};

					document.getElementById("div_group_all").innerHTML = div_group_all;

					//set cmb group value                                                                                        
					for (var i = 0; i < group.length; i++) {
						document.getElementById("cmb_group_" + i + "").value = group[i].group;
					}
					
					if(group.length == 0){
						addGroupInput();
					}
				}else{

				}*/
				document.getElementById("cmb_work_loc_todoufuken").value = app_work_loc_todoufuken;
				
				
				document.getElementById("cmb_work_loc_shikuchouson").value = app_work_loc_shikuchouson;

				if (app_access_todofuken != "" || app_access_train_company != "" || app_access_train_line != "" || app_access_train_line != "" || app_access_train_station != "" || app_access_from_station != "" || app_access_by != "" || app_access_by_time != "") {

					var div_access_all = "",
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
					
					
					var accessTrainCompanyJson2dArray = <%=accessTrainCompanyJson2dArray.toString() %>
					var accessTrainLineJson2dArray    = <%=accessTrainLineJson2dArray.toString()%>
					var accessTrainStationJson2dArray = <%=accessTrainStationJson2dArray.toString()%>

					/*
					for (var i = 0; i < access_todofuken.length; i++) {
						div_access_all += "<div id='div_access_" + i + "' class='div_access_box_0'><a style='margin-top:10px;'' class='a_nav_link' onclick='delete_access(" + i + ")' id='btn_del_access_" +  i + "'>削除</a>";    									
    					div_access_all += "<ul class='ul_access'>";
       					div_access_all += "<li><span class='span_input_field_caption'>都道府県</span><select name='cmb_access_todofuken' id='cmb_access_todofuken_" + i + "' class='normal_combobox'>" + prefOptions + "</select></li>";
    					
    					var trainCompanyOptions = "";   					
    					var accessTrainCompanyJsonArray = accessTrainCompanyJson2dArray[i];
    					for(var j = 0;j < accessTrainCompanyJsonArray.length;j++){
							trainCompanyOptions +=  "<option value='" + accessTrainCompanyJsonArray[j].id + "'>" + accessTrainCompanyJsonArray[j].name + "</option>";
						}
    					  					
    					div_access_all += "<li><span class='span_input_field_caption'>鉄道会社名</span><select name='cmb_access_train_company' id='cmb_access_train_company_" + i + "' class='normal_combobox'><option value=''>選択してください</option>"  + trainCompanyOptions +  "</select></li>";
    					
    					
    					
    					var trainLineOptions = "";
    					
    					var accessTrainLineJsonArray = accessTrainLineJson2dArray[i];
    					
    					for(j = 0; j < accessTrainLineJsonArray.length;j++){
							trainLineOptions +=  "<option value='" + accessTrainLineJsonArray[j].id + "'>" + accessTrainLineJsonArray[j].name + "</option>";
						}
    					
    					
    					div_access_all += "<li><span class='span_input_field_caption'>線路名</span><select name='cmb_access_train_line' id='cmb_access_train_line_" + i + "' class='normal_combobox'><option value=''>選択してください</option>"  +  trainLineOptions +  "</select></li>";
    					
    					var trainStationOptions = "";
    					var accessTrainStationJsonArray = accessTrainStationJson2dArray[i];
    					for(j = 0 ; j < accessTrainStationJsonArray.length; j++){
							trainStationOptions += "<option value='" + accessTrainStationJsonArray[j].id + "'>" + accessTrainStationJsonArray[j].name + "</option>";
						}
    					div_access_all += "<li><span class='span_input_field_caption'>駅名</span><select name='cmb_access_train_station' id='cmb_access_train_station_" + i + "' class='normal_combobox'><option value=''>選択してください</option>" +  trainStationOptions  + "</select> <input class='normal_input_text' name='txt_access_from_station' id='txt_access_from_station_" + i + "' type='text' /> より</li>";
    					div_access_all += "<li><span class='span_input_field_caption'></span><select name='cmb_access_by' id='cmb_access_by_" + i + "' class='normal_combobox'><option value=''>選択してください</option><option value='徒歩'>徒歩</option><option value='バス'>バス</option><option value='車'>車</option></select> <input class='input_text_small' name='txt_access_by_time' id='txt_access_by_time_" + i + "' type='text' /> 分</li>";
    					div_access_all += "</ul>";
    					div_access_all += "</div>";

    					
					};
					*/
					
					for (var i = 0; i < access_todofuken.length; i++) {
						var trainCompanyOptions = "";   					
    					var accessTrainCompanyJsonArray = accessTrainCompanyJson2dArray[i];
    					for(var j = 0;j < accessTrainCompanyJsonArray.length;j++){
							trainCompanyOptions +=  "<option value='" + accessTrainCompanyJsonArray[j].id + "'>" + accessTrainCompanyJsonArray[j].name + "</option>";
						}
						var trainLineOptions = "";
    					var accessTrainLineJsonArray = accessTrainLineJson2dArray[i];
    					for(j = 0; j < accessTrainLineJsonArray.length;j++){
							trainLineOptions +=  "<option value='" + accessTrainLineJsonArray[j].id + "'>" + accessTrainLineJsonArray[j].name + "</option>";
						}
						var trainStationOptions = "";
    					var accessTrainStationJsonArray = accessTrainStationJson2dArray[i];
    					for(j = 0 ; j < accessTrainStationJsonArray.length; j++){
							trainStationOptions += "<option value='" + accessTrainStationJsonArray[j].id + "'>" + accessTrainStationJsonArray[j].name + "</option>";
						}
						
						div_access_all += "<div id='div_access_" + i + "' class='div_access_box_0'>";
						div_access_all += " <div class='form-group'>" + 
									"  <div class='pull-right'>" + 
									"   <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>" + 
									"    <a class='btn btn-rounded btn-danger' style='margin-top:10px;'' class='a_nav_link' onclick='delete_access(" + i + ")' id='btn_del_access_" +  i + "'>削除</a>" + 
									"   </div>" + 
									"  </div>" + 
									" </div>";
						div_access_all += " <div class='form-group'>" + 
    								"  <h6 class='col-lg-offset-3 col-md-2 col-sm-4 col-xs-12' style='font-size:12px; margin-top:20px;''>※ 都道府県</h6>" + 
    								"  <div class='col-lg-5 col-md-8 col-sm-12 col-xs-12' style='margin-top:10px;'>" + 
    								"   <select name='cmb_access_todofuken' id='cmb_access_todofuken_" + i + "' class='form-control' onChange=getSelecterJson('cmb_access_todofuken_" + i + "','cmb_access_train_company_" + i + "','/get_rail_company?pref=')>" +  prefOptions  + "</select>" + 
    								"  </div>" + 
    								" </div>";
						div_access_all += " <div class='form-group'>" + 
    								"  <h6 class='col-lg-offset-3 col-md-2 col-sm-4 col-xs-12' style='font-size:12px; margin-top:20px;''>※ 鉄道会社名</h6>" + 
    								"  <div class='col-lg-5 col-md-10 col-sm-12 col-xs-12' style='margin-top:10px;'>" + 
    								"   <select name='cmb_access_train_company' id='cmb_access_train_company_" + i + "' class='form-control' onChange=getSelecterJson('cmb_access_train_company_" + i + "','cmb_access_train_line_" + i + "','/get_route?rail_company=')><option value=''>選択してください</option>"  + trainCompanyOptions +  "</select>" + 
    								"  </div>" + 
    								" </div>";
						div_access_all += " <div class='form-group'>" + 
    								"  <h6 class='col-lg-offset-3 col-md-2 col-sm-4 col-xs-12' style='font-size:12px; margin-top:20px;'>※ 線路名</h6>" + 
    								"  <div class='col-lg-5 col-md-10 col-sm-12 col-xs-12' style='margin-top:10px;'>" + 
    								"   <select name='cmb_access_train_line' id='cmb_access_train_line_" +  i + "' class='form-control' onChange=getSelecterJson('cmb_access_train_line_" + i + "','cmb_access_train_station_" + i + "','/get_station?route=')><option value=''>選択してください</option>"  + trainLineOptions +  "</select>" + 
    								"  </div>" + 
    								" </div>";
						div_access_all += " <div class='form-group'>" + 
    								"  <h6 class='col-lg-offset-3 col-md-2 col-sm-4 col-xs-12' style='font-size:12px; margin-top:20px;'>※ 駅名</h6>" + 
    								"  <div class='col-lg-3 col-md-10 col-sm-12 col-xs-12' style='margin-top:10px;'>" + 
    								"   <select name='cmb_access_train_station' id='cmb_access_train_station_" + i + "' class='form-control'><option value=''>選択してください</option>" +  trainStationOptions  + "</select>" + 
    								"  </div>" + 
    								"  <div class='col-lg-2 col-md-12 col-sm-12 col-xs-12' style='margin-top:10px;'>" + 
    								"   <input class='form-control' name='txt_access_from_station' id='txt_access_from_station_" + i + "' placeholder='より' type='text' />" +
    								"  </div>" + 
    								" </div>";
						div_access_all += " <div class='form-group'>" + 
    								"  <h6 class='col-lg-offset-3 col-md-2 col-sm-2 col-xs-12' style='font-size:12px; margin-top:20px;'></h6>" + 
    								"  <div class='col-lg-3 col-md-12 col-sm-12 col-xs-12' style='margin-top:10px;'>" + 
    								"   <select name='cmb_access_by' id='cmb_access_by_" + i + "' class='form-control'>" + 
    								"    <option value=''>選択してください</option>" +
    								"    <option value='徒歩'>徒歩</option>" + 
    								"    <option value='バス'>バス</option>" + 
    								"    <option value='車'>車</option>" + 
    								"   </select>" + 
    								"  </div>" + 
    								"  <div class='col-lg-2 col-md-12 col-sm-12 col-xs-12' style='margin-top:10px;'>" + 
    								"   <input class='form-control' name='txt_access_by_time' id='txt_access_by_time_" + i + "' placeholder='分' type='text' />" +
    								"  </div>" + 
    								" </div>";
						div_access_all += " <div class='col-lg-offset-3 col-lg-9 col-md-12 col-sm-12 col-xs-12' style='border-bottom: 1px dashed black; margin-top:10px;'></div>";
						div_access_all += "</div>";
					};
					
					document.getElementById("div_access_all").innerHTML = div_access_all;

					for (var i = 0; i < access_todofuken.length; i++) {
						
						document.getElementById("cmb_access_todofuken_" + i).value = access_todofuken[i];
						document.getElementById("cmb_access_train_company_" + i).value = access_train_company[i];
						document.getElementById("cmb_access_train_line_" + i).value = access_train_line[i];
						document.getElementById("cmb_access_train_station_" + i).value = access_train_station[i];
						document.getElementById("txt_access_from_station_" + i).value = access_from_station[i];
						document.getElementById("cmb_access_by_" + i).value = access_by[i];
						document.getElementById("txt_access_by_time_" + i).value = access_by_time[i];
					};
					
					document.getElementById("hidden_access").value = access_todofuken.length;

				}

				document.getElementById("txt_access_comment").value = app_access_comment;
				
				if(app_access_comment != ""){
					document.getElementById("div_access_detail").style.display = "block";
					document.getElementById("hidden_access_detail").value = "1";
				}
				
				document.getElementById("cmb_division").value = app_division;
				document.getElementById("cmb_division_todofuken").value = app_division_todofuken;
				
				
				
				
				
				
				document.getElementById("cmb_division_shikuchouson").value = app_division_shikuchouson;
				document.getElementById("txt_division_house_number").value = app_division_house_number;
				document.getElementById("txt_division_building_name").value = app_division_building_name;
				document.getElementById("txt_division_comment").value = app_division_comment;

				document.getElementById("txt_telephone_0").value = app_telephone_0;
				document.getElementById("txt_telephone_1").value = app_telephone_1;
				document.getElementById("txt_telephone_2").value = app_telephone_2;
				document.getElementById("txt_telephone_comment").value = app_telephone_comment;
				document.getElementById("txt_telephone_more_comment").value = app_telephone_more_comment;
				
				if(app_telephone_more_comment != ""){
					document.getElementById("div_store_address_detail").style.display = "block";
					document.getElementById("hidden_store_address_detail").value = "1";
				}

				document.getElementById("txt_admin_comment").value = app_admin_comment;

				if (app_store_term != "") {
					var store_term = new Array(),
						store_term = app_store_term.split(","),
						div_store_term_all = "";


					for (var i = 0; i < store_term.length; i++) {
						if (i == 0) {
							document.getElementById("txt_store_term_" + i).value = store_term[i]
						}
						else {
							div_store_term_all += "<div class='div_dynamic_input_text' id='div_store_term_" + i + "'>" +
												  " <div class='col-lg-offset-3  col-lg-7 col-md-12 col-sm-12 col-xs-12' id='div_store_term_0'>" +
												  "  <input name='txt_store_term' class='form-control' id='txt_store_term_"+ i + "' value='" + store_term[i] + "' />" +
												  "  (１００文字以内)" + 
												  "  <div class='pull-right'>" + 
												  "   <a class='btn btn-rounded btn-danger' style='margin-top:5px; margin-right: 5px; margin-bottom:5px;' onclick='delete_store_term(" + i + ")' id='btn_delete_store_term_" + i + "' class='a_nav_link'>削除</a>" + 
												  "  </div>" +
												  " </div>" +   
										          "</div>";
						}						
					};
					document.getElementById("div_store_term_all").innerHTML = div_store_term_all;
				}
			}

			$(function() {
				//initialize combo box and other field value when the screen is loaded
				initialize_screen();
				clear_all_input_field();
				take_get_parameter();

				//key press event
				$("#txt_store_name").keyup(function(){
    				var text_length = $("#txt_store_name").val().length;
    				$("#span_store_name_total_char").html(text_length);
    			});
    			$("#txt_company_name").keyup(function(){
    				var text_length = $("#txt_company_name").val().length;
    				$("#span_company_name_total_char").html(text_length);
    			});
    			$("#txt_company_furigana").keyup(function(){
    				var text_length = $("#txt_company_furigana").val().length;
    				$("#span_company_furigana_total_char").html(text_length);
    			});
    			$("#txt_access_comment").keyup(function(){
    				var text_length = $("#txt_access_comment").val().length;
    				$("#span_access_comment_total_char").html(text_length);
    			});
    			$("#txt_division_comment").keyup(function(){
    				var text_length = $("#txt_division_comment").val().length;
    				$("#span_division_comment_total_char").html(text_length);
    			});
    			$("#txt_telephone_comment").keyup(function(){
    				var text_length = $("#txt_telephone_comment").val().length;
    				$("#span_telephone_comment_total_char").html(text_length);
    			});
    			$("#txt_telephone_more_comment").keyup(function(){
    				var text_length = $("#txt_telephone_more_comment").val().length;
    				$("#span_telephone_more_comment_total_char").html(text_length);
    			});
    			$("#txt_admin_comment").keyup(function(){
    				var text_length = $("#txt_admin_comment").val().length;
    				$("#span_admin_comment_total_char").html(text_length);
    			});

    			//action before submit data
    			$("#btn_confirm_data_change").click(function (){
    				if ( validate_empty_text() != 1 ) {
    					redirect_to_confirm_page();
    				}
    			});

    			//add element action
    			$("#btn_add_store_manager").click(function(){
    			/*	var last_counter = parseInt(document.getElementById("hidden_store_manager").value);
					var	div_store_manager_all = document.getElementById("div_store_manager_all").innerHTML;

					last_counter += 1; 
					div_store_manager_all += "<div class='div_dynamic_input_text' id='div_store_manager_" + last_counter + "'>" + 
										  " <input name='txt_store_manager' class='normal_input_text' id='txt_store_manager_"+ last_counter + "' /> <a onclick='delete_manager(" + last_counter + ")' id='btn_del_store_manager_" 
										  + last_counter + "' class='a_nav_link'>削除</a></div>";

					document.getElementById("div_store_manager_all").innerHTML = div_store_manager_all;
					document.getElementById("hidden_store_manager").value = last_counter;*/
					addStoreManagerInput();
    			});

    			$("#btn_add_group").click(function(){

			/*	    var last_counter = parseInt(document.getElementById("hidden_group").value);
					
					var addInnerHtml = "";
    				var addDiv = document.createElement('div');
					
					var groupRow = <%=groupJsonArray.toString()%>;
				    var groupOptions = "";
				    for(var i = 0; i < groupRow.length;i++){
						groupOptions += "<option value='" + groupRow[i].id + "'>" + groupRow[i].name + "</option>"
					}

					last_counter += 1; 
					addInnerHtml += "<div class='div_dynamic_input_text' id='div_group_" + last_counter + "'>" + 
									 "<select name='cmb_group' id='cmb_group_" + last_counter + "' class='normal_combobox'>" + 
									 "<option value=''>選択をしてください</option>" + 
                                      groupOptions +
									 "</select>" + " <a onclick='delete_group(" + last_counter + ")' id='btn_del_group_" + last_counter + 
									 "' class='a_nav_link'>削除</a></div>";
                    addDiv.innerHTML = addInnerHtml;
					document.getElementById("div_group_all").appendChild(addDiv);
					document.getElementById("hidden_group").value = last_counter;*/
					addGroupInput();
    			});

    			$("#btn_add_access_row").click(function(){
    				var last_counter = parseInt(document.getElementById("hidden_access").value);
    				var addInnerHtml = "";
    				var addDiv = document.createElement('div');

    				

    				last_counter += 1;
    				addInnerHtml += "<div id='div_access_" + last_counter + "' class='div_access_box_0'>";
    				addInnerHtml += " <div class='form-group'>" + 
    								"  <div class='pull-right'>" + 
    								"   <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>" + 
    								"    <a class='btn btn-rounded btn-danger' style='margin-top:10px;'' class='a_nav_link' onclick='delete_access(" + last_counter + ")' id='btn_del_access_" +  last_counter + "'>削除</a>" + 
    								"   </div>" + 
    								"  </div>" + 
    								" </div>";
    				addInnerHtml += " <div class='form-group'>" + 
    								"  <h6 class='col-lg-offset-3 col-md-2 col-sm-4 col-xs-12' style='font-size:12px; margin-top:20px;''>※ 都道府県</h6>" + 
    								"  <div class='col-lg-5 col-md-8 col-sm-12 col-xs-12' style='margin-top:10px;'>" + 
    								"   <select name='cmb_access_todofuken' id='cmb_access_todofuken_" + last_counter + "' class='form-control' onChange=getSelecterJson('cmb_access_todofuken_" + last_counter + "','cmb_access_train_company_" + last_counter + "','/get_rail_company?pref=')>" +  prefOptions  + "</select>" + 
    								"  </div>" + 
    								" </div>";
    				addInnerHtml += " <div class='form-group'>" + 
    								"  <h6 class='col-lg-offset-3 col-md-2 col-sm-4 col-xs-12' style='font-size:12px; margin-top:20px;''>※ 鉄道会社名</h6>" + 
    								"  <div class='col-lg-5 col-md-10 col-sm-12 col-xs-12' style='margin-top:10px;'>" + 
    								"   <select name='cmb_access_train_company' id='cmb_access_train_company_" + last_counter + "' class='form-control' onChange=getSelecterJson('cmb_access_train_company_" + last_counter + "','cmb_access_train_line_" + last_counter + "','/get_route?rail_company=')></select>" + 
    								"  </div>" + 
    								" </div>";
    				addInnerHtml += " <div class='form-group'>" + 
    								"  <h6 class='col-lg-offset-3 col-md-2 col-sm-4 col-xs-12' style='font-size:12px; margin-top:20px;'>※ 線路名</h6>" + 
    								"  <div class='col-lg-5 col-md-10 col-sm-12 col-xs-12' style='margin-top:10px;'>" + 
    								"   <select name='cmb_access_train_line' id='cmb_access_train_line_" +  last_counter + "' class='form-control' onChange=getSelecterJson('cmb_access_train_line_" + last_counter + "','cmb_access_train_station_" + last_counter + "','/get_station?route=')></select>" + 
    								"  </div>" + 
    								" </div>";
    				addInnerHtml += " <div class='form-group'>" + 
    								"  <h6 class='col-lg-offset-3 col-md-2 col-sm-4 col-xs-12' style='font-size:12px; margin-top:20px;'>※ 駅名</h6>" + 
    								"  <div class='col-lg-3 col-md-10 col-sm-12 col-xs-12' style='margin-top:10px;'>" + 
    								"   <select name='cmb_access_train_station' id='cmb_access_train_station_" + last_counter + "' class='form-control'></select>" + 
    								"  </div>" + 
    								"  <div class='col-lg-2 col-md-12 col-sm-12 col-xs-12' style='margin-top:10px;'>" + 
    								"   <input class='form-control' name='txt_access_from_station' id='txt_access_from_station_" + last_counter + "' placeholder='より' type='text' />" +
    								"  </div>" + 
    								" </div>";
    				addInnerHtml += " <div class='form-group'>" + 
    								"  <h6 class='col-lg-offset-3 col-md-2 col-sm-2 col-xs-12' style='font-size:12px; margin-top:20px;'></h6>" + 
    								"  <div class='col-lg-3 col-md-12 col-sm-12 col-xs-12' style='margin-top:10px;'>" + 
    								"   <select name='cmb_access_by' id='cmb_access_by_" + last_counter + "' class='form-control'>" + 
    								"    <option value=''>選択してください</option>" +
    								"    <option value='徒歩'>徒歩</option>" + 
    								"    <option value='バス'>バス</option>" + 
    								"    <option value='車'>車</option>" + 
    								"   </select>" + 
    								"  </div>" + 
    								"  <div class='col-lg-2 col-md-12 col-sm-12 col-xs-12' style='margin-top:10px;'>" + 
    								"   <input class='form-control' name='txt_access_by_time' id='txt_access_by_time_" + last_counter + "' placeholder='分' type='text' />" +
    								"  </div>" + 
    								" </div>";
    				addInnerHtml += " <div class='col-lg-offset-3 col-lg-9 col-md-12 col-sm-12 col-xs-12' style='border-bottom: 1px dashed black; margin-top:10px;'></div>";
					addInnerHtml += "</div>";
                    addDiv.innerHTML =  addInnerHtml;
    				document.getElementById("div_access_all").appendChild(addDiv);
					document.getElementById("hidden_access").value = last_counter;
    			});

				$("#btn_add_store_term").click(function(){
					var last_counter = parseInt(document.getElementById("hidden_access_detail").value);
    				var div_store_term_all = document.getElementById("div_store_term_all").innerHTML;
    				
    				var addDiv = document.createElement('div');

    				last_counter += 1;
    				//div_store_term_all += "<div class='div_dynamic_input_text' id='div_store_term_" + last_counter + "'>" + 
    				var addInnerHTML = "<div class='div_dynamic_input_text' id='div_store_term_" + last_counter + "'>" + 
										  " <div class='col-lg-offset-3 col-lg-7 col-md-12 col-sm-12 col-xs-12' id='div_store_term_0'>" +
										  "  <input name='txt_store_term' class='form-control' id='txt_store_term_"+ last_counter + "' value='' />" +
										  "  (１００文字以内)" + 
										  "  <div class='pull-right'>" + 
										  "   <a class='btn btn-rounded btn-danger' style='margin-top:5px; margin-right: 5px; margin-bottom:5px;' onclick='delete_store_term(" + last_counter + ")' id='btn_delete_store_term_" + last_counter + "' class='a_nav_link'>削除</a>" + 
										  "  </div>" +
										  " </div>" +
										  "</div>";
										  
					addDiv.innerHTML = addInnerHTML;		  
					document.getElementById("div_store_term_all").appendChild(addDiv);
    				//document.getElementById("div_store_term_all").innerHTML = div_store_term_all;
					document.getElementById("hidden_store_term").value = last_counter;
				});
			});	


			//delete multi field
			function delete_manager (index) {
				$("#div_store_manager_" + index).remove();
			}

			function delete_group (index) {
				$("#div_group_" + index).remove();
			}

			function delete_access (index) {
				$("#div_access_" + index).remove();
			}

			function delete_store_term (index) {
				$("#div_store_term_" + index).remove();
			}

			//display detail 
			function display_detail (element_id, hidden_element_id ) {

				var hid = document.getElementById(hidden_element_id).value;
				
				if (hid == 0) {
					document.getElementById(element_id).style.display = "block";
					document.getElementById(hidden_element_id).value = "1";
				}
				else {
					document.getElementById(element_id).style.display = "none";
					document.getElementById(hidden_element_id).value = "0";	
				}

			}
			//redirect to confirmation page
			function redirect_to_confirm_page() {
				
				var accessComent = document.getElementById("txt_access_comment").value.replace(/\r?\n/g,'<br>');
				var divisionComent = document.getElementById("txt_division_comment").value.replace(/\r?\n/g,'<br>');
				var telephonenComent = document.getElementById("txt_telephone_comment").value.replace(/\r?\n/g,'<br>');
				var telephonenMoreComent = document.getElementById("txt_telephone_more_comment").value.replace(/\r?\n/g,'<br>');
				var adminComent = document.getElementById("txt_admin_comment").value.replace(/\r?\n/g,'<br>');
				
				//alert("1");
				var input_store_name             = setParam("app_store_name",document.getElementById("txt_store_name").value);
				var input_company_name           = setParam("app_company_name",document.getElementById("txt_company_name").value);
				var input_company_furigana       = setParam("app_company_furigana",document.getElementById("txt_company_furigana").value);
				var input_store_manager          = setParam("app_store_manager",get_multi_store_manager());
				var input_group                  = setParam("app_group",get_multi_group());
				var input_work_loc_todoufuken    = setParam("app_work_loc_todoufuken",document.getElementById("cmb_work_loc_todoufuken").value);
				var input_work_loc_shikuchouson  = setParam("app_work_loc_shikuchouson",document.getElementById("cmb_work_loc_shikuchouson").value);
				var input_access_todofuken       = setParam("app_access_todofuken",get_multi_access_todofuken());
				var input_access_train_company   = setParam("app_access_train_company",get_multi_access_train_company());
				var input_access_train_line      = setParam("app_access_train_line",get_multi_access_train_line());
				var input_access_train_station   = setParam("app_access_train_station",get_multi_access_train_station());
				var input_access_from_station    = setParam("app_access_from_station",get_multi_access_from_station());
				var input_access_by              = setParam("app_access_by",get_multi_access_by());
				var input_access_by_time         = setParam("app_access_by_time",get_multi_access_by_time());
				//var input_access_comment         = setParam("app_access_comment",document.getElementById("txt_access_comment").value);
				var input_access_comment         = setParam("app_access_comment",accessComent);
				var input_division               = setParam("app_division",document.getElementById("cmb_division").value);
				var input_division_todofuken     = setParam("app_division_todofuken",document.getElementById("cmb_division_todofuken").value);
				var input_division_shikuchouson  = setParam("app_division_shikuchouson",document.getElementById("cmb_division_shikuchouson").value);
				var input_division_house_number  = setParam("app_division_house_number",document.getElementById("txt_division_house_number").value);
				var input_division_building_name = setParam("app_division_building_name",document.getElementById("txt_division_building_name").value);
				//var input_division_comment       = setParam("app_division_comment",document.getElementById("txt_division_comment").value);
				var input_division_comment       = setParam("app_division_comment",divisionComent);
				var input_telephone_0            = setParam("app_telephone_0",document.getElementById("txt_telephone_0").value);
				var input_telephone_1            = setParam("app_telephone_1",document.getElementById("txt_telephone_1").value);
				var input_telephone_2            = setParam("app_telephone_2",document.getElementById("txt_telephone_2").value);
				//var input_telephone_comment      = setParam("app_telephone_comment",document.getElementById("txt_telephone_comment").value);
				var input_telephone_comment      = setParam("app_telephone_comment",telephonenComent);
				//var input_telephone_more_comment = setParam("app_telephone_more_comment",document.getElementById("txt_telephone_more_comment").value);
				var input_telephone_more_comment = setParam("app_telephone_more_comment",telephonenMoreComent);
				//var input_admin_comment          = setParam("app_admin_comment",document.getElementById("txt_admin_comment").value);
				var input_admin_comment          = setParam("app_admin_comment",adminComent);
				var input_store_term             = setParam("app_store_term",get_multi_store_term());
				
				
				//alert("");
			    var f = document.createElement("form");
                f.setAttribute('method',"post");
                f.setAttribute('action',"/setting_store_create_conf");
                f.appendChild(input_store_name);
                f.appendChild(input_company_name);
                f.appendChild(input_company_furigana);
                f.appendChild(input_store_manager);
                f.appendChild(input_group);
                f.appendChild(input_work_loc_todoufuken);
                f.appendChild(input_work_loc_shikuchouson);
                f.appendChild(input_access_todofuken);
                f.appendChild(input_access_train_company);
                f.appendChild(input_access_train_line);
                f.appendChild(input_access_train_station);
                f.appendChild(input_access_from_station);
                f.appendChild(input_access_by);
                f.appendChild(input_access_by_time);
                f.appendChild(input_access_comment);
                f.appendChild(input_division);
                f.appendChild(input_division_todofuken);
                f.appendChild(input_division_shikuchouson);
                f.appendChild(input_division_house_number);
                f.appendChild(input_division_building_name);
                f.appendChild(input_division_comment);
                f.appendChild(input_telephone_0);
                f.appendChild(input_telephone_1);
                f.appendChild(input_telephone_2);
                f.appendChild(input_telephone_comment);
                f.appendChild(input_telephone_more_comment);
                f.appendChild(input_admin_comment);
                f.appendChild(input_store_term);
                var bodyElement = document.body ;
                bodyElement.append(f);
                f.submit();

			}

			//validation 
			function validate_empty_text() {
				var txt_store_name = document.getElementById("txt_store_name").value,
					txt_company_name = document.getElementById("txt_company_name").value,
					cmb_work_loc_todoufuken = document.getElementById("cmb_work_loc_todoufuken").value,
					cmb_work_loc_shikuchouson = document.getElementById("cmb_work_loc_shikuchouson").value,
					cmb_division = document.getElementById("cmb_division").value,
					cmb_division_todofuken = document.getElementById("cmb_division_todofuken").value,
					cmb_division_shikuchouson = document.getElementById("cmb_division_shikuchouson").value,
					txt_division_house_number = document.getElementById("txt_division_house_number").value,
					txt_telephone_0 = document.getElementById("txt_telephone_0").value,
					txt_telephone_1 = document.getElementById("txt_telephone_1").value,
					txt_telephone_2 = document.getElementById("txt_telephone_2").value;								

				var status = 0;

				window.location.hash = '#check';

				$("#div_store_name_error").html("");
				$("#div_company_name_error").html("");
				$("#div_work_loc_error").html("");
				$("#div_division_error").html("");
				$("#div_telephone_error").html("");				

				if (txt_store_name == "") {
					$("#div_store_name_error").html("店舗マスタ名は必須です。");
					status = 1;
				}

				if (txt_company_name == "") {
					$("#div_company_name_error").html("会社・店舗名は必須です。");
					status = 1;	
				}

				if (cmb_work_loc_shikuchouson == "" || cmb_work_loc_todoufuken == "") {
					$("#div_work_loc_error").html("勤務地は必須です。");
					status = 1;
				}

				if (cmb_division == "" || cmb_division_todofuken == "" || cmb_division_shikuchouson == "" || txt_division_house_number == "") {
					$("#div_division_error").html("所在地は必須です。");
					status = 1;
				}

				if (txt_telephone_0 == "" || txt_telephone_1 == "" || txt_telephone_2 == "") {
					$("#div_telephone_error").html("店舗連絡先は必須です。");
					status = 1;
				}				

				return status;
			}

			//get multi line values
			function get_multi_store_manager() {
				var store_manager_list = "",
					cmb_store_manager = document.getElementsByName("cmb_store_manager");

				for (var i = 0; i < cmb_store_manager.length; i++) {
					if (cmb_store_manager[i].value != "") {
						if(i == 0)
							store_manager_list += cmb_store_manager[i].value;
						else
							store_manager_list += "," + cmb_store_manager[i].value;
					}
				};

				return store_manager_list;
			}

			function get_multi_group() {
				var group_list = "",
					cmb_group = document.getElementsByName("cmb_group");

				for (var i = 0; i < cmb_group.length; i++) {
					if (cmb_group[i].value != "") {
	 					if (i == 0) 
							group_list += cmb_group[i].value;
						else 
							group_list += "," + cmb_group[i].value;
					}
				};

				return group_list;
			}

			function get_multi_access_todofuken () {
				var access_todofuken_list = "",
					cmb_access_todofuken = document.getElementsByName("cmb_access_todofuken");

				for (var i = 0; i < cmb_access_todofuken.length; i++) {
					if (cmb_access_todofuken[i].value != "") {
	 					if (i == 0) 
							access_todofuken_list += cmb_access_todofuken[i].value;
						else 
							access_todofuken_list += "," + cmb_access_todofuken[i].value;
					}
				};

				return access_todofuken_list;	
			}
			function get_multi_access_train_company () {
				var access_train_company_list = "",
					cmb_access_train_company = document.getElementsByName("cmb_access_train_company");

				for (var i = 0; i < cmb_access_train_company.length; i++) {
					//if (cmb_access_train_company[i].value != "") {
	 					if (i == 0) 
							access_train_company_list += cmb_access_train_company[i].value;
						else 
							access_train_company_list += "," + cmb_access_train_company[i].value;
					//}
				};

				return access_train_company_list;
			}
			function get_multi_access_train_line () {
				var access_train_line_list = "",
					cmb_access_train_line = document.getElementsByName("cmb_access_train_line");

				for (var i = 0; i < cmb_access_train_line.length; i++) {
					//if (cmb_access_train_line[i].value != "") {
	 					if (i == 0) 
							access_train_line_list += cmb_access_train_line[i].value;
						else 
							access_train_line_list += "," + cmb_access_train_line[i].value;
					//}
				};

				return access_train_line_list;	
			}
			function get_multi_access_train_station () {
				var access_train_station_list = "",
					cmb_access_train_station = document.getElementsByName("cmb_access_train_station");

				for (var i = 0; i < cmb_access_train_station.length; i++) {
					//if (cmb_access_train_station[i].value != "") {
						if (i == 0)
							access_train_station_list += cmb_access_train_station[i].value;
						else
							access_train_station_list += "," + cmb_access_train_station[i].value;
					//}
				};

				return access_train_station_list;
			}
			function get_multi_access_from_station () {
				var access_from_station_list = "",
					txt_access_from_station = document.getElementsByName("txt_access_from_station");

				for (var i = 0; i < txt_access_from_station.length; i++) {
					var add_txt_access_from_station = "より"; // 何も入力がなければ初期値を「より」とする
					if (txt_access_from_station[i].value != "") {
						add_txt_access_from_station = txt_access_from_station[i].value;
					}
					if (i == 0) {
						access_from_station_list += add_txt_access_from_station;
					} else {
						access_from_station_list += "," + add_txt_access_from_station;
					}
				};
				return access_from_station_list;
			}
			function get_multi_access_by () {
				var access_by_list = "",
					cmb_access_by = document.getElementsByName("cmb_access_by");

				for (var i = 0; i < cmb_access_by.length; i++) {
					//if (cmb_access_by[i].value != "") {
						if (i == 0)
							access_by_list += cmb_access_by[i].value;
						else
							access_by_list += "," + cmb_access_by[i].value;
					//}	
				};

				return access_by_list;	
			}
			function get_multi_access_by_time () {
				var access_by_time_list = "",
					txt_access_by_time = document.getElementsByName("txt_access_by_time");

				for (var i = 0; i < txt_access_by_time.length; i++) {
					var add_txt_access_by_time = "分"; // 何も入力がなければ初期値を「分」とする
					if (txt_access_by_time[i].value != "") {
						add_txt_access_by_time = txt_access_by_time[i].value;
					}
					if (i == 0) {
						access_by_time_list += add_txt_access_by_time;
					} else {
						access_by_time_list += "," + add_txt_access_by_time;
					}
				};

				return access_by_time_list;		
			}

			function get_multi_store_term () {
				var store_term_list = "",
					txt_store_term = document.getElementsByName("txt_store_term");

				for (var i = 0; i < txt_store_term.length; i++) {
					if (txt_store_term[i].value != "") {
						if (i == 0)
							store_term_list += txt_store_term[i].value;
						else
							store_term_list += "," + txt_store_term[i].value;
					}	
				};

				return store_term_list;			
			}
		</script>
		<script>
		function prefSelected(todoufuken_select,shikuchouson_select){
		    var prefSelect = document.getElementById(todoufuken_select);
			var index = prefSelect.selectedIndex;
			var selected;
            if (index != 0){
              selected = prefSelect.options[index].value;
            }
            
            var url = "/get_city?pref=" + selected;
            
            var request = new XMLHttpRequest();
            request.onreadystatechange = function() {
				if (request.readyState == 4 && request.status == 200) {		 
				    var cityArray =  JSON.parse(request.responseText);
				   // var select = document.getElementById('cmb_work_loc_shikuchouson');
				    var select = document.getElementById(shikuchouson_select); 
				 /*   var length = select.options.length;
				    var i;
                    for (i = 1; i < length; i++) {
					  select.removeChild
                      select.options[i] = null;//一旦すべてのオプションを消す
                    }*/
                        while (select.options.length) {
                           select.remove(0);
                         }   
                      var initOption = document.createElement('option');
                       initOption.setAttribute('value','');
					   initOption.innerHTML = '選択してください';
					   select.appendChild(initOption);
				    for( i = 0; i < cityArray.length;i++){
                       var option = document.createElement('option');
					   option.setAttribute('value',cityArray[i].id);
					   option.innerHTML = cityArray[i].name;
					   select.appendChild(option);
						
					}
				}
	       }
            request.open("GET", url, true);
            request.send("");

		}
		
		function getSelecterJson(fromSelecter,toSelecter,url){
		    var prefSelect = document.getElementById(fromSelecter);
			var index = prefSelect.selectedIndex;
			var selected;
            if (index != 0){
              selected = ((prefSelect.options[index].value).split(','))[0];
            }
           url = url + selected;
            
            var request = new XMLHttpRequest();
            request.onreadystatechange = function() {
				if (request.readyState == 4 && request.status == 200) {		 
				    var jsonArray =  JSON.parse(request.responseText);
				    var select = document.getElementById(toSelecter); 
                        while (select.options.length) {
                           select.remove(0);
                         }   
                      var initOption = document.createElement('option');
                       initOption.setAttribute('value','');
					   initOption.innerHTML = '選択してください';
					   select.appendChild(initOption);
				    for( i = 0; i < jsonArray.length;i++){
                       var option = document.createElement('option');
					   option.setAttribute('value',(jsonArray[i].id));
					   option.innerHTML = jsonArray[i].name;
					   select.appendChild(option);
						
					}
				}
	       }
            request.open("GET", url, true);
            request.send("");
		}
		
  </script>
 </head>
 <body class="hold-transition skin-kujira sidebar-mini <%=sidebar_collapse%>" id="check">
  <div class="wrapper">
   <jsp:include page="/WEB-INF/views/common/top_bar.jsp" flush="false" />
   <jsp:include page="/WEB-INF/views/common/side_bar.jsp" flush="false" />
   <div class="content-wrapper">
    <section class="content-header">
     <h1>店舗登録</h1>
     <ol class="breadcrumb">
      <li><a href="/"><i class="fa fa-home"></i> ホーム</a></li>
      <li><a href="/setting_store"><i class="fa fa-cogs"></i> 設定</a></li>
      <li class="active">店舗登録</li>
     </ol>
    </section>
    <section class="content">
     <div class="row">
      <section class="col-md-12 col-xs-12">
       <div class="callout callout-warning">
        <h4 style="font-size:16px;">店舗登録</h4>
       </div>
       <div class="row">
        <div class="col-md-12 col-xs-12">
         <div class="box box-kujira">
          <div class="box-body">
           <div class="form-group">
       	    <h6 class="col-lg-3 col-md-4 col-sm-12 col-xs-12" style="font-size:12px;">店舗ID</h6>
       	    <h6 class="col-sm-6 col-xs-12" style="font-size:12px;">システムにより自動採番されます。</h6>
           </div>
          </div>
       	  <div class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
       	   <div class="form-group">
       	   	<h6 class="col-lg-3 col-md-4 col-sm-12 col-xs-12" style="font-size:12px;">店舗マスタ名 <span style="font-size:12px; background-color: #d9534f; border-color: #d43f3a; padding:3px; border-radius: 3px; color: #fff;">必須</span></h6>
       	   	<div class="col-lg-7 col-md-6 col-sm-12 col-xs-12">
       	   	 <label style="font-size: 12px;">管理用の店舗名のため求職者には公開されません。</label>
       	   	 <input type="text" id="txt_store_name" class="form-control" maxlength="50"/>
       	   	 (<span id="span_store_name_total_char" >0</span> / 50文字)
       	   	 <h6 id="div_store_name_error" style="font-size:12px; color:red;"></h6>
       	   	</div>
       	   </div>
       	  </div>
       	  <div class="box-body">
       	   <div class="form-group">
       	   	<h6 class="col-lg-3 col-md-4 col-sm-12 col-xs-12" style="font-size:12px;">会社・店舗名 <span style="font-size:12px; background-color: #d9534f; border-color: #d43f3a; padding:3px; border-radius: 3px; color: #fff;">必須</span></h6>
       	   	<div class="col-lg-7 col-md-6 col-sm-12 col-xs-12">
       	   	 <label style="font-size: 12px;">こちらの名称が求職者に店舗名として表示されます。</label>
       	   	 <input type="text" id="txt_company_name" class="form-control" maxlength="50"/>
       	   	 (<span id="span_company_name_total_char" >0</span> / 50文字)
       	   	 <h6 id="div_company_name_error" style="font-size:12px; color:red;"></h6>
       	   	</div>
       	   </div>
       	  </div>
       	  <div class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
       	   <div class="form-group">
       	   	<h6 class="col-lg-3 col-md-4 col-sm-12 col-xs-12" style="font-size:12px;">会社・店舗名（ふりがな）</h6>
       	   	<div class="col-lg-7 col-md-6 col-sm-12 col-xs-12">
       	   	 <input type="text" id="txt_company_furigana" class="form-control" maxlength="100"/>
       	   	 (<span id="span_company_furigana_total_char" >0</span> / 100文字)
       	   	</div>
       	   </div>
       	  </div>
       	  <div class="box-body">
       	   <div class="form-group">
       	   	<h6 class="col-lg-3 col-md-4 col-sm-12 col-xs-12" style="font-size:12px;">ご担当者様</h6>
       	   	<div class="col-md-7 col-xs-12">
       	   	 <div id="div_store_manager_all"></div>
       	   	 <div><a class='btn btn-rounded btn-kujira' style='margin-top:5px;' id="btn_add_store_manager" class='a_nav_link'>追加</a></div>
       	   	 <input type="hidden" id="hidden_store_manager" value="0"/>
       	   	</div>
       	   </div>
       	  </div>
       	  <div class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
       	   <div class="form-group">
       	   	<h6 class="col-lg-3 col-md-4 col-sm-12 col-xs-12" style="font-size:12px;">グループ</h6>
       	   	<div class="col-md-7 col-xs-12">
       	   	 <div id="div_group_all"></div>
       	   	 <div><a class='btn btn-rounded btn-kujira' style='margin-top:5px;' id="btn_add_group">追加</a></div>
       	   	 <input type="hidden" id="hidden_group" value="0"/>
       	   	</div>
       	   </div>
       	  </div>
       	  <div class="box-body">
       	   <div class="form-group">
       	   	<h6 class="col-lg-3 col-md-4 col-sm-12 col-xs-12" style="font-size:12px;">勤務地 <span style="font-size:12px; background-color: #d9534f; border-color: #d43f3a; padding:3px; border-radius: 3px; color: #fff;">必須</span></h6>
       	   	<div class="col-lg-9 col-md-12 col-sm-12 col-xs-12">
       	   	 <label style="font-size: 10px;">店舗のエリア検索の際使用されます（店舗マスタ管理・採用ホームページの求職者検索用）。</label>
       	   	</div>
       	   </div>
       	   <div class="form-group">
       	   	<h6 class="col-lg-2 col-md-2 col-sm-4 col-xs-12" style="font-size:12px;">※ 都道府県</h6>
       	   	<div class="col-lg-5 col-md-10 col-sm-12 col-xs-12">
       	   	 <select id="cmb_work_loc_todoufuken" class="form-control" onChange="getSelecterJson('cmb_work_loc_todoufuken','cmb_work_loc_shikuchouson','/get_city?pref=')">
       	   	  <option value="">選択してください</option>
       	   	  <%for(int i=0;i < prefObjArray.length;i++){%>
       	   	  <option value="<%=prefObjArray[i].getId()%>"><%=prefObjArray[i].getName()%></option>
       	   	  <%}%>
       	   	 </select>
       	   	</div>
       	   </div>
       	   <div class="form-group">
       	    <h6 class="col-lg-offset-3 col-md-2 col-sm-4 col-xs-12" style="font-size:12px; margin-top:10px;">※ 市区町村</h6>
       	     <div class="col-lg-5 col-md-10 col-sm-12 col-xs-12" style="margin-top:10px;">
       	      <select id="cmb_work_loc_shikuchouson" class="form-control">
       	       <option value="-1">選択してください</option>
       	       <%for(int i=0;i < workCityObjArray.length;i++){%>
       	       <option value="<%=workCityObjArray[i].getId()%>"><%=workCityObjArray[i].getName()%></option>
       	       <%}%>
       	      </select>
			 </div>
       	   </div>
       	   <h6 id="div_work_loc_error" style="font-size:12px; color:red;"></h6>
       	  </div>
       	  
       	  
       	  
       	  
       	  
       	  <div class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
       	   <div class="form-group">
       	   	<h6 class="col-lg-3 col-md-4 col-sm-12 col-xs-12" style="font-size:12px;">アクセス</h6>
       	   	<div class="col-lg-9 col-md-12 col-sm-12 col-xs-12" style="border-bottom:1px dashed black;">
       	   	 <label style="font-size:10px;">こちらのアクセス情報が求職者に勤務地へのアクセスとして表示されます。</label><br>
       	   	 <a class="btn btn-rounded btn-kujira" style="margin-bottom: 10px;" onclick="display_detail('div_access_detail','hidden_access_detail')" class="a_nav_link">もっと詳しく</a>
       	   	</div>
       	   </div>
       	   
       	   
       	   <div id="div_access_all">
       	   	<div id="div_access_0" class="div_access_box_0">
       	   	 <div class="form-group">
       	   	  <div class="pull-right">
       	   	   <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
       	   	    <a class="btn btn-rounded btn-danger" style="margin-top:10px;" class="a_nav_link" onclick="delete_access(0)" id="btn_del_access_0">削除</a>
       	   	   </div>
       	   	  </div>
       	   	 </div>
       	     <div class="form-group">
       	   	  <h6 class="col-lg-offset-3 col-md-2 col-sm-4 col-xs-12" style="font-size:12px; margin-top:20px;">※ 都道府県</h6>
       	   	  <div class="col-lg-5 col-md-8 col-sm-12 col-xs-12" style="margin-top:10px;">
       	   	   <select name="cmb_access_todofuken" id="cmb_access_todofuken_0" class="form-control" onChange="getSelecterJson('cmb_access_todofuken_0','cmb_access_train_company_0','/get_rail_company?pref=')">
       	   	   	<option value="">選択してください</option>
       	   	   	<%for(int i=0;i < prefObjArray.length;i++){%>
       	   	   	<option value="<%=prefObjArray[i].getId()%>"><%=prefObjArray[i].getName()%></option>
       	   	   	<%}%>
       	   	   </select>
       	   	  </div>
       	     </div>
       	     <div class="form-group">
       	   	  <h6 class="col-lg-offset-3 col-md-2 col-sm-4 col-xs-12" style="font-size:12px; margin-top:20px;">※ 鉄道会社名</h6>
       	   	  <div class="col-lg-5 col-md-10 col-sm-12 col-xs-12" style="margin-top:10px;">
       	   	   <select name="cmb_access_train_company" id="cmb_access_train_company_0" class="form-control" onChange="getSelecterJson('cmb_access_train_company_0','cmb_access_train_line_0','/get_route?rail_company=')">
       	   	   </select>
       	   	  </div>
       	     </div>
       	     <div class="form-group">
       	   	  <h6 class="col-lg-offset-3 col-md-2 col-sm-4 col-xs-12" style="font-size:12px; margin-top:20px;">※ 線路名</h6>
       	   	  <div class="col-lg-5 col-md-10 col-sm-12 col-xs-12" style="margin-top:10px;">
       	   	   <select name="cmb_access_train_line" id="cmb_access_train_line_0" class="form-control" onChange="getSelecterJson('cmb_access_train_line_0','cmb_access_train_station_0','/get_station?route=')">
       	   	   </select>
       	   	  </div>
       	     </div>
       	     <div class="form-group">
       	   	  <h6 class="col-lg-offset-3 col-md-2 col-sm-4 col-xs-12" style="font-size:12px; margin-top:20px;">※ 駅名</h6>
       	   	  <div class="col-lg-3 col-md-10 col-sm-12 col-xs-12" style="margin-top:10px;">
       	   	   <select name="cmb_access_train_station" id="cmb_access_train_station_0" class="form-control"></select>
       	   	  </div>
       	   	  <div class="col-lg-2 col-md-12 col-sm-12 col-xs-12" style="margin-top:10px;">
       	   	   <input class="form-control" name="txt_access_from_station" id="txt_access_from_station_0" placeholder="より" type="text" />
       	   	  </div>
       	     </div>
       	     <div class="form-group">
       	   	  <h6 class="col-lg-offset-3 col-md-2 col-sm-2 col-xs-12" style="font-size:12px; margin-top:20px;"></h6>
       	   	  <div class="col-lg-3 col-md-12 col-sm-12 col-xs-12" style="margin-top:10px;">
       	   	   <select name="cmb_access_by" id="cmb_access_by_0" class="form-control">
       	   	   	<option value="">選択してください</option>
       	   	   	<option value="徒歩">徒歩</option>
       	   	   	<option value="バス">バス</option>
       	   	   	<option value="車">車</option>
       	   	   </select>
       	   	  </div>
       	   	  <div class="col-lg-2 col-md-12 col-sm-12 col-xs-12" style="margin-top:10px;">
       	   	   <input class="form-control" name="txt_access_by_time" id="txt_access_by_time_0" placeholder="分" type="text" />
       	   	  </div>
       	     </div> 
       	     <div class="col-lg-offset-3 col-lg-9 col-md-12 col-sm-12 col-xs-12" style="border-bottom: 1px dashed black; margin-top:10px;"></div>
       	     <input type="hidden" id="hidden_access_total_row" value="0" />
       	   	</div>
       	   </div>
       	   
       	   
       	   <div class="form-group">
       	    <div class="col-lg-offset-3 col-md-12 col-sm-12 col-xs-12">
       	     <a id="btn_add_access_row" style="margin-top: 10px; margin-bottom: 10px;" class="btn btn-rounded btn-kujira">追加</a>
       	    </div>
       	   </div>
       	   <input type="hidden" value="0" id="hidden_access" />
       	   <div class="form-group" id="div_access_detail" style="display:none;">
       	    <div class="col-lg-offset-3 col-lg-7 col-md-12 col-sm-12 col-xs-12">
       	     <textarea id="txt_access_comment" class="form-control" style="resize: none;"></textarea>
       	     (<span id="span_access_comment_total_char">0</span> / 200文字)
       	    </div>
       	    <input type="hidden" id="hidden_access_detail" value="0" />
       	   </div>
       	  </div>
       	  <div class="box-body">
       	   <div class="form-group">
       	   	<h6 class="col-lg-3 col-md-4 col-sm-12 col-xs-12" style="font-size:12px;">公開住所 <span style="font-size:12px; background-color: #d9534f; border-color: #d43f3a; padding:3px; border-radius: 3px; color: #fff;">必須</span></h6>
       	   	<div class="col-lg-9 col-md-12 col-sm-12 col-xs-12">
       	   	 <label style="font-size:10px;">公開する会社・店舗所在地を入力下さい。</label>
       	   	</div>
       	   </div>
       	   <div class="form-group">
       	    <h6 class="col-lg-2 col-md-2 col-sm-4 col-xs-12" style="font-size:12px; margin-top:20px;">※ 区分</h6>
       	    <div class="col-lg-5 col-md-10 col-sm-12 col-xs-12" style="margin-top:10px;">
       	     <select id="cmb_division" class="form-control">
       	   	  <option value="">選択してください</option>
       	   	  <%for(int i = 0; i < divisionArray.length; i++){%>
       	   	  <option value="<%=divisionArray[i].getId()%>"><%=divisionArray[i].getName()%></option>
       	   	  <%}%>
       	   	 </select>
       	   	</div>
       	   </div>
       	   <div class="form-group">
       	    <h6 class="col-lg-offset-3 col-md-2 col-sm-4 col-xs-12" style="font-size:12px; margin-top:20px;">※ 都道府県</h6>
       	    <div class="col-lg-5 col-md-10 col-sm-12 col-xs-12" style="margin-top:10px;">
       	     <select id="cmb_division_todofuken" class="form-control" onChange="getSelecterJson('cmb_division_todofuken','cmb_division_shikuchouson','/get_city?pref=')">
       	   	  <option value="">選択してください</option>
       	   	  <%for(int i=0;i < prefObjArray.length;i++){%>
       	   	  <option value="<%=prefObjArray[i].getId()%>"><%=prefObjArray[i].getName()%></option>
       	   	  <%}%>
       	   	 </select>
       	   	</div>
       	   </div>
       	   <div class="form-group">
       	    <h6 class="col-lg-offset-3 col-md-2 col-sm-4 col-xs-12" style="font-size:12px; margin-top:20px;">※ 市区町村</h6>
       	    <div class="col-lg-5 col-md-10 col-sm-12 col-xs-12" style="margin-top:10px;">
       	     <select id="cmb_division_shikuchouson" class="form-control" >
       	   	  <option value="-1">選択してください</option>
       	   	  <%for(int i=0;i < divCityObjArray.length;i++){%>
       	   	  <option value="<%=divCityObjArray[i].getId()%>"><%=divCityObjArray[i].getName()%></option>
       	   	  <%}%>
       	   	 </select>
       	   	</div>
       	   </div>
       	   <div class="form-group">
       	    <h6 class="col-lg-offset-3 col-md-2 col-sm-4 col-xs-12" style="font-size:12px; margin-top:20px;">※ 所在地（番地）</h6>
       	    <div class="col-lg-5 col-md-10 col-sm-12 col-xs-12" style="margin-top:10px;">
       	     <input type="text" id="txt_division_house_number" class="form-control" maxlength="75" />(75文字以内)
       	   	</div>
       	   </div>
       	   <div class="form-group">
       	    <h6 class="col-lg-offset-3 col-md-2 col-sm-4 col-xs-12" style="font-size:12px; margin-top:20px;">※ (建物名)</h6>
       	    <div class="col-lg-5 col-md-10 col-sm-12 col-xs-12" style="margin-top:10px;">
       	     <input type="text" id="txt_division_building_name" class="form-control" maxlength="75" />(75文字以内)
       	   	</div>
       	   </div>
       	   <div class="form-group">
       	    <h6 class="col-lg-offset-3 col-md-2 col-sm-4 col-xs-12" style="font-size:12px; margin-top:20px;">※ 備考・補足</h6>
       	    <div class="col-lg-5 col-md-10 col-sm-12 col-xs-12" style="margin-top:10px;">
       	     <textarea id="txt_division_comment" class="form-control" style="resize: none;"></textarea>
       	     (<span id="span_division_comment_total_char">0</span> / 200文字)
       	     <h6 id="div_division_error" style="font-size:12px; color:red;"></h6>
       	   	</div>
       	   </div>
       	  </div>
       	  <div class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
       	   <div class="form-group">
       	   	<h6 class="col-lg-3 col-md-4 col-sm-12 col-xs-12" style="font-size:12px;">店舗連絡先 <span style="font-size:12px; background-color: #d9534f; border-color: #d43f3a; padding:3px; border-radius: 3px; color: #fff;">必須</span></h6>
       	   	<div class="col-lg-9 col-md-12 col-sm-12 col-xs-12">
       	   	 <label style="font-size:10px;">こちらの電話番号と受付時間が求職者に公開されます。</label>
       	   	</div>
       	   </div>
       	   <div class="form-group">
       	    <div class="col-lg-2 col-md-12 col-sm-12 col-xs-12" style="margin-top:10px;">
       	     <input id="txt_telephone_0" class="form-control" type="text" />
       	   	</div>
       	    <div class="col-lg-2 col-md-12 col-sm-12 col-xs-12" style="margin-top:10px;">
       	     <input id="txt_telephone_1" class="form-control" type="text" />
       	   	</div>
       	    <div class="col-lg-2 col-md-12 col-sm-12 col-xs-12" style="margin-top:10px;">
       	     <input id="txt_telephone_2" class="form-control" type="text" />
       	   	</div>
       	   </div>
       	   <div class="form-group">
       	    <div class="col-lg-offset-3 col-lg-7 col-md-12 col-sm-12 col-xs-12" style="margin-top:10px;">
       	     <label style="font-size: 12px;">ＴＥＬ受付時間</label>
       	     <textarea id="txt_telephone_comment" class="form-control" style="resize: none;"></textarea>
       	     (<span id="span_telephone_comment_total_char">0</span> / 200文字)
       	   	</div>
       	   </div>
       	   <div class="form-group">
       	    <div class="col-lg-offset-3 col-md-12 col-sm-12 col-xs-12">
       	     <a class="btn btn-rounded btn-kujira" style="margin-top: 10px; margin-bottom: 10px;" onclick="display_detail('div_store_address_detail','hidden_store_address_detail')">もっと詳しく</a>
       	    </div>
       	   </div>
       	   <div class="form-group" id="div_store_address_detail" style="display:none">
       	    <div class="col-lg-offset-3 col-lg-7 col-md-12 col-sm-12 col-xs-12" style="margin-top:10px;">
       	     <textarea id="txt_telephone_more_comment" class="form-control" style="resize: none;"></textarea>
       	     <span id="span_telephone_more_comment_total_char">0</span> / 200文字)
       	     <input type="hidden" id="hidden_store_address_detail" value="0">
       	   	</div>
       	   </div>
       	   <h6 id="div_telephone_error" style="font-size:12px; color:red;"></h6>
       	  </div>
       	  <div class="box-body">
       	   <div class="form-group">
       	   	<h6 class="col-lg-3 col-md-4 col-sm-12 col-xs-12" style="font-size:12px;">管理者コメント(求職者に非公開の項目です)</h6>
       	   	<div class="col-lg-7 col-md-12 col-sm-12 col-xs-12">
       	   	 <textarea id="txt_admin_comment" class="form-control" style="resize: none;"></textarea>
       	   	 (<span id="span_admin_comment_total_char">0</span> / 1000文字)
       	   	</div>
       	   </div>
       	  </div>

       	  <div class="box-body">
       	   <div class="form-group">
       	   	<h6 class="col-lg-3 col-md-4 col-sm-12 col-xs-12" style="font-size:12px;">店舗マッチング条件</h6>
       	   	<div class="col-lg-9 col-md-12 col-sm-12 col-xs-12">
       	   	 <label style="font-size:10px;">設定したキーワードが各媒体の求人原稿の店舗名と一致した場合、こちらの店舗への応募として応募者が振り分けされます。</label>
       	   	</div>
       	   	<div class="col-lg-7 col-md-12 col-sm-12 col-xs-12" id="div_store_term_0">
       	   	 <input name="txt_store_term" id="txt_store_term_0" class="form-control" type="text" maxlength="100" />
       	   	 (１００文字以内)
       	   	 <div class="pull-right">
       	   	  <a class='btn btn-rounded btn-danger' style='margin-top:5px; margin-right: 5px; margin-bottom: 5px;' id="btn_delete_store_term_0" onclick="delete_store_term(0)">削除</a>
       	   	 </div>
       	   	</div>
       	   	<div id="div_store_term_all"></div>
       	   	<input type="hidden" value="0" id="hidden_store_term" value="0"/>
       	   </div>
       	   <div class="form-group">
       	    <div class="col-lg-offset-3 col-md-12 col-sm-12 col-xs-12">
       	   	 <a class='btn btn-rounded btn-kujira' style='margin-top:5px;' id="btn_add_store_term">追加</a>
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
         	<a class="btn btn-warning btn-rounded" href="/setting_store">< 戻る</a>
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
   function clear_all_input_field() {
    //document.getElementById("").value = "";
   }
  </script>
  <script>
$(document).ready(function() {
    // get current URL path and assign 'active' class
    var pathname = window.location.pathname;
    $('.setting').parent().addClass('active') && $('.setting > li > a[href="/setting_store"]').parent().addClass('active');
})
  </script>
 </body>
</html>
