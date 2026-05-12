<%-- 
    Document   : topbar
    Created on : May 4, 2026, 8:40:16 PM
    Author     : abhi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.sqlutilitycrud.model.Users"%>

 
          <%-- TOP BAR --%>
        <div class="topbar">
            <div class="search-box">
                <i class="fa-solid fa-magnifying-glass" style="color:#555"></i>
                <input type="text" id="searchInput"
                       placeholder="Search podcasts..."
                       onkeydown="if(event.key==='Enter') doSearch('${pageContext.request.contextPath}')">
            </div>
            <button class="btn-green" onclick="openModal()">
                <i class="fa-solid fa-plus"></i> Add Podcast
            </button>
            <a class="user-avatar"
               href="${pageContext.request.contextPath}/profile.fin"
               title="<%= user.getName() %>"><%= letter %></a>
        </div>
  
