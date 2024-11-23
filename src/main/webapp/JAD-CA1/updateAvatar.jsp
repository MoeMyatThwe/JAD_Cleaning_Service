<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*, java.io.*, com.cleaningService.util.DatabaseConnection" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String avatarUrl = null;
    String uploadPath = application.getRealPath("") + "gallery/avatars";
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdir();

    try {
        Part filePart = request.getPart("avatar");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = userId + "_" + System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            avatarUrl = "gallery/avatars/" + fileName;
            filePart.write(uploadPath + File.separator + fileName);
        }

        if (avatarUrl != null) {
            try (Connection conn = DatabaseConnection.connect();
                 PreparedStatement stmt = conn.prepareStatement("UPDATE users SET avatar_url = ? WHERE id = ?")) {
                stmt.setString(1, avatarUrl);
                stmt.setInt(2, userId);
                stmt.executeUpdate();
            }
        }
        response.sendRedirect("profile.jsp");
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error updating avatar: " + e.getMessage() + "</p>");
    }
%>
