<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="com.cleaningService.dao.UserDAO" %>
<%@ page import="com.cleaningService.model.User" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial, sans-serif;
            background-color: #fff8e1; 
        }

        .login-card {
            padding: 20px;
            width: 350px;
            background-color: #F7E3D2;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
        }

        h2 {
            color: #674636;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #674636;
        }

        input[type="email"], input[type="password"], input[type="submit"] {
            display: block;
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #c6a38f; 
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #674636;
            color: white;
            cursor: pointer;
            font-weight: bold;
        }

        input[type="submit"]:hover {
            background-color: #835945; 
        }

        h5 {
            text-align: center;
            color: #674636;
        }

        h5 a {
            text-decoration: none;
            color: #c67443; 
        }

        h5 a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-card">
        <h2>Login</h2>
        <form method="post">
            <label>Email</label>
            <input type="email" name="email" required>
            <label>Password</label>
            <input type="password" name="password" required>
            <input type="submit" value="Login">
        </form>
        <h5>Don't have an account? <a href="register.jsp">Register</a></h5>
    </div>


    <%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email); // Fetch user details

        if (user != null && userDAO.verifyPassword(password, user.getPassword())) {
            // Set session attributes
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getName());
            session.setAttribute("role", user.getRole());

            // Redirect based on role
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("dashboard.jsp");
            } else {
                response.sendRedirect("home.jsp");
            }
        } else {
            out.println("<p style='color:red;'>Invalid email or password.</p>");
        }
    }
%>
    
</body>
</html>
