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
/* navigation bar */
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
/* dropdown menu style */ 
.dropbtn {
    background-color: #4CAF50;
    color: white;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;
}

.dropbtn:hover, .dropbtn:focus {
    background-color: #3e8e41;
}

.dropdown {
    float: right;
    position: relative;
    display: inline-block;
    
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    overflow: auto;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    right: 0;
}

.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdown a:hover {background-color: #f1f1f1}

.show {display:block;}

</style>
<script>
/* When the user clicks on the button, 
toggle between hiding and showing the dropdown content */
function dropFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {

    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}
</script>

</head>
<body>
<h1 align="center" style="color:"> Foodzilla </h1>
<div class="nav">
<ul class="nav_list">
  <li class="nav_li"><a href="restaurants.jsp">Home</a></li>
  <li class="nav_li"><a href="orderstatus.jsp">Orders</a></li>
  <li class="nav_li"><a href="reviews.jsp">Reviews</a></li>
  <li class="nav_li"><a href="contact.html">Contact</a></li>
  <li class="nav_li"><a href="about.html">About</a></li>
</ul>
</div>

<%
String userName = (String) session.getAttribute("mail_id");
if (null == userName) {
   request.setAttribute("SessionError", "Session has ended.  Please login.");
   RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
   rd.forward(request, response);
}

HttpSession hp= request.getSession();
out.println("<div class=\"dropdown\">");
out.println("<button onclick=\"dropFunction()\" class=\"dropbtn\">"+hp.getAttribute("username")+" &#8711;</button>");
out.println("<div id=\"myDropdown\" class=\"dropdown-content\">");
out.println("<a href=\"chpasswd.jsp\">Change password</a>");
out.println("<a href=\"updatead.jsp\">Update contact details</a>");
out.println("<a href=\"logout.jsp\">Logout</a>");
out.println("</div></div>");
%>

<h3>Please enter below your new password</h3>
<form name="ChPasswdForm1" action="chpasswd.jsp" method="post">
<table>
        <tr>
        <td><label for="password">Password</label> </td> 
        <td> <input type="password" name="password" pattern=".{6,}" required title="6 characters minimum"></td>
        <td> (*password must be at least 6 characters long)</td>
        </tr>
        <tr> 
        <td><input type="submit" name="changepasswordbtn"value="Change Password"></td> 
        </tr>   
 </table>
 </form>
 
 <%
if(request.getParameter("changepasswordbtn")!= null && request.getParameter("changepasswordbtn").isEmpty()!=true)
{
try
{
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","hr","hr");

String password=request.getParameter("password");

HttpSession h= request.getSession();
String usermail=(String)h.getAttribute("mail_id");
int i=0;
String query="UPDATE CUSTOMER SET PASSWORD='"+password+"' WHERE MAIL_ID='"+usermail+"'";
Statement stmt=con.createStatement();
i=stmt.executeUpdate(query);
if(i>0)
{
		out.println("Password Changed Successfully !!! <br>");
	
}else
{
	out.println("We are sorry, we are having technical issues. Kindly check later. Please contact support team. <br>");
}

con.close();
}
catch (Exception e) {
e.printStackTrace();
}
}
%>
</body>
</html>