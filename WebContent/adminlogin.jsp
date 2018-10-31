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
/*navigation menu */
ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    background-color: #333;
}

li {
    float: left;
}

li a, .dropbtn {
    display: inline-block;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}

li a:hover, .dropdown:hover .dropbtn {
    background-color: red;
}

li.dropdown {
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
}

.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    text-align: left;
}

.dropdown-content a:hover {background-color: #f1f1f1}

.show {display:block;}

</style>
</head>
<body>
<h1 align="center" style="color:"> Foodzilla Admin </h1>
<ul>
  <li><a href="adminlogin.jsp">Home</a></li>
  <li><a href="acontact.html">Contact</a></li>
  <li><a href="aabout.html">About</a></li>

</ul>

<br>
<br>
<div  align="center">
<form name="Form1" action="AdminLogin" method="post" accept-charset="utf-8" > 
<input type="hidden" name="sessionid" value="12345" > 
    <table >  
        <tr><td><label for="umail"><b>Email</b></label></td>  
        <td><input type="email" name="umail" placeholder="mailid@email.com" required></td></tr>
        <tr><td> </td></tr>
        <tr><td><label for="password"><b>Password </b></label></td>  
        <td><input type="password" name="password"  required></td></tr>    
        <tr><td><input type="submit" value="Login"></td> 
        <td><input type="reset" value="Reset"></td></tr> 
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