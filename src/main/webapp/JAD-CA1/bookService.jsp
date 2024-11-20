<%@ include file="check.jsp" %>
<%@ page import="java.sql.*, java.util.*" %>
<main>
    <h1>Book Your Service</h1>
    <form action="confirmBooking.jsp" method="post">
        <label for="date">Select Date:</label>
        <input type="date" id="date" name="date" required>
        <label for="duration">Duration (in hours):</label>
        <select id="duration" name="duration" required>
            <option value="1">1 Hour</option>
            <option value="2">2 Hours</option>
            <option value="3">3 Hours</option>
        </select>
        <label for="address">Address:</label>
        <input type="text" id="address" name="address" required>
        <label for="specialRequest">Special Request:</label>
        <textarea id="specialRequest" name="specialRequest"></textarea>
        <input type="hidden" name="subServiceId" value="<%= request.getParameter("subServiceId") %>">
        <button type="submit">Confirm Booking</button>
    </form>
</main>
