<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "jakarta.servlet.http.HttpSession" %>
<%@ page import = "com.cleaningService.model.Category" %> 
<%@ page import = "com.cleaningService.model.Service" %> 
<%@ page import = "com.cleaningService.dao.ServiceDAO" %> 
<%@ page import = "com.cleaningService.dao.CategoryDAO" %> 
<%@ page import = "java.util.List" %>
<%@ include file="authCheck.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Service</title>
</head>
<body>
<div class="container">

<%
    // Retrieve serviceId from the URL parameter
    String serviceIdStr = request.getParameter("serviceId");
    int serviceId = Integer.parseInt(serviceIdStr);

    // Fetch the service details from the database using serviceId
    ServiceDAO serviceDAO = new ServiceDAO();
    Service service = serviceDAO.retrieveServiceById(serviceId);
%>

<h2>Update Service</h2>

<!-- The form to update service details -->
<form method="post" action="<%=request.getContextPath() %>/UpdateServiceServlet">
    <!-- Hidden input to pass the serviceId -->
    <input type="hidden" name="serviceId" value="<%= service.getId() %>">

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
            CategoryDAO categoryDAO = new CategoryDAO();
            List<Category> categories = categoryDAO.getAllCategory();
            for(Category category : categories){
        %>
            <option value="<%= category.getId() %>" <%= (category.getId() == service.getCategory_id()) ? "selected" : "" %>><%= category.getCategoryName() %></option>
        <%
            }
        %>
    </select><br>

    <input type="submit" value="Update Service">
</form>

</div>

<a href="serviceList.jsp">Go back to the service list</a>
</body>
</html>
