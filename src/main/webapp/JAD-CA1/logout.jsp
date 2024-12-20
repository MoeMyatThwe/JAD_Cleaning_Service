<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ page session="true" %>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%
    // Invalidate session
    session.invalidate();

    // Clear cookies
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("userId")) {
                cookie.setMaxAge(0); // Expire the cookie
                response.addCookie(cookie);
            }
        }
    }

    // Redirect to home page
    response.sendRedirect("home.jsp");
%>
