<!-- Final -->

<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="es.hyrax.object.AppStatusObject" %>
<%@ page import="es.hyrax.object.AccountObject" %>
<%@ page import="es.hyrax.object.singleton.FollowUpStrGetter" %>

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
	AppStatusObject[] appStatusArray = (AppStatusObject[])request.getAttribute("appStatusArray");
	FollowUpStrGetter followUpStrGetter = FollowUpStrGetter.getInstance();
    //AppStatusObject[] appStatusArray = new AppStatusObject[0];
	int countDeleteArray = 0;

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
			
			$(function() {
    			//clear_screen();
    			take_get_parameter();

    			//final action button
   			});
			
			function take_get_parameter() {
				var del_row_no = S_GET("del_row_no");
				var edit_row_no = S_GET("edit_row_no");
				var new_line = S_GET("new_line");

				if (new_line == "1") {
					var table_data_content 		= document.getElementById("table_data_content").innerHTML;
					var app_code 				= S_GET("app_code"), 
						app_status_name			= S_GET("app_status_name"),
						app_follow_up			= S_GET("app_follow_up");

					table_data_content += "<tr id='row_999'>";
					table_data_content += "<td class='data_table_data'>" + app_code + "</td><td class='data_table_data'>" + app_status_name + 
										  "</td><td class='data_table_data'>" + app_follow_up + "</td><td><div><ul class='ul_navigation'><li><a id='edit_row_999' onclick=\"edit_per_line('" + app_code + "','" + app_status_name + "','" + app_follow_up + "','999')\" class='a_nav_link'>編集</a></li><li><a id='delete_row_999' onclick='delete_per_line('999')' href='#'>削除</a></li></ul>	</div></td>" 
					table_data_content += "</tr>";

					document.getElementById("table_data_content").innerHTML = table_data_content;
				}
				else if(edit_row_no != "") {
					var table_row 			= document.getElementById("row_" + edit_row_no).innerHTML;
					var app_code 				= S_GET("app_code"), 
						app_status_name			= S_GET("app_status_name"),
						app_follow_up			= S_GET("app_follow_up");

					table_row				= "<td class='data_table_data'>" + app_code + "</td><td class='data_table_data'>" + app_status_name + 
											  "</td><td class='data_table_data'>" + app_follow_up + "</td><td><div><ul class='ul_navigation'><li><a id='edit_row_" + edit_row_no + "' onclick=\"edit_per_line('" + app_code + "','" + app_status_name + "','" + app_follow_up + "','" + edit_row_no + "')\" class='a_nav_link'>編集</a></li><li><a id='delete_row_" + edit_row_no + "' onclick='delete_per_line('" + edit_row_no + "')' class='a_nav_link'>削除</a></li></ul>	</div></td>";
					document.getElementById("row_" + edit_row_no).innerHTML = table_row;
				}
				else if(del_row_no != "") {
					$("#row_" + del_row_no).remove();
				}
			
			}
			
			function setParam(name,value){
				var input = document.createElement('input');
                input.setAttribute('type', 'hidden');
                input.setAttribute('name', name);
                input.setAttribute('value', value);
                return input;
			}

			function redirect_create_page(){
				var f = document.createElement("form");
				f.setAttribute('method',"post");
				f.setAttribute('action',"setting_app_status_create");
				var inputOp = setParam('op',1);
				f.appendChild(inputOp);
				var bodyElement = document.body;
				bodyElement.append(f);
				f.submit();
			}
			function redirect_update_page(id,followUp,statusName){
				var f = document.createElement("form");
				f.setAttribute('method',"post");
				f.setAttribute('action',"setting_app_status_create");		
				
				var inputOp = setParam('op',0);
				var inputid = setParam('app_id',id);
				var inputFollowUp = setParam('app_follow_up',followUp);
				var inputStatusName = setParam('app_status_name',statusName);
				f.appendChild(inputOp);
				f.appendChild(inputid);
				f.appendChild(inputFollowUp);
				f.appendChild(inputStatusName);
				var bodyElement = document.body;
				bodyElement.append(f);
				f.submit();
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
				
			
			//delete single & mass
			function delete_per_line(index){
				var del_conf = confirm("削除します。よろしいですか？");

				if (del_conf == true){
					//$("#row_"+index).remove();
					toDeleteServlet(index);
				}
			}
			/* end delete single & mass */			

			function edit_per_line( status_code, status_name, status_follow_up, row_id) {
				var link = 	"setting_app_status_create.html?op=2&edit_row_no=" + row_id + "&app_code=" + status_code + 
							"&app_status_name=" + status_name + "&app_follow_up=" + status_follow_up;

				window.location.href = link;
			}
  </script>
 </head>
 <body class="hold-transition skin-kujira sidebar-mini <%=sidebar_collapse%>">
  <div class="wrapper">
   <jsp:include page="/WEB-INF/views/common/top_bar.jsp" flush="false" />
   <jsp:include page="/WEB-INF/views/common/side_bar.jsp" flush="false" />
   <div class="content-wrapper">
    <section class="content-header">
     <h1>選考ステータス設定</h1>
     <ol class="breadcrumb">
      <li><a href="/"><i class="fa fa-home"></i> ホーム</a></li>
      <li><a href="/setting_app_status"><i class="fa fa-cogs"></i> 設定</a></li>
      <li class="active">選考ステータス設定</li>
     </ol>
    </section>
    <section class="content">
     <div class="row">
      <section class="col-md-12 col-xs-12">
       <div class="callout callout-warning">
        <h4 style="font-size:16px;">選考ステータス一覧</h4>
       </div>
       <div class="row">
        <div class="col-md-12 col-xs-12">
         <div class="form-group">
          <div class="pull-right">
           <a id="btn_register_0" class="btn btn-rounded btn-kujira" onclick="redirect_create_page()">新規登録</a>
          </div>
         </div>
        </div>
       </div>
       <br>
       <div class="row">
        <div class="col-md-12 col-xs-12">
         <div class="responsive-table">
          <table class="table table-striped table-bordered">
           <thead>
           	<th style="font-size:12px;" scope="col"><b>コード</b></th>
           	<th style="font-size:12px;" scope="col"><b>選考ステータス</b></th>
           	<th style="font-size:12px;" scope="col"><b>紐付け先の選考フロー</b></th>
           	<th style="font-size:12px;" scope="col"><b>操作</b></th>
           </thead>
           <tbody>
           	<% for(int i = 0; i < appStatusArray.length; i++){%>
           	<tr id="row_0">
           	 <th style="font-size:12px;" scope="row"><%=appStatusArray[i].getId() %></th>
           	 <td style="font-size:12px;" data-title="応募日時"><%=appStatusArray[i].getStatusName() %></td>
           	 <td style="font-size:12px;" data-title="応募日時"><%=followUpStrGetter.getStr(appStatusArray[i].getFollowUp()) %></td>
           	 <td style="font-size:12px;" data-title="応募日時">
              <div class="text-center">
              	<a id="edit_row_0" href="javascript:void(0)" onclick="redirect_update_page(<%=appStatusArray[i].getId() %>,<%=appStatusArray[i].getFollowUp() %>,'<%=appStatusArray[i].getStatusName() %>')" class='a_nav_link' style="text-decoration: none;">編集</a><label> | </lavel>
              	<a id="delete_row_0" href="javascript:void(0)" style="text-decoration: none;" onclick="delete_per_line('<%=appStatusArray[i].getId()%>')" class='a_nav_link'>削除</a>
              </div>
             </td>
           	</tr>
           	<% } %>
           </tbody>
          </table>
         </div>
        </div>
       </div>
       <br>
       <div class="row">
        <div class="col-md-12 col-xs-12">
         <div class="form-group">
          <div class="pull-right">
           <a id="btn_register_1" class="btn btn-rounded btn-kujira" onclick="redirect_create_page()">新規登録</a>
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
   function clear_screen() {
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
