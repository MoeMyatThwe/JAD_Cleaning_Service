<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*, com.cleaningService.util.DatabaseConnection" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve form data
    String name = request.getParameter("name");
    String password = request.getParameter("password");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");

    try (Connection conn = DatabaseConnection.connect();
         PreparedStatement stmt = conn.prepareStatement(
             "UPDATE users SET name = ?, phone = ?, address = ?"
             + (password != null && !password.trim().isEmpty() ? ", password = ?" : "")
             + " WHERE id = ?")) {

        stmt.setString(1, name);
        stmt.setString(2, phone);
        stmt.setString(3, address);

        if (password != null && !password.trim().isEmpty()) {
            stmt.setString(4, password);
            stmt.setInt(5, userId);
        } else {
            stmt.setInt(4, userId);
        }

        int rowsUpdated = stmt.executeUpdate();
        if (rowsUpdated > 0) {
            response.sendRedirect("profile.jsp");
        } else {
            out.println("<p style='color:red;'>Error updating profile. Please try again.</p>");
        }
    } catch (SQLException e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>
