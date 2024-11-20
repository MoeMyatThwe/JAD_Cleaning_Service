
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    
    
</head>
<body>
   
    <!-- Welcome Section -->
    <section class="welcome-section">
        <h1>
            <% if (username != null) { %>
                Welcome, <%= username %>!
            <% } else { %>
                Welcome to Shiny Home Services!
            <% } %>
        </h1>
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
		<section class="leaders-section py-5">
    <div class="container">
        <!-- Left Column: Text and Button -->
        <div class="row align-items-center">
            <div class="col-md-6">
                <h2 class="mb-4">Leaders in Professional Cleaning Services in Singapore</h2>
                <p class="mb-4 text-muted">
                    Shiny’s years of experience have positioned us as the leaders in professional cleaning services in Singapore. 
                    We encompass a full range of deep cleaning and sanitation solutions for residential and corporate spaces. 
                    Our singular aim is to enhance your environment to a superior state of cleanliness and hygiene.
                </p>
                 <a href="#contact-us" class="btn btn-outline-dark px-4 py-2">Contact Us</a>
            </div>

            <!-- Right Column: Highlights -->
            <div class="col-md-6">
                <div class="service-highlights d-flex">
                    <!-- Highlight 1 -->
                    <div class="highlight">
                        <img src="/JAD_Cleaning_Service_CA1/JAD-CA1/gallery/spray_img1.jpg" alt="Safety Icon">
                        <h4>Safety of Cleaning Agents</h4>
                    </div>
                    <!-- Highlight 2 -->
                    <div class="highlight">
                        <img src="/JAD_Cleaning_Service_CA1/JAD-CA1/gallery/clean_home1.png" alt="Cleaning Icon">
                        <h4>An Extraordinary Cleaning Operation</h4>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
	
    <!-- Section 3: Customer Testimonials -->
    <section class="testimonials-section">
    <div class="container">
        <!-- Heading -->
        <h2 class="section-title">Hear What Our Customers Have to Say</h2>
        <p class="section-subtitle">
            Trusted by both local & expat communities, we are rated 4.7/5 stars on Google by over 2,600+ users!
        </p>

        <!-- Testimonial Cards -->
        <div class="testimonials">
            <!-- Testimonial 1 -->
            <div class="testimonial-card">
                <img src="/JAD_Cleaning_Service_CA1/JAD-CA1/gallery/verify.png" alt="Review Icon" class="review-icon">
                <p class="testimonial-text">
                    “All pretty mummies need time for their hair and nails, right? I’m so happy that I found a part-time cleaner. She frees up so much of my weekends!”
                </p>
                <span class="customer-name">@midiforreal</span>
                <div class="rating">★★★★★</div>
            </div>

            <!-- Testimonial 2 -->
            <div class="testimonial-card">
                <img src="/JAD_Cleaning_Service_CA1/JAD-CA1/gallery/verify.png" alt="Review Icon" class="review-icon">
                <p class="testimonial-text">
                    “I’ve worked with many helpers before. They go through training, so the quality is consistent. Highly recommend them!”
                </p>
                <span class="customer-name">@keweitay</span>
                <div class="rating">★★★★★</div>
            </div>

            <!-- Testimonial 3 -->
            <div class="testimonial-card">
                <img src="/JAD_Cleaning_Service_CA1/JAD-CA1/gallery/verify.png" alt="Review Icon" class="review-icon">
                <p class="testimonial-text">
                    “No housework means more time for work! My house is squeaky clean every week. So happy with the service!”
                </p>
                <span class="customer-name">@miss_luxe</span>
                <div class="rating">★★★★★</div>
            </div>
        </div>
    </div>
</section>
    

   <!-- Section 4: Benefits for Your Organization -->
<!-- Section 4: Benefits for Your Organization -->
<section class="benefits-section">
    <div class="container">
        <h2 class="section-title">The Benefits for Your Organization</h2>
        <div class="benefit-cards">
            <!-- Benefit Card 1 -->
            <div class="benefit-card">
                <img src="/JAD_Cleaning_Service_CA1/JAD-CA1/gallery/efficiency.png" alt="Efficiency Icon" class="benefit-icon">
                <h3>Increased Efficiency</h3>
                <p>Automating the booking process removes manual coordination and saves time.</p>
            </div>
            <!-- Benefit Card 2 -->
            <div class="benefit-card">
                <img src="/JAD_Cleaning_Service_CA1/JAD-CA1/gallery/betterService.png" alt="Service Icon" class="benefit-icon">
                <h3>Better Service</h3>
                <p>Instant appointment booking eliminates back-and-forth communication hassles.</p>
            </div>
            <!-- Benefit Card 3 -->
            <div class="benefit-card">
                <img src="/JAD_Cleaning_Service_CA1/JAD-CA1/gallery/reminder.png" alt="reminder Icon" class="benefit-icon">
                <h3>Decreased No-shows</h3>
                <p>Automatic reminders ensure appointments are not forgotten or missed.</p>
            </div>
        </div>
    </div>
</section>

   

    <!-- Section 5: Contact Us -->
    <section id="contact-us" class="contact-section">
    <div class="container">
        <h2 class="section-title">Contact Us</h2>
        <div class="contact-details">
            <!-- Address -->
            <div class="contact-item">
                <i class="fas fa-map-marker-alt contact-icon"></i>
                <div>
                    <h3>Address</h3>
                    <p>5 Yishun Industrial Street 1<br>#01-24 Northspring BizHub</p>
                </div>
            </div>
            <!-- Operating Hours -->
            <div class="contact-item">
                <i class="fas fa-clock contact-icon"></i>
                <div>
                    <h3>Operating Hours</h3>
                    <p>Weekdays: 9am - 6pm<br>Saturday: 9am - 6pm</p>
                </div>
            </div>
            <!-- Phone -->
            <div class="contact-item">
                <i class="fas fa-phone contact-icon"></i>
                <div>
                    <h3>Phone</h3>
                    <p>+65 6602 8171</p>
                </div>
            </div>
            <!-- Email -->
            <div class="contact-item">
                <i class="fas fa-envelope contact-icon"></i>
                <div>
                    <h3>Email</h3>
                    <p>enquiry@shiny.com<br>corporate@shiny.com</p>
                </div>
            </div>
        </div>
    </div>
</section>
    
    

    <!-- Footer -->
    <jsp:include page="footer.html" />

</body>
</html>
