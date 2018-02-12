<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>월 근태 현황</title>
<script>

	/* 근무년월 달력 함수 */
	$(function () {
		$('#workingYearMonth').datetimepicker({ //근무년월 달력
			viewMode: 'days',
			format: 'YYYY-MM'
		});
		$('#attdStatId').val(moment().format('YYYY-MM'));
	});

	/* 사원번호 선택 Modal 함수 */
	function empModal(url, formId){//모달창을 띄워 사원 list 띄우기
		$('#empModalTbody').empty();//입력되있던 리스트데이터 삭제
		
		paging.ajaxFormSubmit(url, formid, function(rslt){
			console.log("결과데이터 " + JSON.stringify(rslt));
		
			//$('#empModalTable').children('thead').css('width','calc(100% - 1em)'); //테이블 스크롤 css
			
			if(rslt == null){
				$('#empModalTbody').append(
				"조회할 데이터가 없습니다."
				
				);
			}else if(){
				$
			}
			
			
		})//paging.ajax
	}//function empModal
	
	


</script>
</head>
<body>
	<div class="main" style="min-height: 867px;">
		<div class="main-content">
			<div class="container-fluid">
			<h3 class="page-title">월 근태 현황</h3>
				<div class="panel">
					<div class="panel-body">
						<form class="form-inline" name="">	
							<table class="table table-bordered">
								<tr align="center">
									<td>근무년월</td>
									<td align="left">
										<!-- 달력 : 근무년월 -->										
										<div class="input-group date" id="workingYearMonth">
											<input type="text" class="form-control" id="attdStatId" name=""/>
												<span class="input-group-addon">
													<span class="fa fa-calendar" />
												</span>
										</div>
									</td>
									<td>부서</td>  
									<td align="center">
										<select>
										<option value="">전체</option>
										<option value="">인크레파스</option>
										<option value="">인사부</option>
										<option value="">영업부</option>
										<option value="">성실부</option>
										</select>
									</td>
									<td>사원번호</td>
									<td align="left">
										<!-- 사원번호 입력 -->
										<div class="input-group">
											<input type="text" class="form-control" id="empEmno" name="empEmno" placeholder="사번입력  / 검색버튼">
											<span class="input-group-addon">
												<span class="glyphicon glyphicon-search" aria-hidden="true" data-toggle="modal" data-target="#empModal" onClick="empModal"></span> <!-- 검색 아이콘 -->
											</span>
										</div>
										<!-- 검색버튼 -->
										<input type="button" class="btn btn-danger btn-xs" style="float:right;"name="search" value="검색">
									</td>
								</tr>
							</table>
						</form>
					</div>
					<div class="panel-body">
						<h4>◈ 근태현황<h4>
						<table border="1" class="table table-bordered">
						<tr align="center">
							<td>사원번호</td>
							<td>성명</td>
							<td>부서</td>
							<td>직급</td>
						</tr>
						<tr align="center">
							<td> 　　　　 </td>
							<td> 　　　　 </td>
							<td> 　　　　 </td>
							<td> 　　　　 </td>
						</tr>
						</table>
						<table border="1" class="table table-bordered">
							<tr align="center">
								<td> 1</td>
								<td> 2</td>
								<td> 3</td>
								<td> 4</td>
								<td> 5</td>
								<td> 6</td>
								<td> 7</td>
								<td> 8</td>
								<td> 9</td>
								<td> 10</td>
								<td> 11</td>
								<td> 12</td>
								<td> 13</td>
								<td> 14</td>
								<td> 15</td>
								<td> 16</td>
								<td>비고</td>
							</tr>
							<tr align="center">
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>	
								<td rowspan="4"></td>	
							</tr>
							<tr align="center">
								<td>17</td>
								<td>18</td>
								<td>19</td>
								<td>20</td>
								<td>21</td>
								<td>22</td>
								<td>23</td>
								<td>24</td>
								<td>25</td>
								<td>26</td>
								<td>27</td>
								<td>28</td>
								<td>29</td>
								<td>30</td>
								<td>31</td>
								<td rowspan="2"></td>
							</tr>
							<tr align="center">
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
								<td> 　　　　 </td>
							</tr>
						</table>
					</div>
				</div><!-- "panel" -->
			</div>
		</div>
	</div>

	<!-- 사원번호 선택 Modal View -->
	<div id="empModal" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button><!-- 닫기버튼 -->
					<div class="modal-title" align="center"><h2> 사원 정보 조회 </h2></div>
						<div class="modal-body">
					<!-- <div class="search_wrap" style="padding: 0px 10px 20px 15px; "> -->
							<form class="form-inline" id="empFrm">
								검색어 &nbsp;
								<input type="text" class="form-control" name="keyword"> &nbsp;&nbsp;&nbsp;
									<input type="checkbox" id="retrChk">
									퇴직자포함
								<input type="button" class="btn btn-danger btn-xs" style="float:right;"name="attendance" value="검색" onClick="empModal">
							</form>
						<div class="">
							<table border="1" class="table tablesorter table-bordered" id="">
								<thead>
									<tr align="center">
										<th></th>
										<th>사원번호</th>
										<th>이름</th>
										<th>부서</th>
										<th>직급</th>
									</tr>
								</thead>
								<tbody id="empModalTbody" style="display:block;height:200px; overflow:auto;"><!-- overflow:auto 스크롤 사용시 필요-->
								
								
								
								
								
								
								</tbody>
							</table>
						</div>	
					</div>
				</div>
			</div>
		</div>
	</div>
	<p>
</body>
</html>

