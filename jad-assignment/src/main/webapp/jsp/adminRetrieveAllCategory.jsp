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
<title>All Categories</title>
</head>
<body>
    <h1>All Categories</h1>
    <table border="1">
        <thead>
            <tr>
                <th>Category Name</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%                    
            	HttpSession userSession = request.getSession();

                CategoryDAO categoryDAO = new CategoryDAO();
                List<Category> categories = categoryDAO.getAllCategory();
                
                // Check if categories are available
                if(categories != null && !categories.isEmpty()){
                    for(Category category : categories){
            %>
            <tr>
                <td><%= category.getCategoryName() %></td>
                <td>
                    <button class="btn-update" onclick="location.href='updateService.jsp
                    <%userSession.setAttribute("categoryId", category.getId()); %>'">Update</button>
                    <button class="btn-delete" onclick="if(confirm('Are you sure you want to delete this service?')) location.href='deleteCategory.jsp<%userSession.setAttribute("categoryId", category.getId()); %>'">Delete</button>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="3">No categories found.</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>
