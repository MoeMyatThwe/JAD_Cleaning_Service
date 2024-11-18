package com.jadcleaning.servlets;

import java.io.IOException;
import java.util.List;
import com.jadcleaning.dao.ServiceDAO;
import com.jadcleaning.models.Service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/services")
public class ServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ServiceDAO dao = new ServiceDAO();
            List<Service> services = dao.getAllServices();
            request.setAttribute("services", services);
            request.getRequestDispatcher("/services.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to fetch services");
        }
    }
}
