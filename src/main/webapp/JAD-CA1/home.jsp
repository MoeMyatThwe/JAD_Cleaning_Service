<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

    String username = session != null ? (String) session.getAttribute("username") : null;
    String role = session != null ? (String) session.getAttribute("role") : null; // Role: admin, member, or null for public
%>
<%
    // Determine the redirect URL based on user's login status
    String redirectURL;
    if (session != null && session.getAttribute("username") != null) {
        // If user is logged in, redirect to the services page
        redirectURL = "services.jsp";
    } else {
        // If user is not logged in, redirect to the register page
        redirectURL = "register.jsp";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shiny Home Services</title>
    <link rel="stylesheet" href="home.css"> 
</head>
<body>
    <!-- Navbar -->
    <nav>
        <ul class="navbar">
            <li><a href="home.jsp">Shiny</a></li>
            <li><a href="home.jsp">Home</a></li>
            <li><a href="services.jsp">Services</a></li>
            <% if ("admin".equals(role)) { %>
                <li><a href="dashboard.jsp">Dashboard</a></li>
                <li><a href="appointments.jsp">Appointments</a></li>
                <li><a href="feedback.jsp">Feedback</a></li>
            <% } else if ("member".equals(role)) { %>
                <li><a href="appointments.jsp">Appointments</a></li>
                <li><a href="feedback.jsp">Feedback</a></li>
            <% } else { %>
                <li><a href="register.jsp">Register</a></li>
            <% } %>
            <% if (username != null) { %>
                <li><a href="logout.jsp">Logout</a></li>
            <% } else { %>
                <li><a href="login.jsp">Login</a></li>
            <% } %>
        </ul>
    </nav>

    <!-- Welcome Section -->
    <section class="welcome-section">
        <h1>
            <% if (username != null) { %>
                Welcome, <%= username %>!
            <% } else { %>
                Welcome to Shiny Home Services!
            <% } %>
        </h1>
        <p>Your trusted partner for professional cleaning services.</p>
    </section>
    
    <!-- Hero Section -->
	<section id="home" class="hero-section">
	    <div class="hero-overlay">
	        <h1>Professional Cleaning Services at Your Doorstep</h1>
	        <p>Your trusted partner for a cleaner, healthier environment.</p>
	        <button onclick="location.href='<%= redirectURL %>'" class="custom-btn">Book a Service</button>
	        
	    </div>
	</section>
    

    <!-- Section 2: Leaders in Professional Cleaning -->
    <section class="leaders-section">
        <div class="container">
            <h2>Leaders in Professional Cleaning Services in Singapore</h2>
            <p>Shiny’s years of experience have positioned us as leaders in professional cleaning services. We encompass a full range of deep cleaning and sanitation solutions for residential and corporate spaces. Our singular aim is to enhance your environment to a superior state of cleanliness and hygiene.</p>
            <div class="service-highlights">
                <div class="highlight">
                    <img src="assets/safety-icon.png" alt="Safety Icon">
                    <h3>Safety of Cleaning Agents</h3>
                </div>
                <div class="highlight">
                    <img src="assets/cleaning-operation-icon.png" alt="Cleaning Icon">
                    <h3>An Extraordinary Cleaning Operation</h3>
                </div>
            </div>
            <a href="about.jsp" class="btn">About Us</a>
        </div>
    </section>

    <!-- Section 3: Customer Testimonials -->
    <section class="testimonials-section">
        <div class="container">
            <h2>Hear What Our Customers Have to Say</h2>
            <p>Trusted by both local and expat communities, we are rated 4.7/5 stars on Google by over 2,600+ users!</p>
            <div class="testimonial-cards">
                <div class="testimonial">
                    <p>"Shiny’s cleaners are professional and reliable. They’ve made my life so much easier!"</p>
                    <span>@happy_customer</span>
                </div>
                <div class="testimonial">
                    <p>"The deep cleaning service was exceptional. My home looks brand new. Highly recommended!"</p>
                    <span>@clean_home_owner</span>
                </div>
                <div class="testimonial">
                    <p>"I’m so glad I found Shiny! They are fast, efficient, and always leave my house spotless."</p>
                    <span>@busy_professional</span>
                </div>
            </div>
        </div>
    </section>

    <!-- Section 4: Benefits for Your Organization -->
    <section class="benefits-section">
        <div class="container">
            <h2>The Benefits for Your Organization</h2>
            <div class="benefit-cards">
                <div class="benefit">
                    <h3>Increased Efficiency</h3>
                    <p>Automating the booking process removes manual coordination and saves time.</p>
                </div>
                <div class="benefit">
                    <h3>Better Service</h3>
                    <p>Instant appointment booking eliminates back-and-forth communication hassles.</p>
                </div>
                <div class="benefit">
                    <h3>Decreased No-shows</h3>
                    <p>Automatic reminders ensure appointments are not forgotten or missed.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Section 5: Contact Us -->
    <section class="contact-section">
        <div class="container">
            <h2>Contact Us</h2>
            <div class="contact-details">
                <div>
                    <h3>Address</h3>
                    <p>5 Yishun Industrial Street 1<br>#01-24 Northspring BizHub</p>
                </div>
                <div>
                    <h3>Operating Hours</h3>
                    <p>Weekdays: 9am - 6pm<br>Saturday: 9am - 6pm</p>
                </div>
                <div>
                    <h3>Phone</h3>
                    <p>+65 6602 8171</p>
                </div>
                <div>
                    <h3>Email</h3>
                    <p>enquiry@shiny.com<br>corporate@shiny.com</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <jsp:include page="footer.html" />

</body>
</html>
