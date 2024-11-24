<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import = "com.cleaningService.model.Service" %> 
<%@ page import = "com.cleaningService.dao.ServiceDAO" %> 
<%@ page import = "jakarta.servlet.http.HttpSession" %>
<%@ include file="authCheck.jsp" %>
<%@ include file="../html/adminNavbar.html" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Services</title>
</head>
<body>
    <div clas="main-content">
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
	            <img src="<%= request.getContextPath() %>/<%= service.getImage() %>" alt="Service Image">
	            <h3><%= service.getName() %></h3>
	            <p><strong>Price:</strong> $<%= service.getPrice() %></p>
	            <p><strong>Description:</strong> <%= service.getDescription() %></p>
	
	            <!-- Update Button -->
	            <form action="adminUpdateService.jsp" method="get">
				    <input type="hidden" name="serviceId" value="<%= service.getId() %>">
				    <input type="hidden" name="action" value="update">
				    <button class="btn-update" type="submit">Update</button>
			</form>

	            
	            <!-- Upload New Image Button -->
	            <form action="adminUpdatePhoto.jsp" method="post">
	            	<input type="hidden" name="serviceId" value="<%= service.getId() %>">
	                <input type="hidden" name="action" value="upload">
	                
	                <button class="btn-upload" type="submit">Upload New Image</button>
	            </form>
	
	            <!-- Delete Button -->
	            <form action="adminDeleteService.jsp" method="post" onsubmit="return confirm('Are you sure you want to delete this service?');">
	                <input type="hidden" name="action" value="delete">
	                <input type="hidden" name="serviceId" value="<%= service.getId() %>">
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
	        
	        <script>
	        
	        function storeServiceIdInCookie(serviceId){
	        	document.cookie = "serviceId="+serviceId+"; path=/;";
	        	
	        	document.getElementById('updateForm').onsubmit();
	        }
	        
	        </script>
	    </div>
    </div>
<style>

/* General Reset */
body, html {
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    box-sizing: border-box;
}

.card {
    background: #f0f0f0 !important;
}


/* Mobile Menu Toggle */
.menu-toggle {
    display: none;
    background: #575757;
    color: white;
    padding: 5px 10px;
    border-radius: 4px;
    cursor: pointer;
}

@media (max-width: 768px) {
    .menu-toggle {
        display: block;
    }

    .main-content {
        background: #f4f4f4;
        min-height: 100vh;
        margin-top: 60px; /* Offset for navbar height */
    }

    header {
        background: #fff;
        padding: 20px;
        margin-bottom: 20px;
        border-radius: 4px;
    }

    header h1 {
        margin: 0;
        color: #2c3e50;
    }

    /* Summary Cards */
    .summary-cards {
        display: flex;
        gap: 20px;
        margin-bottom: 20px;
        flex-wrap: wrap;
    }

    .card {
        flex: 1;
        min-width: 200px;
        background: #fff;
        padding: 20px;
        text-align: center;
        border-radius: 4px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .card h3 {
        margin-bottom: 10px;
        color: #34495e;
    }

    .card p {
        font-size: 1.5em;
        color: #16a085;
    }

    /* Table Section */
    .table-section {
        background: #fff;
        padding: 20px;
        border-radius: 4px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    table th, table td {
        padding: 10px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    table th {
        background: #34495e;
        color: #fff;
    }

    table tr:hover {
        background: #f1f1f1;
    }
}

</style>    

    
</body>
</html>
