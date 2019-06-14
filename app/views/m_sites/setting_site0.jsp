<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="es.hyrax.object.SiteObject" %>
<%@ page import="es.hyrax.object.RecruitmentSiteObject" %>
<%@ page import="es.hyrax.util.Integer107" %>
<%@ page import="es.hyrax.object.singleton.GroupStrGetter" %>
<%@ page import="es.hyrax.object.singleton.StoreStrGetter" %>
<%@ page import="es.hyrax.object.singleton.StatusStrGetter" %>
<%@ page import="es.hyrax.object.singleton.AuthStrGetter" %>
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
	
	SiteObject[] siteArray = (SiteObject[])request.getAttribute("siteArray");
	RecruitmentSiteObject[] recruitmentSiteArray = (RecruitmentSiteObject[])request.getAttribute("recruitmentSiteArray");
	
	String onePageLimit = (String)session.getAttribute("one_page_limit");
	String mode = (String)request.getAttribute("mode");
	
	String searchTitle = (String)request.getAttribute("searchTitle");
	String searchSiteStr = (String)request.getAttribute("searchSite");
	int searchSite = Integer107.parseIfNoDigit(searchSiteStr,0);
	
	int maxNum = 0;
    if(siteArray.length > 0){
	    maxNum = siteArray[0].getMaxNum();
    }
	
	if((null == onePageLimit) || (onePageLimit.equals(""))){
		onePageLimit = "20";
	}
	int oneLimit = Integer107.parseIfNoDigit(onePageLimit,0);
	
	String pageNumStr = (String)request.getAttribute("page_num");
	if((null== pageNumStr) || pageNumStr.equals("")){
		pageNumStr = "1";
	}
	int pageNum = Integer.parseInt(pageNumStr);
	int maxPageCnt = ((maxNum + (oneLimit - 1)) / oneLimit);
	
	int startPageNum = 1;
	int endPageNum = 5;
	
	if (pageNum < 6) {
		startPageNum = 1;
		if (maxPageCnt < 6) {
			endPageNum = maxPageCnt;
		} else {
			endPageNum = 5;
		}
	} else {
		if((pageNum + 2) < maxPageCnt){
			startPageNum = pageNum - 2;
			endPageNum = pageNum + 2;
		} else {
			startPageNum = maxPageCnt - 4;
			endPageNum = maxPageCnt;
		}
	}
	
	int startNum = ((pageNum -1 ) * Integer.parseInt(onePageLimit)) + 1; //０件でも１件〜となってしまうため修正要
	int endNum   =  startNum - 1  + siteArray.length;
	
	Boolean prefEnableFlg = (pageNum < 2) ? false : true; 
	Boolean highPrefEnableFlg = (pageNum < 6) ? false : true;
						 
	Boolean nextEnableFlg = (pageNum < maxPageCnt) ? true : false; 
	Boolean highNextEnableFlg = (pageNum < (maxPageCnt - 4)) ? true : false;	
						 
	int highPreNum = pageNum - 5;
	if (highPreNum < 1){
		highPreNum = 1;
	}
	int preNum = pageNum - 1;
	if (preNum < 1){
		preNum = 1;
	}
	int highNextNum = pageNum + 5;
	if (highNextNum > maxPageCnt){
		highNextNum = maxPageCnt;
	}
	int nextNum = pageNum + 1;
	if (nextNum > maxPageCnt){
		nextNum = maxPageCnt;
	}

