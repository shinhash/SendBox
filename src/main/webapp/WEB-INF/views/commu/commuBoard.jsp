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
	<title>${commuNm }</title>

<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
      rel="stylesheet">

<style type="text/css">
	
	#dataTable_filter{
		width: 200px;
		float: right;
	}
	#dataTable_filter{
		
	}
	label {
		width: 200px;
	}
	#subscriptBtn{
		background: white;
		color: blue;
		border: 0px none white;
	}
	
	#starBtn:hover {
		background-size: 1.5em;
	}
	
	#BookMark:hover{
		color: #ffe812;
	}
	
	
	
	
	
	
	
	
	/* 커뮤니티 td 길이 */
	.boardNum{
		width: 5%;
		text-align: center;
	}
    .boardTitle{
    	width: 35%;
    }
    .boardWriter{
    	width: 8%;
		text-align: center;
    }
    .boardEmpJobTitle{
		width: 6%;
		text-align: center;
	}
	.boardEmpDeptNm{
		width: 8%;
		text-align: center;
	}
	.boardEmpTeamNm{
		width: 8%;
		text-align: center;
	}
    .boardDate{
    	width: 10%;
		text-align: center;
    }
    
                             
    .commuTitleLineTr{
    	background: #303A71;
    }
	.commuBoardLineTr:hover {
		background: #C3C5D2;
	}
	
</style>



<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<script>

	$(function(){
		
		$("#insertCommuPostBtn").on("click", function(){
			document.location = "/commu/commuPostInsertView?commuSeq=${param.commuSeq}";
		});
		
		$("#subscriptBtn").on("click", function(){
			$(this).css({background : "blue", color : "white"});
		});
		
		$("#CommuBoardTableBody").on("click", ".delBoard", function(){
			alert("삭제된 게시글 입니다.")
		});
		
		
		
		
		
		$("#BookMark").on("click", function(){
			var commuSeq = $(this).data("commuid");
			var commuNm = $(this).data("communm");
			//alert("즐겨찾기 추가")
			document.location = "/commu/insertCommuBKMK?commuSeq="+commuSeq+"&commuNm="+commuNm;
		});
		
		
		
		$("#unBookMark").on("click", function(){
			var commuSeq = $(this).data("commuid");
			//alert("즐겨찾기 삭제")
			document.location = "/commu/deleteCommuBKMK?commuSeq="+commuSeq;
		});
		
		
		
		$('#recordCnt').val("${pagination.recordCountPerPage}");
		$("#searched").val("${searchKeyword}");
		
		console.log("searchCondition = " + "${searchCondition}");
		
		if("${searchCondition}" == ""){
			$("#searchCondition").val("board_title")
		}else{
			$("#searchCondition").val("${searchCondition}");				
		}
		
		
		
		$('#recordCnt').on('change', function(){
			console.log('record changed');
			console.log($(this).val());
			recordCnt = $(this).val();
			document.location = "/commu/commuBoardList?commuSeq=${commuSeq }&recordCountPerPage="+recordCnt;
		});
		
		
		
		$('#btnSearch').on('click', function(){
			console.log('searching...');
			var recordCnt = $("#recordCnt").val();
			var searchCondition = $('#searchCondition').val();
			var searchKeyword = $('#searched').val();
			
			
			document.location = "/commu/commuBoardList?commuSeq=${commuSeq }&recordCountPerPage="+recordCnt+"&searchCondition="+searchCondition+"&searchKeyword="+searchKeyword;
		});
	});

</script>
</head>



