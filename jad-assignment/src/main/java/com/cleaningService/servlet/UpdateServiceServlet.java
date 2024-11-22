package com.cleaningService.servlet;
import java.io.IOException;

import com.cleaningService.dao.ServiceDAO;
import com.cleaningService.model.Service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdateServiceServlet")
public class UpdateServiceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession userSession = request.getSession();
    	Integer serviceId =(Integer) userSession.getAttribute("serviceId");
        // Get the form data
        String serviceName = request.getParameter("serviceName");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String categoryStr = request.getParameter("category");
        
        try {
            // Parse the price and category
            double price = Double.parseDouble(priceStr);
            int categoryId = Integer.parseInt(categoryStr);

            // Create a Service object with updated values
            Service serviceToUpdate = new Service();
            serviceToUpdate.setId(serviceId);
            serviceToUpdate.setName(serviceName);
            serviceToUpdate.setDescription(description);
            serviceToUpdate.setPrice(price);
            serviceToUpdate.setCategory_id(categoryId);

            // Update the service in the database
            ServiceDAO serviceDAO = new ServiceDAO();
            boolean isUpdated = serviceDAO.updateService(serviceToUpdate);

            // Redirect back to the service list or show a success/failure message
            if (isUpdated) {
                response.sendRedirect(request.getContextPath() + "/jsp/adminRetrieveServices.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/jsp/adminRetrieveServices.jsp");
            }
        } catch (NumberFormatException e) {
            // Handle the error if price or category is not valid
            response.sendRedirect(request.getContextPath() + "/updateService.jsp?error=Invalid price or category");
        }
    }
}
