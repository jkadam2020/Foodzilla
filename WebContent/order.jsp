<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>
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
<%

HttpSession hs=request.getSession();

int id=(Integer)hs.getAttribute("rest_id");
//int id=Integer.parseInt(str);
try
{
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","hr","hr");

String qry="select rname from restaurant where rest_id="+id;
Statement stmt=con.createStatement();
ResultSet Rst=stmt.executeQuery(qry);
String rname=null;
if(Rst.next())
{
rname=Rst.getString("rname");
}
out.println("<div align=\"left\">");
out.println("<table><tr><td style='width: 150px;'><h3> Restaurant id: "+hs.getAttribute("rest_id")+"</h3></td></tr>");
out.println("<tr><td style='width: 150px;'><h3> Restaurant Name: "+rname+"</h3></td></tr>");
out.println("</table></div>");

out.println("<h2> Menu </h2>");



String query="select * from menu where rest_id="+id;

out.println("<form name=\"MenuForm\" action=\"BillingClass\" method=\"POST\">");
out.println("<table border=\"0\" bgcolor=\"#cceeff\">");
out.println("<tr><td style='width: 150px; color: blue;'>Food Item</td>");
out.println("<td style='width: 150px; color: blue; '>Price</td>");
out.println("<td style='width: 50px; color: blue;'> Selections </td>");
out.println("<td style='width: 20px; color: blue;'> Quantity </td></tr>");
Statement s=con.createStatement();
ResultSet R=s.executeQuery(query);

while(R.next())
{
	out.println("<tr><td style='width: 150px;'>" + R.getString("iname") + "  </td>");
    out.println("<td style='width: 150px; '>" + R.getString("price") + "   </td>");
    out.println("<td style='width: 50px;'> <input type =\"checkbox\"  name =\"menu\" value=\""+R.getInt("item_id")+ "\">" + "</td>");
    out.println("<td> <input type =\"number\"  min=\"1\" name =\"quantity_"+R.getInt("item_id")+"\" value=\"1\">" + "</td></tr>");
}
out.println("</table>");
out.println("<input  type=\"submit\" value=\"submit\">");
out.println("</form>");

con.close();
}
catch (Exception e) {
e.printStackTrace();
}

%>
<%
if(null!=request.getAttribute("billingErrorMsg"))
{
out.println("<h3 align=\"left\" style=\"color:\red\">");
out.println(request.getAttribute("billingErrorMsg"));
out.println("</h3>");
}
%>

</body>
</html>