<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">


        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">
            
            
            
            	<!-- Begin Page Content -->
                <div class="container-fluid">
                    <!-- Page Heading -->
                    <h2 class="h3 mb-2 text-gray-800"><i class="fas fa-users" style="margin-left: 10px;"></i>&nbsp&nbsp ${commuNm }
	                    
	                    <c:choose>
	                    	<c:when test="${dbCommuBkmk != null}">
	                    		<i type="button" id="unBookMark" data-commuid="${commuSeq }" 
	                    		class="fas fa-star" style="float: right; margin-right: 50px; color: #ffe812;"></i>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<i type="button" id="BookMark" data-commuid="${commuSeq }" data-communm="${commuNm }"
	                    		class="fas fa-star" style="float: right; margin-right: 50px;"></i>
	                    	</c:otherwise>
	                    </c:choose>
	                    
	                    
                    </h2>
                    
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
<!--                             <h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-fw fa-head-side-cough-slash" style="margin-left: 10px;"></i>&nbsp업무시간 마스크는 필수입니다.</a></h6> -->
                        </div>
                        <div class="card-body">
                        
                        
                            <div class="table-responsive" style="overflow: hidden;">
                            
                            	<div class="row">
                            	
                            	
                            	
                            		<!-- search line -->
									<div class="col-sm-12 col-md-5">
										<div class="dataTables_length" id="dataTable_length">
											<i class="fas fa-th-large" style="display: inline;"></i>
											<label>
												<select id="recordCnt" name="recordCountPerPage" aria-controls="dataTable" 
												class="custom-select custom-select-sm form-control form-control-sm">
													<option class="cnt" value="5" selected>5개씩 보기</option>
													<option class="cnt" value="10">10개씩 보기</option>
													<option class="cnt" value="15">15개씩 보기</option>
													<option class="cnt" value="20">20개씩 보기</option>
												</select>
											</label>
										</div>
									</div>
									 <div class="col-sm-12 col-md-7"  style="display: inline-block;">
										<div id="" class="dataTables_filter" style="float: right;">
											검색조건 : 
											<select id="searchCondition" name="searchCondition" 
											class="custom-select custom-select-sm form-control form-control-sm" style="width: 100px;">
												<option value="board_title" selected>제목</option>
												<option value="emp_nm">작성자</option>
											</select>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<i class="fas fa-search" style="display: inline;"></i>검색 : 
											<input type="text" id="searched" name="searchKeyword" class="form-control form-control-sm" style="width: 200px; display: inline;">
											<button type="button" id="btnSearch" class="btn" style="display:inline; background: #303A71; color: white;">검색</button>
											&nbsp;&nbsp;
										</div>
									</div>
								</div>
                            
                            	<br>
                            	
                            	<!-- table show line -->
                                <table class="table" width="100%" cellspacing="0">
                                    <thead style="text-align: center;">
                                        <tr class="commuTitleLineTr" style="color: white;">
                                            <th>NO</th>
                                            <th style="text-align: center;">제목</th>
                                            <th>작성자</th>
                                            <th>직급</th>
                                            <th>부서명</th>
                                            <th>팀명</th>
                                            <th>등록일</th>
                                        </tr>
                                    </thead>
                                    <tbody id="CommuBoardTableBody"  style="text-align: center;">
                                    
                                  		<c:choose>
											
                                  			<c:when test="${commuBoardList.size() > 0}">
	                                   			<c:forEach var="i" begin="0" end="${commuBoardList.size()-1}" step="1">
												<tr class="commuBoardLineTr">
													<td class="boardNum">${i + 1 + boardFrontNum}</td>
													<td class="boardTitle"  style="text-align: left;">
													<c:choose>
														<c:when test="${commuBoardList.get(i).boardSt == 'Y'}">
															<a href="/commu/commuPostView?boardSeq=${commuBoardList.get(i).boardSeq}&commuSeq=${commuBoardList.get(i).commuSeq}">${commuBoardList.get(i).boardTitle }</a>
														</c:when>
														<c:when test="${commuBoardList.get(i).boardSt == 'N'}">
															<a href="#" class="delBoard">삭제된 게시글 입니다.</a>														
														</c:when>
													</c:choose>
													</td>
													<td class="boardWriter">${commuBoardList.get(i).empNm }</td>
													<td class="boardEmpJobTitle">${empTitleList.get(i) }</td>
													<td class="boardEmpDeptNm">${empDeptInfoList.get(i).deptName }</td>
													<td class="boardEmpTeamNm">${empDeptInfoList.get(i).teamName }</td>
													<td class="boardDate">${commuBoardList.get(i).boardDt }</td>
												</tr>
												</c:forEach>
                                  			</c:when>
                                  			
                                  			<c:otherwise>
                                  				<tr>
													<td colspan="7">데이터 없음</td>
												</tr>
                                  			</c:otherwise>
                                  		
                                  		</c:choose>
		                                   	
                                   	
									</tbody>
                                </table>
                                
                                
                                
                                
                                
                            </div>
                            
                            
                            
                            
                            
                            <!-- 페이징 처리  -->
                            <div class="row">
								<div class="col-sm-12 col-md-5">
									<div class="dataTables_info" id="dataTable_info" role="status" aria-live="polite">
									</div>
								</div>
								<div class="col-sm-12 col-md-7">
									<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
										<ul class="pagination">
										
										
										
										
										
											<!-- 좌측 이동 네비게이션 -->
											<c:choose>
												<c:when test="${pagination.currentPageNo == 1 or pagination.currentPageNo == null}">
													<li class="paginate_button page-item previous disabled" id="dataTable_previous">
														<a href="#" aria-controls="dataTable"  class="page-link">
															<i class="fas fa-angle-double-left"></i>
														</a>
													</li>
													<li class="paginate_button page-item previous disabled" id="dataTable_previous">
														<a href="#" aria-controls="dataTable"  class="page-link">
															<i class="fas fa-angle-left"></i>
														</a>
													</li>
												</c:when>
												<c:when test="${commuBoardList.size() > 0}">
													<li class="paginate_button page-item previous" id="dataTable_previous">
														<a href="/commu/commuBoardList?commuSeq=${commuSeq }" aria-controls="dataTable" class="page-link">
															<i class="fas fa-angle-double-left"></i>
														</a>
													</li>
													<li class="paginate_button page-item previous" id="dataTable_previous">
														<a href="/commu/commuBoardList?commuSeq=${commuSeq }&pageIndex=${pagination.currentPageNo-1}" aria-controls="dataTable" class="page-link">
															<i class="fas fa-angle-left"></i>
														</a>
													</li>
												</c:when>
											</c:choose>
											
											
											
											
											
											<c:choose>
											
												<c:when test="${commuBoardList.size() > 0 }">
													<c:forEach begin="${pagination.getFirstPageNoOnPageList() }" end="${pagination.getLastPageNoOnPageList() }" step="1" var="i">
														<c:choose>
															<c:when test="${pagination.currentPageNo == i }">
																<li class="paginate_button page-item active">
																	<a aria-controls="dataTable"  class="page-link">${i }</a>
																</li>
															</c:when>
															<c:otherwise>
																<li class="paginate_button page-item">
																	<a aria-controls="dataTable" class="page-link"
																	href="/commu/commuBoardList?commuSeq=${commuSeq }&pageIndex=${i}&recordCountPerPage=${pagination.recordCountPerPage }&searchCondition=${searchCondition }&searchKeyword=${searchKeyword }">
																	${i }</a>
																</li>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<li class="paginate_button page-item active">
														<a aria-controls="dataTable"  class="page-link">1</a>
													</li>
												</c:otherwise>
											
											</c:choose>
											
											
											
											
											
											
											
											
											
											<!-- 우측 이동 네비게이션 -->
											<c:choose>
												<c:when test="${pagination.currentPageNo == pagination.getTotalPageCount()}">
													<li class="paginate_button page-item next disabled" id="dataTable_next">
														<a href="#" aria-controls="dataTable" class="page-link">
															<i class="fas fa-angle-right"></i>
														</a>
													</li>
													<li class="paginate_button page-item next disabled" id="dataTable_next">
														<a href="#" aria-controls="dataTable" class="page-link">
															<i class="fas fa-angle-double-right"></i>
														</a>
													</li>
												
												
												</c:when>
												<c:otherwise>
													<li class="paginate_button page-item next" id="dataTable_next">
														<a aria-controls="dataTable" data-dt-idx="2" tabindex="0" class="page-link"
														 href="/commu/commuBoardList?commuSeq=${commuSeq }&pageIndex=${pagination.currentPageNo+1}&recordCountPerPage=${pagination.recordCountPerPage }&searchCondition=${searchCondition }&searchKeyword=${searchKeyword }">
															<i class="fas fa-angle-right"></i>
														</a>
													</li>
													<li class="paginate_button page-item next" id="dataTable_next">
														<a aria-controls="dataTable" data-dt-idx="2" tabindex="0" class="page-link"
														 href="/commu/commuBoardList?commuSeq=${commuSeq }&pageIndex=${pagination.getTotalPageCount()}&recordCountPerPage=${pagination.recordCountPerPage }&searchCondition=${searchCondition }&searchKeyword=${searchKeyword }">
															<i class="fas fa-angle-double-right"></i>
														</a>
													</li>
												</c:otherwise>
											</c:choose>
										</ul>
									</div>
								</div>
							</div>
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
							<!-- 글작성버튼 -->
							<input type="button" id="insertCommuPostBtn" class="btn" value="글작성" style="display:inline; float: right; background: #303A71; color: white;">
						</div>
                    </div>

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

    <!-- Core plugin JavaScript-->
    <script src="/admin2form/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/admin2form/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="/admin2form/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="/admin2form/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="/admin2form/js/demo/datatables-demo.js"></script>

</body>

	

	
