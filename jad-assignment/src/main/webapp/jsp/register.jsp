<%@ page import="com.cleaningService.dao.UserDAO" %>
<%@ page import="com.cleaningService.model.User" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Register</title>
</head>
<body>
    <h2>Registration Form</h2>

    <form method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required><br><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>

        <input type="submit" value="Register">
    </form>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Create a User object
            User user = new User(name, email, password);

            // Call the UserDAO to register the user
            UserDAO userDAO = new UserDAO();
            boolean success = userDAO.registerUser(user);

            if (success) {
                out.println("<p>Registration successful!</p>");
            } else {
                out.println("<p>Error during registration. Please try again.</p>");
            }
        }
    %>
</body>
</html>
