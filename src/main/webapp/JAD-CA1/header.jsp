<%@ page session="true" %>
<%
Integer userId = (Integer) session.getAttribute("userId"); // Retrieve user ID from session
String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role"); // Retrieve role from session
%>
<header>
    <nav>
        <div class="navbar-container">
            <!-- Logo and Brand Name -->
            <div class="logo">
                <a href="home.jsp">
                    <img src="/JAD_Cleaning_Service_CA1/JAD-CA1/gallery/ShinyLogo.jpg" alt="Shiny Logo">
                    Shiny
                </a>
            </div>

            <!-- Hamburger Menu Icon -->
            <div class="hamburger-menu" onclick="toggleMenu()">
                <span></span>
                <span></span>
                <span></span>
            </div>

            <!-- Navbar Links -->
            <ul class="navbar">
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
                    <li><a href="cart.jsp">Cart</a></li>
                    <li><a href="serviceHistory.jsp">Feedback</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                <% } else { %>
                    <li><a href="login.jsp">Login</a></li>
                <% } %>
            </ul>
        </div>
    </nav>
</header>

<script>
    function toggleMenu() {
        const navbar = document.querySelector('.navbar');
        navbar.classList.toggle('show');
    }
</script>
