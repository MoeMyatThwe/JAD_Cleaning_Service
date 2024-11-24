<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    // Invalidating the session to log the user out
    if (session != null) {
        session.invalidate(); // Invalidate the session to log out the user
    }

    // Redirect to the login page or home page after logging out
    response.sendRedirect("login.jsp");  
%>
</body>
</html>