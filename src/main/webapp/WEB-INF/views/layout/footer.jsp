<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- <link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSans-kr.css' rel='stylesheet' type='text/css'> -->

<style>
@font-face {
    font-family: 'Jal_Onuel';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10-21@1.0/Jal_Onuel.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
footer *{
	font-family: 'Jal_Onuel';
	box-sizing:border-box;
	z-index: 100;
}
#container{
  	background-color:#abd9e9;
  	font-family:Arial;
}
#container{
	width:550px;
	height:520px;
	background:#eff3f7;
	margin:0 auto;
	font-size:0px;
	border-radius:5px;
	overflow:hidden;
	margin-bottom: 50px;
	display: none;
}
aside{
	width:150px;
	height:520px;
	background-color:#3b3e49;
	display:inline-block;
	font-size:15px;
	vertical-align:top;
	overflow-y:scroll;
}
main{
	width:400px;
	height:450px;
	display:inline-block;
	font-size:15px;
	vertical-align:top;
}

aside header{
	padding:30px 20px;
}
aside input{
	width:100%;
	height:50px;
	line-height:50px;
	padding:0 50px 0 20px;
	background-color:#5e616a;
	border:none;
	border-radius:3px;
	color:#fff;
	background-image:url(https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_search.png);
	background-repeat:no-repeat;
	background-position:170px;
	background-size:40px;
}
aside input::placeholder{
	color:#fff;
}
aside ul{
	padding-left:0;
	margin:0;
	list-style-type:none;
	height:690px;
}
aside li{
	padding:10px 0;
}
aside li:hover{
	background-color:#5e616a;
}
h2,h3{
	margin:0;
}
aside li img{
	border-radius:50%;
	margin-left:20px;
margin-right:8px;
}
aside li div{
	display:inline-block;
	vertical-align:top;
	margin-top:12px;
	margin-left: 12px;
}
aside li h2{
	font-size:14px;
	color:#fff;
	font-weight:normal;
	margin-bottom:5px;
}
aside li h3{
	font-size:12px;
	color:#7e818a;
	font-weight:normal;
}

.status{
	width:8px;
	height:8px;
	border-radius:50%;
	display:inline-block;
	margin-right:7px;
}


main header{
	height:0px;
	padding:10px 5px 35px 30px;
	margin-bottom: 0px;
}
main header > *{
	display:inline-block;
	vertical-align:top;
}
main header div{
	margin-left:0px;
	margin-right:0px;
	margin-bottom: 5px;
}
main header h2{
	font-size:15px;
	margin-bottom:10px;
	margin-left: 15px;
	padding-left: 10px;
}
#chat{
	padding-left:0;
	margin:0;
	list-style-type:none;
	height:400px;
	border-top:2px solid #fff;
	border-bottom:2px solid #fff;
	overflow-y: scroll;
}
#chat li{
	padding:10px 5px;
}
#chat h2,#chat h3{
	display:inline-block;
	font-size:15px;
}
#chat h3{
	color:#bbb;
}
#chat .entete{
	margin-bottom:5px;
}
#chat .message{
	padding:10px;
	color:#fff;
	line-height:15px;
	max-width:70%;
	display:inline-block;
	text-align:left;
	border-radius:10px;
	overflow-y: auto;
	overflow: hidden;
	line-height: 1.2em;
	word-break: break-all;
	font-family: sans-serif;
	font-size: 13px;
}
#chat .me{
	text-align:right;
}
#chat .others .message{
	background-color:#58b666;
}
#chat .me .message{
	background-color:#6fbced;
}
#chat .triangle{
	width: 0;
	height: 0;
	border-style: solid;
	border-width: 1px 5px 10px 1px;
}
#chat .others .triangle{
    border-color: transparent transparent #58b666 transparent;
    margin-left:15px;
}
#chat .me .triangle{
    border-color: transparent transparent #6fbced transparent;
    margin-left:373px;
}

main footer{
	height: 50px;
	padding:20px 30px 10px 20px;
}
main footer textarea{
	cursor:pointer;
}
main footer textarea{
	resize:none;
	border:none;
	display:block;
	width:70%;
	height:40px;
	border-radius:3px;
	padding:10px;
	font-size:13px;
	margin-bottom:13px;
	float: left;
}
main footer textarea::placeholder{
	color:#ddd;
}
main footer a{
	text-decoration:none;
	text-transform:uppercase;
	font-weight:bold;
	color:#6fbced;
	vertical-align:top;
	margin-left:333px;
	margin-top:5px;
	display:inline-block;
}
#sendBtn{
	width: 30px;
	height: 10px;
}
#message{
	display: none;
}
#sendChatBtn{
	display: none;
}
.chatProfile{
	width: 25px;
	height: 30px;
}






