<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Account</title>
  <link rel="icon" 
      type="image/png"
      href="${pageContext.request.contextPath}/images/favicon_1.png">
  <link rel="stylesheet" href="CSS/signup.css"/>
</head>

<body>

<div class="container">
    <div class="signup-box">
        <div class="logo">Podcuast Manager</div>
        <h2>Sign up to get started</h2>

        <form action="${pageContext.request.contextPath}/register.fin" method="post">
            <input type="text" name="name" 
                   placeholder="Rupal shukla"
                   required pattern="^[A-Za-z ]{2,80}$"
                   title="please enter the valid name">
            <input type="email" name="email"
                   placeholder="youremails@gmail.com"
                   required 
                   title="please enter the valid email">
            <input type="password" name="password" 
                   placeholder="Rupal#@457sh"
                   required pattern="^[A-Za-z0-9@#$%&*()_+]{6,30}$"
                   title="password must be 6 to 30 character long">

            <input type="submit" class="btn" value="Sign Up">
        </form>

        <a class="login-link" href="${pageContext.request.contextPath}/login.fin">
            Already have an account? Log in
        </a>
    </div>
</div>

</body>
</html>