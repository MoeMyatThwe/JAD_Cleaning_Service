<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*, com.cleaningService.util.DatabaseConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
    <link rel="stylesheet" href="home.css">
    <link rel="stylesheet" href="profile.css">
</head>
<body>
    <%
        // Ensure user is logged in
        if (session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }


        // Fetch user data
        String name = "", email = "", phone = "Not Specified", address = "Not Specified", avatarUrl = "gallery/default_avatar.jpg", coverPhotoUrl = "gallery/default_cover.jpg";
        try (Connection conn = DatabaseConnection.connect();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE id = ?")) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    name = rs.getString("name");
                    email = rs.getString("email");
                    phone = rs.getString("phone") != null ? rs.getString("phone") : phone;
                    address = rs.getString("address") != null ? rs.getString("address") : address;
                    avatarUrl = rs.getString("avatar_url") != null ? rs.getString("avatar_url") : avatarUrl;
                    coverPhotoUrl = rs.getString("cover_photo_url") != null ? rs.getString("cover_photo_url") : coverPhotoUrl;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
    <div class="profile-container">
        <div class="profile-cover" style="background-image: url('<%= coverPhotoUrl %>');">
            <div class="profile-avatar">
                <img src="<%= avatarUrl %>" alt="User Avatar">
                <form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/UploadAvatarServlet">
                    <input type="file" name="avatar" accept="image/*" required>
                    <button type="submit" class="change-avatar-btn">Change Avatar</button>
                </form>
            </div>
            <form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/UploadCoverPhotoServlet">
                <input type="file" name="coverPhoto" accept="image/*" required>
                <button type="submit" class="change-cover-btn">Change Cover Photo</button>
            </form>
        </div>
        <div class="profile-details">
            <h1>Welcome, <%= name %></h1>
            <form method="post" action="updateProfileServlet">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="<%= name %>" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= email %>" readonly>

                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phone" value="<%= phone %>">

                <label for="address">Address:</label>
                <textarea id="address" name="address" rows="3"><%= address %></textarea>

                <button type="submit" class="update-profile-btn">Update Profile</button>
            </form>
        </div>
    </div>
</body>
</html>
