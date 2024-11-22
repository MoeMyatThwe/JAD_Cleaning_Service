<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.cleaningService.dao.ServiceDAO" %>
<%@ page import="com.cleaningService.dao.CategoryDAO" %>
<%@ page import="com.cleaningService.model.Service" %>
<%@ page import="com.cleaningService.model.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.File" %>
<%@ page import="jakarta.servlet.http.Part" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Service</title>
</head>
<body>
<%
    ServiceDAO serviceDAO = new ServiceDAO();
	CategoryDAO categoryDAO = new CategoryDAO();


    
    if("POST".equalsIgnoreCase(request.getMethod())){
    	try{
    		String name = request.getParameter("serviceName");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String categoryStr = request.getParameter("category");
            String image = "/images/default-image.jpg";
            double price = Double.parseDouble(priceStr);
            int category = Integer.parseInt(categoryStr);
            
           	Service service = new Service(name, description, price, category, image);
            boolean created = serviceDAO.createService(service);

            if(created){
                out.println("<p>Service created successfully!</p>");
            }else{
                out.println("<p>Service not created!</p>");
            }

    	}catch (Exception e) {
            out.println("<p>Error processing form data: " + e.getMessage() + "</p>");
        }
    }
%>

<h1>Create New Service</h1>
<form method="POST">
    <label for="serviceName">Service Name:</label>
    <input type="text" id="serviceName" name="serviceName" required><br>

    <label for="description">Description:</label>
    <textarea id="description" name="description" rows="4" required></textarea><br>

    <label for="price">Price (USD):</label>
    <input type="number" id="price" name="price" step="0.01" required><br>

    <label for="category">Category:</label>
    <select id="category" name="category" required>
        <option value="">-- Select a Category --</option>
        <%
            List<Category> categories = categoryDAO.getAllCategory();
            for(Category category: categories){
            %>
                <option value="<%= category.getId() %>"><%= category.getCategoryName() %></option>
            <%
            }
            %>

    </select><br>

    <button type="submit">Add Service</button>
</form>

</body>
</html>
