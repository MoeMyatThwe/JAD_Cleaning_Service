<%@ include file="check.jsp" %>
<%@ page import="java.sql.*, com.cleaningService.util.DatabaseConnection" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");

    try (Connection conn = DatabaseConnection.connect();
         PreparedStatement stmt = conn.prepareStatement(
             "UPDATE users SET name = ?, email = ?, phone = ?, address = ? WHERE id = ?")) {
        stmt.setString(1, name);
        stmt.setString(2, email);
        stmt.setString(3, phone);
        stmt.setString(4, address);
        stmt.setInt(5, userId);

        int rowsUpdated = stmt.executeUpdate();
        if (rowsUpdated > 0) {
            response.sendRedirect("profile.jsp?message=Profile updated successfully!");
        } else {
            out.println("<p style='color:red;'>Error updating profile. Please try again.</p>");
        }
    } catch (SQLException e) {
        out.println("<p style='color:red;'>Database error: " + e.getMessage() + "</p>");
    }
%>
