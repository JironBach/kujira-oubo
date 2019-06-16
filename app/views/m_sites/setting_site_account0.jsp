<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="es.hyrax.object.SiteObject" %>
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

%>
<!DOCTYPE html>
<html>
 <head>
  <jsp:include page="/WEB-INF/views/common/index_header.jsp" flush="false" />
  <title>くじら応募</title>
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
      <li><a href="/setting_account"><i class="fa fa-cogs"></i> 設定</a></li>
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
        <div class="col-md-12">
         <div class="pull-right">
          <!-- <a class="btn btn-warning new-button-print" data-toggle="modal"data-no="4" data-target="#create-modal"data-keyboard="true" data-backdrop="true">新規作成</a> -->
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          <a id="edit_btn" onclick="create_site();return false;" data-toggle="modal" data-no="3" data-target="#create-modal"data-keyboard="true" data-backdrop="true" class="btn btn-warning new-button-print">新規作成</a>
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
             <!-- <th style="font-size:12px;" scope="col"><b>No.</b></th> -->
             <th style="font-size:12px;" scope="col"><b>掲載サイト</b></th>
             <th style="font-size:12px;" scope="col"><b>求人サイト名</b></th>
             <th style="font-size:12px;" scope="col"><b>ID</b></th>
             <th style="font-size:12px;" scope="col"><b>状態</b></th>
             <th style="font-size:12px;" scope="col"><b>編集</b></th>
       	    </tr>
       	   </thead>
           <tbody>
            <% 
            int num = 1;
            for(int i = 0 ; i < siteArray.length;i++){if(null!=siteArray[i]) {
            %>
       	    <tr>
       	     <!-- <th style="font-size:12px;" scope="row"><center><%= num %></center></th> -->
       	     <td style="font-size:12px;" data-title="掲載サイト"><%=siteArray[i].getSiteId()%></td>
       	     <td style="font-size:12px;" data-title="求人サイト名"><%=siteArray[i].getName()%></td>
       	     <td style="font-size:12px;" data-title="ID"><%= siteArray[i].getUserId() %></td>
       	     <td style="font-size:16px;" data-title="状態">
             <%
             if (siteArray[i].getNoScrapingFlg() == 0){
             %>
              <center><span class="label label-success">利用中</span></center>
             <%
             } else {
             %>
              <center><span class="label label-warning">利用不可</span></center>
             <%
             }
             %>
            </td>
       	     <td style="font-size:12px;" data-title="編集">
       	      <center>
       	       <a id="edit_btn" onclick="update_site_account(<%=siteArray[i].getId() %>, '<%=siteArray[i].getNoScrapingFlg() %>', '<%=siteArray[i].getName() %>', '<%= siteArray[i].getUrl() %>', '<%= siteArray[i].getUserId() %>', '<%= siteArray[i].getPassword() %>');return false;" data-toggle="modal" data-no="3" data-target="#edit-modal"data-keyboard="true" data-backdrop="true" class="btn btn-primary modal-open btn-flat"><i class="fa fa-pencil"></i> 編集</a>
       	      </center>
       	     </td>
       	    </tr>
            <% num+= 1;
             } } %>
       	   </tbody>
       	  </table>
       	 </div>
       	</div>
       </div>
       <br>
       <div class="row">
        <div class="col-md-12">
         <div class="pull-right">
          <a class="btn btn-warning new-button-print" data-toggle="modal"data-no="4" data-target="#create-modal" data-keyboard="true" data-backdrop="true">新規作成</a>
         </div>
        </div>
</div>
      </section>
     </div>
    </section>
   </div>
   <jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false" />
  </div>
<div id="create-modal" class="w3-modal" style="margin-bottom: 20px;">
  <div class="w3-modal-content w3-card-4" style="border-radius: 10px;">
    <header class="w3-container w3-teal" style="border-top-left-radius: 10px; border-top-right-radius: 10px;"> <img src="/res/img/send_email.png" style="width:50px; padding-top:5px; padding-bottom: 5px; padding-right:5px;float:left;" /> <span class="w3-button w3-display-topright" style="border-top-right-radius: 10px; font-size:12px;" onclick="closeCreateModal()">閉じる</span>
      <h4 style="margin-top: 9px; font-size:16px;">
        <center>求人サイト新規設定</center>
      </h4>
    </header>
    <div class="w3-container modd"> <br>
      <form id="form" action="" method="POST" role="form">
        <div class="row">
          <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="form-group"> <label>サイトアドレス</label> <textarea class="form-control" id="new_url" style="resize:none;" placeholder="サイトアドレス"></textarea>
              <div class="help-block with-errors">入力必須</div>
            </div>
          </div>
          <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
            <div class="form-group"> <label>クライアントID</label> <input type="text" class="form-control" name="new_id" placeholder="クライアントID" /> </div>
          </div>
          <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
            <div class="form-group"> <label>ログインID</label> <input type="text" class="form-control" name="" placeholder="ログインID" /> </div>
          </div>
          <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
            <div class="form-group"> <label>パスワード</label> <input type="text" class="form-control" name="" placeholder="パスワード" /> </div>
          </div>
          <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
            <div class="form-group"> <select name="group_flag" class="form-control" required>
          <option value="Y" selected>有効</option>
          <option value="N">休止</option>
         </select> </div>
          </div>
          <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"> <button type="submit" class="btn btn-primary pull-right" id="modal-send"><i class="fa fa-save"></i> 保存する</button> </div>
        </div>
      </form> <br> </div>
  </div>
