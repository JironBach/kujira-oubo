<!-- Final -->

<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="es.hyrax.util.Integer107" %>
<%@ page import="es.hyrax.object.BlacklistObject" %>
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
 BlacklistObject[] blacklistArray = (BlacklistObject[])request.getAttribute("blacklistParameterArray");
 String input_name = (String)request.getAttribute("bl_name");
 String input_mail = (String)request.getAttribute("bl_mail");
 int countDeleteArray = 0;
 String onePageLimit = (String)session.getAttribute("one_page_limit");
 int maxNum = 0;
 if(null != blacklistArray && blacklistArray.length > 0) {
 	maxNum = blacklistArray[0].getMax_count();
 }
 if(null == onePageLimit) {
 	onePageLimit = "20";
 }
 int oneLimit = Integer107.parseIfNoDigit(onePageLimit,0);
 String pageNumStr = (String)request.getAttribute("page_num");
 if(null== pageNumStr) {
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
 	if((pageNum + 2) < maxPageCnt) {
 		startPageNum = pageNum - 2;
 		endPageNum = pageNum + 2;
    } else {
    	startPageNum = maxPageCnt - 4;
    	endPageNum = maxPageCnt;
    }
 }
 int startNum = ((pageNum -1 ) * Integer.parseInt(onePageLimit)) + 1;
 int endNum   =  startNum - 1  + blacklistArray.length;
 Boolean prefEnableFlg = (pageNum < 2) ? false : true;
 Boolean highPrefEnableFlg = (pageNum < 6) ? false : true;
 Boolean nextEnableFlg = (pageNum < maxPageCnt) ? true : false;
 Boolean highNextEnableFlg = (pageNum < (maxPageCnt - 4)) ? true : false;
 int highPreNum = pageNum - 5;
 if (highPreNum < 1) {
 	highPreNum = 1;
 }
 int preNum = pageNum - 1;
 if (preNum < 1) {
 	preNum = 1;
 }
 int highNextNum = pageNum + 5;
 if (highNextNum > maxPageCnt) {
 	highNextNum = maxPageCnt;
 }
 int nextNum = pageNum + 1;
 if (nextNum > maxPageCnt) {
 	nextNum = maxPageCnt;
 }
