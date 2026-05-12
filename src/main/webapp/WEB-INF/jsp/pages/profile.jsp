<%-- 
    Document   : profile
    Created on : May 3, 2026, 9:01:03 PM
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
    <title>PodcastMgr - My Profile</title>
      <link rel="icon" 
      type="image/png"
      href="${pageContext.request.contextPath}/images/favicon_1.png">
    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/CSS/Style.css" rel="stylesheet">
    <!--<script src="js/script.js" defer></script>-->
</head>
<body>

<%-- SESSION CHECK --%>
<%
    Users user = (Users) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.fin");
        return;
    }

    List<Podcast> myPodcasts = (List<Podcast>) request.getAttribute("myPodcasts");
    if (myPodcasts == null) myPodcasts = new java.util.ArrayList<>();

    String letter = user.getName().substring(0, 1).toUpperCase();
%>

<div class="layout"> 

<%@include file="/WEB-INF/jsp/components/sidebar.jsp" %>

    <%-- MAIN --%>
    <div class="main">

        <%-- TOP BAR --%>
         <%@include file="/WEB-INF/jsp/components/topbar.jsp" %>


        <%-- CONTENT --%>
        <div class="content">

            <%-- PROFILE HEADER --%>
            <div class="profile-header">
                <div class="big-avatar"><%= letter %></div>
                <div>
                    <div class="profile-name"><%= user.getName() %></div>
                    <div class="profile-email">
                        <i class="fa-solid fa-envelope"></i> <%= user.getEmail() %>
                    </div>
                    <div class="profile-stats">
                        <i class="fa-solid fa-microphone"></i>
                        <%= myPodcasts.size() %> podcast<%= myPodcasts.size() != 1 ? "s" : "" %> posted
                    </div>
                </div>
                <a class="btn-logout" href="${pageContext.request.contextPath}/logout.fin">
                    <i class="fa-solid fa-right-from-bracket"></i> Logout
                </a>
            </div>

            <%-- MY PODCASTS --%>
            <div class="sec-header">
                <div class="sec-title">
                    <i class="fa-solid fa-microphone"></i> My Podcasts
                </div>
            </div>

            <% if (myPodcasts.isEmpty()) { %>
                <div class="empty-box">
                    <div class="empty-ico">
                        <i class="fa-solid fa-microphone-slash"></i>
                    </div>
                    <p>You have not added any podcasts yet!</p>
                    <a class="btn-green" href="${pageContext.request.contextPath}/home.fin" style="text-decoration:none;display:inline-block;margin-top:8px">
                        <i class="fa-solid fa-plus"></i> Add Your First Podcast
                    </a>
                </div>
            <% } else { %>
                <div class="cards-row">
                    <% for (Podcast p : myPodcasts) { %>
                    <div class="pod-card">
                        <div class="mine-badge">Yours</div>
                       <div class="pod-art" onclick="playPodcast('<%= p.getId() %>','<%= p.getTitle().replace("'","\\'") %>'
                           ,'<%= p.getAuthor().replace("'","\\'") %>','<%= p.getAudioUrl() != null ? 
                                   p.getAudioUrl() : p.getFeedUrl() %>','<%= p.getCoverImageUrl() != null ? p.getCoverImageUrl() : "" %>')">
                            <% if (p.getCoverImageUrl() != null && !p.getCoverImageUrl().isEmpty()) { %>
                                <img src="<%= p.getCoverImageUrl() %>" alt="cover" onerror="this.style.display='none'">
                            <% } else { %>
                                <div class="pod-art-placeholder">
                                    <i class="fa-solid fa-microphone"></i>
                                </div>
                            <% } %>
                            <button class="play-fab">
                                <i class="fa-solid fa-play"></i>
                            </button>
                        </div>
                        <div class="pod-title"><%= p.getTitle() %></div>
                        <div class="pod-author"><%= p.getAuthor() %></div>
                        <div class="pod-cat"><%= p.getCategory() %></div>

                        <%-- EDIT & DELETE BUTTONS --%>
                        <div class="card-actions">
                            <button class="btn-edit"
                                onclick="openEditModal(
                                    '<%= p.getId() %>',
                                    '<%= p.getTitle().replace("'","\\'") %>',
                                    '<%= p.getAuthor().replace("'","\\'") %>',
                                    '<%= p.getCategory() %>',
                                    '<%= p.getFeedUrl() %>',
                                    '<%= p.getDescription() != null ? p.getDescription().replace("'","\\'") : "" %>'
                                )">
                                <i class="fa-solid fa-pen"></i> Edit
                            </button>
                            <button class="btn-delete"
                                onclick="openDeleteConfirm('<%= p.getId() %>','<%= p.getTitle().replace("'","\\'") %>')">
                                <i class="fa-solid fa-trash"></i> Delete
                            </button>
                        </div>
                    </div>
                    <% } %>
                </div>
            <% } %>

        </div><%-- end content --%>

        <%-- PLAYER BAR --%>
      
        <%@include file="/WEB-INF/jsp/components/playbaar.jsp" %>
        
    </div><%-- end main --%>
