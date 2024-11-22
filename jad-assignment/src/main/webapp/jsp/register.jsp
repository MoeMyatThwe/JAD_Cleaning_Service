<%@ page import="com.cleaningService.dao.UserDAO" %>
<%@ page import="com.cleaningService.model.User" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <link rel="stylesheet" type="text/css" href="../css/register.css">
    <title>Register</title>
    
</head>
<body>4
<div class="register-card">
        <h2>Register</h2>
        <form method="post">
        
            <label for="name">Name:</label>
	        <input type="text" id="name" name="name" required><br><br>
	
	        <label for="email">Email:</label>
	        <input type="email" id="email" name="email" required><br><br>
	
	        <label for="password">Password:</label>
	        <input type="password" id="password" name="password" required><br><br>
	
			<label for="phoneNum">Phone Number: </label>
	        <input type="tel" id="phoneNum" name="phoneNum" required><br><br>
	        
	        <label for="address">Address:</label>
	        <input type="text" id="address" name="address" required><br><br>

            <button type="submit">Register</button>
        </form>
        <br>
        <h5>Already have an account? <a href="../login/index.html" style="color: #343a40;">Login</a></h5>
    </div>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phoneNumStr = request.getParameter("phoneNum");
            Integer phoneNum = Integer.parseInt(phoneNumStr);
            String address = request.getParameter("address");
            Integer role = 2;

            // Create a User object
            User user = new User(name, email, password, phoneNum, address, role);

            // Call the UserDAO to register the user
            UserDAO userDAO = new UserDAO();
            boolean success = userDAO.registerUser(user);

            if (success) {
            	session.setAttribute("username", name);
                out.println("<p>Registration successful!</p>");
            } else {
                out.println("<p>Error during registration. Please try again.</p>");
            }
        }
    %>
</body>
</html>
