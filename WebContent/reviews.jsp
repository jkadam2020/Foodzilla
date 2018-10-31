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
/* Feedback stars */
.rating {
    overflow: hidden;
    display: inline-block;
    font-size: 0;
}
.rating-input {
    float: right;
    width: 0;
    opacity: 0;
}
.rating:hover .rating-star:hover,
.rating:hover .rating-star:hover ~ .rating-star,
.rating-input:checked ~ .rating-star {
    background-position: 0 0;
}
.rating-star,
.rating:hover .rating-star {
    float: right;
    display: block;
    width: 16px;
    height: 16px;
    background: url('http://kubyshkin.ru/samples/star-rating/star.png') 0 -16px;
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
<h2> Reviews </h2>
<%

try
{
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","hr","hr");

String query="select * from reviews ORDER BY rtime DESC";
Statement s=con.createStatement();
ResultSet R=s.executeQuery(query);

java.text.SimpleDateFormat dateformat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
int i=0;
while(R.next())
{
	String q2="select * from restaurant where rest_id="+R.getInt("rest_id");
	Statement s2=con.createStatement();
	ResultSet R2=s2.executeQuery(q2);

	String q3="select * from customer where cust_id="+R.getInt("cust_id");
	Statement s3=con.createStatement();
	ResultSet R3=s3.executeQuery(q3);
	
	if(R2.next()&& R3.next())
	{
	out.println("<br>");
	out.println("<table border=\"0\" bgcolor=\"#cceeff\">");
	out.println("<tr><td style='width: 200px;'> Restaurant: " + R2.getString("rname") + " </td>");
	out.println("<td style='width: 200px;'> By: " + R3.getString("firstname") + " </td>");
	out.println("<td style='width: 200px;'>Review Date: " + dateformat.format(R.getTimestamp("rtime")) + " </td></tr>");
    out.println("<tr><td style=\"color:gold\">");
    for(int j=0;j<R.getInt("rating");j++)
    {
    	out.println("&#9733;");
    }
    out.println(" </td></tr>");
    out.println("<tr><td colspan=\"3\"> <textarea style=\"color:blue\" disabled readonly cols=\"70\" rows=\"5\">"+R.getString("review")+"</textarea></td></tr>");
    out.println("<table>");
    out.println("<br>");
    i++;
	}
}

//out.println("<input  type=\"submit\" value=\"submit\" >");
//out.println("</form>");
if(i==0)
{
	out.println("No reviews Present.");
}
con.close();
}
catch (Exception e) {
e.printStackTrace();
}
%>

</body>
</html>