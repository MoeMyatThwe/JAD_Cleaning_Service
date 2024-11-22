package com.cleaningService.servlet;

import com.cleaningService.dao.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

@WebServlet("/UpdatePhotoServlet")
@MultipartConfig
public class UpdatePhotoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Retrieve the service ID from the form
            String serviceId = request.getParameter("serviceId");
            Part filePart = request.getPart("photo");

            // Validate if a file is uploaded
            if (filePart != null && filePart.getSize() > 0) {
                // Get the file name
                String fileName = filePart.getSubmittedFileName();

                // Define the upload path to `webapp/images/`
                String uploadPath = getServletContext().getRealPath("") + "images";
                File uploadDir = new File(uploadPath);

                // Create the images directory if it doesn't exist
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                // Save the file
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);

                // Update the database with the new image filename
                ServiceDAO serviceDAO = new ServiceDAO();
                boolean isUpdated = serviceDAO.updateServicePhoto(Integer.parseInt(serviceId), fileName);

                if (isUpdated) {
                    response.getWriter().println("<script>alert('Service photo updated successfully!');"
                            + "window.location.href='adminRetrieveServices.jsp';</script>");
                } else {
                    response.getWriter().println("<script>alert('Failed to update service photo in the database.');</script>");
                }
            } else {
                response.getWriter().println("<script>alert('No file selected. Please choose a file.');</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('An error occurred. Please try again.');</script>");
        }
    }
}
