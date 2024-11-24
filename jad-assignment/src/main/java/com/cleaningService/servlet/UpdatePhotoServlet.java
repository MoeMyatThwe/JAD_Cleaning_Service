package com.cleaningService.servlet;

import java.io.*;

import org.jose4j.json.internal.json_simple.JSONArray;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.cleaningService.dao.ServiceDAO;
import org.jose4j.json.internal.json_simple.JSONArray;

@WebServlet("/updatePhoto")
public class UpdatePhotoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String galleryPath = getServletContext().getRealPath("/gallery/updatePhoto");
        File galleryDir = new File(galleryPath);
        
        if (galleryDir.exists() && galleryDir.isDirectory()) {
            String[] imageFiles = galleryDir.list((dir, name) -> name.toLowerCase().endsWith(".jpg") || name.toLowerCase().endsWith(".png"));
            
            JSONArray jsonImages = new JSONArray();
            
            if (imageFiles != null) {
                for (String imageFile : imageFiles) {
                	
                    String imagePath = "/gallery/updatePhoto/" + imageFile;
                    jsonImages.add(imagePath); 
                    
                }
            }
            
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(jsonImages.toString());
            out.flush();
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	String serviceIdStr = request.getParameter("serviceId");
        String selectedPhoto = request.getParameter("photo");
        
        System.out.println(serviceIdStr);
        

        if (serviceIdStr != null && selectedPhoto != null) {
        	int serviceId = Integer.parseInt(serviceIdStr);
            ServiceDAO serviceDAO = new ServiceDAO();
            boolean isUpdated = serviceDAO.updateServicePhoto(serviceId, selectedPhoto);
            
            if (isUpdated) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Photo updated successfully.");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Failed to update photo.");
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid input.");
            return;
        }
    }
}