#escapeChatModal {
	display: none;
	position:relative;
	width:100%;
	height:100%;
	z-index:1;
	margin-top: -50%;
}
#escapeChatModal h2 {
	margin:0;   
}
#escapeChatModal button {
	display:inline-block;
	width:50px;
	font-size: 10px;
	margin-left:calc(100% - 100px - 10px);
}
#escapeChatModal .modal_content {
	width:500px;
	margin:100px auto;
	padding:20px 10px;
	background:#fff;
	border:2px solid #666;
}
#escapeChatModal .modal_layer {
	position:fixed;
	top:0;
	left:0;
	width:100%;
	height:100%;
	background:rgba(0, 0, 0, 0.5);
	z-index:-10;
}



#menuListDiv li:hover {
	background: skyblue;
 	color : white;	
}
#chatDropDownMenu{
	padding: 0px;
	position: absolute;
	left: 200px;
	top: 0px;
}



.chatRoomSearchI{
	cursor: pointer;
	width:30px; 
	height: 28px; 
	padding-left: 7px; 
	padding-right: 0px; 
	padding-top: 7px; 
	padding-bottom: 0px; 
	vertical-align: top;
	background: white;
	color: #303A71;
}


.timeSpan{
	font-size: 5px;
	vertical-align: super;
}
.timeSpan.me{
	margin-right: 5px;
}
.timeSpan.others{
	margin-left: 5px;
}
.empInfo{
	font-family: sans-serif;
	font-size: 5px;
}


#searchRoomName{
	height: 30px;
	width: 90%;
	background: white;
	color: black;
	padding-left: 3px;
	padding-right: 3px;
}
#searchRoomName::placeholder {
  color: gray;
}

#chatRoomHeadTd{
	padding-left: 10%;
}
.chatInfoTr{
	font-size: 20px;
	height: 80px;
}


</style>





<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.js"></script>
<script>
	var webSocket = {
		init: function(param) {
			this._url = param.url;
			this._initSocket();
		},
		sendChat: function() {
			this._sendMessage($('#message').val());
			$('#message').val('');
		},
		receiveMessage: function(str) {
			
			let today = new Date();   

			let year = today.getFullYear(); // 년도
			let month = today.getMonth() + 1;  // 월
			let date = today.getDate();  // 날짜
			let day = today.getDay(); // 요일
			let hours = today.getHours(); // 시
			let minutes = today.getMinutes();  // 분
			
			// 월, 일, 시간, 분이 한자리 수라면 2자리 형태로 변경
			if(month/10 < 1){
				month = "0" + month;
			}
			if(date/10 < 1){
				date = "0" + date;
			}
			if(hours/10 < 1){
				hours = "0" + hours;				
			}
			if(minutes/10 < 1){
				minutes = "0" + minutes;
			}
			
			
			
			var newHour = "";
			if(parseInt(hours) > 12){
				newHour = "오후 "+parseInt(hours-12);
			}else{
				newHour += "오전 "+hours;
			}
			
			var splitStr = str.split(":+:");
			var chatInfo = "";
			
			
			
			
			// 채팅방 초대가 아닐경우
			if(splitStr[0] != "invite"){
				if(splitStr[0] == '${EMP.empId}'){
					chatInfo += "<li class='me'>";
					chatInfo += "	<div class='entete'>";
					chatInfo += "		<h2><img class='rounded-circle chatProfile' src='/profileImgView?empId="+splitStr[0]+"'/></h2>";
					chatInfo += "		<h2 class='empInfo'>"+splitStr[1]+"</h2>";
					chatInfo += "	<div class='triangle'></div>";
					chatInfo += "	<span class='timeSpan me'>"+newHour+":"+minutes+"</span><div class='message'>"+splitStr[2]+"</div>";
					chatInfo += "</li>";
					
				}else{
					chatInfo += "<li class='others'>";
					chatInfo += "	<div class='entete'>";
					chatInfo += "		<h2><img class='rounded-circle chatProfile' src='/profileImgView?empId="+splitStr[0]+"'/></h2>";
					chatInfo += "		<h2 class='empInfo'>"+splitStr[1]+"</h2>";
					chatInfo += "	<div class='triangle'></div>";
					chatInfo += "	<div class='message'>"+splitStr[2]+"</div><span class='timeSpan others'>"+newHour+":"+minutes+"</span>";
					chatInfo += "</li>";
				}
			}
			// 채팅방 초대일 경우
			else{
				chatInfo += "<li class='others'>";
				chatInfo += "	<div class='entete'>";
				chatInfo += "		<h2><img class='rounded-circle chatProfile' src='/profileImgView?empId="+splitStr[1]+"'/></h2>";
				chatInfo += "		<h2 class='empInfo'>"+splitStr[2]+"</h2>";
				chatInfo += "	<div class='triangle'></div>";
				chatInfo += "	<div class='message'>"+splitStr[3]+"</div><span class='timeSpan others'>"+newHour+":"+minutes+"</span>";
				chatInfo += "</li>";
			}
			
			
			if(chatShowStatus == true){
				$('#chat').append(chatInfo);
			}
			
			var divChat = document.getElementById('chat');
			$('#chat').animate({scrollTop: divChat.scrollHeight - divChat.clientHeight + 100}, 100);
		},
		closeMessage: function(str) {
		},
		disconnect: function() {
			this._socket.close();
		},
		_initSocket: function() {
			this._socket = new SockJS(this._url);
			this._socket.onmessage = function(evt) {
				console.log(evt);
				webSocket.receiveMessage(evt.data);
			};
			this._socket.onclose = function(evt) {
				webSocket.closeMessage(evt.data);
			}
		},
		_sendMessage: function(str) {
			if(str != ''){
				this._socket.send(str);				
			}
		}
	};
