#JAD-CA1 Cleaning Service Application
##Overview
The JAD-CA1 Cleaning Service Application is a web-based platform designed to provide a seamless experience for users to book cleaning services, 
manage their bookings, and provide feedback. The system includes features for user authentication, service management, booking functionality,
feedback collection, and profile management, ensuring an end-to-end solution for both customers and administrators.

#Features
##User Management
Register: Allows users to create an account and stores user information securely with encrypted passwords.
Login/Logout: Authenticates users and manages sessions and cookies for secure access.
Profile Management: Enables users to view and update their profile details and avatar.
##Service Management
Service Categories: Displays various cleaning services such as Home Cleaning, Office Cleaning, and Sofa Cleaning.
Sub-Services: Lists specific cleaning options under each category, including details like price and description.
##Booking System
Booking Details: Users can select sub-services, specify booking date, time, and duration, and add special requests.
##Cart Management: Provides an interface for users to manage selected services and proceed to checkout.
Checkout: Saves booking details to the database and clears the cart upon successful checkout.
##Feedback System
Submit Feedback: Allows users to rate completed services and leave comments.
Manage Feedback: Users can view, update, or delete their previous feedback.
##Dynamic Homepage
Showcases service highlights, testimonials dynamically fetched from the feedback database, and contact details.
##Frontend
HTML, CSS, JavaScript
Bootstrap (for responsive design)
##Backend
Java (JSP and Servlets)
JDBC for database connectivity
##Database
PostgreSQL (hosted on Neon.tech)
Other Libraries/Frameworks
BCrypt: For password hashing and verification.
Jakarta Servlet API: For handling HTTP requests and responses.
##File Structure
Core Files
DatabaseConnection.java: Manages database connectivity.
UserDAO.java, BookingDAO.java, FeedbackDAO.java: Handle database operations for users, bookings, and feedback.
CartCheckoutServlet.java: Manages cart checkout logic and booking creation.
##Frontend
JSP Files:
Home.jsp, Services.jsp, ServiceDetails.jsp: Display core features.
Register.jsp, Login.jsp, Profile.jsp: Handle user-related functionality.
Cart.jsp, BookingDetails.jsp, Feedback.jsp: Manage booking and feedback.
##CSS Files:
Home.css, Services.css, Cart.css, etc.: Provide styling for corresponding JSP files.
##Reusable Components
Header.jsp and Footer.html: Include dynamic navigation bar and footer across pages.
Check.jsp: Ensures pages are accessible only to authenticated users.
##Installation
Prerequisites
Java Development Kit (JDK 11 or later)
Apache Tomcat (10.x)


Student Name: Moe Myat Thwe
Class: DIT/FT/2A/23
Admin No.: P2340362

