<%-- 
    Document   : home
    Created on : Apr 22, 2026, 10:02:36 PM
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
        <title>PodcastMgr - Home</title>
        <link rel="icon" 
      type="image/png"
      href="${pageContext.request.contextPath}/images/favicon_1.png">
         <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/CSS/Style.css" rel="stylesheet">
    </head>
    <body>

        <%-- SESSION CHECK --%>
        <%
            Users user = (Users) session.getAttribute("loggedUser");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login.fin");
                return;
            }

            List<Podcast> allPodcasts = (List<Podcast>) request.getAttribute("allPodcasts");
            if (allPodcasts == null) {
                allPodcasts = new java.util.ArrayList<>();
            }

            String letter = user.getName().substring(0, 1).toUpperCase();

            java.util.Calendar cal = java.util.Calendar.getInstance();
            int hour = cal.get(java.util.Calendar.HOUR_OF_DAY);
            String greet = hour < 12 ? "Good morning" : hour < 17 ? "Good afternoon" : "Good evening";
        %>

        <div class="layout">

            <!----- side baar ----->
            <%@ include file="/WEB-INF/jsp/components/sidebar.jsp" %>

            <%-- MAIN --%>
            <div class="main">

                <%-- TOP BAR --%>
                <%@include file="/WEB-INF/jsp/components/topbar.jsp" %>

                <%-- CONTENT --%>
                <div class="content">

                    <div class="greeting"><%= greet%>, <%= user.getName()%></div>

                    <%-- RECENTLY ADDED --%>
                    <div class="sec-header">
                        <div class="sec-title">
                            <i class="fa-solid fa-bolt"></i> Recently Added
                        </div>
                        <a class="sec-link" href="${pageContext.request.contextPath}/podcast/search.fin">See all</a>
                    </div>
                    <div class="feat-grid">
                        <% int count = 0;
                            for (Podcast p : allPodcasts) {
                                if (count >= 6)
                                    break;%>
                        <div class="feat-card" onclick="playPodcast('<%= p.getId()%>', '<%= p.getTitle().replace("'", "\\'")%>',
                                        '<%= p.getAuthor().replace("'", "\\'")%>', '<%= p.getAudioUrl() != null
                                      ? p.getAudioUrl() : p.getFeedUrl()%>', '<%= p.getCoverImageUrl() != null ? p.getCoverImageUrl() : ""%>')">

                            <% if (p.getCoverImageUrl() != null && !p.getCoverImageUrl().isEmpty()) {%>
                            <img class="feat-img" src="<%= p.getCoverImageUrl()%>" alt="cover" onerror="this.style.display='none'">
                            <% } else { %>
                            <div class="feat-img-placeholder">
                                <i class="fa-solid fa-microphone"></i>
                            </div>

                            <% }%>
                            <div class="feat-name"><%= p.getTitle()%></div>

                        </div>

                        <% count++;
                            } %>
                    </div>

                    <%-- HORROR --%>
                    <div class="sec-header">
                        <div class="sec-title">
                            <i class="fa-solid fa-skull"></i> Horror Stories
                        </div>
                        <a class="sec-link" href="${pageContext.request.contextPath}/podcast/category.fin?cat=Horror">See all</a>
                    </div>
                    <%-- HORROR CARDS --%>
                    <div class="cards-row">
                        <% int h = 0;
                            for (Podcast p : allPodcasts) {
                                if (!p.getCategory().equals("Horror") || h >= 4) {
                                    continue;
                                }
                                boolean mine = p.getUserId() == user.getID();%>
                        <div class="pod-card" onclick="playPodcast('<%= p.getId()%>', '<%= p.getTitle().replace("'", "\\'")%>', '<%= p.getAuthor().replace("'", "\\'")%>', '<%= p.getAudioUrl() != null ? p.getAudioUrl() : p.getFeedUrl()%>', '<%= p.getCoverImageUrl() != null ? p.getCoverImageUrl() : ""%>')">
                            <% if (mine) { %><div class="mine-badge">Yours</div><% } %>
                            <div class="pod-art">
                                <% if (p.getCoverImageUrl() != null && !p.getCoverImageUrl().isEmpty()) {%>
                                <img src="<%= p.getCoverImageUrl()%>" alt="cover" onerror="this.style.display='none'">
                                <% } else { %>
                                <div class="pod-art-placeholder">
                                    <i class="fa-solid fa-skull"></i>
                                </div>
                                <% }%>
                                <button class="play-fab"><i class="fa-solid fa-play"></i></button>
                            </div>
                            <div class="pod-title"><%= p.getTitle()%></div>
                            <div class="pod-author"><%= p.getAuthor()%></div>
                            <div class="pod-cat"><%= p.getCategory()%></div>
                            <%-- Add this INSIDE each pod-card after pod-cat --%>

                            <% if (p.getDescription() != null && !p.getDescription().isEmpty()) {%>
                            <div class="pod-desc"><%= p.getDescription().length() > 60 ? p.getDescription().substring(0, 60) + "..." : p.getDescription()%></div>
                            <span class="read-more"
                                  onclick="event.stopPropagation();
                  openDescModal(
                          '<%= p.getTitle().replace("'", "\\'")%>',
                          '<%= p.getDescription().replace("\\", "\\\\").replace("'", "\\'").replace("\n", "\\n").replace("\r", "")%>'
                          )">Read more</span>
                            <% } %>
                        </div>
                        <% h++;
                            } %>
                    </div>

                    <%-- LOVE --%>
                    <div class="sec-header">
                        <div class="sec-title">
                            <i class="fa-solid fa-heart"></i> Love Stories
                        </div>
                        <a class="sec-link" href="${pageContext.request.contextPath}/podcast/category.fin?cat=Love">See all</a>
                    </div>
                    <div class="cards-row">
                        <% int l = 0;
                            for (Podcast p : allPodcasts) {
                                if (!p.getCategory().equals("Love") || l >= 4) {
                                    continue;
                                }
                                boolean mine = p.getUserId() == user.getID();%>
                        <div class="pod-card" onclick="playPodcast('<%= p.getId()%>', '<%= p.getTitle().replace("'", "\\'")%>',
                                        '<%= p.getAuthor().replace("'", "\\'")%>', '<%= p.getAudioUrl() != null
                                        ? p.getAudioUrl() : p.getFeedUrl()%>', '<%= p.getCoverImageUrl() != null ? p.getCoverImageUrl() : ""%>')">
                            <% if (mine) { %><div class="mine-badge">Yours</div><% } %>
                            <div class="pod-art">
                                <% if (p.getCoverImageUrl() != null && !p.getCoverImageUrl().isEmpty()) {%>
                                <img src="<%= p.getCoverImageUrl()%>" alt="cover" onerror="this.style.display='none'">
                                <% } else { %>
                                <div class="pod-art-placeholder">
                                    <i class="fa-solid fa-heart"></i>
                                </div>
                                <% }%>
                                <button class="play-fab">
                                    <i class="fa-solid fa-play"></i>
                                </button>
                            </div>
                            <div class="pod-title"><%= p.getTitle()%></div>
                            <div class="pod-author"><%= p.getAuthor()%></div>
                            <div class="pod-cat"><%= p.getCategory()%></div>

                            <%-- Add this INSIDE each pod-card after pod-cat --%>

                            <% if (p.getDescription() != null && !p.getDescription().isEmpty()) {%>
                            <div class="pod-desc"><%= p.getDescription().length() > 60 ? p.getDescription().substring(0, 60) + "..." : p.getDescription()%></div>
                            <span class="read-more"
                                  onclick="event.stopPropagation(); openDescModal(
                          '<%= p.getTitle().replace("'", "\\'")%>',
                          '<%= p.getDescription().replace("\\", "\\\\").replace("'", "\\'").replace("\n", "\\n").replace("\r", "")%>'
                          )">Read more</span>
                            <% } %>
                        </div>
                        <% l++;
                            } %>
                    </div>

                    <%-- ALL PODCASTS --%>
                    <div class="sec-header">
                        <div class="sec-title">
                            <i class="fa-solid fa-fire"></i> All Podcasts
                        </div>
                        <a class="sec-link" href="${pageContext.request.contextPath}/podcast/search.fin">See all</a>
                    </div>
                    <div class="cards-row">
                        <% int a = 0;
                            for (Podcast p : allPodcasts) {
                                if (a >= 4) {
                                    break;
                                }
                                boolean mine = p.getUserId() == user.getID();%>
                        <div class="pod-card" onclick="playPodcast('<%= p.getId()%>', '<%= p.getTitle().replace("'", "\\'")%>'
                                        , '<%= p.getAuthor().replace("'", "\\'")%>', '<%= p.getAudioUrl() != null
                                       ? p.getAudioUrl() : p.getFeedUrl()%>', '<%= p.getCoverImageUrl() != null ? p.getCoverImageUrl() : ""%>')">
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
                            <%-- Add this INSIDE each pod-card after pod-cat --%>
                            <div class="pod-title"><%= p.getTitle()%></div>
                            <div class="pod-author"><%= p.getAuthor()%></div>
                            <div class="pod-cat"><%= p.getCategory()%></div>
                            <% if (p.getDescription() != null && !p.getDescription().isEmpty()) {%>
                            <div class="pod-desc"><%= p.getDescription().length() > 60 ? p.getDescription().substring(0, 60) + "..." : p.getDescription()%></div>
                            <span class="read-more"
                                  onclick="event.stopPropagation();
                  openDescModal(
                          '<%= p.getTitle().replace("'", "\\'")%>',
                          '<%= p.getDescription().replace("\\", "\\\\").replace("'", "\\'").replace("\n", "\\n").replace("\r", "")%>'
                          )">Read more</span>
                            <% } %>
                        </div>
                        <% a++;
                            } %>
                        <% if (allPodcasts.isEmpty()) { %>
                        <p style="color:#a0a0a0;font-size:13px">No podcasts yet. Add the first one!</p>
                        <% } %>
                    </div>

                </div><%-- end content --%>

                <%-- PLAYER BAR --%>
                <%@include file="/WEB-INF/jsp/components/playbaar.jsp" %>

            </div><%-- end main --%>
        </div><%-- end layout --%>

        <%-- ADD PODCAST MODAL --%>
        <div class="modal-overlay" id="modalOverlay">
            <div class="modal">
                <h3><i class="fa-solid fa-circle-plus"></i> Add New Podcast</h3>
                <p>Paste a real RSS feed link — cover image fetched automatically!</p>
                <input type="text" id="f-title"  placeholder="Podcast title *">
                <input type="text" id="f-author" placeholder="Author / Narrator *">
                <select id="f-cat">
                    <option value="">Select category *</option>
                    <option>Horror</option>
                    <option>Love</option>
                    <option>Comedy</option>
                    <option>Technology</option>
                    <option>Education</option>
                    <option>Business</option>
                </select>
                <input type="text" id="f-url" placeholder="RSS Feed URL * (e.g. https://anchor.fm/s/xxx/podcast/rss)">
                <div class="info-msg" id="infoMsg"></div>
                <div class="err-msg"  id="errMsg"></div>
                <textarea id="f-desc" placeholder="Short description (optional)"></textarea>
                <div class="modal-btns">
                    <button class="btn-cancel" onclick="closeModal()">Cancel</button>
                    <button class="btn-save" id="saveBtn"
                            onclick="savePodcast('${pageContext.request.contextPath}')">
                        <i class="fa-solid fa-floppy-disk"></i> Save Podcast
                    </button>
                </div>
            </div>
        </div>



        <!-- DESCRIPTION MODAL -->
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

        <%-- PODCAST LIST FOR JS PLAYER --%>

        <script>
            var podList = [
            <% for (int i = 0; i < allPodcasts.size(); i++) {
                    Podcast p = allPodcasts.get(i);%>
            {
            id:'<%= p.getId()%>',
                    title:'<%= p.getTitle().replace("'", "\\'")%>',
                    author:'<%= p.getAuthor().replace("'", "\\'")%>',
                    feedUrl:'<%= p.getAudioUrl() != null ? p.getAudioUrl() : p.getFeedUrl()%>',
                    coverUrl:'<%= p.getCoverImageUrl() != null ? p.getCoverImageUrl() : ""%>'
            }<%= i < allPodcasts.size() - 1 ? "," : ""%>
            <% }%>
            ];
        </script>
        <script src="${pageContext.request.contextPath}/js/script.js"></script>

    </body>
</html>