%>
<!DOCTYPE html>
<html>
 <head>
  <jsp:include page="/WEB-INF/views/common/index_header.jsp" flush="false" />
  <title>くじら応募</title>
  <script>
			document.addEventListener('DOMContentLoaded',
				function(){
					selectedOnePageLimit();
					take_get_parameter();
				}
			);
			
			function take_get_parameter(){
                document.getElementById("cmbSearchSite").value = '<%=searchSite%>';
			}
			function selectedOnePageLimit(){
                document.getElementById('txt_one_page_limit').value = "<%=onePageLimit%>";
                document.getElementById('txt_one_page_limit2').value = "<%=onePageLimit%>";
                //alert("pagenum"+'<%=pageNum%>'+"maxNum"+'<%=maxNum%>'+"startNum"+'<%=startNum%>'+"endNum"+'<%=endNum%>');
			}
			function setParam(name,value){
				var input = document.createElement('input');
                input.setAttribute('type', 'hidden');
                input.setAttribute('name', name);
                input.setAttribute('value', value);
                return input;
			}
			

			function toServlet(mode, num, onePageLimit){
				var inputOnePageLimit = setParam("one_page_limit",onePageLimit);
				var inputMode = setParam("mode",mode);
				var f = document.createElement("form");
				f.setAttribute('method',"post");
				f.setAttribute('action',"/setting_site/"+num);
				f.appendChild(inputOnePageLimit);
				f.appendChild(inputMode);
				if(mode == "search"){
					var searchSite = document.getElementById("cmbSearchSite").value;
					var searchTitle = document.getElementById("txtSearchTitle").value;

					var inputSearchSite = setParam('searchSite',searchSite);
					var inputSearchTitle = setParam('searchTitle',searchTitle);
					
					f.appendChild(inputSearchSite);
					f.appendChild(inputSearchTitle);
			   }
				var bodyElement = document.body ;
                bodyElement.append(f);
				f.submit();
			}
			
			function toUpdServlet(id){
				var onePageLimit = document.getElementById("txt_one_page_limit").value;
				var pageNum = getPageNumber();
				var inputOnePageLimit = setParam("one_page_limit",onePageLimit);
				var inputId           = setParam("app_id",id);
				var inputPageNum      = setParam("page_num",pageNum);
				
				var f = document.createElement("form");
				
				f.setAttribute('method',"post");
				f.setAttribute('action',"/setting_site_upd");
				f.appendChild(inputOnePageLimit);
				f.appendChild(inputId);
				f.appendChild(inputPageNum);
				var bodyElement = document.body ;
                bodyElement.append(f);
				f.submit();
			}
			function toDeleteServlet(deleteArr){
				var inputDeleteArr = setParam('delete_id_arr',deleteArr);
				var inputPageNumStr = setParam('pageNumStr','<%=pageNumStr%>');
				var f = document.createElement("form");
                f.setAttribute('method',"post");
                f.setAttribute('action',"/setting_site_delete");
				f.appendChild(inputDeleteArr);
                f.appendChild(inputPageNumStr);
				var bodyElement = document.body ;
                bodyElement.append(f);
                f.submit();
			}
			function onePageLimit(){
				//toServlet('<%=mode%>',getPageNumber(), document.activeElement.value);
				toServlet('<%=mode%>',"1", document.activeElement.value);
			}
			function moveList(num) {
				toServlet('<%=mode%>',num, document.getElementById("txt_one_page_limit").value);
			}
			function nowList(){
				//alert("!!!!!!!!! nowList()!!!!");
			}
			function searchSiteList(){
				toServlet("search",1, document.getElementById("txt_one_page_limit").value);
			}
			function resetSearchInfo(){
				toServlet("no_search",1,document.getElementById("txt_one_page_limit").value);
			}

			//以下はデータ取得メソッド
			function getPageNumber(){
				return <%=pageNumStr%>;
		    }

			function redirect_page(){
				
			}

			//reissue single & mass
			function reissue_single(index){
				var del_conf = confirm("再発行します。よろしいですか？");
    			
    			if (del_conf == true) {
					document.getElementById("span_reissue_"+ index ).innerHTML = get_today_date() + " " + get_current_full_time();
					document.getElementById("btn_reissue_" + index).style.display = "none";
				}
			}

			function reissue_mass(){

				if (get_total_selected_rad() > 0) {

					var del_conf = confirm("再発行します。よろしいですか？");
					if (del_conf == true) {
						var rad = document.getElementsByName("cb_data");
						for (var i = 0; i < rad.length; i++) {

							if(rad[i].checked == true){
								$("#span_reissue_" + rad[i].value).html(get_today_date() + " " + get_current_full_time());
								$("#span_id_status_" + rad[i].value).html("有効");

								if ( document.getElementById("btn_reissue_" + rad[i].value) != null )
									document.getElementById("btn_reissue_" + rad[i].value).style.display = "none";							
							}
						}

						clear_check_all();
					}

				}
				else
					alert("一括再発行処理対象を選択してください。");		
			}

			function get_total_selected_rad(){
				var rad = document.getElementsByName("cb_data");
				var counter = 0;

				for (var i = 0; i < rad.length; i++) {
					if(rad[i].checked == true)
						counter ++;
				}

				return counter;
			}

			//delete single & mass
			function delete_per_line(index){
				var del_conf = confirm("削除します。よろしいですか？");

				if (del_conf == true) 
					//$("#row_"+index).remove();
					toDeleteServlet(index);
					
			}
			function delete_all_line(){
				if (get_total_selected_rad() > 0) {
					var del_conf = confirm("削除します。よろしいですか？");
					var index = new Array();
					var counter = 0;

					if (del_conf == true) {
						var deleteArr = '';
						var rad = document.getElementsByName("cb_data");
						for (var i = 0; i < rad.length; i++) {
							if(rad[i].checked == true){
								index[counter] = rad[i].value;
								deleteArr = deleteArr + ','+rad[i].value;
								counter ++;			
							}
						}

						/*for (var i = 0; i < counter; i++) {
							$("#row_" + index[i]).remove();
						};*/
						

						if(counter > 0){
						    toDeleteServlet(deleteArr);
						}

						document.getElementById("cb_data_x").checked = false;
					}
				}
				else
					alert("削除処理対象を選択してください。");		
			}
			/* end delete single & mass */

			function check_all(){
				var rad = document.getElementsByName("cb_data");
				var rad_all = document.getElementById("cb_data_x");

				for (var i = 0; i < rad.length; i++) {
					if (rad_all.checked == true)
						rad[i].checked = true;
					else
						rad[i].checked = false;					
				}
			}
			
  </script>
 </head>
 <body class="hold-transition skin-kujira sidebar-mini <%=sidebar_collapse%>">
  <div class="wrapper">
   <jsp:include page="/WEB-INF/views/common/top_bar.jsp" flush="false" />
   <jsp:include page="/WEB-INF/views/common/side_bar.jsp" flush="false" />
   <div class="content-wrapper">
    <section class="content-header">
     <h1>求人掲載サイト管理</h1>
     <ol class="breadcrumb">
      <li><a href="/"><i class="fa fa-home"></i> ホーム</a></li>
      <li><a href="/setting_site"><i class="fa fa-cogs"></i> 設定</a></li>
      <li class="active">求人掲載サイト管理</li>
     </ol>
    </section>
    <section class="content">
     <div class="row">
      <section class="col-md-12 col-xs-12">
       <div class="callout callout-warning">
        <h4 style="font-size:16px;">求人掲載サイト一覧</h4><br>
        <h4 style="font-size:12px;">現在データ収集先として登録されているサイトの一覧になります。応募掲載サイトの新規登録は、サポートデスクまでご連絡ください。</h4>
       </div>
       <div class="row">
        <div class="col-md-12 col-xs-12">
         <div class="box box-kujira box-solid">
          <div class="box-header with-border">
           検索メニュー
          </div>
          <div class="box-body">
           <div class="col-md-12 col-xs-12">
            <div class="form-group">
             <div class="pull-right">
              <a style="color:#000;" class="btn btn-rounded btn-kujira" href="" onClick="resetSearchInfo(); return false;">検索項目をリセット</a>
             </div>
            </div>
           </div>
           <div class="form-group">
            <div class="col-md-3 col-xs-12">
           	 <label style="font-size: 12px;">掲載サイト</label>
           	 <select class="form-control" id="cmbSearchSite" >
           	  <option value="-1"></option>
           	  <%for(int i =0 ; i < recruitmentSiteArray.length;i++){%>
           	  <option value="<%=recruitmentSiteArray[i].getId()%>"><%=recruitmentSiteArray[i].getSiteName()%></option>
           	  <%}%>
           	 </select>
           	</div>
           	<div class="col-md-6 col-xs-12">
           	 <label style="font-size: 12px;">求人案件名</label>
           	 <input class="form-control" id="txtSearchTitle" type="text" value="<%=searchTitle %>" placeholder="求人案件名" />
           	</div>
           </div>
          </div>
          <div class="box-body">
           <div class="col-md-12 col-xs-12">
           	<div class="text-center">
           	 <button class="btn btn-rounded btn-kujira" id="search_button" onClick="searchSiteList()">検索</button>
           	</div>
           </div>
          </div>
         </div>
        </div>
       </div>
       <br>
       <div class="row">
        <div class="col-md-12 col-xs-12">
         <div class="pull-left">
          <%=maxNum%> 件中 <%=startNum%> ~ <%=endNum%> 件表示
         </div>
         <div class="pull-right">
          <select class="form-control" id="txt_one_page_limit" onchange="onePageLimit()">
           <option value="20">20件</option>
           <option value="50">50件</option>
           <option value="100">100件</option>
          </select>
         </div>
        </div>
       </div>
       <div class="row">
        <div class="col-md-12 col-xs-12 text-center">
         <ul class="pagination">
          <% if (highPrefEnableFlg) { %>  <li id ="non_selected_list"><a href="#" onClick="moveList(<%=highPreNum%>); return false;"><<</a></li>  <% }%>
          <% if (prefEnableFlg) { %>      <li id ="non_selected_list"><a href="#" onClick="moveList(<%=preNum%>); return false;"><</a></li>   <% }%>
          <% if (pageNum >= 10) { %>
          <li id ="non_selected_list"><a href="#" onClick="moveList(1); return false;">1</a></li>
          <li id ="omission_list"><a href="javascript:void(0)" >...</a></li>
          <% } 
          for (int i = startPageNum; i <= endPageNum; i++) {
          if (i == pageNum) { %>
          <li class="active" id ="selected_list"><a href="javascript:void(0)" ><%=i%></a></li>
          <% } else {%>
          <li id ="non_selected_list"><a href="#" onClick="moveList(<%=i%>); return false;"><%=i%></a></li>
          <%}
          } %>
          <% if (nextEnableFlg) { %>  <li id ="non_selected_list"><a href="#" onClick="moveList(<%=nextNum%>); return false;">></a></li>  <% }%>
          <% if (highNextEnableFlg) { %><li id ="non_selected_list"><a href="#" onClick="moveList(<%=highNextNum%>); return false;">>></a></li>  <% }%>
         </ul>
        </div>
       </div>
       <div class="row">
        <div class="col-md-12 col-xs-12">
         <div class="pull-left">
          <a style="color:#000;" id="btn_create_new" href="/setting_site_create" class="btn btn-kujira">新規登録</a>
         </div>
         <div class="pull-right">
          <a class="btn btn-rounded btn-danger" onclick="delete_all_line()" id="btn_delete_all_0">一括削除</a>
         </div>
        </div>
       </div>
       <br>
       <div class="row">
       	<div class="col-md-12">
       	 <div class="responsive-table">
       	  <table class="table table-striped table-bordered">
       	   <thead>
       	    <tr>
             <th scope="col"><center>
              <label class="switch">
               <input onclick="check_all()" id="cb_data_x" class="input_form_field_radio" type="checkbox" value="">
               <span class="slider round"></span>
              </label>
              </center>
             </th>
             <th style="font-size:12px;" scope="col"><b>掲載サイト</b></th>
             <th style="font-size:12px;" scope="col"><b>求人案件名</b></th>
             <th style="font-size:12px;" scope="col"><b>ID</b></th>
             <th style="font-size:12px;" scope="col"><b>自動取込</b></th>
             <th style="font-size:12px;" scope="col"><b>操作</b></th>
       	    </tr>
       	   </thead>
       	   <tbody>
       	    <% for(int i = 0 ; i < siteArray.length;i++){ %>
       	     <tr id="row_0">
       	      <th style="font-size:12px;" scope="row">
       	       <center>
       	       	<label class="switch">
       	       	 <input class="input_form_field_radio" name="cb_data" id="cb_data_2" value='<%=siteArray[i].getId()%>' type="checkbox"/>
       	       	 <span class="slider round"></span>
       	       	</label>
       	       </center>
       	      </th>
       	      <td style="font-size:12px;" data-title="掲載サイト"><%=siteArray[i].getName()%></td>
       	      <td style="font-size:12px;" data-title="求人案件名"><%=siteArray[i].getSubName()%></td>
       	      <td style="font-size:12px;" data-title="ID"><%=siteArray[i].getUserId()%></td>
       	      <td style="font-size:16px;" data-title="状態">
              <%
              if (siteArray[i].getNoScrapingFlg() == 0){
              %>
               <center><span class="label label-success">利用中</span></center>
              <%
              } else if(siteArray[i].getNoScrapingFlg() == 1){
              %>
               <center><span class="label label-warning">不利用</span></center>
              <%
              } else if(siteArray[i].getNoScrapingFlg() == 5){
              %>
               <center><span class="label label-danger">応募者入力</span></center>
              <%
              } else if(siteArray[i].getNoScrapingFlg() == 9){
              %>
               <center><span class="label label-danger">利用不可</span></center>
              <%
              }
              %>
              </td>
       	      <td style="font-size:12px;" data-title="操作">
       	       <div class="text-center">
       	       	<a id="edit_row_2" href="javascript:void(0)" onClick="toUpdServlet('<%=siteArray[i].getId()%>','<%=siteArray[i].getPassword()%>')">編集</a> | 
       	       	<a id="delete_row_2" href="javascript:void(0)" onclick="delete_per_line('<%=siteArray[i].getId()%>')">削除</a>
       	       </div>
       	      </td>
       	     </tr>
       	    <%}%>
       	   </tbody>
       	  </table>
       	 </div>
       	</div>
       </div>
       <div class="row">
        <div class="col-md-12 col-xs-12">
         <div class="pull-left">
          <a style="color:#000;" id="btn_create_new" href="/setting_site_create" class="btn btn-kujira">新規登録</a>
         </div>
         <div class="pull-right">
          <a class="btn btn-rounded btn-danger" id="btn_delete_all_1" onclick="delete_all_line()">一括削除</a>
         </div>
        </div>
       </div>
       <br>
       <div class="row">
        <div class="col-md-12 col-xs-12">
         <div class="pull-left">
          <%=maxNum%> 件中 <%=startNum%> ~ <%=endNum%> 件表示
         </div>
         <div class="pull-right">
          <select class="form-control" id="txt_one_page_limit2" onchange="onePageLimit()">
           <option value="20">20件</option>
           <option value="50">50件</option>
           <option value="100">100件</option>
          </select>
         </div>
        </div>
       </div>
       <div class="row">
        <div class="col-md-12 col-xs-12 text-center">
         <ul class="pagination">
          <% if (highPrefEnableFlg) { %>  <li id ="non_selected_list"><a href="#" onClick="moveList(<%=highPreNum%>); return false;"><<</a></li>  <% }%>
          <% if (prefEnableFlg) { %>      <li id ="non_selected_list"><a href="#" onClick="moveList(<%=preNum%>); return false;"><</a></li>   <% }%>
          <% if (pageNum >= 10) { %>
          <li id ="non_selected_list"><a href="#" onClick="moveList(1); return false;">1</a></li>
          <li id ="omission_list"><a href="javascript:void(0)" >...</a></li>
          <% } 
          for (int i = startPageNum; i <= endPageNum; i++) {
          if (i == pageNum) { %>
          <li class="active" id ="selected_list"><a href="javascript:void(0)" ><%=i%></a></li>
          <% } else {%>
          <li id ="non_selected_list"><a href="#" onClick="moveList(<%=i%>); return false;"><%=i%></a></li>
          <%}
          } %>
          <% if (nextEnableFlg) { %>  <li id ="non_selected_list"><a href="#" onClick="moveList(<%=nextNum%>); return false;">></a></li>  <% }%>
          <% if (highNextEnableFlg) { %><li id ="non_selected_list"><a href="#" onClick="moveList(<%=highNextNum%>); return false;">>></a></li>  <% }%>
         </ul>
        </div>
       </div>
      </section>
     </div>
    </section>
   </div>
   <jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false" />
  </div>
  <script>
   function clear_check_all() {
	var rad = document.getElementsByName("cb_data");
	document.getElementById("cb_data_x").checked = false;
    for (var i = 0; i < rad.length; i++)
     rad[i].checked = false;
   }
   function clear_screen() {
   }
  </script>
  <script src="/dist/js/jquery.js"></script>
  <script src="/dist/js/bootstrap.js"></script>
  <script src="/dist/js/adminlte.js?v=1"></script>
  <script>
$(document).ready(function() {
    // get current URL path and assign 'active' class
    var pathname = window.location.pathname;
    $('.setting').parent().addClass('active') && $('.setting > li > a[href="'+pathname+'"]').parent().addClass('active');
})
  </script>
 </body>
</html>
