<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cleaningService.dao.ServiceDAO" %>
<%@ page import="com.cleaningService.model.Service" %>
<%@ include file="authCheck.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Service Photo</title>
</head>
<body>
    <h2>Update Service Photo</h2>

    <!-- Form to upload a new photo -->
    <form method="POST" action="<%=request.getContextPath() %>/UpdatePhotoServlet" enctype="multipart/form-data">
        <!-- Hidden field to pass the service ID -->
        <input type="hidden" name="serviceId" value="<%= request.getParameter("serviceId") %>">
        
        <!-- File input for uploading the photo -->
        <input type="file" name="photo" required><br><br>
        
        <input type="submit" value="Update Photo">
    </form>
</body>
</html>