</div><%-- end layout --%>

<%-- EDIT MODAL --%>
<div class="modal-overlay" id="editModal">
    <div class="modal">
        <h3><i class="fa-solid fa-pen"></i> Edit Podcast</h3>
        <p>Update your podcast details below.</p>
        <input type="hidden" id="e-id">
        <input type="text"   id="e-title"  placeholder="Podcast title *">
        <input type="text"   id="e-author" placeholder="Author / Narrator *">
        <select id="e-cat">
            <option value="">Select category *</option>
            <option>Horror</option>
            <option>Love</option>
            <option>Comedy</option>
            <option>Technology</option>
            <option>Education</option>
            <option>Business</option>
        </select>
        <input type="text" id="e-url"  placeholder="RSS Feed URL *">
        <textarea          id="e-desc" placeholder="Description (optional)"></textarea>
        <div class="modal-btns">
            <button class="btn-cancel" onclick="closeEditModal()">Cancel</button>
            <button class="btn-save" onclick="submitEdit('${pageContext.request.contextPath}')">
                <i class="fa-solid fa-floppy-disk"></i> Save Changes
            </button>
        </div>
    </div>
</div>

<%-- DELETE CONFIRM --%>
<div class="confirm-overlay" id="confirmOverlay">
    <div class="confirm-box">
        <h3><i class="fa-solid fa-triangle-exclamation"></i> Delete Podcast?</h3>
        <p id="confirmMsg">Are you sure you want to delete this podcast?</p>
        <div class="confirm-btns">
            <button class="btn-no"  onclick="closeConfirm()">Cancel</button>
            <button class="btn-yes" onclick="submitDelete('${pageContext.request.contextPath}')">
                <i class="fa-solid fa-trash"></i> Yes, Delete
            </button>
        </div>
    </div>
</div>

<%-- PODCAST LIST FOR JS PLAYER --%>
<script>
var podList = [
    <% for (int i = 0; i < myPodcasts.size(); i++) {
           Podcast p = myPodcasts.get(i); %>
    { 
        id:'<%= p.getId() %>', 
        title:'<%= p.getTitle().replace("'","\\'") %>', 
        author:'<%= p.getAuthor().replace("'","\\'") %>', 
        feedUrl:'<%= p.getAudioUrl() != null ? p.getAudioUrl() : p.getFeedUrl() %>', 
        coverUrl:'<%= p.getCoverImageUrl() != null ? p.getCoverImageUrl() : "" %>' 
    }<%= i < myPodcasts.size()-1 ? "," : "" %>
    <% } %>
];
</script>
<script src="${pageContext.request.contextPath}/js/script.js"></script>

</body>
</html>

