<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cleaningService.dao.ServiceDAO" %>
<%@ page import="com.cleaningService.model.Service" %>
<%@ include file="authCheck.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Service Photo</title>
    <style>
        .popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: #fff;
            padding: 20px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            z-index: 1000;
        }

        .popup img {
            width: 100px;
            height: 100px;
            margin: 10px;
            cursor: pointer;
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }
    </style>
</head>
<body>
    <h2>Update Service Photo</h2>

<form id="updateForm" method="POST" action="<%=request.getContextPath() %>/updatePhoto">
    <!-- Hidden input field with serviceId retrieved from the session -->
    <input type="hidden" name="serviceId" value="<%= request.getParameter("serviceId") %>">
    <button type="button" onclick="showPopup()">Choose Photo</button>
    <input type="text" id="photoInput" name="photo" readonly><br><br>
    
    <input type="submit" value="Update Photo">
</form>


    <!-- Popup for selecting an image -->
    <div class="overlay" id="overlay"></div>
    <div class="popup" id="popup">
        <h3>Select a Photo</h3>
        <div id="gallery"></div>
        <button onclick="closePopup()">Cancel</button>
    </div>

    <script>
        // Show the popup and load images
        function showPopup() {
            fetch('<%=request.getContextPath()%>/updatePhoto', {
                method: 'GET'
            })
            .then(response => response.json())
            .then(data => {
                const galleryDiv = document.getElementById('gallery');
                galleryDiv.innerHTML = '';
                data.forEach(imagePath => {
                    const imgElement = document.createElement('img');
                    imgElement.src = imagePath;
                    imgElement.alt = imagePath;
                    imgElement.onclick = function () {
                        selectPhoto(imagePath);
                    };
                    galleryDiv.appendChild(imgElement);
                });

                document.getElementById('popup').style.display = 'block';
                document.getElementById('overlay').style.display = 'block';
            })
            .catch(error => console.error('Error loading images:', error));
        }

        // Close the popup
        function closePopup() {
            document.getElementById('popup').style.display = 'none';
            document.getElementById('overlay').style.display = 'none';
        }

        // Set selected photo to the input field
        function selectPhoto(imagePath) {
            document.getElementById('photoInput').value = imagePath;
            closePopup();
        }
    </script>
</body>
</html>
