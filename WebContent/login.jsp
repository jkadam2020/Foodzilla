<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Foodzilla</title>
<style>
body {
    background-image: url("images/cutefd.jpg");
    background-position: center top;
    background-size: 100% auto;
    }
ul.nav_list {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    background-color: #333;
}

li.nav_li {
    float: left;
}

li.nav_li a {
    display: block;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}

li.nav_li a:hover {
    background-color: #111;
}
</style>
</head>
<body>
<h1 align="center" style="color:"> Foodzilla </h1>
<div class="nav">
<ul class="nav_list">
  <li class="nav_li"><a href="login.jsp">Home</a></li>
  <li class="nav_li"><a href="contact.html">Contact</a></li>
  <li class="nav_li"><a href="about.html">About</a></li>
</ul>
</div>
<br>
<br>
<div  align="center">
<form name="Form1" action="LoginClass" method="post" accept-charset="utf-8" > 
<input type="hidden" name="sessionid" value="12345" > 
    <table >  
        <tr><td><label for="umail"><b>Email</b></label></td>  
        <td><input type="email" name="umail" placeholder="mailid@email.com" required></td></tr>
        <tr><td> </td></tr>
        <tr><td><label for="password"><b>Password </b></label></td>  
        <td><input type="password" name="password"  required></td></tr>    
        <tr><td><input type="submit" value="Login"></td> 
        <td><input type="reset" value="Reset"></td></tr> 
     <tr><td colspan="2">    
   <b><a href="signup.html">Sign Up Here!!!</a></b> </td></tr> 
</table>
</form>  
</div>
<%
if(null!=request.getAttribute("errorMsg"))
{
out.println("<h3 align=\"left\" style=\"color:\red\">");
out.println(request.getAttribute("errorMsg"));
out.println("</h3>");
}
if(null!=request.getAttribute("SessionError"))
{
out.println("<h3 align=\"left\" style=\"color:\red\">");
out.println(request.getAttribute("SessionError"));
out.println("</h3>");
}
%>
</body>
</html>