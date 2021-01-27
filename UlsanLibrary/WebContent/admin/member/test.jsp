<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>


<script type="text/javascript">

 

    $(document).ready(function(){

        $("#massiveSelectCheckBox").click(function() {

            

            var isChecked = $(this).prop("checked");

            $(".deleteArticleId").prop("checked", isChecked);

            

        });

        

        $("#massiveDeleteBtn").click(function() {

            

            var isChecked = false;

            

            /* 각각의 클래스를 다 보면서 선택이 됬는지 안됬는지 체크한다. */

            $(".deleteArticleId").each(function(index, data){

                if( data.checked ){

                    isChecked = data.checked;

                }

            });

            

            if(!isChecked){

                alert("삭제할 대상을 선택하세요.");

                return;

            }

            

            /* 사용자에게 한번 더 컨펌 */

            if( confirm("정말 삭제하시겠습니까?")){

                alert("삭제되었습니다");

                

                var form = $("#massiveDeleteForm");

                form.attr("method", "post");

                form.attr("action", "<c:url value="/massiveDelete" />");

                form.submit();

            }

        });

    });

 

</script>

 

 

    <a href="<c:url value="/logout" />"><img src="<c:url value="/resource/img/logout.png" />" id="btnLogout" /></a>

    총 ${ articles.paging.totalArticleCount } 건의 게시물이 있습니다.

    <br/>

    <table>

        <tr>

            <th>

                <input type="checkbox" id="massiveSelectCheckBox" />

            </th>

            <th>번호</th>

            <th>제목</th>

            <th>글쓴이</th>

            <th>조회수</th>

            <th>추천수</th>

        </tr>

        

        

    <form id="massiveDeleteForm">

        <c:forEach items="${articles.articleList}" var="article">

            <tr>

                <td>

                    <input type="checkbox" class="deleteArticleId" 

                            name="deleteArticleId" value="${ article.articleId }" />

                </td>

                <td>${article.articleId}</td>

                <td id="title">

                    <a href = "<c:url value="/increaseHits?articleId=${article.articleId}" />">

                        ${article.title}

                    </a>

                    <c:if test="${article.fileCount gt 0}">

                        [${article.fileCount}개의 첨부파일 있음.]

                    </c:if>

                </td>

                <td>${article.nickName}</td>

                <td>${article.hits}</td>

                <td>${article.recommends}</td>

            </tr>

        </c:forEach>

    </form>    

    

    

        <tr>

            <td colspan="6">

                <form id="searchForm">

                ${ articles.paging.getPagingList("pageNo", "[@]", "[이전]", "[다음]", "searchForm") }

                </form>

            </td>

        </tr>

    </table>

    <a href="<c:url value="/write" />">글쓰기</a>

    <span id="massiveDeleteBtn" style="cursor: pointer;">일괄삭제</span>

    


