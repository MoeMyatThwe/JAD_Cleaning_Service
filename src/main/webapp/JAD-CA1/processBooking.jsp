<%@ page import="com.cleaningService.dao.BookingDAO" %>

<%
    Integer userId = (Integer) session.getAttribute("userId"); // Retrieve user ID from session
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String subServiceIdParam = request.getParameter("subServiceId");
    String specialRequest = request.getParameter("specialRequest");

    int subServiceId = Integer.parseInt(subServiceIdParam);

    BookingDAO bookingDAO = new BookingDAO();
    boolean success = bookingDAO.createBooking(userId, subServiceId, specialRequest);

    if (success) {
        out.println("<p>Booking successful!</p>");
    } else {
        out.println("<p>Failed to create booking. Please try again.</p>");
    }
%>
