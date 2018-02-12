<!-- 
	휴가신청 현황 리스트 - 유성실,신지연
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>휴가신청현황</title>
<link rel="stylesheet" href="/spring/resources/common/css/vacation.css" />
<link rel="stylesheet" href="/spring/resources/common/css/bootstrap2-toggle.min.css" />
<style>
.table > tbody > tr > td { 
	vertical-align: middle;
}
</style>
<script src="/spring/resources/common/js/bootstrap2-toggle.min.js"></script>
<script type="text/javascript">

/* 실행함수 모음 */
$(function(){
	calender();	//달력
	deptSelect();	//부서 셀렉 
	rankSelect();	//직급 셀렉
	situationSelect();	//승인현황 셀렉
	progList();	//승인현황 리스트 ajax
	enterKey();	//검색 후 엔터키
});

/* ajax - list */

function progList() {
			
		paging.ajaxFormSubmit("vacationProgressList.ajax", "f1", function(rslt){
			console.log("ajaxFormSubmit -> callback");
			console.log("결과데이터" + JSON.stringify(rslt));
			
			//이전 리스트 삭제
			$('#deptNameList').empty();	//부서 셀렉박스
			$('#rankNameList').empty();	//직급 셀렉박스
			$('#progressTbody').empty();	//사원 리스트
			
			//테이블 스크롤 
			$('#progressTable').children('thead').css("width","calc(100% - 1.1em)");
			
			//부서명 셀렉박스
			if(rslt.deptNameList == null){
				$('#deptNameList').append("<option value=''>"+ 없음  +"</option>");
			} else {
				$('#deptNameList').append(
					"<option value=''>"+ '부서' +"</option>");
				$.each(rslt.deptNameList, function(k, v){
					$('#deptNameList').append(
						"<option value='"+v.deptCode+"'>"+ v.deptName +"</option>"	
					);
				});//.each.deptName
				$('#deptNameList').val($('#deptHidden').val()).prop("selected", true); //input hidden값 value를 선택
			}//if

			
			//직급명 셀렉박스
			if(rslt.rankNameList == null){
				$('#rankNameList').append("<option value=''>"+ 없음  +"</option>");
			} else {
				$('#rankNameList').append(
					"<option value=''>"+ '직급' +"</option>");
				$.each(rslt.rankNameList, function(k, v){
					$('#rankNameList').append(
						"<option value='"+ v.rankCode +"'>"+ v.rankName + "</option>"		
					);
				});//each.rankName
				$('#rankNameList').val($('#rankHidden').val()).prop("selected", true); //input hidden값 value를 선택
				
			}//if
			
			
			//사원 리스트
			if(rslt.vacationProgressList == null){
				$('#progressTbody').append(
					"<div class='text-center'><br><br><br><br>조회할 자료가 없습니다.</div>"	
				);
			}else{
				$.each(rslt.vacationProgressList, function(index, s){
					$("#progressTbody").append(
						"<tr>" +
							"<td>" +
								"<label class='fancy-checkbox-inline'>" +
									"<input type='checkbox' name='chk' id='chk'>" +
									"<span></span>" +
								"</label>" +
								"<input type='hidden' id='vastSerialNumber' name='vastSerialNumber' value='" + s.vastSerialNumber+ "'>"+
							"</td>" +
							"<td>" + s.empEmno + "</td>" +
							"<td>" + s.empName + "</td>" +
							"<td>" + s.deptName + "</td>" +
							"<td>" + s.rankName + "</td>" +
							"<td>" + s.vastCrtDate + "</td>" +
							"<td>" + s.vastType + "</td>" +
							"<td>" + s.vastTerm + "</td>" +
							"<td>" + s.vastVacUd + "</td>" +
							"<td>" + s.vastCont + "</td>" +
							"<td><input type='checkbox' data-toggle='toggle' name='progToggle' id='progToggle' data-on='완료' data-off='대기' data-onstyle='primary' data-width='75' data-height='30'>"+
						"</tr>"
					);//append		
				
					/* DB에 저장되어있는 '승인완료'를 토글로 나타내기 */
					$("input[type='checkbox'][name=progToggle]").bootstrapToggle();
						var progTr = s.vastProgressSituation;
						if(progTr == "승인완료"){
							var progTd = $("#progressTbody tr:last").children().eq(10);							
							progTd.children().children("#progToggle").prop('checked', true).change();
// 							console.log(progTr);
						} else {
						}//if
				});	//each.List
				
				//table 가운데 정렬
				$('#progressTable').children().addClass('text-center');
				//table sorter
				$(function(){
					$('#progressTable').tablesorter();
				});
				$(function(){
					$('#progressTable').tablesorter({sortList: [[0,0],[1,0]]});
				});
	
			}//if-table 생성
			
		});//paging
}	//ajax로 리스트 불러오기

