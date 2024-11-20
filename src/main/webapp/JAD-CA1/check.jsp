<%
    String user = (String) session.getAttribute("user");
    if (user == null || user.isEmpty()) {
        response.sendRedirect("login.jsp");
    }
%>
