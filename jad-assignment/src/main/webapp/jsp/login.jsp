<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.cleaningService.dao.UserDAO" %>
<%@ page import="com.cleaningService.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
    <div class="login-card">
        <h2>Login</h2>
        <form method="post">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Password</label>
            <div class="password-container">
                <input type="password" id="password" name="password" required>
                <img src="../images/eye-close-password.png" id="eye-close-password">
            </div>
            <input type="submit" value="Login">
        </form>
        <br>
        <h5>Don't have an account? <a href="/register/index.html" style="color: #343a40;">Register</a></h5>
        <h5><a href="./passwordRecovery/index.html" style="color: #343a40;">Forget Password?</a></h5>
    </div>
    <style>
    /* styles.css */

	* {
	    margin: 0;
	    padding: 0;
	    box-sizing: border-box;
	}
	
	body {
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    height: 100vh;
	    background-color: white;
	    font-family: Arial, sans-serif;
	}
	
	.login-card {
	    width: 300px;
	    padding: 20px;
	    background-color: rbg(195,224,229);
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	    border-radius: 8px;
	    text-align: center;
	}
	
	h2 {
	    margin-bottom: 20px;
	    color: #333;
	}
	
	form label {
	    display: block;
	    text-align: left;
	    margin-bottom: 5px;
	    color: #555;
	    font-size: 14px;
	}
	
	form input {
	    width: 100%;
	    padding: 10px;
	    margin-bottom: 15px;
	    border: 1px solid #ddd;
	    border-radius: 4px;
	}
	
	.password-container{
	
	    display: flex;
	    align-items: center;
	}
	
	.password-container img{
	    width: 35px;
	    cursor: pointer;
	}
	
	.password-container input {
	    width: 100%; 
	    padding: 10px;
	}
	
	.password-container {
	    position: relative;
	    width: 100%;
	}
	
	.password-container input {
	    width: 100%;
	    padding-right: 40px; 
	}
	
	.password-container img {
	    position: absolute;
	    display: flex;
	    align-items: center;
	    right: 10px; 
	    top: 40%;
	    transform: translateY(-50%);
	    width: 30px;
	    cursor: pointer;
	}
	
	.password-container input:focus {
	    border-color: #4b5156; /* Highlight border color when focused */
	    outline: none;
	}
	
	
	button {
	    width: 100%;
	    padding: 10px;
	    background-color: #5885AF;
	    color: white;
	    border: none;
	    border-radius: 4px;
	    cursor: pointer;
	    font-size: 16px;
	}
	
	button:hover {
	    background-color: #343a40;
	}
	
	    
    </style>
    
    <%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        System.out.println(email+password);

        UserDAO userDAO = new UserDAO();
        boolean isValidUser = userDAO.verifyUser(email, password);

        if (isValidUser) {
            out.println("<p>Login successful!</p>");
        } else {
            out.println("<p>Invalid email or password.</p>");
        }
    }
    %>
</body>

</html>