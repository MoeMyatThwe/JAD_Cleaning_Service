<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.cleaningService.dao.UserDAO" %>
<%@ page import="com.cleaningService.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "java.util.Date, java.util.Calendar, java.util.Base64" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../css/login.css">
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
                <img src="../gallery/eye-close-password.png" id="eye-close-password">
            </div>
            <input type="submit" value="Login">
        </form>
        <br>
        <h5>Don't have an account? <a href="/register/index.html" style="color: #343a40;">Register</a></h5>
    </div>
    
    <%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email, password);
        

        if (user != null) {
        	
        	int roleId = user.getRole();
        	session.setAttribute("userRole", roleId);
            session.setAttribute("userId", user.getId());
            Integer userId = (Integer)session.getAttribute("userId");
            
            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.MINUTE, 30);
            String token = Base64.getEncoder().encodeToString((email + ":" + calendar.getTimeInMillis()).getBytes());
            
            session.setAttribute("authToken", token);
            
            %>
        	<script>alert('Login Successful!')</script>
        	<%
        	
            if(roleId == 1){
            	response.sendRedirect("adminDashboard.jsp");
            }else if(roleId == 2){
            	response.sendRedirect("home.jsp");
            }
        } else {
        	%>
        	<script>alert('Login Failed!')</script>
        	<%        
       	}
    }
    %>
    
    <!-- For show password -->
    <script>
    function togglePasswordVisibility(inputField, icon) {
        if (inputField.type === "password") {
            inputField.type = "text";
            icon.src = "../gallery/eye-open-password.png";
        } else {
            inputField.type = "password";
            icon.src = "../gallery/eye-close-password.png";
        }
    }
    function setupPasswordToggle() {
        const eyePassword = document.getElementById("eye-close-password");
        const eyeRepassword = document.getElementById("eye-close-repassword");
        const password = document.getElementById("password");
        const repassword = document.getElementById("repassword");

        eyePassword.onclick = function () {
            togglePasswordVisibility(password, eyePassword);
        };

        eyeRepassword.onclick = function () {
            togglePasswordVisibility(repassword, eyeRepassword);
        };
    }
    window.addEventListener("DOMContentLoaded", setupPasswordToggle);

    </script>
</body>

</html>