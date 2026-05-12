<%-- 
    Document   : search
    Created on : May 3, 2026, 8:41:09 PM
    Author     : abhi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.sqlutilitycrud.model.Users"%>
<%@page import="com.mycompany.sqlutilitycrud.model.Podcast"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>PodcastMgr - Search</title>
          <link rel="icon" 
      type="image/png"
      href="${pageContext.request.contextPath}/images/favicon_1.png">
        <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/CSS/Style.css" rel="stylesheet">
    </head>
    <body>

        <%
            Users user = (Users) session.getAttribute("loggedUser");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login.fin");
                return;
            }
            List<Podcast> results = (List<Podcast>) request.getAttribute("results");
            if (results == null) {
                results = new java.util.ArrayList<>();
            }
            String keyword = (String) request.getAttribute("keyword");
            if (keyword == null) {
                keyword = "";
            }
            String letter = user.getName().substring(0, 1).toUpperCase();
        %>

        <div class="layout">

            <%@include file="/WEB-INF/jsp/components/sidebar.jsp" %>

            <div class="main">

                <%@include file="/WEB-INF/jsp/components/topbar.jsp" %>

                <div class="content">

                    <div class="cat-pills">
                        <a class="cat-pill <%= keyword.isEmpty() ? "active" : ""%>"
                           href="${pageContext.request.contextPath}/podcast/search.fin?q=">All</a>
                        <a class="cat-pill <%= keyword.equals("Horror") ? "active" : ""%>"
                           href="${pageContext.request.contextPath}/podcast/category.fin?cat=Horror">
                            <i class="fa-solid fa-skull"></i> Horror</a>
                        <a class="cat-pill <%= keyword.equals("Love") ? "active" : ""%>"
                           href="${pageContext.request.contextPath}/podcast/category.fin?cat=Love">
                            <i class="fa-solid fa-heart"></i> Love</a>
                        <a class="cat-pill <%= keyword.equals("Comedy") ? "active" : ""%>"
                           href="${pageContext.request.contextPath}/podcast/category.fin?cat=Comedy">
                            <i class="fa-solid fa-face-laugh"></i> Comedy</a>
                        <a class="cat-pill <%= keyword.equals("Technology") ? "active" : ""%>"
                           href="${pageContext.request.contextPath}/podcast/category.fin?cat=Technology">
                            <i class="fa-solid fa-microchip"></i> Technology</a>
                        <a class="cat-pill <%= keyword.equals("Education") ? "active" : ""%>"
                           href="${pageContext.request.contextPath}/podcast/category.fin?cat=Education">
                            <i class="fa-solid fa-graduation-cap"></i> Education</a>
                        <a class="cat-pill <%= keyword.equals("Business") ? "active" : ""%>"
                           href="${pageContext.request.contextPath}/podcast/category.fin?cat=Business">
                            <i class="fa-solid fa-briefcase"></i> Business</a>
                    </div>

                    <div class="results-title">
                        <% if (!keyword.isEmpty()) {%>
                        <i class="fa-solid fa-magnifying-glass"></i> Results for "<%= keyword%>"
                        <% } else { %>
                        <i class="fa-solid fa-fire"></i> All Podcasts
                        <% }%>
                    </div>
                    <div class="results-count">
                        <i class="fa-solid fa-list"></i> <%= results.size()%> podcast<%= results.size() != 1 ? "s" : ""%> found
                    </div>

                    <% if (results.isEmpty()) {%>
                    <div class="empty-box">
                        <div class="empty-ico"><i class="fa-solid fa-magnifying-glass"></i></div>
                        <p>No podcasts found for "<%= keyword%>"</p>
                    </div>
                    <% } else { %>
                    <div class="cards-row">
                        <% for (Podcast p : results) {
                                boolean mine = p.getUserId() == user.getID();%>
                        <div class="pod-card" onclick="playPodcast('<%= p.getId()%>', '<%= p.getTitle().replace("'", "\\'")%>', '<%= p.getAuthor().replace("'", "\\'")%>', '<%= p.getAudioUrl() != null ? p.getAudioUrl() : p.getFeedUrl()%>', '<%= p.getCoverImageUrl() != null ? p.getCoverImageUrl() : ""%>')">
                            <% if (mine) { %><div class="mine-badge">Yours</div><% } %>
                            <div class="pod-art">
                                <% if (p.getCoverImageUrl() != null && !p.getCoverImageUrl().isEmpty()) {%>
                                <img src="<%= p.getCoverImageUrl()%>" alt="cover" onerror="this.style.display='none'">
                                <% } else { %>
                                <div class="pod-art-placeholder">
                                    <i class="fa-solid fa-microphone"></i>
                                </div>
                                <% }%>
                                <button class="play-fab">
                                    <i class="fa-solid fa-play"></i>
                                </button>
                            </div>
                            <div class="pod-title"><%= p.getTitle()%></div>
                            <div class="pod-author"><%= p.getAuthor()%></div>
                            <div class="pod-cat"><%= p.getCategory()%></div>
                            <% if (p.getDescription() != null && !p.getDescription().isEmpty()) { %>
    <div class="pod-desc"><%= p.getDescription().length() > 80 ? p.getDescription().substring(0, 80) + "..." : p.getDescription() %></div>
    <span class="read-more"
          onclick="event.stopPropagation(); openDescModal(
              '<%= p.getTitle().replace("'", "\\'") %>',
              '<%= p.getDescription().replace("\\", "\\\\").replace("'", "\\'").replace("\n", "\\n").replace("\r", "") %>'
          )">Read more</span>
<% } %>
                        </div>
                        <% } %>
                    </div>
                    <% } %>

                </div><%-- end content --%>

                <%@include file="/WEB-INF/jsp/components/playbaar.jsp" %>

            </div><%-- end main --%>
        </div><%-- end layout --%>
<div class="desc-overlay" id="descOverlay">
    <div class="desc-modal">

        <div class="desc-top">
            <h2 id="descTitle"></h2>

            <button class="desc-close"
                    onclick="closeDescModal()">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>

        <div class="desc-content"
             id="descContent">
        </div>

    </div>
</div>
        <script>
            var podList = [
            <% for (int i = 0; i < results.size(); i++) {
                    Podcast p = results.get(i);%>
            { id:'<%= p.getId()%>', title:'<%= p.getTitle().replace("'", "\\'")%>', author:'<%= p.getAuthor().replace("'", "\\'")%>', feedUrl:'<%= p.getAudioUrl() != null ? p.getAudioUrl() : p.getFeedUrl()%>', coverUrl:'<%= p.getCoverImageUrl() != null ? p.getCoverImageUrl() : ""%>' }<%= i < results.size() - 1 ? "," : ""%>
            <% }%>
            ];
        </script>
        <script src="${pageContext.request.contextPath}/js/script.js"></script>

    </body>
</html>