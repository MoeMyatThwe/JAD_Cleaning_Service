<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="com.cleaningService.dao.UserDAO" %>
<%@ page import="com.jadcleaning.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>
 
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial, sans-serif;
            background-color: #fff8e1; 
        }

        .register-card {
            padding: 20px;
            width: 350px;
            background-color: #F7E3D2; 
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
        }

        h2 {
            color: #674636; /* Brown */
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #674636;
        }

        input[type="text"], input[type="email"], input[type="password"], input[type="submit"] {
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
    <div class="register-card">
        <h2>Register</h2>
        <form method="post">
            <label>Name</label>
            <input type="text" name="name" required>
            <label>Email</label>
            <input type="email" name="email" required>
            <label>Password</label>
            <input type="password" name="password" required>
            <input type="submit" value="Register">
        </form>
        <h5>Already have an account? <a href="login.jsp">Login</a></h5>
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
            boolean success = userDAO.registerUser(user);

            if (success) {
                session.setAttribute("username", name); // Save user name to session
                response.sendRedirect("home.jsp");
            } else {
                out.println("<p style='color:red;'>Error during registration. Please try again.</p>");
            }
        }
    %>
</body>
</html>