</script>
<script>

	$(function(){
		
		$("#alertsDropdownChat").hide();
		// 주소록 불러오기
		$("#showMyAddrBtn").on("click", function(){
			
			var uri = "/chat/showAddrList";
			var popupName  = "주소록";
			var options = "width=500,height=600, left = 800, top=200,location=no";
			
			window.open(uri, popupName, options,);
		});
		
		
		
		// 채팅방 리스트 불러오기
		$("#chatBoardViewBtn").on("click", function(){
			
			$.ajax({
				url		: "/chat/mychatList",
				data	: { empId : "${EMP.empId}" },
				dataType: "json",
				method	: "post",
				success	: function(data){
					
					$("#chat").html("");
					
					if(parseInt(chatClickCnt) % 2 == 0){
						console.log(data.chatRoomList);
						
						var chatRMInfo = "";
						
						// 해당 사원의 채팅방 리스트를 반환하는 함수
						chatRMInfo = chatRMInfoList(data);
						$("#chatRoomList").html(chatRMInfo);
						$("#container").show(200);
						selectAlarmEmp();
					}else{
						
						chatShowStatus = false;
						
						$("#chat").html("");
						$("#chatTitleName").html("sendbox chat");
						$("#alertsDropdownChat").hide();
						
						$("#message").hide();
						$("#sendChatBtn").hide();
						$("#container").hide(200);
					}
					chatClickCnt++;
				},
				error	: function(error){
					alert("채팅방 불러오기 실패!")
				}
			});
		});
		
		
		
		
		
		
		// 채팅방 검색하기
		$("#searchRoomName").keyup(function(){
			var chatRoom = $("#searchRoomName").val();
			console.log("chatRoom = ", chatRoom);
			$.ajax({
				url		: "/chat/mychatList",
				data	: { empId 		 : "${EMP.empId}",
							chatrmNm : chatRoom },
				dataType: "json",
				method	: "post",
				success	: function(data){
					
					$("#chat").html("");
					
						
					console.log(data.chatRoomList);
					
					var chatRMInfo = "";
					
					data.searchChatRoomNm = chatRoom.slice();
					console.log("data.searchChatRoomNm = ", data)
					
					// 해당 사원의 채팅방 리스트를 반환하는 함수
					chatRMInfo = chatRMInfoList(data);
					
					$("#chatTitleName").html("sendbox chat");
					$("#chatRoomList").html(chatRMInfo);
					selectAlarmEmp();
					
					$("#alertsDropdownChat").hide();
					$("#message").hide();
					$("#sendChatBtn").hide();
				},
				error	: function(error){
					alert("채팅방 불러오기 실패!")
				}
			});
			var id = "#chatAlarm_"+chatRoomId+" div h2 span#CRMACnt";
			$("#chatRoomList").find(id).text("0");
		});
		
		
		
		
		
		
		
		
		
		
		// 채팅방의 채팅 정보 가져오기
		$("#chatRoomList").on("click", ".chatrmId", function(){
			
			chatRoomId = $(this).data("roomid");
			chatRoomName = $(this).data("roomname");
			
			
			if(currChatRoomId != ""){
				webSocket.disconnect();
			}
			currChatRoomId = chatRoomId;
			
			
			// 해당 채팅방의 채팅로그 정보 리스트 출력 함수
			viewChatInfoList();
			selectAlarmEmp();
		});
		

		
		
		
		
		
		
		// 채팅 입력
		var message = "";
		$("#sendChatBtn").on("click", function(){
			
			message = $("#message").val();
			
			if(message != ''){
				$.ajax({
					url		: "/chat/insertChatInfo",
					data	: { chatCont : message },
					dataType: "json",
					method	: "post",
					success	: function(data){
						
						console.log(data);
						
						webSocket.sendChat();
						
						var divChat = document.getElementById('chat');
						$('#chat').animate({
					        scrollTop: divChat.scrollHeight - divChat.clientHeight + 100
					    }, 100);
					},
					error	: function(error){
						alert("db insert 실패")
					}
				});
				
				
				
				// 채팅알람을 모든인원의 알람테이블에 저장(insert)
				if(message.length > 10){
					message  = message.split(0, 10) + "...";
				}
				var alarmChatLink = "chatRoomId="+chatRoomId+"&chatRoomNm="+chatRoomName;
				var alarm_cont = "chat" + ":+:" + message;
				$.ajax({
					url		: "/alarm/alarmChatInsert",
					data	: { chatRoomId 		: chatRoomId,
								alarmCont 		: alarm_cont,
								alarmLinkCont	: alarmChatLink },
					dataType: "json",
					method	: "post",
					success	: function(data){
					},
					error	: function(error){
						alert("error : " + error.status);
					}
				});
				
						
				
				
				// 채팅방 서버에 있는 모든인원에게 알림 보내기
				$.ajax({
					url		: "/alarm/chatRoomEmpList",
					data	: { chatRoomId : chatRoomId },
					dataType: "json",
					method	: "post",
					success	: function(data){
						
						list = data.empIdList;
						console.log("data : ", data);
						console.log("data : ", data.empIdList);
						
						$.each(list, function(i, v){
							
							// 전 인원에게 메시지 보내기
							sendMessage("chat" + "," + "${EMP.empId}" + "," + list[i] + "," + chatRoomId + "," + "채팅입니다.");
						});
					},
					error	: function(error){
						alert("error!! : " + error.status);
					}
				});
			}
		});
		
		
		// 채팅방이 활성화된 상태에서 사원 추가
		$("#addEmpBtn").on("click", function(){
			var uri = "/chat/showAddEmpList?chatRoomId="+chatRoomId;
			var popupName  = "주소록";
			var options = "width=500,height=600,left=800,top=200,location=no";
			window.open(uri, popupName, options);
		});
		
		
		$("#escapeCRLi").on("click", function(){
			$('body').removeClass('modal-open');
			$('.modal-backdrop').remove();
		});
		
		
		
		// 채팅방 나가기 확인 버튼 클릭시 함수
		$("#escapeChatOkBtn").on("click", function(){
			
			$("#escapeChatRoomBtn").modal("hide");
			
			$("#chat").html("");
			$("#alertsDropdownChat").hide();
			$("#chat").html("");
			$("#chatTitleName").html("sendbox chat");
		
			$("#message").hide();
			$("#sendChatBtn").hide();
			
			$.ajax({
				url		: "/chat/delChatInfoEmp",
				data	: { chatrmId : chatRoomId },
				dataType: "json",
				method	: "post",
				success	: function(data){
					
					
					$("#escapeChatModal").fadeOut();
					
					$.ajax({
						url		: "/chat/mychatList",
						data	: { empId : "${EMP.empId}" },
						dataType: "json",
						method	: "post",
						success	: function(data){
							
							$("#chat").html("");
								
							var chatRMInfo = "";
							
							// 해당 사원의 채팅방 리스트를 반환하는 함수
							chatRMInfo = chatRMInfoList(data);
							
							
							$("#chatRoomList").html(chatRMInfo);
							$("#container").show(200);
							
							chatShowStatus = false;
							
							$("#alertsDropdownChat").hide();
							$("#chat").html("");
							$("#chatTitleName").html("sendbox chat");
							$("#message").hide();
							$("#sendChatBtn").hide();
							
							webSocket._sendMessage('${EMP.empNm}님이 방을 나가셨습니다.');
							webSocket.disconnect();
						},
						error	: function(error){
							alert("채팅방 불러오기 실패!");
						}
					});
				},
				error	: function(error){
					alert("채팅방 나가기 실패");
				}
			});
		});
		
		
		
		
		
		
		
		
		// 채팅방 설정메뉴에서 설정버튼을 클릭했을 경우 실행하는 함수
		$("#chatRoomSetting").on("click", function(){
			
			// 해당 채팅방의 접속인원 정보
			$.ajax({
				url		: "/chat/searchChatRMInfo",
				data	: { chatrmId : chatRoomId },
				dataType: "json",
				method	: "post",
				success	: function(data){
					var dbChatRoom = data.dbChatRoom;
					console.log("dbChatRoom : ", dbChatRoom);
					
					$("#charRMName").val(dbChatRoom.chatrmNm);
					$("#chatRoomHeadCnt").text(dbChatRoom.headcount+"명");
					$("#chatrmId").val(dbChatRoom.chatrmId);
				},
				error	: function(error){
					alert("error code : ", error.status);
				}
			})
		});
		
		// 채팅방 이름 변경 버튼 클릭 함수
		$("#updateChatRMInfoBtn").on("click", function(){
			
			var chatRoomId = $("#chatrmId").val();
			var chatRoomNm = $("#charRMName").val();
			$.ajax({
				url		: "/chat/updateChatRMInfo",
				data	: { chatrmId : chatRoomId,
							chatrmNm : chatRoomNm },
				dataType: "json",
				method	: "post",
				success	: function(dataA){
					
					var temp = "";
					$.ajax({
						url		: "/chat/mychatList",
						data	: { empId : "${EMP.empId}",
									chatrmNm : temp },
						dataType: "json",
						method	: "post",
						success	: function(data){
							$("#chat").html("");
							console.log(data.chatRoomList);
							var chatRMInfo = "";
							// 해당 사원의 채팅방 리스트를 반환하는 함수
							chatRMInfo = chatRMInfoList(data);
							$("#chatTitleName").html("sendbox chat");
							$("#chatRoomList").html(chatRMInfo);
							$("#alertsDropdownChat").hide();
							$("#message").hide();
							$("#sendChatBtn").hide();
						},
						error	: function(error){
							alert("채팅방 불러오기 실패!")
						}
					});

				},
				error	: function(error){
					alert("error : 채팅방 이름 수정 실패");
				}
			});
			$("#chatRoomSettingModal").modal("hide");
		});
	});
	
	// 초대한 사원 채팅 표시
	function chatInfoListReload(empInfo){
		
		console.log("empInfo = ", empInfo)
		
		var empIdArr = empInfo.empIdList;
		var empNmArr = empInfo.empNmList;
		
		console.log("empNmArr = ", empNmArr);
		console.log("empIdArr = ", empIdArr);
		
		for(var i=0; i<empNmArr.length; i++){
			webSocket._sendMessage("invite:~:"+empNmArr[i]+"님이 입장하셨습니다.:~:"+empIdArr[i]+":~:"+empNmArr[i]);
		}
		
		// 해당 채팅방의 채팅로그 정보 리스트 출력 함수
		webSocket.disconnect();
		viewChatInfoList();
	}
	
	
	
	
	
	
	
	
	// 해당 사원의 채팅방 리스트를 반환하는 함수
	function chatRMInfoList(data){
		
		var chatRMInfo = "";
		
		var inputText = "";
		if(data.searchChatRoomNm != null && data.searchChatRoomNm != ""){
			inputText = data.searchChatRoomNm;
		}
		$.each(data.chatRoomList, function(){
			chatRMInfo += "<li id='chatAlarm_"+this.chatrmId+"' class='chatrmId' data-roomid='"+this.chatrmId+"' data-roomname='"+this.chatrmNm+"'>";
			chatRMInfo += "	<div>";
			chatRMInfo += "		<h2>"+this.chatrmNm;
			chatRMInfo += "	<span id='CRMACnt' class='badge badge-danger badge-counter'></span>";
			chatRMInfo += "		</h2>";
			chatRMInfo += "		<h3>";
			chatRMInfo += "			<span class='chatRoomLine'></span>";
			chatRMInfo += "		</h3>";
			chatRMInfo += "	</div>";
			chatRMInfo += "</li>";
		});
		return chatRMInfo;
	}
	
	
	
	// 해당 채팅방의 채팅로그 리스트 정보 출력 함수
	function viewChatInfoList(){
		$.ajax({
			url		: "/chat/chatInfoList",
			data	: { chatrmId : chatRoomId },
			dataType: "json",
			method	: "post",
			success	: function(data){
				
				chatShowStatus = true;
				
				$("#message").show();
				$("#sendChatBtn").show();
				
				webSocket.init({ url : "<c:url value='/socketChat'/>" });
				
				$("#chat").html();
				console.log(data.chatInfoList)
				
				var chatInfo = ""; 
				$.each(data.chatInfoList, function(){
					
					
					var dateInfo = this.chatDt;
					let today = new Date(dateInfo);   

					let year = today.getFullYear(); // 년도
					let month = today.getMonth() + 1;  // 월
					let date = today.getDate();  // 날짜
					let day = today.getDay(); // 요일
					let hours = today.getHours(); // 시
					let minutes = today.getMinutes();  // 분
					
					// 월, 일, 시간, 분이 한자리 수라면 2자리 형태로 변경
					if(month/10 < 1){
						month = "0" + month;
					}
					if(date/10 < 1){
						date = "0" + date;
					}
					if(hours/10 < 1){
						hours = "0" + hours;				
					}
					if(minutes/10 < 1){
						minutes = "0" + minutes;
					}
					
					var newHour = "";
					if(parseInt(hours) > 12){
						newHour = "오후 "+parseInt(hours-12);
					}else{
						newHour += "오전 "+hours;
					}
					
					if(this.empId == '${EMP.empId}'){
						chatInfo += "<li class='me'>";
						chatInfo += "	<div class='entete'>";
						chatInfo += "		<h2><img class='rounded-circle chatProfile' src='/profileImgView?empId="+this.empId+"'/></h2>";
						chatInfo += "		<h2 class='empInfo'>"+this.empNm+"</h2>";
						chatInfo += "	<div class='triangle'></div>";
						chatInfo += "	<span class='timeSpan me'>"+newHour+":"+minutes+"</span><div class='message'>"+this.chatCont+"</div>";
						chatInfo += "</li>";
					}else{
						chatInfo += "<li class='others'>";
						chatInfo += "	<div class='entete'>";
						chatInfo += "		<h2><img class='rounded-circle chatProfile' src='/profileImgView?empId="+this.empId+"'/></h2>";
						chatInfo += "		<h2 class='empInfo'>"+this.empNm+"</h2>";
						chatInfo += "	<div class='triangle'></div>";
						chatInfo += "	<div class='message'>"+this.chatCont+"</div><span class='timeSpan others'>"+newHour+":"+minutes+"</span>";
						chatInfo += "</li>";
					}
					
				});
				$("#chat").html(chatInfo);
				$("#chatTitleName").html(chatRoomName);
				$("#alertsDropdownChat").show();
				selectAlarmEmp();
				
				var id = "#chatAlarm_"+chatRoomId+" div h2 span#CRMACnt";
				$("#chatRoomList").find(id).text("");
				
				var divChat = document.getElementById('chat');
				$('#chat').animate({
			        scrollTop: divChat.scrollHeight - divChat.clientHeight + 100
			    }, 100);
			},
			error	: function(error){
				alert("채팅방 불러오기 실패!")
			}
		});
	}
	
	
	
	
	
	
	
	
	// 채팅방 리스트 정보 리로드
	function chatRoomsReload(){
		
		$.ajax({
			url		: "/chat/mychatList",
			data	: { empId : "${EMP.empId}" },
			dataType: "json",
			method	: "post",
			success	: function(data){
			
				$("#chat").html("");
			
				console.log(data.chatRoomList);
			
				var chatRMInfo = "";
				$.each(data.chatRoomList, function(){
					chatRMInfo += "<li id='chatAlarm_"+this.chatrmId+"' class='chatrmId' data-roomid='"+this.chatrmId+"' data-roomname='"+this.chatrmNm+"'>";
					chatRMInfo += "	<div>";
					chatRMInfo += "		<h2>"+this.chatrmNm;
					chatRMInfo += " <span id='CRMACnt' style='width: 5px; height: 5px; font-size: 5px;' class='badge badge-danger badge-counter'></span>";
					chatRMInfo += "		</h2>";
					chatRMInfo += "		<h3>";
					chatRMInfo += "			<span class='chatRoomLine'></span>";
					chatRMInfo += "		</h3>";
					chatRMInfo += "	</div>";
					chatRMInfo += "</li>";
				});
			
				$("#chatRoomList").html(chatRMInfo);
				$("#container").show(200);
				
				chatShowStatus = false;
			
				$("#alertsDropdownChat").hide();
			},
			error	: function(error){
				alert("채팅방 불러오기 실패!")
			}
		});
	}
