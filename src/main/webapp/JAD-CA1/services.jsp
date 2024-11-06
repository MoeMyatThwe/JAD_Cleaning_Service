<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Our Services</title>
<link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <header>
        <h1>Our Cleaning Services</h1>
        <p>Select a category to view more details and pricing.</p>
    </header>

    <section>
        <h2>Service Categories</h2>
        <ul>
        <% 
                // Step 1: Load JDBC Driver
                Class.forName("com.mysql.jdbc.Driver");  

                // Step 2: Define Connection URL
                String connURL = "jdbc:mysql://localhost/db1?user=root&password=root1234&serverTimezone=UTC";

                // Step 3: Establish connection to URL
                Connection conn = DriverManager.getConnection(connURL); 
                
                // Step 4: Use PreparedStatement for executing the query
                String query = "SELECT DISTINCT category FROM services";
                PreparedStatement ps = conn.prepareStatement(query);

                // Step 5: Execute the query
                ResultSet rs = ps.executeQuery();

                // Display each category as a link
                while (rs.next()) {
                    String category = rs.getString("category");
                    out.println("<li><a href='serviceDetails.jsp?category=" + category + "'>" + category + "</a></li>");
                }

                // Step 6: Close ResultSet, PreparedStatement, and Connection objects
                rs.close();
                ps.close();
                conn.close();
            %>
           
        </ul>
    </section>

</body>
</html>