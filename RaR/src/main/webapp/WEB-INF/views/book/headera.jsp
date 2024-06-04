<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form action="bookSearch.do" method="post" id="searchForm">
    <table>
        <tr>
        	<td>
        		<select name="ck" id="ck">
					<option value="Keyword" <c:if test="${param.ck=='Keyword'}">selected</c:if>>제목,저자</option>
					<option value="Title" <c:if test="${param.ck=='Title'}">selected</c:if>>제목</option>
					<option value="Author" <c:if test="${param.ck=='Author'}">selected</c:if>>저자</option>
					<option value="Publisher" <c:if test="${param.ck=='Publisher'}">selected</c:if>>출판사</option>
				</select>
        	</td>
            <td>
                <input type="search" name="sheck" placeholder="검색어를 입력하세요" id="sheck" value="${param.sheck}">
                <input type="hidden" value="${param.start != null ? param.start : 1}" id="start" name="start">
                <input type="hidden" id="currentSearch" name="currentSearch" value="${param.sheck}">
                <input type="submit" value="검색" id="sk">
            </td>
        </tr>
        <tr>
            <td>
                <button type="button" id="prev">이전 페이지</button>
                <label id="count">1</label>
                <button type="button" id="next">다음 페이지</button>
            </td>
        </tr>
    </table>
</form>

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function () {
        const startInput = document.getElementById('start');
        const searchForm = document.getElementById('searchForm');
        const prevButton = document.getElementById('prev');
        const nextButton = document.getElementById('next');
        const searchInput = document.getElementById('sheck');
        const currentSearchInput = document.getElementById('currentSearch');
        const count = document.getElementById('count');

        let currentPage = parseInt(startInput.value);
        count.textContent = currentPage;

        prevButton.addEventListener('click', function () {
            let currentPage = parseInt(startInput.value);
            if (currentPage <= 1) {
                alert('첫 페이지입니다.');
                return;
            }
            currentPage -= 1;
            count.textContent = currentPage;
            startInput.value = currentPage;
            currentSearchInput.value = searchInput.value;
            searchForm.submit();
        });

        nextButton.addEventListener('click', function () {
            let currentPage = parseInt(startInput.value);
            currentPage += 1;
            count.textContent = currentPage;
            startInput.value = currentPage;
            currentSearchInput.value = searchInput.value;
            searchForm.submit();
        });

        searchForm.addEventListener('submit', function (event) {
            if (searchInput.value.trim() === '') {
                alert('검색어를 입력하세요.');
                event.preventDefault();
            }
        });
    });
</script>