</script>



<!-- Footer -->
<footer class="sticky-footer bg-white" style="position: relative;">

	<div style="position: fixed; right: 20px; bottom:20px;">


		<div id="container">
		
			<aside>
				<ul id="searchLine" style="height: 60px;">
					<li>
						<div style='margin-left: 5px; margin-right: 0px;'>
							<input type="text" id="searchRoomName" placeholder="채팅방 이름 검색"/>
						</div>
					</li>
				</ul>
				<ul id="chatRoomList" style="margin-top: 1px;"></ul>
			</aside>
			
			
			<main>
			
				<header>
					<div style="height: 50px;">
						<span id="chatTitleName" style="float: left; width: 250px; text-align: left;">sendbox chat</span>
						
							<i class="nav-link fas fa-cog" href="#" id="alertsDropdownChat" 
								role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" 
								style="font-size: 20px; color: gray; padding: 0px; float: right; margin-left: 20px;"></i> 
							<!-- Dropdown - Alerts -->
							<div id="chatDropDownMenu" class="dropdown-list dropdown-menu dropdown-menu-right shadow" 
								aria-labelledby="alertsDropdownChat">
								<!-- 메뉴 상단바 -->
								<h6 class="dropdown-header" style="color : white; background-color: #b5b5b5; border: none;">SETTING</h6>
								<!-- 메뉴 내용 -->
								<div id="menuListDiv"  style="margin: 10px; margin-left: 10px;">
									<li id="escapeCRLi" data-toggle="modal" data-target="#escapeChatRoomBtn">대화방 나가기</li>
									<hr>
									<li id="addEmpBtn">초대하기</li>
									<hr>
									<li id="chatRoomSetting" data-toggle="modal" data-target="#chatRoomSettingModal">설정</li>
								</div>
							</div>
							
							<i type="button" id="showMyAddrBtn" class="fas fa-address-book" 
							style="font-size: 20px; color: gray; float: right; margin-left: 20px;"></i>
						</span>
					</div>
				</header>
				
				
					
				<ul id="chat"></ul>


				<footer>
					<textarea id="message" placeholder="Type your message"></textarea>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" id="sendChatBtn" class="btn btn-outline-success sendBtn"
						value="send" />
				</footer> 
			</main>
		</div>

		<div style="position: fixed; right: 20px; bottom:20px;">
			<i type="button" class="fas fa-fw fa-comments" id="chatBoardViewBtn" style="font-size: 40px; color: gray;"></i>
			<!-- 채팅알림 숫자 -->
			<span id="chatAlarmCount" style="margin-left: -18px; float: right; position: absolute;" class="badge badge-danger badge-counter"></span>
		</div>
	</div>
	
	
	
	
	
	<!-- Modal -->
	<div class="modal fade" id="escapeChatRoomBtn" tabindex="-1" role="dialog" aria-labelledby="escapeModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="escapeModalLabel">채팅방에서 나가시겠습니까?</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <div align="center">
	        	<p>채팅방을 나가면 당신의 해당 채팅방의 모든기록이 삭제됩니다.</p>
	        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	        <button type="button" id="escapeChatOkBtn" class="btn btn-primary">나가기</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	
	
	
	<!-- Modal -->
	<div class="modal fade" id="chatRoomSettingModal" tabindex="-1" role="dialog" aria-labelledby="chatRoomSettingModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="chatRoomSettingModalLabel">채팅방 설정</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <div align="center">
	        	<input type="hidden" id="chatrmId" name="chatrmId" />
				<table>
					<tr class="chatInfoTr">
						<td>방이름</td>
						<td><input type="text" id="charRMName" name="chatrmNm" /></td>
					</tr>
					<tr class="chatInfoTr">
						<td>방 접속 인원</td>
						<td id="chatRoomHeadTd"><span id="chatRoomHeadCnt"></span></td>
					</tr>
				</table>
	        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" id="updateChatRMInfoBtn" class="btn btn-primary">확인</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	
	
    	
    <div class="container my-auto" style="height: 40px; margin-bottom: 0px;">
        <div class="copyright text-center my-auto" style="height: 100%; margin-top: 20px;">
            SENDBOX &copy; 2020
        </div>
    </div>
  