/*검색 버튼 */
function searchClick(){		
	progList();
};

/* 검색어 입력 후 엔터키 작동 */
function enterKey(){
	$("#keyword").keydown(function(f){
			if(f.keyCode == 13){	//javaScript에서는 13이 enter키를 의미함
			searchClick();
			return false;
		}
	});
}

/* 부서명 셀렉 */
function deptSelect(){
	$("#deptNameList").change(function(){
		//input hidden의 vlaue로 선택한 option을 입력
		$('#deptHidden').val($(this).children("option:selected").select().val()); 
		progList(); //ajax 실행
	});
}
	
/* 직급명 셀렉 */
function rankSelect(){
	$('#rankNameList').change(function(){
// 		$(this).children("option:selected").text();
		$('#rankHidden').val($(this).children("option:selected").select().val());
		progList();	//ajax 실행
	});
}

/* 승인현황 셀렉 */
function situationSelect(){
	$('#situationList').change(function(){
		$('#situationHidden').val($(this).children('option:selected').select().val());
		progList();	//ajax 실행
	});
}

/* month 달력 */
function calender(){
	$('#baseMonth').val(moment().format('YYYY-MM'));	//현재 월로 보여줌
	$('#monthDateTimePicker').datetimepicker({
		viewMode: 'months',
		format: 'YYYY-MM'
	});
	
	//month의 최대값을 현재 월로 제한
	$('#monthDateTimePicker').data("DateTimePicker").maxDate(moment());
};	
	

/* 체크박스 전체선택 */
function checkAllFunc(obj){ //최상단 체크박스를 click하면
	$("input[type='checkbox'][name=chk]").each(function() {
		this.checked = obj.checked;  //name이 chk인 체크박스를 checked로 변경
	})
} 


/* 체크박스 승인완료 버튼 */
function toggleOn(){
	var chk = $("[name=chk]").length; //체크박스 갯수

	$("[name=chk]").each(function() {
		console.log(chk);
		var progTr = $(this).closest('tr'); //체크박스와 가까운 위치의 tr
		var progTd = progTr.children().eq(10); //tr 자식인 7번째 인덱스의 td(토글키 있는 위치의 td)

// 		if(progTd.children().children("#progToggle").is(':checked') == true){
// 			console.log('1');
// 		}
		if($(this).prop('checked')){
			progTd.children().children("#progToggle").prop('checked', true).change();
		}else{
			
		}//if
	});	//name-each
	
}//toggleOn




/* 승인완료 후 저장하기  */
function vacProgSave(){
	
	var progToggleResult;	//체크된 것 저장할 변수
	$("input[type=checkbox][id=progToggle]").each(function(){
		if($(this).prop('checked')){
			
			var chkTr = $(this).closest('tr');	//체크한 것과 가장 가까운 tr
			var chkHi = chkTr.children().children("input[type=hidden][id=vastSerialNumber]").val();//체크한 것의 히든 value 값
			
			if(progToggleResult == null){
				progToggleResult = chkHi;
			} else{
				progToggleResult = progToggleResult +"/"+chkHi;	//히든 value 값을 구분자와 저장
				console.log("저장::"+progToggleResult);
			}
		}//if
	});//input.each
	$('#progToggleResult').val(progToggleResult);
		console.log("저장후::"+$('#progToggleResult').val());
	
	paging.ajaxFormSubmit("vacationProgSave.ajax", "f2", function(rslt){
		console.log("ajaxFormSubmit -> callback");
		console.log("결과데이터" + JSON.stringify(rslt));
		
		if(rslt == null){
			alert("저장에 실패하였습니다. 다시 시도해주세요.")
		} else{
			alert("저장되었습니다.")
			window.location.reload();	//새로고침
		}
	});	//paging.ajax
	
}//vacProgSave


</script>
</head>
<body>
	<div class="main" style="min-height: 867px;">
		<div class="main-content">
			<div class="container-fluid">
			<h3 class="page-title">휴가신청현황</h3>
				<div class="panel panel-headline">
					<div class="panel-body">
						<form class="form-inline" name="f1" id="f1">
