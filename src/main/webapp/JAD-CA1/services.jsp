<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Available Services</title>
</head>
<body>
    <h1>Our Cleaning Services</h1>
    <table border="1">
        <tr>
            <th>Service Name</th>
            <th>Description</th>
            <th>Price</th>
        </tr>
        <c:forEach items="${services}" var="service">
            <tr>
                <td>${service.name}</td>
                <td>${service.description}</td>
                <td>${service.price}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
