<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="es.hyrax.object.AccountObject" %>
<%@ page import="es.hyrax.object.NotificationObject" %>
<%@ page import="es.hyrax.object.ApplicantsInfo" %>
<%@ page import="es.hyrax.util.Integer107" %>
<%
	AccountObject loginAccountObj = (AccountObject)session.getAttribute("loginAccountObj"); 
	NotificationObject[] notificationArray = (NotificationObject[])request.getAttribute("notificationArray"); 
 //  ApplicantsInfo applicantsInfo = (ApplicantsInfo)request.getAttribute("applicantsInfo");
 
	int nearDeadLineCount = (Integer)request.getAttribute("nearDeadLineCount");
	int outOfDeadLineCount = (Integer)request.getAttribute("outOfDeadLineCount");
	int todayInterviewCount = (Integer)request.getAttribute("todayInterviewCount");
    int unreadCount         = (Integer)request.getAttribute("unreadCount");
	  
	  
	//  request.setAttribute(nearDeadLineCount,"nearDeadLineCount");
	//  request.setAttribute(outOfDeadLineCount,"outOfDeadLineCount");
	//  request.setAttribute(todayInterviewCount,"todayInterviewCount");
%>
<jsp:include page="/WEB-INF/views/common/common.jsp" flush="false" />
<html>
	<head>
		<!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
		<jsp:include page="/WEB-INF/views/common/meta_header.jsp" flush="false" />
		<!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
	</head>

	<body id="cat01">
         <section class="section section-header bg-kujira-orange">
			<section class="grid-header container grid-1280">
			<!--header section-->
				<div class="text-left">
					<h3><img src="/res/img/logo.png?v=1" width="221"/> </h3>
				</div>
				<div id="header-rigth" class="text-right">
					<!--<a id="hdr_help_nav" href="/applicant#">ヘルプ</a>　-->
					<a id="hdr_logout_nav" href="/login">ログアウト</a>
					<br/>
					<p id="hdr_text_login">ログイン：<span id="hdr_usr_login"><%=loginAccountObj.getFullname()%>様</span></p>
				</div>
			<!--end header section-->
			<!-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& -->
					<jsp:include page="/WEB-INF/views/common/nav.jsp" flush="false" />
			<!-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& -->		
				</section>
          </section>
          
          <br><br><br><br><br><br><br><br>
          
			
			<section class="container grid-1280">
			<h4 class="cjk">システムからのお知らせ</h4>
			<!--&& application summary section-->
			<br><br>
			<!--&& end application summary section-->

			<!--&& notification summary section-->
			<div class="notif_title">
				<!--<h3 class="notif_content_title cjk"><img src="res/img/notif_logo.png" style="width:25px; padding-right:10px;float:left;"/>システムからのお知らせ</h3>-->
				<ul class="ul_notif_content">
					<!--<li>
						2016年05月24日 ~ 15:20<a id="notif_link_01" onclick="openModal('notif_link_01', 1)" href="#">マイナビバイトメンテナンスに伴う自動取込一時停止のお知らせ</a>
					</li>
					<li>
						2016年04月15日 ~ 10:30<a id="notif_link_02" onclick="openModal('notif_link_02', 2)" href="#">自動取込をしている媒体の管理画面パスワード・IDが変更された場合はお知らせ下さい</a>
					</li>
					<li>
						2016年03月05日 ~ 16:40<a id="notif_link_03" onclick="openModal('notif_link_03', 3)" href="#">おうぼうけるくん定期メンテナンスに伴う自動取込エラーについて</a>
					</li>-->
					<% for(int i = 0; i < notificationArray.length; i++) { %>
					<li><%=notificationArray[i].getMakeNotifPeriod() %> <a id="notif_link_01" onclick="openModal('<%=notificationArray[i].getTitle() %>',  '<%=notificationArray[i].getPurpose() %>')" href="javascript:void(0)"> <%=notificationArray[i].getTitle() %> </a>
					<%}%>
						
				</ul>
			</div>
			
			
			
			<br><br>
			<h4 class="column col-12">求人対応状況</h4>
				<section class="columns">
					
				</section>
				<section class="columns top_list">

						<div class="column col-3"><a href="" onclick="sendSearchDate(1); return false;" >未読</a><span class="li_sum_style"><%=unreadCount%></span><span>名</span></div>
						<div class="column col-3"><a href="" onclick="sendSearchData(2); return false;">対応期間近</a><span class="li_sum_style"><%=nearDeadLineCount%></span><span>名</span></div>
						<div class="column col-3"><a href="" onclick="sendSearchData(3); return false">対応期限超過</a><span class="li_sum_style"><%=outOfDeadLineCount%></span><span>名</span></div>
						<div class="column col-3"><a href="" onclick="sendSearchData(4); return false">当日面接</a><span class="li_sum_style"><%=todayInterviewCount%></span><span>名</span></div>
				</section>
			
			
			</section>
			

			
			
			<!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->	
				<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false" />
			<!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
			
			
			<!--&& end notification summary section-->

			<!-- ************************************************************************************************************************************* -->
			<!--&& modal window-->
			<div id="my_modal" class="modal">
				<div class="modal_content">
					<div class="modal_header">
						<img src="/res/img/notif_logo.png" style="width:25px; padding-top:15px; padding-right:10px;float:left;"/>
						<span id="close" class="close_modal" onclick="closeDialog()">閉じる</span>
						<h2 class="modal_title">お知らせ詳細</h2>
					</div>
					<div class="modal_body">
						<div id="notif_subject" class=""></div>
						<div id="notif_content_msg" class=""></div>
					</div>
				</div>
			</div>

			<script>
				var modal = document.getElementById("my_modal");
				var span = document.getElementById("close");

				function closeDialog(){
					modal.style.display = "none";
				}

				function openModal(notif_link_id, msg_status){
					
					var ntf_msg = "";

				/*	if(msg_status == 1){
						ntf_msg = "お客様各位<br/><br/>日頃は「ウェッブの名前」をご利用いただき、誠にありがとうございます。<br/><br/>" 
								  + "以下の日程でマイナビバイト定期メンテナンスが行われるため「ウェッブの名前」の自動取込が一時停止されます。<br/><br/>"
								  + "【日時】<br/>2016年5月28日（土曜）午前1時00分～午前11時00分 （最大）<br/>※メンテナンス日程は延期する可能性があります。<br/></br/>"
								  + "【対象サービス】<br/>マイナビバイトの自動取込機能 <br/><br/>"
								  + "【お客様への影響】<br/>メンテナンス期間中は「ウェッブの名前」でマイナビバイトの応募者の自動取込がされず、ＴＯＰページの自動取込一覧でエラーが表示されます。<br/>メンテナンス終了次第、自動取込は自動的に再開されます。<br/><br/>"
								  + "お客様にはご不便をおかけいたしますが、何卒ご理解いただきますようお願い申し上げます。<br/><br/>"
								  + "【お問合せ・相談窓口について】<br/><br/>"
								  + "本件についてのお問い合わせは、下記までお願いいたします。<br/><br/>"
								  + "株式会社九地良<br/>「ウェッブの名前」運営事務局<br/><br/>■ご意見・お問い合わせメール：my-kujira@kujira.co.jp<br/>ＴＥＬ：12-3456-7890<br/>（お問い合わせのご対応は、平日の10:00～17:00となります）";
								  
					}
					else if(msg_status == 2){
						ntf_msg = "お客様各位<br/><br/>日頃は「ウェッブの名前」をご利用いただき、誠にありがとうございます。<br/>"
								  + "表題の件について、お知らせとなります。<br/><br/>"
								  + "自動取込をしている媒体の管理画面のパスワード・IDが変更された場合<br/>「ウェッブの名前」側の設定変更が必要になります。<br/>その際は、新たなパスワード・IDを事務局・もしくは担当までご連絡<br/>いただける様お願い致します。<br/><br/>"
								  + "――――――――――――――――――――――――――――――<br/>■配信元<br/>株式会社九地良<br/>「ウェッブの名前」運営事務局<br/><br/>"
								  + "■ご意見･お問い合わせ<br/>メール：my-kujira@kujira.co.jp<br/>ＴＥＬ：12-3456-7890<br/>（お問い合わせのご対応は、平日の10:00～17:00となります）<br/>――――――――――――――――――――――――――――――<br/>(C)KUJIRA Corporation";
					}
					else if(msg_status == 3){
						ntf_msg = "お客様各位<br/><br/>日頃は「ウェッブの名前」をご利用いただき、誠にありがとうございます。<br/>表題の件について、お知らせとなります。"
								  + "<br/>おうぼうけるくんでは、毎週日曜日深夜～翌月曜日早朝にかけてメンテナンスが行われます。<br/><br/>"
								  + "それに伴って自動取込のエラー表示がＴＯＰページに表示されますが<br/>自動復旧致しますのでご安心ください。<br/>"
								  + "これによる応募者の取りこぼしは発生致しません。<br/><br/>"
								  + "なお、おうぼうけるくんメンテナンス時間中は応募者の<br/>取込ができないため日曜日深夜～翌月曜日早朝については<br/>"
								  + "応募者の取込に時差が発生致しますのでご了承下さい、<br/><br/>"
								  + "【お問合せ・相談窓口について】<br/><br/>"
								  + "本件についてのお問い合わせは、下記までお願いいたします。<br/><br/>"
								  + "株式会社九地良<br/>「ウェッブの名前」運営事務局<br/><br/>"
								  + "■ご意見・お問い合わせ<br/>メール：my-kujira@kujira.co.jp<br/>ＴＥＬ：12-3456-7890<br/>（お問い合わせのご対応は、平日の10:00～17:00となります）";	
					}
				  */
					
					document.getElementById("notif_subject").innerHTML = notif_link_id;
					//document.getElementById("notif_content_msg").innerHTML = ntf_msg;
					document.getElementById("notif_content_msg").innerHTML = msg_status;

					modal.style.display = "block";

				}
		    function setParam(name,value){
				var input = document.createElement('input');
                input.setAttribute('type', 'hidden');
                input.setAttribute('name', name);
                input.setAttribute('value', value);
                return input;
			}
				
		    function sendSearchData(situation) {		
			 	var fromWhichInput = setParam("from_which","setting_store_search");
			 	var input_situation   = setParam("situation",situation);
			    var f = document.createElement("form");
                f.setAttribute('method',"post");
                f.setAttribute('action',"/applicant");
                f.appendChild(fromWhichInput);
                f.appendChild(input_situation);
                var bodyElement = document.body ;
                bodyElement.append(f);
                f.submit();
			}
			</script>
			<!--&& end of modal window-->
			<!-- ************************************************************************************************************************************* -->

			<!--end content section-->
			<!-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& -->
	</body>
</html>
