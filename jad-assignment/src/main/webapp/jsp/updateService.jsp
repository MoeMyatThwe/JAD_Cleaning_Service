<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "com.cleaningService.model.Category" %> 
    <%@ page import = "com.cleaningService.model.Service" %> 
    <%@ page import = "com.cleaningService.dao.ServiceDAO" %>
    <%@page import = "java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Service</title>
</head>
<body>
<div class="container">
<%
	String serviceIdStr = request.getParameter("serviceId");
	int serviceId = Integer.parseInt(serviceIdStr);
    		
	ServiceDAO serviceDAO = new ServiceDAO();
	Service service = new Service();
	service = serviceDAO.retrieveServiceById(serviceId);
	
%>
        <h2>Update Service</h2>

        <!-- The form to update service details -->
        <form method="POST">
            
            
            <label for="serviceName">Service Name</label>
            <input type="text" id="serviceName" name="serviceName" value="<%= service.getName() %>" required>

            <label for="description">Description</label>
            <textarea id="description" name="description" rows="4" required><%= service.getDescription() %></textarea>

            <label for="price">Price</label>
            <input type="number" id="price" name="price" value="<%= service.getPrice() %>" step="0.01" required>

            <label for="category">Category:</label>
    		<select id="category" name="category" required>
		        <option value="">-- Select a Category --</option>
		        <%
		            List<Category> categories = serviceDAO.getAllCategory();
		            for(Category category: categories){
		            %>
		                <option value="<%= category.getId() %>"><%= category.getCategoryName() %></option>
		            <%
		            }
		            %>
		
		    </select><br>

            <input type="submit" value="Update Service">
        </form>
    </div>
    
    <% if("POST".equalsIgnoreCase(request.getMethod())){
    	String serviceName = request.getParameter("serviceName");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        
        System.out.print(serviceName);

        // Create a Service object with updated values
        Service serviceToUpdate = new Service();
        serviceToUpdate.setName(serviceName);
        serviceToUpdate.setDescription(description);
        serviceToUpdate.setPrice(price);
        serviceToUpdate.setCategory_id(categoryId);

        // Update the service in the database using ServiceDAO
        boolean isUpdated = serviceDAO.updateService(serviceToUpdate);

        // Provide feedback to the user
        if (isUpdated) {
            out.println("<p>Service updated successfully!</p>");
        } else {
            out.println("<p>Failed to update the service.</p>");
        }
    }
        
    %>

    <a href="serviceList.jsp">Go back to the service list</a>
</body>
</html>