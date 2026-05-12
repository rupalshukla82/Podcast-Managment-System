<%-- 
    Document   : sidebar
    Created on : May 4, 2026, 8:00:10 PM
    Author     : abhi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

         <%-- SIDEBAR --%>
    <div class="sidebar">
        <div class="logo">
            <i class="fa-solid fa-microphone"></i> PodcastMgr
        </div>

        <a class="nav-link active" href="${pageContext.request.contextPath}/home.fin">
            <i class="fa-solid fa-house"></i> Home
        </a>
        <a class="nav-link" href="${pageContext.request.contextPath}/podcast/search.fin">
            <i class="fa-solid fa-magnifying-glass"></i> Search
        </a>
        <a class="nav-link" href="${pageContext.request.contextPath}/profile.fin">
            <i class="fa-solid fa-user"></i> My Profile
        </a>
        <div class="nav-link" onclick="openModal()">
            <i class="fa-solid fa-plus"></i> Add Podcast
        </div>

        <hr class="sidebar-divider">
        <div class="sidebar-label">Categories</div>

        <a class="cat-link" href="${pageContext.request.contextPath}/podcast/category.fin?cat=Horror">
            <i class="fa-solid fa-skull"></i> Horror
        </a>
        <a class="cat-link" href="${pageContext.request.contextPath}/podcast/category.fin?cat=Love">
            <i class="fa-solid fa-heart"></i> Love
        </a>
        <a class="cat-link" href="${pageContext.request.contextPath}/podcast/category.fin?cat=Comedy">
            <i class="fa-solid fa-face-laugh"></i> Comedy
        </a>
        <a class="cat-link" href="${pageContext.request.contextPath}/podcast/category.fin?cat=Technology">
            <i class="fa-solid fa-microchip"></i> Technology
        </a>
        <a class="cat-link" href="${pageContext.request.contextPath}/podcast/category.fin?cat=Education">
            <i class="fa-solid fa-graduation-cap"></i> Education
        </a>
        <a class="cat-link" href="${pageContext.request.contextPath}/podcast/category.fin?cat=Business">
            <i class="fa-solid fa-briefcase"></i> Business
        </a>
    </div>
 
