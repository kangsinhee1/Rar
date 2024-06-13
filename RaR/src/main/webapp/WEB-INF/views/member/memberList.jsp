<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록(관리자 전용)</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ksh2.css" type="text/css">
<script type="text/javascript">
window.onload=function(){
	const myForm = document.getElementById('search_form');
	//이벤트 연결
	myForm.onsubmit=function(){
		const keyword = document.getElementById('keyword');
		if(keyword.value.trim()==''){
			alert('검색어를 입력하세요');
			keyword.value = '';
			keyword.focus();
			return false;
		}
	};
};
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-main">
	<div class="content-main">
		<h2>회원목록(관리자)</h2>
		<form id="search_form" action="adminList.do"
		                                    method="get">
			<ul class="search">
				<li>
					<select name="keyfield">
						<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>이름</option>
						<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>email</option>
					</select>
				</li>
				<li>
					<input type="search" size="16" name="keyword" 
					          id="keyword" value="${param.keyword}">
				</li>
				<li>
					<input type="submit" value="찾기">
				</li>
			</ul>	                                    
		</form>
		<div class="list-space align-right">
			<input type="button" value="홈으로"
			       onclick="location.href='${pageContext.request.contextPath}/main/main.do'">       
		</div>
		<c:if test="${count == 0}">
		<div class="result-display">
			표시할 회원정보가 없습니다.
		</div>
		</c:if>
		<c:if test="${count > 0}">
		<table>
			<tr>
				<th>회원번호</th>
				<th>이메일</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>가입일</th>
				<th>등급</th>
			</tr>
			<c:forEach var="member" items="${list}">
			<tr>
				<td>${member.user_num}</td>
				<td>
					<c:if test="${member.user_auth > 0}">
					<a href="adminUserForm.do?user_num=${member.user_num}">${member.user_email}</a>
					</c:if>
					<c:if test="${member.user_auth == 0}">${member.user_email}</c:if>
				</td>
				<td>${member.user_name}</td>
				<td>${member.user_phone}</td>
				<td>${member.user_address1 }</td>
				<td>${member.user_date}</td>
				<td>
					<c:if test="${member.user_auth == 0}">탈퇴</c:if>
					<c:if test="${member.user_auth == 1}">정지</c:if>
					<c:if test="${member.user_auth == 2}">일반</c:if>
					<c:if test="${member.user_auth == 3}">실버</c:if>
					<c:if test="${member.user_auth == 4}">골드</c:if>
					<c:if test="${member.user_auth == 5}">플레티넘</c:if>
					<c:if test="${member.user_auth == 9}">관리</c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
		<div class="align-center">${page}</div>
		</c:if>		
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>






