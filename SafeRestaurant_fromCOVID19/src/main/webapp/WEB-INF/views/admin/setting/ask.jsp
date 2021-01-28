<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/WEB-INF/views/admin/include/adminHead.jsp"%>

<%@include file="/WEB-INF/views/admin/include/adminSideNav.jsp"%>

<%@include file="/WEB-INF/views/admin/include/adminSetting.jsp"%>

<style>
	a{
		text-decoration: none;
	}
</style>

                    <div class="card mb-4" style="width: 100%;">
                            <div class="card-header">
                                <i class="fas fa-table mr-1"></i>
                                문의 목록
                            </div>
                            <div class="card-body" >
                                <div class="table-responsive" >
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th>ID</th>
                                                <th>Title</th>
                                                <th>Date</th>
                                                <th>Check</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:set var="number" value="1"/>
                                        	<c:forEach var="list" items="${list}" varStatus="status">
	                                            <tr>
	                                                <td style="text-align: center; font-weight: bold; vertical-align: middle;">${number}</td>
	                                                <td style="vertical-align: middle; width: 200px; text-align: center; height: 100px;">
	                                                	${list.id}
	                                                </td>
	                                                <td style="vertical-align: middle;">
	                                                	<a href="/customerService/view?uid=${list.uid}">${list.title}</a>
	                                                </td>
	                                                <td style="vertical-align: middle;">${list.date}</td>
	                                                <td style="vertical-align: middle; text-align: center;">
	                                                	<c:if test="${list.count > 0}">
	                                                		확인 완료
	                                                	</c:if>
	                                                </td>
	                                            </tr>
                                            <c:set var="number" value="${number+1 }"/>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                </main>

               
<%@include file="/WEB-INF/views/admin/include/adminFooter.jsp"%>
