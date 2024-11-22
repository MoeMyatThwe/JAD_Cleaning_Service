<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import = "java.util.List"%>
    <%@ page import = "com.cleaningService.model.Category" %> 
    <%@ page import = "com.cleaningService.dao.CategoryDAO" %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="../css/adminRetrieveAllCategory.css">
<title>All Category</title>
</head>
<body>
	<div class="card-container">
	<%
		CategoryDAO categoryDAO = new CategoryDAO();
		List<Category>categories = categoryDAO.getAllCategory();
		
		if(categories != null || categories.isEmpty()){
			for(Category category:categories){
				%>
				<div class="card">
		             
		            <h3><%= category.getCategoryName() %></h3>
		            <p><strong>Price:</strong> $<%=category.getCategoryName()%></p>
		            <button class="btn-update" onclick="location.href='updateService.jsp?serviceId=<%= category.getId() %>'">Update</button>
		            <button class="btn-delete" onclick="if(confirm('Are you sure you want to delete this service?')) location.href='adminDeleteService.jsp?serviceId=<%= category.getId() %>';">Delete</button>
		        </div>
				<%
			}
		}
	
	%>
	</div>
</body>
</html>