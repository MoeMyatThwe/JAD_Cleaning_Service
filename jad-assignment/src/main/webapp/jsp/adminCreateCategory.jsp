<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<%@ page import="com.cleaningService.util.DBConnection" %>
<%@ page import="com.cleaningService.dao.CategoryDAO" %>
<%@ page import="com.cleaningService.model.Category" %>
<%@ include file="authCheck.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create New Category</title>
</head>
<body>

    <h2>Create New Category</h2>

    <!-- Form for creating a new category -->
    <form method="POST" >
        <label for="categoryName">Category Name:</label>
        <input type="text" id="categoryName" name="categoryName" required>
        <br><br>
        <input type="submit" value="Create Category">
    </form>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
        	try{
        		String categoryName = request.getParameter("categoryName");
    			CategoryDAO categoryDAO = new CategoryDAO();
                boolean isCreated = categoryDAO.createCategory(categoryName);
            	
    	            if(isCreated){
    	            	out.println("<p>Category created</p>");
    	            }else{
    	            	out.println("<p>Failed</p>");
    	            }
        	}
            catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error occurred while creating the category.</p>");
            }
        }
    %>

</body>
</html>