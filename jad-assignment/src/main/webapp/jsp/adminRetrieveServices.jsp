<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.util.List"%>
    <%@ page import = "com.cleaningService.model.Service" %> 
    <%@ page import = "com.cleaningService.dao.ServiceDAO" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Services</title>
<link rel="stylesheet" type="text/css" href="../css/adminRetrieveService.css">
</head>
<body>
<h1>All Services</h1>
    <div class="card-container">
        <%	
        	ServiceDAO serviceDAO = new ServiceDAO();
            // Retrieve the list of services from the request scope
            List<Service> services = serviceDAO.retrieveService();
            
            if (services != null || !services.isEmpty()) {
                for (Service service : services) {
                	
        %>
        <div class="card">
            <img src="<%=request.getContextPath()%><%=service.getImage()%>" alt="Service Image">
            <h3><%= service.getName() %></h3>
            <p><strong>Price:</strong> $<%= service.getPrice() %></p>
            <p><strong>Description:</strong> <%= service.getDescription() %></p>
            <button class="btn-update" onclick="location.href='updateService.jsp?serviceId=<%= service.getId() %>'">Update</button>
            <button class="btn-upload" onclick="location.href='uploadImage.jsp?serviceId=<%= service.getId() %>'">Upload New Image</button>
            <button class="btn-delete" onclick="if(confirm('Are you sure you want to delete this service?')) location.href='adminDeleteService.jsp?serviceId=<%= service.getId() %>';">Delete</button>
        </div>
        <%
                }
            } else {
        %>
        <p>No services available.</p>
        <%
            	}
        %>
    </div>
</body>
</html>