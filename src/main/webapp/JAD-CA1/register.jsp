<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="com.cleaningService.dao.UserDAO" %>
<%@ page import="com.cleaningService.model.User" %>
<%@ page import="jakarta.servlet.http.Cookie" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="register.css">
</head>
<body>
    <div class="register-container">
        <div class="register-card">
            <h2 class="register-title">Register</h2>
            <form method="post" action="register.jsp" class="register-form">
                <label for="name" class="register-label">Name:</label>
                <input type="text" id="name" name="name" placeholder="Enter your name" class="register-input" required>

                <label for="email" class="register-label">Email:</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" class="register-input" required>

                <label for="password" class="register-label">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" class="register-input" required>

                <input type="submit" value="Register" class="register-btn">
            </form>
            <p class="register-login">
                Already have an account? <a href="login.jsp" class="register-login-link">Login</a>
            </p>
        </div>
    </div>

    <% 
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Create User object
            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);

            // Call UserDAO to save user
            UserDAO userDAO = new UserDAO();
            int userId = userDAO.registerUser(user);

            if (userId > 0) { // If registration is successful
                // Set session attributes
                session.setAttribute("userId", userId);
                session.setAttribute("username", name);

                // Optionally set a cookie for persistent login
                Cookie userIdCookie = new Cookie("userId", String.valueOf(userId));
                userIdCookie.setMaxAge(60 * 60 * 24 * 7); // 7 days
                response.addCookie(userIdCookie);

                // Redirect to home or profile
                response.sendRedirect("home.jsp");
            } else {
                out.println("<p style='color:red;'>Error during registration. Please try again.</p>");
            }
        }
    %>
</body>
</html>
