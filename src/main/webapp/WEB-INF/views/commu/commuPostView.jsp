<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>게시글</title>

    <!-- Custom styles for this page -->
    <link href="/admin2form/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	
	<!-- Bootstrap core JavaScript-->
<!-- 	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	
	
	<!-- Custom fonts for this template -->
    <link href="/admin2form/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
          rel="stylesheet">
	
    
<script>
    $(document).ready(function() {
        $('#summernote').summernote({
        	height: null,                 // 에디터 높이
			minHeight: 300,             // 최소 높이
			maxHeight: null,             // 최대 높이
			focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
			lang: "ko-KR",					// 한글 설정
			toolbar: [],
			disableResizeEditor: false,
			disableDragAndDrop: true
        });
        $("#summernote").summernote('disable');
		$('.note-statusbar').hide();
        
        
        $("#fileAddTD").on("click", ".fileAddBtn", function(){
        	alert("fileAdd");
        	var tag = '<div class="col-sm-10 fileDiv" style="margin-bottom : 5px;">';
        	tag += '<input type="file" name="realfilename">';
        	tag += ' <input class="btn btn-primary fileAddBtn" type="button" value="+" style="outline: 0; border: 0; color: white; font-size:15px;">';
        	tag += ' <input class="btn btn-primary fileSubBtn" type="button" value="-" style="width : 32px; outline: 0; border: 0; color: white; font-size:15px; background: red;">';
        	tag += '</div>';
        	$("#fileAddTD").append(tag);
        });
        
        
        $("#fileAddTD").on("click", ".fileSubBtn", function(){
        	$(this).parents(".fileDiv").remove();
        });
        
        
        $("#updateBoardBtn").on("click", function(){
			document.location = "/commu/updateBoardView?boardSeq=${commuBoard.boardSeq}";
        });
        
        $("#backBtn").on("click", function(){
        	document.location = "/commu/commuBoardList?commuSeq=${commuBoard.commuSeq}";
        });
        
        $("#delBoardBtn").on("click", function(){
        	document.location = "/commu/deleteCommuBoard?boardSeq=${commuBoard.boardSeq}&commuSeq=${commuBoard.commuSeq}";
        });
        
        
        $("#repleInsertBtn").on("click", function(){
        	
        	var message = $("#repleContent").val();
        	
        	var commuEmpId = "${commuBoard.empId}";
        	var dbEmpId = "${EMP.empId}";
        	if(message != ""){
       			if(commuEmpId != dbEmpId){
           			// 채팅알람을 모든인원의 알람테이블에 저장(insert)
                	if(message.length > 10){
        				message  = message.split(0, 10) + "...";
        			}
        			var alarm_cont = "post" + ":+:" + message;
        			console.log(alarm_cont);
        			console.log("${commuBoard.empId}");
        			console.log($("#commuBoardEmpId").val());
        			var commuBoardAlarmLink = "/commu/commuPostView?boardSeq=${commuBoard.boardSeq}";
        			$.ajax({
        				url		: "/alarm/alarmPostInsert",
        				data	: { receiverId 		: '${commuBoard.empId}',
        							alarmCont 		: alarm_cont,
        							alarmLinkCont	: commuBoardAlarmLink },
        				dataType: "json",
        				method	: "post",
        				success	: function(data){
        					sendMessage("post" + "," + "${EMP.empId}" + "," + "${commuBoard.empId}" + "," + "댓글" + "," + "댓글작성입니다.");
        				},
        				error	: function(error){ alert("error : " + error.status); }
        			});
       			}
       			$("#repleWriteForm").submit();
           	}else{
           		alert("댓글 내용을 작성해주세요.")
           	}
        });
        
        repleSeq = "";
        $(".delRepleBtn").on("click", function(){
        	repleSeq = $(this).parents(".showRepleDiv").find(".repleSeq").val();
        });
        
        $("#delRepleModalBtn").on("click", function(){
        	document.location = "/commu/deleteCommuReple?repleSeq="+repleSeq+"&boardSeq=${commuBoard.boardSeq}";
        });
        
    });
    
