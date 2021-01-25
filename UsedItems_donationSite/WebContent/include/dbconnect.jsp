<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
    Class.forName("com.mysql.jdbc.Driver");
    String url="jdbc:mysql://localhost:3306/proweb?serverTimezone=UTC";
    									   //web: DB이름.
    									   //serverTimezone=UTC: servertimezone 에러 나지 말라고 설정해준 것.
    String user="root";
    String password="1111";
%>