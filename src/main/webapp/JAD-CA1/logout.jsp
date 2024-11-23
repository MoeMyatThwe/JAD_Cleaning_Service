<%@ page session="true" %>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%
    session.invalidate();

    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            cookie.setMaxAge(0); 
            response.addCookie(cookie);
        }
    }
    response.sendRedirect("home.jsp");
%>
