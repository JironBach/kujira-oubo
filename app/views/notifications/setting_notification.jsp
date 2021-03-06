<!-- Final -->

<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="es.hyrax.object.NotificationObject"%>
<%@ page import="es.hyrax.util.Integer107" %>
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
	String message = (String)request.getAttribute("message");
	NotificationObject[] notificationArray = (NotificationObject[])request.getAttribute("notificationArray");       
	
	int maxNum = 0;
	if(null != notificationArray && notificationArray.length > 0){
	    maxNum = notificationArray[0].getMaxNum();
    }
	 
	String onePageLimit = (String)session.getAttribute("one_page_limit");
	if((null == onePageLimit) || (onePageLimit.equals(""))){
		onePageLimit = "1";
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
	int endNum   =  startNum - 1  + notificationArray.length;
	
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
	
	/*
	if (Integer.parseInt(pageNumStr) < 3) {
		startPageNum = 1;
		endPageNum = 5;
	} else {
		startPageNum = pageNum - 2;
		endPageNum = pageNum + 2;
		
	}
	Boolean prefEnableFlg = (pageNum < 2) ? false : true; 
	Boolean highPrefEnableFlg = (pageNum < 6) ? false : true;
	int highPreNum = pageNum - 5;
	int preNum = pageNum - 1;
	int highNextNum = pageNum + 5;
	int nextNum = pageNum + 1;
	
	
	int onePageLimitNum = Integer107.parseInt(onePageLimit);
	int startNum = 1;
	int endNum = 20;
	int maxNum = 0;

	if(null != notificationArray && notificationArray.length > 0){
		maxNum = notificationArray[0].getMaxNum();

		startNum = (pageNum-1)*onePageLimitNum + 1;
		endNum = onePageLimitNum;
		if((startNum + onePageLimitNum) > maxNum){
			endNum = maxNum - ((pageNum-1)*onePageLimitNum);
		}
		
	}else{
		startNum = 0;
		endNum = 0;
	}
	*/
	
	
 String ss = (String)loginAccountObj.getFullname();
 String pict = ss.substring(0, 1);
%>
<!DOCTYPE html>
<html>
 <head>
  <jsp:include page="/WEB-INF/views/common/index_header.jsp" flush="false" />
  <title>くじら応募</title>
  <script>
			
			$(function() {
    			//clear_screen();
    			selectedOnePageLimit();
    			take_get_parameter();
    			clear_check_all();

    			//final action button
   			});
			function selectedOnePageLimit(){
                document.getElementById('txt_one_page_limit').value = "<%=onePageLimit%>";
                document.getElementById('txt_one_page_limit2').value = "<%=onePageLimit%>";
                //alert("pagenum"+'<%=pageNum%>'+"maxNum"+'<%=maxNum%>'+"startNum"+'<%=startNum%>'+"endNum"+'<%=endNum%>');
			}
			function take_get_parameter(){
				var del_row_no = S_GET("del_row_no");

				$("#row_" + del_row_no).remove();
				var pageNum = '<%= pageNum%>';

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

				if (del_conf == true){
					toDeleteServlet(index);
					//$("#row_"+index).remove();
				}
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
			
			function setParam(name,value){
				var input = document.createElement('input');
                input.setAttribute('type', 'hidden');
                input.setAttribute('name', name);
                input.setAttribute('value', value);
                return input;
			}

			/*function update_selected_row(start_date, end_date, title, purpose, del_row_no) {
				var link = "setting_notification_upd.html?";

				link += "app_start_date=" + start_date + "&app_end_date=" + end_date + "&app_title=" + title + 
						"&app_purpose=" + purpose + "&del_row_no=" + del_row_no;

				window.location.href = link;
				
								var app_start_date 	= S_GET("app_start_date"),
					app_end_date	= S_GET("app_end_date"),
					app_title		= S_GET("app_title"),
					app_purpose		= S_GET("app_purpose");*/
				
				
			function toDeleteServlet(deleteArr){
				var inputDeleteArr = setParam('delete_id_arr',deleteArr);
				var inputPageNumStr = setParam('page_num','<%=pageNumStr%>');
				var f = document.createElement("form");
                f.setAttribute('method',"post");
                f.setAttribute('action',"/setting_notification_delete");
				f.appendChild(inputDeleteArr);
                f.appendChild(inputPageNumStr);
				var bodyElement = document.body ;
                bodyElement.append(f);
                f.submit();
			}			
			function update_selected_row(id,startDate,endDate,title,purpose,situation,createTime) {

				var onePageLimit = document.getElementById("txt_one_page_limit").value;
				var pageNumStr = <%=pageNumStr%>;
				var inputOnePageLimit = setParam("one_page_limit",onePageLimit);
				var inputPageNum      = setParam("page_num",pageNumStr);
				var f = document.createElement("form");
                f.setAttribute('method',"post");
                f.setAttribute('action',"/setting_notification_upd");
				var inputId = setParam("app_id",id);
				var inputStartDate = setParam("app_start_date",startDate);
				var inputEndDate = setParam("app_end_date",endDate);
				var inputTitle = setParam("app_title",title);
				var inputPurpose = setParam("app_purpose",purpose);
				var inputCreateTime = setParam("created_at",createTime);

                f.appendChild(inputOnePageLimit);				
				f.appendChild(inputPageNum);
				f.appendChild(inputId);
				f.appendChild(inputStartDate);
				f.appendChild(inputEndDate);
				f.appendChild(inputTitle);
				f.appendChild(inputPurpose);
				f.appendChild(inputCreateTime);

				var bodyElement = document.body ;
                bodyElement.append(f);

				f.submit();
			}
			function toServlet(num, onePageLimit){		
				var inputOnePageLimit = setParam("one_page_limit",onePageLimit);
				var f = document.createElement("form");
				f.setAttribute('method',"post");
				f.setAttribute('action',"/setting_notification/"+num);
				f.appendChild(inputOnePageLimit);
				var bodyElement = document.body;
				bodyElement.append(f);
				f.submit();
			}
			function onePageLimit(){
				//toServlet(getPageNumber(), document.activeElement.value);
				toServlet("1", document.activeElement.value);
			}
			function moveList(num) {
				toServlet(num, document.getElementById("txt_one_page_limit").value);
			}
			function getPageNumber(){
				return <%=pageNumStr%>;
		    }
			
  </script>
 </head>
 <body class="hold-transition skin-kujira sidebar-mini <%=sidebar_collapse%>">
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
        <h4 style="font-size:16px;">採用責任者からのお知らせ一覧</h4>
       </div>
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
          <a style="color:#000;" id="btn_create_new" href="/setting_notification_create" class="btn btn-kujira">新規登録</a>
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
             <th style="font-size:12px;" scope="col"><b>掲載期間</b></th>
             <th style="font-size:12px;" scope="col"><b>タイトル</b></th>
             <th style="font-size:12px;" scope="col"><b>内容</b></th>
             <!--<th style="width:100px;">掲載状況</th>   あとで復元-->
             <th style="font-size:12px;" scope="col"><b>作成日</b></th>
             <th style="font-size:12px;" scope="col"><b>操作</b></th>
       	    </tr>
       	   </thead>
       	   <tbody>
       	    <% for(int i = 0; i < notificationArray.length;i++){%>
       	     <tr id="row_0">
       	      <th style="font-size:12px;" scope="row">
       	       <center>
       	       	<label class="switch">
       	       	 <input class="input_form_field_radio" name="cb_data" id="cb_data_2" value='<%=notificationArray[i].getId()%>' type="checkbox"/><
       	       	 <span class="slider round"></span>
       	       	</label>
       	       </center>
       	      </th>

       	      <%
       	       String startDate = (String)notificationArray[i].getStartDate();
       	       String finalStartDate = startDate.substring(0, 16);

       	       String endDate = (String)notificationArray[i].getEndDate();
       	       String finalEndDate = endDate.substring(0, 16);
       	      %>

       	      <td style="font-size:12px;" data-title="掲載期間"><%=finalStartDate%> <%=finalEndDate%></td>
       	      <td style="font-size:12px;" data-title="タイトル">
       	       <a onclick="update_selected_row(<%=notificationArray[i].getId()%>,<%=notificationArray[i].getStartDate()%>,<%=notificationArray[i].getEndDate()%>,<%=notificationArray[i].getTitle()%>,<%=notificationArray[i].getPurpose()%>,<%=notificationArray[i].getSituation()%>,<%=notificationArray[i].getCreateTime()%>)"><%=notificationArray[i].getTitle()%>
       	       </a>
       	      </td>
       	      <td style="font-size:12px;" data-title="内容"><%=notificationArray[i].getPurpose()%></td>
       	      <!--<td style="font-size:12px;" data-title="掲載状況"><%=notificationArray[i].getSituation()%></td>  あとで復元-->

       	      <%
       	       String createTime = (String)notificationArray[i].getCreateTime();
       	       String finalCreateTime = createTime.substring(0, 16);
       	      %>

       	      <td style="font-size:12px; width:120px;" data-title="作成日"><%=finalCreateTime%></td>
       	      <td style="font-size:12px;" data-title="操作">
       	       <div class="text-center">
       	       	<a id="edit_row_2" href="javascript:void(0)" onclick="update_selected_row('<%=notificationArray[i].getId()%>','<%=notificationArray[i].getStartDate()%>','<%=notificationArray[i].getEndDate()%>','<%=notificationArray[i].getTitle()%>','<%=notificationArray[i].getPurpose()%>','<%=notificationArray[i].getSituation()%>','<%=notificationArray[i].getCreateTime()%>')">編集</a> | 
       	       	<a id="delete_row_2" href="javascript:void(0)" onclick="delete_per_line('<%=notificationArray[i].getId()%>')" >削除</a>
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
          <a style="color:#000;" id="btn_create_new" href="/setting_account_create" class="btn btn-kujira">新規登録</a>
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
