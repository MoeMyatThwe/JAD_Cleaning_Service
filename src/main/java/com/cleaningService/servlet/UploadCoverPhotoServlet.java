package com.cleaningService.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.cleaningService.util.DatabaseConnection;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet("/uploadCoverPhotoServlet")
public class UploadCoverPhotoServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads/covers";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Ensure user is logged in
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        if (!isMultipart) {
            request.setAttribute("error", "Form must be multipart/form-data.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        // File upload settings
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        try {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            @SuppressWarnings("unchecked")
            List<FileItem> items = upload.parseRequest(request);

            String fileName = null;
            for (FileItem item : items) {
                if (!item.isFormField()) {
                    fileName = userId + "_" + item.getName();
                    String filePath = uploadPath + File.separator + fileName;
                    item.write(new File(filePath));
                }
            }

            if (fileName != null) {
                String coverPhotoUrl = UPLOAD_DIR + "/" + fileName;
                // Update the database
                try (Connection conn = DatabaseConnection.connect();
                     PreparedStatement stmt = conn.prepareStatement(
                             "UPDATE users SET cover_photo_url = ? WHERE id = ?")) {
                    stmt.setString(1, coverPhotoUrl);
                    stmt.setInt(2, userId);
                    stmt.executeUpdate();
                }
                response.sendRedirect("profile.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "File upload failed. Please try again.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
}