</footer>
<!-- End of Footer -->
<script>


	//알람 정보 리로드 함수
	function selectAlarmEmp(){
		chatNewArr = [];

		// post, voteEmp, report alarm
		$.ajax({
			url		: "/alarm/selectAlarmEmp",
			dataType: "json",
			method	: "post",
			success	: function(data){
				console.log("alarmList : ", data);
				var myNomalAlarmCnt = 0;
				var alarmInfoList = data.alarmList;
				var alarmTag = "";
				var sender = "";
				console.log("sender : ", sender)
				
				if(alarmInfoList != null && alarmInfoList.length > 0){
					$.each(alarmInfoList, function(i, v){
						
		 				var alarmCont = alarmInfoList[i].alarmCont.split(":+:");
						myNomalAlarmCnt++;
						sender = alarmInfoList[0].alarmSender ;
						alarmTag += "<a class='dropdown-item d-flex align-items-center' href='#' id='"+alarmInfoList[i].alarmSeq+"'";
		                alarmTag += "data-alarmlink='"+alarmInfoList[i].alarmLinkCont+"' data-alarmtype='"+alarmInfoList[i].alarmCont.split(":+:")[0]+"'>";
		                alarmTag += "<div class='dropdown-list-image mr-3'>";
		                alarmTag += "<img class='rounded-circle' src='/profileImgView?empId=";
		           		alarmTag += sender;
		             	alarmTag += "' alt=''>";
		                alarmTag += "</div>";
						
		                if(alarmInfoList[i].alarmSt == "Y"){
			 				alarmTag += "<div class='font-weight-bold'><div class='text-truncate alarmClicked' style='color : blue;'>";
		                }else if(alarmInfoList[i].alarmSt == "C"){
			 				alarmTag += "<div class='font-weight-bold'><div class='text-truncate'>";
		                }
		                
		 				var sendType = "";
		 				if(alarmCont[0] == "post"){
		 					sendType = "댓글"	;					
		 				}else if(alarmCont[0] == "voteEmp"){
		 					sendType = "투표";
		 				}else if(alarmCont[0] == "repCOMPLETE"){
		 					sendType = "기안승인";
		 				}else if(alarmCont[0] == "repNext"){
		 					sendType = "결재대기";
		 				}else if(alarmCont[0] == "repCancel"){
		 					sendType = "기안반려";
		 				}
		 				alarmTag += "["+sendType+"]"+" : "+alarmCont[1];
		 				alarmTag += '</div>';
						
						alarmTag += "<div class='small text-gray-500'>"
	                    alarmTag += alarmInfoList[i].alarmDt;
	                    alarmTag += " / ";
	                    alarmTag += sender;
	                    alarmTag += "@sendbox.com";
	                    alarmTag += "</div></div>"
	    				alarmTag += "</a>";
					});
					console.log("sender : ", sender);
				}else{
					alarmTag += "<div><br><h6 style='text-align : center;'><strong>알람이 없습니다</strong></h6></div>"
				}
					
				if('${EMP.empId}' != sender){
					if(myNomalAlarmCnt > 0){
		 				$("#alarmCntSpan").text(data.alarmCnt);
					}else{
						var alarmTag = "<div><br><h6 style='text-align : center;'><strong>알람이 없습니다</strong></h6></div>"
					}
					$("#alamnListDiv").html(alarmTag);
	 			}
			},
			error	: function(error){
				alert("error : " + error.status);
			}
		});
		
		
		
		// chat alarm
		$.ajax({
			url		: "/alarm/selectChatAlarmEmp",
			dataType: "json",
			method	: "post",
			success	: function(data){
				var myChatAlarmCnt = 0;
				var alarmInfoList = data.alarmList;
				var alarmTag = "";
				console.log("채팅 알람 리스트 : ", alarmInfoList);
				
				if(alarmInfoList != null && alarmInfoList.length > 0){
					$.each(alarmInfoList, function(i, v){
						// 채팅알람의 갯수
						myChatAlarmCnt++;
						// 채팅알람의 방번호의 정보
						chatNewArr.push(alarmInfoList[i].alarmLinkCont.split("&")[0]);
					});
					
					// 방 정보 깊은 복사
					chatAlarmTempInfo = chatNewArr.slice();
					// 방번호 추출(중복제거)
					chatAlarmRoomInfoArr = new Set(chatAlarmTempInfo);
					console.log("방번호 추출(중복제거) = ", chatAlarmRoomInfoArr);
					
					// 추출된 Set객체를 배열객체로 변환
					const chatTempArr = Array.from(chatAlarmRoomInfoArr);
					chatAlarmArr = [];
					for(var i=0; i<chatTempArr.length; i++){
						var chatRMInfo = chatTempArr[i].split("=")[1];
						console.log("방번호 = ", chatRMInfo);
						
						var chatAlarmCnt = 0;
						for(var j=0; j<chatNewArr.length; j++){
							if(chatRMInfo == chatNewArr[j].split("=")[1]){
								chatAlarmCnt++;
							}
						}
						// 해당 채팅방 번호와 새로온 채팅의 갯수
						chatAlarmArr.push(chatRMInfo+":+:"+chatAlarmCnt);
					}
					
					// 방 id의 태그에 채팅 알람 정보 입력
					for(var i=0; i<chatAlarmArr.length; i++){
						var chatRoomInfo = chatAlarmArr[i].split(":+:");
						var chatRMId = chatRoomInfo[0];
						var chatRMCnt = chatRoomInfo[1];
						var id = "#chatAlarm_"+chatRMId+" div h2 span#CRMACnt";
						console.log("id 정보 = ", id);
						console.log("test");
						
						if(parseInt(chatRMCnt) > 0){
							$("#chatRoomList").find(id).text(chatRMCnt);
						}else{
							$("#chatRoomList").find(id).text("");
						}
					}
				}
				if(myChatAlarmCnt > 0){
					$("#chatAlarmCount").text(myChatAlarmCnt);
				}else{
					$("#chatAlarmCount").text("");
				}
			},
			error	: function(error){
				alert("error exception !!!");
			}
		});
	}


</script>

