<%-- 
    Document   : login
    Created on : Apr 22, 2026, 12:00:24 PM
    Author     : abhi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Account</title>
  <link rel="icon"
      type="image/png"
      href="${pageContext.request.contextPath}/images/favicon_1.png">
  <link rel="stylesheet" href="CSS/login.css"/>
</head>

<body>

<div class="container">
    <div class="login-box">
        <div class="logo">Podcuast Manager</div>
        <h2>login to your Account</h2>

        <form action="${pageContext.request.contextPath}/home.fin" method="post">
            
            <input type="email" name="email"
                   placeholder="youremails@234gmail.com"
                   required 
                   title="please enter the valid email">
            <input type="password" name="password" 
                   placeholder="Rupal#@457sh"
                   required pattern="^[A-Za-z0-9@#$%&*()_+]{6,30}$"
                   title="password must be 6 to 30 character long">

            <input type="submit" class="btn" value="Login">
        </form>

        <a class="signup-link" href="${pageContext.request.contextPath}/index.fin">
            No have an account? Sign up 
        </a>
    </div>
</div>

</body>
</html>

