<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="card mb-4">
				<div class="card-header">
				    <i class="fas fa-table mr-1"></i>
				    회원 관리 테이블
				</div>
				<div class="card-body">
				    <div class="table-responsive">
				        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
				            <thead>
				                <tr>
				                    <th>아이디</th>
				                    <th>주소</th>
				                    <th>연락처</th>
				                    <th>상태</th>
				                    <th>관리</th>
				                </tr>
				            </thead>
				            <tbody>
				            <c:forEach var="list" items="${list}">
				                <tr>
				                    <td>${list.id}</td>
				                    <td>${list.address}</td>
				                    <td>${list.tel}</td>
				                    <td>Lv.${list.level}</td>
				                    <td>
				                    	<c:choose>
											<c:when test="${list.level eq '0'}">
											</c:when>
											<c:otherwise>
												<a href="/admin/force?id=${list.id}">탈퇴</a>
											</c:otherwise>
										</c:choose>
				                    </td>
				                </tr>
			               </c:forEach>
				            </tbody>
				        </table>
				    </div>
				</div>
	        </div>
	    </div>
	</main>