<!-- 							<i class="fa fa-asterisk-red" aria-hidden="true" ></i>							 -->
							신청월
							<!-- 달력 -->
							<div class="input-group date" id="monthDateTimePicker">
								<input type="text" class="form-control" id="baseMonth" name="baseMonth"/>
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-calendar"></span> <!-- 달력 아이콘 -->
								</span>
							</div>
						  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="text" class="form-control" name="keyword" id="keyword" placeholder="검색어 입력"> 
							<input type="button" class="btn btn-primary" name="search" value="검색" onclick="searchClick()">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<select name="deptNameList" id="deptNameList" value="부서별" class="form-control"><!-- 부서 -->
							</select> 
							<select name="rankNameList" id="rankNameList" value="직급별" class="form-control"><!-- 직급 -->
							</select>
							<select name="situationList" id="situationList" class="form-control">
								<option value="">결재상태</option>
								<option value="승인대기">승인대기</option>
								<option value="승인완료">승인완료</option>
<!-- 								<option value="cat">반려</option> -->
							</select>
							<input type="hidden" id="deptHidden"><!-- 네임으로 하면 파라미터 값이 넘어감 -->
							<input type="hidden" id="rankHidden">
							<input type="hidden" id="situationHidden"><!-- 결재상태 -->
							<!-- 새로고침 -->
							<input type="button" class="btn btn-primary" name="reStart" value="전체보기" onclick="window.location.reload()">
						</form>
					</div>
				</div>
				<div class="panel panel-headline">
					<div class="panel-body"> 
						<div class="list_wrap">
							<form class="form-inline" name="f2" id="f2">
								<table class="table tablesorter table-bordered" id="progressTable" name="progressTable">
									<thead>
										<tr>
											<th class="sorter-false" style="width:6%;">
												<label class="fancy-checkbox-inline">
													<input type="checkbox" onclick="checkAllFunc(this)">
													<span></span>
												</label>
												<input type="hidden" name="progToggleResult" id="progToggleResult" value="">
											</th>
											<th>사원번호</th>
											<th>이름</th>
											<th>부서</th>
											<th>직급</th>
											<th>신청일</th>
											<th>휴가구분</th>
											<th>휴가기간</th>
											<th>일수</th>
											<th>휴가사유</th>
											<th>결재상태</th>
										</tr>
									</thead>
									<tbody id="progressTbody">
									</tbody>
								</table>
							</form>
						</div>
						<!-- END list table 영역 -->
						    
						<!-- 버튼영역 -->
						<div class="text-center"> 
							<button type="button" class="btn btn-info" onclick="toggleOn()">승인완료</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-danger" onclick="vacProgSave()">저장하기</button>
						</div>
						<!-- END 버튼영역 -->
					</div>
				</div>
			</div>
			

			<!-- 사원번호 Modal -->
			<div id="empEmnoModal" class="modal fade" role="dialog">
			  <div class="modal-dialog">
			  
			  <!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<p class="modal-title">사번 정보 조회</p>
					</div>
					<div class="modal-body">
						<div class="search_wrap" style="padding: 0px 10px 20px 15px; ">
							<form class="form-inline">
								검색어&nbsp;<input type="text" class="form-control">&nbsp;&nbsp;&nbsp;
								<label class="fancy-checkbox-inline">
									<input type="checkbox" name="">
									<span>퇴직자 포함</span>
								</label>
								<input type="button" class="btn btn-primary" style="float:right;" name="search" onclick="empEmnoSearch()" value="검색">
							</form>
						</div>

						<div class="list_wrap">
							<table class="table tablesorter table-bordered">
								<tbody>
									<thead>
										<tr>
											<th></th>
											<th>사원번호</th>
											<th>성명</th>
											<th>부서</th>
											<th>직급</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>
												<label class="fancy-checkbox-inline">
													<input type="checkbox" name="empEmnoChk">
													<span></span>
												</label>
											</td>
											<td>12345</td>
											<td>유성실</td>
											<td>개발팀</td>
											<td>사원</td>
										</tr>
										<tr>
											<td>
												<label class="fancy-checkbox-inline">
													<input type="checkbox" name="empEmnoChk">
													<span></span>
												</label>
											</td>
											<td>2345</td>
											<td>유성실</td>
											<td>개발팀</td>
											<td>사원</td>
										</tr>
										<tr>
											<td>
												<label class="fancy-checkbox-inline">
													<input type="checkbox" name="empEmnoChk">
													<span></span>
												</label>
											</td>
											<td>17895</td>
											<td>유성실</td>
											<td>개발팀</td>
											<td>사원</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="empEmnoClick()">선택</button>
						</div>
					</div>
				</div>
			</div>
			<!-- END MODAL -->
		</div>
		<!-- END MAIN CONTENT -->
	</div>
	<!-- END MAIN -->
	
	
</body>
</html>