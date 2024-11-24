<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
           <%@ page import = "com.cleaningService.dao.CategoryDAO" %> 
           <%@ include file="authCheck.jsp" %>
           
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
HttpSession userSession = request.getSession();
Integer categoryId =(Integer) userSession.getAttribute("categoryId");

if(categoryId == null){
	%>
	<script>alert('Category Id cannot be retrieved.')</script>
	<%
}else{
	try{
		CategoryDAO categoryDAO = new CategoryDAO();
		boolean isDeleted = categoryDAO.deleteCategory(categoryId);
		
		if(isDeleted){
			%>
			<script>alert('Category deleted.')</script>
			<%
			response.sendRedirect("adminRetrieveAllCategory.jsp");

		}else{
			%>
			<script>alert('Failed to delete category.')</script>
			<%
		}
	}catch(NumberFormatException e){
		out.println("<p>Invalid category ID format. Please try again.</p>");
	}
}

%>
</body>
</html>