</div>

  <div id="edit-modal" class="w3-modal" style="margin-bottom: 20px;">
   <div class="w3-modal-content w3-card-4" style="border-radius: 10px;">
    <header class="w3-container w3-teal" style="border-top-left-radius: 10px; border-top-right-radius: 10px;">
     <img src="/res/img/send_email.png" style="width:50px; padding-top:5px; padding-bottom: 5px; padding-right:5px;float:left;"/>
     <span class="w3-button w3-display-topright" style="border-top-right-radius: 10px; font-size:12px;" data-dismiss="modal" aria-label="Close" onclick="closeDialog()">閉じる</span>
     <h4 style="margin-top: 9px; font-size:16px;"><center>求人サイト設定情報編集</center></h4>
     <center><h6 style="margin-top: 9px; font-size:12px;">求人サイト名：<span id="name_column"></span></h6></center>
    </header>
    <div class="w3-container modd">
     <br>
     <form id="form" action="/setting_site_account_update" method="POST" role="form">
      <div class="row">
       <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
        <input type="hidden" class="form-control" id="id" name="id" placeholder="クライアントID" />
        <div class="form-group">
         <label>サイトアドレス</label>
         <textarea class="form-control" style="resize:none;" placeholder="サイトアドレス" id="url_column" name="url_column"></textarea>
        </div>
       </div>
       <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
       	<div class="form-group">
       	 <label>ユーザーID</label>
       	 <input type="text" class="form-control" id="user_id_column" name="user_id_column" placeholder="クライアントID" />
       	</div>
       </div>
       <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
       	<div class="form-group">
       	 <label>パスワード</label>
       	 <input type="password" class="form-control" id="password_column" name="password_column" placeholder="パスワード" />
       	</div>
       </div>
       <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
       	<div class="form-group" style="margin-top: 25px;">
       	 <select class="form-control" id="no_scraping_flg" onchange="vtvt()" name="no_scraping_flg" required>
       	  <option value="0">利用可</option>
		      <option value="1">利用不可</option>
		     </select>
       	</div>
       </div>
       <input type="hidden" id="show">
       <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
	      <button type="submit" class="btn btn-primary pull-right" id="modal-send"><i class="fa fa-save"></i> 保存する</button>
	     </div>
      </div>
     </form>
    <br>
    </div>
   </div>
  </div>
  <script src="/dist/js/jquery.js"></script>
  <script src="/dist/js/bootstrap.js"></script>
  <script src="/dist/js/adminlte.js?v=1"></script>
  <script>

  function vtvt() {
   var tes = document.getElementById("no_scraping_flg").value;
   var rrr = document.getElementById("show").value=tes;

   if (rrr==1) {
    document.getElementById("url_column").required = true;
    document.getElementById("user_id_column").required = true;
    document.getElementById("password_column").required = true;
   } else {
    document.getElementById("url_column").required = false;
    document.getElementById("user_id_column").required = false;
    document.getElementById("password_column").required = false;
   }


  }

   $("#edit_btn").click(function() {
    //document.getElementById("edit-modal").title = "0";
    var modal = document.getElementById("edit-modal");
    modal.style.display = "block";
   });

   function update_site_account(id, noScrapingFlg, name, url, userId, password){
    //document.getElementById("edit-modal").title = id;
    document.getElementById("id").value = id;
    document.getElementById("name_column").innerHTML = name;
    document.getElementById("url_column").value = url;
    document.getElementById("user_id_column").value = userId;
    document.getElementById("password_column").value = password;
    document.getElementById("no_scraping_flg").value = noScrapingFlg;
    document.getElementById("show").value = noScrapingFlg;
    var vvv = document.getElementById("no_scraping_flg").value = noScrapingFlg;

    if(vvv==1) {
      document.getElementById("url_column").required = true;
      document.getElementById("user_id_column").required = true;
      document.getElementById("password_column").required = true;
    } else {
      document.getElementById("url_column").required = false;
      document.getElementById("user_id_column").required = false;
      document.getElementById("password_column").required = false;
    }

    no_scraping_flg.options[no_scraping_flg.options.selectedIndex].selected = true;
    modal.style.display = "block";
   }
   
   function closeCreateModal(){
    var modal1 = document.getElementById("create-modal");
    document.getElementById("edit-modal").title = "";
    document.getElementById("name_column").innerHTML = "";
    document.getElementById("id").value = "";
    document.getElementById("url_column").value = "";
    document.getElementById("user_id_column").value = "";
    document.getElementById("password_column").value = "";
    document.getElementById("no_scraping_flg").value = "";
    modal1.style.display = "none";
   }

   function closeDialog(){
    var modal1 = document.getElementById("edit-modal");
    document.getElementById("edit-modal").title = "";
    document.getElementById("name_column").innerHTML = "";
    document.getElementById("id").value = "";
    document.getElementById("url_column").value = "";
    document.getElementById("user_id_column").value = "";
    document.getElementById("password_column").value = "";
    document.getElementById("no_scraping_flg").value = "";
    modal1.style.display = "none";
   }
  </script>
  <script>
$(document).ready(function() {
    // get current URL path and assign 'active' class
    var pathname = window.location.pathname;
    $('.setting').parent().addClass('active') && $('.setting > li > a[href="'+pathname+'"]').parent().addClass('active');
})
  </script>
 </body>
</html>
