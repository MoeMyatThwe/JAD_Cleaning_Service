<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.cleaningService.dao.SubServiceDAO" %>
<%@ page import="com.cleaningService.model.SubService" %>
<%
    String subServiceIdParam = request.getParameter("sub_service_id");
    if (subServiceIdParam == null || subServiceIdParam.isEmpty()) {
        out.println("<h1>Sub-service not found!</h1>");
    } else {
        int subServiceId = Integer.parseInt(subServiceIdParam);
        SubServiceDAO subServiceDAO = new SubServiceDAO();
        SubService subService = subServiceDAO.getSubServiceById(subServiceId);

        if (subService == null) {
            out.println("<h1>Sub-service not found!</h1>");
        } else {
            // Display sub-service details
%>
<h1>Booking for: <%= subService.getName() %></h1>
<p>Description: <%= subService.getDescription() %></p>
<p>Price: $<%= subService.getPrice() %></p>
<img src="<%= subService.getImage() %>" alt="Sub-service Image" style="width:200px;height:auto;"/>
<%
        }
    }
%>