</script>
<style>
	
	.note-editable{
		height: auto;
	}
	.vl {
	  float : left;
	  text-align: center;
	}
	#d1{
	  border-left: 2px solid gray;
	}
	
	.front{
		text-align: center;
		font-family: 'Nanum Gothic', sans-serif;
		width: 200px;
	}
		
	table {
	    width: 100%;
	    border-top: 3px solid #858796;
	    border-collapse: collapse;
  	}
  	th, td {
	    border-bottom: 1px solid #858796;
	    padding: 10px;
  	}
  	#repleInsertBtn{
  		height: 75px;
  		font-size: 20px;
  		vertical-align: top;
  	}
  	#repleContent{
  		width: 92%;
  		padding: 15px;
  	}
  	.showRepleDiv{
  		margin-bottom: 2px;
  		width: 98%;
  	}
</style>
</head>

<body id="page-top">
    <!-- Page Wrapper -->
    <div id="wrapper">
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content">
                <!-- Begin Page Content -->
                <div class="container-fluid"  style="max-width: 90%;">
                    <!-- Page Heading -->
                    <h2 class="h3 mb-2 text-gray-800" style="display: inline;"><i class="fas fa-inbox" style="margin-left: 10px; "></i>&nbsp&nbsp ${commuBoard.boardTitle }</h2>
                    <hr>
                    <br>
                    <!-- summernote -->
					<form action="" method="post" enctype="multipart/form-data">
	                    <table style="width:100%;" id="boardViewTable">
	                    	<tr>
	                    		<td class="front">제목</td>
	                    		<td>
	                    			<span>${commuBoard.boardTitle }</span>
	                    		</td>
	                    	</tr>
	                    	<tr>
	                    		<td class="front">작성자</td>
	                    		<td>
	                    			<span>${commuBoard.empNm } ${empTitle }</span>
	                    		</td>
	                    	</tr>
							<tr>
								<td class="front"><i class="fas fa-fw fa-paperclip" style="margin-left: 10px;"></i>첨부파일</td>
								<td id="fileAddTD">
								
									<!-- db에서 파일 가져오기 -->
									<div id="DBfileDivParent" class="col-sm-10 DBfileAddedDiv" style="margin-bottom : 5px;">
										<c:if test="${commuBoardFileList.size() > 0}">
											<c:forEach var="i" begin="0" end="${commuBoardFileList.size()-1}" step="1">
												<div class="DBfileDivChild" data-fileid="${commuBoardFileList.get(i).attachfileSeq }">
													<a href="/commu/fileDown?attachfileSeq=${commuBoardFileList.get(i).attachfileSeq}&boardSeq=${commuBoardFileList.get(i).boardSeq}">${commuBoardFileList.get(i).realfilename}</a>
												</div>
											</c:forEach>
										</c:if>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2">
								 	<textarea id="summernote" name="boardContent">${commuBoard.boardCont }</textarea>
								</td>
							</tr>
							</table>
						 	<br>
						 	
						 	<input type="hidden" name="commuSeq" value="${commuBoard.commuSeq }"/>
						 	<input type="hidden" name="boardTitle" value="${commuBoard.boardTitle }"/>
						 	<input type="hidden" name="boardSeq" value="${commuBoard.boardSeq }"/>
						 	
						 	
						 	<input id="backBtn" type="button" class="btn btn-left" value="목록" 
						 	style="display:inline; margin-right: 10px; float: left; background: #104467; color: white;"/>
						 	<c:if test="${EMP.empId == commuBoard.empId}">
							 	<input type="button" id="updateBoardBtn" class="btn btn-warning" value="수정" style="float: right; margin-left: 10px;"/>
							 	<input type="button" data-toggle="modal" data-target="#delBoardModal" class="btn btn-danger" value="삭제" style="float: right;"/>
						 	</c:if>
						</form>
						
						<br><br><br>
						
		                <div id="repleDivParent">
		                	<div id="repleDivHeader"><span>댓글 목록</span></div>
		                	<hr>
							<div id="repleDivBody" style="margin-left: 3%;">
								<c:if test="${repleList.size() > 0}">
									<c:forEach var="i" begin="0" end="${repleList.size()-1}" step="1">
										<div class="showRepleDiv" 
											style="color: black; background: #F1F1F1; border-radius: 20px; padding: 20px; font-size: 15px; font-family: inherit;">
											<input type="hidden" class="repleSeq" name="repleSeq" value="${repleList.get(i).repleSeq }" />
											${repleList.get(i).empNm } ${commuRepleEmpTitleList.get(i) }
											<div style="float: right;">
												작성일자 : <fmt:formatDate value="${repleList.get(i).repleDt }" pattern="YYYY-MM-dd"/>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<c:if test="${repleList.get(i).empId == EMP.empId}">
													<c:if test="${repleList.get(i).repleSt == 'Y' }">
														<button type="button" class="btn btn-danger delRepleBtn" 
														 data-toggle="modal" data-target="#delRepleModal"
														style="float: right; margin-right: 5px; margin-top: -5px;">삭제</button>											
													</c:if>
												</c:if>
											</div>
											
											<br><br>
											<c:choose>
												<c:when test="${repleList.get(i).repleSt == 'Y'}">
													<span>${repleList.get(i).repleCont }</span>
												</c:when>
												<c:when test="${repleList.get(i).repleSt == 'N'}">
													<span>삭제된 댓글 입니다.</span>
												</c:when>
											</c:choose>
										</div>
										<br>
									</c:forEach>
								</c:if>
							</div>
		                	<hr>
							<form id="repleWriteForm" action="/commu/repleRegist" method="post">
								<input type="hidden" name="boardSeq" value="${commuBoard.boardSeq }"/>
								<input type="hidden" id="commuBoardEmpId" name="empId" value="${commuBoard.empId }"/>
								<div id="writeRepleDiv" style="margin-left: 3%;">
									<textarea id="repleContent" name="repleCont" rows="2" cols="10" style="resize: none;"></textarea>
									<button type="button" id="repleInsertBtn" class="btn"style="background-color: white;">등록</button>
								</div>
							</form>
		                	<hr>
		                </div>
		                
		                
		                
		                <!-- post delete Modal -->
						<div class="modal fade" id="delBoardModal" tabindex="-1" role="dialog" aria-labelledby="delBoardModalLabel" aria-hidden="true">
						  <div class="modal-dialog" role="document">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title" id="delBoardModalLabel">게시글 삭제</h5>
						        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						          <span aria-hidden="true">&times;</span>
						        </button>
						      </div>
						      <div class="modal-body">
						        <div align="center">
						        	<p>정말로 게시글을 삭제하시겠습니까?</p>
						        </div>
						      </div>
						      <div class="modal-footer">
						        <button type="button" id="delBoardBtn" class="btn btn-danger">삭제</button>
						        <button type="button" class="btn" data-dismiss="modal" style="background: #104467; color: white;">취소</button>
						      </div>
						    </div>
						  </div>
						</div>
						
						
						
						
						<!-- reple delete Modal -->
						<div class="modal fade" id="delRepleModal" tabindex="-1" role="dialog" aria-labelledby="delRepleModalabel" aria-hidden="true">
						  <div class="modal-dialog" role="document">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title" id="delRepleModalabel">댓글 삭제</h5>
						        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						          <span aria-hidden="true">&times;</span>
						        </button>
						      </div>
						      <div class="modal-body">
						        <div align="center">
						        	<p>정말로 댓글을 삭제하시겠습니까?</p>
						        </div>
						      </div>
						      <div class="modal-footer">
						        <button type="button" id="delRepleModalBtn" class="btn btn-danger">삭제</button>
						        <button type="button" class="btn" data-dismiss="modal" style="background: #104467; color: white;">취소</button>
						      </div>
						    </div>
						  </div>
						</div>
				
				
				
				
				
				<!-- End summernote -->
                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->
            
            
            	

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
<!--     <a class="scroll-to-top rounded" href="#page-top"> -->
<!--         <i class="fas fa-angle-up"></i> -->
<!--     </a> -->

    
</body>
