<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import = "com.cleaningService.model.Service" %> 
<%@ page import = "com.cleaningService.dao.ServiceDAO" %> 
<%@ page import = "jakarta.servlet.http.HttpSession" %>
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
            // Retrieve the list of services from the database
            List<Service> services = serviceDAO.retrieveService();
            
            if (services != null && !services.isEmpty()) {
                for (Service service : services) {
        %>
        <div class="card">
            <img src="<%= request.getContextPath() %>/uploads/<%= service.getImage() %>" alt="Service Image">
            <h3><%= service.getName() %></h3>
            <p><strong>Price:</strong> $<%= service.getPrice() %></p>
            <p><strong>Description:</strong> <%= service.getDescription() %></p>

            <!-- Update Button -->
            <form action="updateService.jsp" method="post">
                <input type="hidden" name="action" value="update">
                <%
                    // Storing the serviceId in session
                    HttpSession userSession = request.getSession();
                    session.setAttribute("serviceId", service.getId());
                %>
                <button class="btn-update" type="submit">Update</button>
            </form>
            
            <!-- Upload New Image Button -->
            <form action="adminUpdatePhoto.jsp" method="post">
                <input type="hidden" name="action" value="upload">
                <%
                    // Storing the serviceId in session
                    session.setAttribute("serviceId", service.getId());
                %>
                <button class="btn-upload" type="submit">Upload New Image</button>
            </form>

            <!-- Delete Button -->
            <form action="adminDeleteService.jsp" method="post" onsubmit="return confirm('Are you sure you want to delete this service?');">
                <input type="hidden" name="action" value="delete">
                <%
                    // Storing the serviceId in session
                    session.setAttribute("serviceId", service.getId());
                %>
                <button class="btn-delete" type="submit">Delete</button>
            </form>
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
