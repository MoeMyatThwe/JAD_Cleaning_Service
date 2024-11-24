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
String categoryIdStr = request.getParameter("categoryId");
System.out.println(categoryIdStr);

if(categoryIdStr == null || categoryIdStr.isEmpty()){
	%>
	<script>alert('Category Id cannot be retrieved.')</script>
	<%
}else{
	int categoryId = Integer.parseInt(categoryIdStr);
	try{
		CategoryDAO categoryDAO = new CategoryDAO();
		boolean isDeleted = categoryDAO.deleteCategory(categoryId);
		
		if(isDeleted){
			%>
			<script>alert('Category deleted.')</script>
			<%
			response.sendRedirect("adminRetrieveAllCategories.jsp");

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