%>
<!DOCTYPE html>
<html>
 <head>
  <jsp:include page="/WEB-INF/views/common/index_header.jsp" flush="false" />
  <title>くじら応募</title>
  <script>
   document.addEventListener('DOMContentLoaded', function() {
   	selectedOnePageLimit();
   });
   
   function selectedOnePageLimit(){
    document.getElementById('txt_one_page_limit').value = "<%=onePageLimit%>";
    document.getElementById('txt_one_page_limit2').value = "<%=onePageLimit%>";
   }

   function setParam(name,value){
	var input = document.createElement('input');
    input.setAttribute('type', 'hidden');
    input.setAttribute('name', name);
    input.setAttribute('value', value);
    return input;
   }

   var pageNumDesStr = <%=pageNumStr%>;

   function toServlet(from_which,page_num,one_page_limit) {
	var f = document.createElement("form");
	f.setAttribute('method',"post");
	f.setAttribute('action',"/setting_blacklist/" + page_num);
	var input_one_page_limit = setParam("one_page_limit",one_page_limit);
	f.appendChild(input_one_page_limit);
	var	search_name = document.getElementById("txtSearchName").value;
	var inputName = setParam('bl_name',search_name);
	var search_mail = document.getElementById("txtSearchMail").value;
	var inputMail = setParam('bl_mail',search_mail);
	if (search_name == "" && search_mail == ""){
	} else {
		from_which = "search";
	}
	var input_from_which = setParam("from_which",from_which);
	f.appendChild(input_from_which);
	f.appendChild(inputName);
    f.appendChild(inputMail);
	
	var bodyElement = document.body ;
    bodyElement.append(f);
	f.submit();
   }

   function onePageLimit(){
	toServlet("one_page_limit",getPageNumDes(), document.activeElement.value);
   }
			
   function moveList(num) {
	toServlet("move_list",num, document.getElementById("txt_one_page_limit").value);
   }

   function resetSearchInfo(){
	 document.getElementById("txtSearchName").value = "";
	 document.getElementById("txtSearchMail").value = "";
	 toServlet("no_search",1,document.getElementById("txt_one_page_limit").value);
   }
			
   function getPageNumDes(){
	return "1";
   }

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
   
   function search_blacklist(){
	   search_name = document.getElementById("txtSearchName").value;
	   search_mail = document.getElementById("txtSearchMail").value;
	   if(search_name == "" && search_mail == ""){
		   alert("検索条件を入力してください");
		   return;
	   }
	   
	   var alert_str = "";
	   var name_err_flg = false;
	   var mail_err_flg = false;
	   
	   if(search_name.length > 0 && search_name.length < 2){
		   name_err_flg = true;
	   }
	   if(search_mail.length > 0 && search_mail.length < 5){
		   mail_err_flg = true;
	   }
	   
	   if(name_err_flg){
		   if(mail_err_flg){
			   alert_str = "「氏名」は2文字以上\n「メール/電話」は5文字以上入力してください";
		   } else {
			   alert_str = "「氏名」は2文字以上入力してください";
		   }
	   } else {
		   if(mail_err_flg){
			   alert_str = "「メール/電話」は5文字以上入力してください";
		   }
	   }
	   
	   if(name_err_flg == true || mail_err_flg == true){
		   alert(alert_str);
		   return;
	   }
	   
	   toServlet("search",1,document.getElementById("txt_one_page_limit").value);
	   
   }

   function toDeleteServlet(deleteArr){
	var inputDeleteArr = setParam('delete_id_arr',deleteArr);
	var inputPageNumStr = setParam('pageNumStr','<%=pageNumStr%>');
	var f = document.createElement("form");
    f.setAttribute('method',"post");
    f.setAttribute('action',"/setting_blacklist_delete");
	f.appendChild(inputDeleteArr);
    f.appendChild(inputPageNumStr);
	var bodyElement = document.body ;
    bodyElement.append(f);
    f.submit();
   }

   function delete_per_line(index){
	var del_conf = confirm("削除します。よろしいですか？");
	if (del_conf == true)
		toDeleteServlet(index);
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

   function delete_all_line(){
	if (get_total_selected_rad() > 0) {
		var del_conf = confirm("削除します。よろしいですか？");
		var index = new Array();
		var counter = 0;
		if (del_conf == true) {
			var deleteArr = '';
			var rad = document.getElementsByName("cb_data");
			for (var i = 0; i < rad.length; i++) {
				if(rad[i].checked == true) {
					index[counter] = rad[i].value;
					deleteArr = deleteArr + ','+rad[i].value;
					counter ++;			
				}
			}
			if(counter > 0) {
				toDeleteServlet(deleteArr);
			}
			document.getElementById("cb_data_x").checked = false;
		}
	} else
		alert("削除処理対象を選択してください。");
   }
   
   function return_input(){
	   var conf_modal = document.getElementById("blacklist_add_conf_modal");
   	   conf_modal.style.display = "none";
	   var add_modal = document.getElementById("blacklist_add_modal");
   	   add_modal.style.display = "block";
   }
   
   function toAddServlet(){
	   var fromWhich = setParam('from_which',"setting_blacklist");
	   var inputName = setParam('name_blacklist',document.getElementById("txtAddName").value);
	   var inputMail = setParam('mail_blacklist',document.getElementById("txtAddMail").value);
	   var inputMail2 = setParam('mail2_blacklist',document.getElementById("txtAddMail2").value);
	   var inputTel = setParam('tel_blacklist',document.getElementById("txtAddTel").value);
	   var inputTel2 = setParam('tel2_blacklist',document.getElementById("txtAddTel2").value);
	   
	   var f = document.createElement("form");
       f.setAttribute('method',"post");
       f.setAttribute('action',"/blacklist_add");
	   f.appendChild(fromWhich);
	   f.appendChild(inputName);
	   f.appendChild(inputMail);
	   f.appendChild(inputMail2);
	   f.appendChild(inputTel);
	   f.appendChild(inputTel2);
	   var bodyElement = document.body ;
       bodyElement.append(f);
       f.submit()
       
	   document.getElementById("txtAddName").value = "";
	   document.getElementById("txtAddMail").value = "";
	   document.getElementById("txtAddMail2").value = "";
	   document.getElementById("txtAddTel").value = "";
	   document.getElementById("txtAddTel2").value = "";
	   var conf_modal = document.getElementById("blacklist_add_conf_modal");
   	   conf_modal.style.display = "none";
   }
   
  </script>
 </head>
 <body class="hold-transition skin-kujira sidebar-mini <%=sidebar_collapse%>">
  <div class="wrapper">
   <jsp:include page="/WEB-INF/views/common/top_bar.jsp" flush="false" />
   <jsp:include page="/WEB-INF/views/common/side_bar.jsp" flush="false" />
   <div class="content-wrapper">
    <section class="content-header">
     <h1>ブラックリスト設定</h1>
     <ol class="breadcrumb">
      <li><a href="/"><i class="fa fa-home"></i> ホーム</a></li>
      <li><a href="/setting_blacklist"><i class="fa fa-cogs"></i> 設定</a></li>
      <li class="active">ブラックリスト設定</li>
     </ol>
    </section>
    <section class="content">
     <div class="row">
      <section class="col-md-12 col-xs-12">
       <div class="callout callout-warning">
        <h4 style="font-size:16px;">ブラックリスト登録明細一覧</h4>
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
           	<div class="col-md-6 col-xs-12">
           	 <label style="font-size: 12px;">氏名</label>
           	 <input class="form-control" id="txtSearchName" type="text" placeholder="氏名" value="<%=input_name%>"/>
           	</div>
           	<div class="col-md-6 col-xs-12">
           	 <label style="font-size: 12px;">メール/電話</label>
           	 <input class="form-control" id="txtSearchMail" type="text" placeholder="メールアドレス or 電話番号" value="<%=input_mail%>" />
           	</div>
           </div>
          </div>
          <div class="box-body">
           <div class="col-md-12 col-xs-12">
           	<div class="text-center">
           	 <button class="btn btn-rounded btn-kujira" id="search_button" onclick="search_blacklist()">検索</button>
           	</div>
           </div>
          </div>
         </div>
        </div>
       </div>
       <br>
       <div class="row">
        <div class="col-md-12">
         <%=maxNum%> 件中 <%=startNum%> ~ <%=endNum%> 件表示 
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
        <div class="col-md-12 text-center">
         <ul class="pagination">
          <% if (highPrefEnableFlg) { %><li id ="non_selected_list"><a href="#" aria-label="Previous" onClick="moveList(<%=highPreNum%>); return false;"><span aria-hidden="true"><<</span></a></li><% }%>
          <% if (prefEnableFlg) { %><li id ="non_selected_list"><a href="#" onClick="moveList(<%=preNum%>); return false;"><</a></li><%}%>
          <% if (pageNum >= 10) { %>
          <li id="non_selected_list"><a href="#" onClick="moveList(1); return false;">1</a></li>
          <li id ="omission_list"><a href="javascript:void(0)" >...</a></li>
          <% }
          for (int i = startPageNum; i <= endPageNum; i++) {
           if (i == pageNum) { %>
          <li id ="selected_list" class="active"><a href="javascript:void(0)" ><%=i%></a></li>
          <% } else { %>
          <li id ="non_selected_list"><a href="#" onClick="moveList(<%=i%>); return false;"><%=i%></a></li>
          <% }
          } %>
          <% if (nextEnableFlg) { %>  <li id ="non_selected_list"><a href="#" onClick="moveList(<%=nextNum%>); return false;">></a></li>  <% }%>
          <% if (highNextEnableFlg) { %><li id ="non_selected_list"><a href="#" onClick="moveList(<%=highNextNum%>); return false;">>></a></li>  <% }%>
         </ul>
        </div>
       </div>
       <div class="row">
        <div class="col-md-12 col-xs-12">
         <div class="pull-left">
          <a style="color:#000;" id="add_blacklist" class="btn btn-kujira">新規登録</a>
         </div>
         <div class="pull-right">
          <a class="btn btn-rounded btn-danger" id="btn_delete_all_0" onclick="delete_all_line()">一括削除</a>
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
             <th scope="col" width="7%"><center>
              <label class="switch">
               <input onclick="check_all()" id="cb_data_x" class="input_form_field_radio" type="checkbox" value="">
               <span class="slider round"></span>
              </label>
              </center>
             </th>
             <!-- <th style="font-size:12px;" scope="col"><b>ブラックリストID</b></th> -->
             <th style="font-size:12px;" scope="col" width="15%"><b>氏名</b></th>
             <th style="font-size:12px;" scope="col" width="20%"><b>メール</b></th>
             <th style="font-size:12px;" scope="col" width="20%"><b>メール2</b></th>
             <th style="font-size:12px;" scope="col" width="14%"><b>電話</b></th>
             <th style="font-size:12px;" scope="col" width="14%"><b>電話2</b></th>
             <th style="font-size:12px;" scope="col" width="10%"><b>操作</b></th>
            </tr>
           </thead>
           <tbody>
            <% for(int i = 0; i < blacklistArray.length; i++) {%>
            <tr>
             <th scope="col">
              <center>
               <label class="switch">
                <input id="cb_data_2" name="cb_data" class="input_form_field_radio" value='<%=blacklistArray[i].getId()%>' type="checkbox" value="">
                <span class="slider round"></span>
               </label>
              </center>
             </th>
             <!-- <td style="font-size:12px;" data-title="ブラックリストID"><%=blacklistArray[i].getId()%></td> -->
             <td style="font-size:12px;" data-title="名"><%=blacklistArray[i].getName()%></td>
             <td style="font-size:12px;" data-title="郵便物"><%=blacklistArray[i].getMail()%></td>
             <td style="font-size:12px;" data-title="メール2"><%=blacklistArray[i].getMail2()%></td>
             <td style="font-size:12px;" data-title="電話"><%=blacklistArray[i].getTel()%></td>
             <td style="font-size:12px;" data-title="電話2"><%=blacklistArray[i].getTel2()%></td>
             <td style="font-size:12px;">
              <center>
               <a style="text-decoration: none; color:blue" href="javascript:void(0)" onclick="delete_per_line('<%=blacklistArray[i].getId()%>')">削除</a>
              </center>
             </td>
            </tr>
            <% } %>
           </tbody>
          </table>
         </div>
       	</div>
       </div>
      </section>
     </div>
    </section>
   </div>
   <jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false" />
  </div>

  <div id="blacklist_add_modal" class="w3-modal" style="margin-bottom: 20px;">
   <div class="w3-modal-content w3-card-4" style="border-radius: 10px;">
    <header class="w3-container w3-teal" style="border-top-left-radius: 10px; border-top-right-radius: 10px;">
     <img src="/res/img/send_email.png" style="width:50px; padding-top:5px; padding-bottom: 5px; padding-right:5px;float:left;"/>
     <span id="btn_close_modal" class="w3-button w3-display-topright" style="border-top-right-radius: 10px; font-size:12px;" onclick="close_dialog()">閉じる</span>
     <h4 style="margin-top: 9px; font-size:12px;"><center>ブラックリスト登録</center></h4>
    </header>
    <div class="w3-container modd">
     <br>
     <div class="row">
      <div class="col-md-12 col-xs-12">
       <div class="box box-kujira">
        <div class="box-body">
         <div class="form-group">
          <div class="col-md-6 col-xs-12">
           <label style="font-size: 12px;">氏名</label>
           <input class="form-control" id="txtAddName" type="text" placeholder="氏名" />
          </div>
         </div>
        </div>
        <div class="box-body">
         <div class="form-group">
          <div class="col-md-6 col-xs-12">
           <label style="font-size: 12px;">メール</label>
           <input class="form-control" id="txtAddMail" type="text" placeholder="メール" />
          </div>
          <div class="col-md-6 col-xs-12">
           <label style="font-size: 12px;">メール2</label>
           <input class="form-control" id="txtAddMail2" type="text" placeholder="メール2" />
          </div>
         </div>
        </div>
        <div class="box-body">
         <div class="form-group">
          <div class="col-md-6 col-xs-12">
           <label style="font-size: 12px;">電話</label>
           <input class="form-control" id="txtAddTel" type="text" placeholder="電話" />
          </div>
          <div class="col-md-6 col-xs-12">
           <label style="font-size: 12px;">電話2</label>
           <input class="form-control" id="txtAddTel2" type="text" placeholder="電話2" />
          </div>
         </div>
        </div>
       </div>
      </div>
     </div>
     <br>
     <div class="row">
   	  <div class="col-md-12">
   	   <div class="pull-right">
		<a class="btn btn-kujira btn-rounded" id="to_add_conf_btn">入力内容を確認</a>
	   </div>
      </div>
     </div>
     <br>
    </div>
   </div>
  </div>
  
  <div id="blacklist_add_conf_modal" class="w3-modal" style="margin-bottom: 20px;">
   <div class="w3-modal-content w3-card-4" style="border-radius: 10px;">
    <header class="w3-container w3-teal" style="border-top-left-radius: 10px; border-top-right-radius: 10px;">
     <img src="/res/img/send_email.png" style="width:50px; padding-top:5px; padding-bottom: 5px; padding-right:5px;float:left;"/>
     <h4 style="margin-top: 9px; font-size:12px;"><center>ブラックリスト登録確認</center></h4>
    </header>
    <div class="w3-container modd">
     <br>
     <div class="row">
      <div class="col-md-12 col-xs-12">
       <div class="row">
        <div class="col-md-12 col-xs-12">
         <div class="box box-kujira box-solid">
          <div class="box-header with-border">
           <h3 style="font-size:12px;" class="box-title">入力内容</h3>
          </div>
          <div class="box-body">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">氏名</h6>
            <div class="col-sm-4 col-xs-12" id="conf_name"></div>
           </div>
          </div>
          <div class="box-body" style="background-color: rgb(238, 120, 0, 0.2)">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">メール</h6>
            <div class="col-sm-4 col-xs-12" id="conf_mail"></div>
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">メール2</h6>
            <div class="col-sm-4 col-xs-12" id="conf_mail2"></div>
           </div>
          </div>
          <div class="box-body">
           <div class="form-group">
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">電話</h6>
            <div class="col-sm-4 col-xs-12" id="conf_tel"></div>
            <h6 class="col-sm-2 col-xs-12" style="font-size:12px;">電話2</h6>
            <div class="col-sm-4 col-xs-12" id="conf_tel2"></div>
           </div>
          </div>
         </div>
        </div>
       </div>
      </div>
     </div>
     <br>
     <div class="row">
   	  <div class="col-md-12">
   	   <div class="pull-left">
		<a class="btn btn-kujira btn-rounded" onclick="return_input()">戻る</a>
	   </div>
   	   <div class="pull-right">
		<a class="btn btn-kujira btn-rounded" onclick="toAddServlet()">登録</a>
	   </div>
      </div>
     </div>
     <br>
    </div>
   </div>
  </div>
  
  
  
  <script src="/dist/js/jquery.js"></script>
  <script src="/dist/js/bootstrap.js"></script>
  <script src="/dist/js/adminlte.js?v=1"></script>
  <script>
   function clear_check_all() {
	var rad = document.getElementsByName("cb_data");document.getElementById("cb_data_x").checked = false;
	for (var i = 0; i < rad.length; i++)
		rad[i].checked = false;
   }


   $("#add_blacklist").click(function() {
   	var modal = document.getElementById("blacklist_add_modal");
   	modal.style.display = "block";
   });

   function close_dialog() {
   	var modal = document.getElementById("blacklist_add_modal");
   	modal.style.display = "none";
   }

   $(document).ready(function() {
    var pathname = window.location.pathname;
    $('.setting').parent().addClass('active') && $('.setting > li > a[href="'+pathname+'"]').parent().addClass('active');
   })
   
   $("#to_add_conf_btn").click(function() {
	var txtAddName = document.getElementById("txtAddName").value;
	var txtAddMail = document.getElementById("txtAddMail").value;
	var txtAddMail2 = document.getElementById("txtAddMail2").value;
	var txtAddTel = document.getElementById("txtAddTel").value;
	var txtAddTel2 = document.getElementById("txtAddTel2").value;
	   
	if(txtAddName == ""){
		alert("氏名は入力必須です。");
		return;
	} else {
		if(txtAddMail == "" && txtAddMail2 == "" && txtAddTel == "" && txtAddTel2 == ""){
			alert("メールまたは電話を1件以上入力してください。");
			return;
		}
	}
	   
	var add_modal = document.getElementById("blacklist_add_modal");
   	add_modal.style.display = "none";
   	
	document.getElementById("conf_name").innerHTML = txtAddName;
	document.getElementById("conf_mail").innerHTML = txtAddMail;
	document.getElementById("conf_mail2").innerHTML = txtAddMail2;
	document.getElementById("conf_tel").innerHTML = txtAddTel;
	document.getElementById("conf_tel2").innerHTML = txtAddTel2;
	
   	var conf_modal = document.getElementById("blacklist_add_conf_modal");
   	conf_modal.style.display = "block";
   });
   
   
   
  </script>
 </body>
</html>
