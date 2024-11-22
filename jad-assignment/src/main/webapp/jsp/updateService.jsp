<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "jakarta.servlet.http.HttpSession" %>
    <%@ page import = "com.cleaningService.model.Category" %> 
    <%@ page import = "com.cleaningService.model.Service" %> 
    <%@ page import = "com.cleaningService.dao.ServiceDAO" %>
    <%@ page import = "com.cleaningService.dao.CategoryDAO" %>
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
	HttpSession userSession = request.getSession();
	Integer serviceId =(Integer) userSession.getAttribute("serviceId");
	System.out.println(serviceId + "here");
	if (serviceId == null) {
	    out.println("<script>alert('No service selected.'); location.href='adminRetrieveService.jsp';</script>");
	}
	ServiceDAO serviceDAO = new ServiceDAO();
	CategoryDAO categoryDAO = new CategoryDAO();
	Service service = new Service();
	service = serviceDAO.retrieveServiceById(serviceId);
	
	System.out.print(service.getPrice());
%>
        <h2>Update Service</h2>

        <!-- The form to update service details -->
        <form method="post" action="<%=request.getContextPath() %>/UpdateServiceServlet">
            
            
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
		            List<Category> categories = categoryDAO.getAllCategory();
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
    
    
    <a href="serviceList.jsp">Go back to the service list</a>
</body>
</html>