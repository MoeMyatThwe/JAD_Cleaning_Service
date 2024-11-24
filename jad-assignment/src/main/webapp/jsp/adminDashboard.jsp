<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ include file="authCheck.jsp" %>
<%@page import = "com.cleaningService.dao.ServiceDAO" %>
<%@page import = "com.cleaningService.dao.BookingDAO" %>
<%@page import = "com.cleaningService.dao.FeedbackDAO" %>
<%@page import = "com.cleaningService.model.Booking" %>
<%@ include file="../html/adminNavbar.html" %>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
</head>
<body>
<%
Integer loggedInUserRoleId = (Integer) session.getAttribute("userRole");
if(loggedInUserRoleId == null || loggedInUserRoleId == 2){
	response.sendRedirect("login.jsp");
	return;	
}


ServiceDAO serviceDAO = new ServiceDAO();
BookingDAO bookingDAO = new BookingDAO();
FeedbackDAO feedbackDAO = new FeedbackDAO();
int numOfServices = serviceDAO.retrieveNumberOfServices();
int numOfBookings = bookingDAO.retrieveBookingNum();
int numOfFeedbacks =feedbackDAO.retrieveFeedbackNum();
%>
    

    <!-- Main Content -->
    <div class="main-content">
    
        <header>
            <h1>Admin Dashboard</h1>
            <p>Welcome back, Admin!</p>
        </header>

        <!-- Summary Cards -->
        <div class="summary-cards">
        	<div class="card">
        		<h3>Total Services</h3>
        		<p><%=numOfServices%></p>
        	</div>
        
            <div class="card">
                <h3>Total Bookings</h3>
                <p><%=numOfBookings%></p>
            </div>
            
            <div class="card">
                <h3>Customer Feedbacks</h3>
                <p><%=numOfFeedbacks%></p>
            </div>    
        </div>

        <!-- Bookings Table -->
        <%
        Booking booking = new Booking();
    	List<Booking> bookings = bookingDAO.retrieveAllBookings();
    	
    	if(numOfBookings == 0){
    		%>
    		<p>There is no booking yet.</p>
    		<%
    	}else{
    			
		%>

		<div class="table-section">
		    <h2>Recent Bookings</h2>
		    <table>
		        <thead>
		            <tr>
		                <th>Booking ID</th>
		                <th>Customer Name</th>
		                <th>Service</th>
		                <th>Date</th>
		                <th>Time</th>
		            </tr>
		        </thead>
		        <tbody>
		            <%-- Loop through all bookings and display them in table rows --%>
		            <%
		                for (Booking bookingList : bookings) {
		                	System.out.print(booking.getId());
	                        System.out.print(booking.getCustomerName());
	                         
		            %>
		                    <tr>
		                        <td><%= booking.getId() %></td>
		                        
		                        
		                        <td><%= booking.getCustomerName() %></td>
		                        <td><%= booking.getServiceName() %></td>
		                        <td><%= booking.getDate() %></td>
		                        <td><%= booking.getTime() %></td>
		                    </tr>
		            <%
		                }
		            %>
		        </tbody>
		    </table>
		</div>
    </div>
    <%
    }
    %>

<script>
    const menuToggle = document.querySelector('.menu-toggle');
    const navMenu = document.querySelector('.navbar ul');

    menuToggle.addEventListener('click', () => {
        navMenu.classList.toggle('show');
    });
</script>
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

    /* /* Summary Cards */
    .summary-cards {
        display: flex;
        gap: 20px;
        margin-bottom: 20px;
        flex-wrap: wrap;
    } */

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
    /* .table-section {
        background: #fff;
        padding: 20px;
        border-radius: 4px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .table-section table {
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
    } */
}

</style>    
</body>
</html>