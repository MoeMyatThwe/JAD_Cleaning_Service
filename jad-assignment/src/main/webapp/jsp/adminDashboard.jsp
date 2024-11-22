<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
    <link rel="stylesheet" href="../css/adminDashboard.css">

</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <h2>Cleaning Service</h2>
        <ul>
            <li><a href="#">Dashboard</a></li>
            <li><a href="#">Manage Bookings</a></li>
            <li><a href="#">Manage Cleaners</a></li>
            <li><a href="#">Customer Feedback</a></li>
            <li><a href="#">Logout</a></li>
        </ul>
    </div>

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
        		<p>23</p>
        	</div>
        
            <div class="card">
                <h3>Total Bookings</h3>
                <p>120</p>
            </div>
            
            <div class="card">
                <h3>Customer Feedbacks</h3>
                <p>40</p>
            </div>    
        </div>

        <!-- Bookings Table -->
        <div class="table-section">
            <h2>Recent Bookings</h2>
            <table>
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Customer Name</th>
                        <th>Service</th>
                        <th>Status</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1001</td>
                        <td>John Doe</td>
                        <td>Deep Cleaning</td>
                        <td>Completed</td>
                        <td>2024-11-15</td>
                        <td><button>Edit</button> <button>Delete</button></td>
                    </tr>
                    <tr>
                        <td>1002</td>
                        <td>Jane Smith</td>
                        <td>Carpet Cleaning</td>
                        <td>Pending</td>
                        <td>2024-11-16</td>
                        <td><button>Edit</button> <button>Delete</button></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>


</body>
</html>