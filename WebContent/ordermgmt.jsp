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

li a:hover, .dropdown1:hover .dropbtn,.dropdown2:hover .dropbtn {
    background-color: red;
}

li.dropdown1,li.dropdown2 {
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

.dropdown-content a:hover{background-color: #f1f1f1}

.show {display:block;}

/* dropdown button menu style */ 
.dropbtnB {
    background-color: #4CAF50;
    color: white;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;
}

.dropbtnB:hover, .dropbtnB:focus {
    background-color: #3e8e41;
}

.dropdownB {
    float: right;
    position: relative;
    display: inline-block;
    
}

.dropdown-contentB {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    overflow: auto;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    right: 0;
}

.dropdown-contentB a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdownB a:hover {background-color: #f1f1f1}

.show {display:block;}
/*table style */
.Maintable {
    border-collapse: collapse;
    border: 1px solid black;
}</style>
<script>
/* When the user clicks on the button, 
toggle between hiding and showing the dropdown content */
function myFunction1() {
    document.getElementById("myDropdown1").classList.toggle("show");
}

/*
// Close the dropdown if the user clicks outside of it
window.onclick = function(e) {
  if (!e.target.matches('.dropbtn1')) {

    var dropdowns = document.getElementsByClassName("dropdown-content1");
    for (var d = 0; d < dropdowns.length; d++) {
      var openDropdown = dropdowns[d];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
} */
function myFunction2() {
    document.getElementById("myDropdown2").classList.toggle("show");
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(e) {
  if (!e.target.matches('.dropbtn')) {

    var dropdowns = document.getElementsByClassName("dropdown-content");
    for (var d = 0; d < dropdowns.length; d++) {
      var openDropdown = dropdowns[d];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}
/* When the user clicks on the button, 
toggle between hiding and showing the dropdown content */
function dropFunction() {
    document.getElementById("myDropdownB").classList.toggle("show");
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtnB')) {

    var dropdowns = document.getElementsByClassName("dropdown-contentB");
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
<h1 align="center" style="color:"> Foodzilla Admin </h1>
<ul>
  <li><a href="welcomeadmin.jsp">Home</a></li>
  <li class="dropdown1">
    <a href="javascript:void(0)" class="dropbtn" onclick="myFunction1()">Admin Functions</a>
    <div class="dropdown-content" id="myDropdown1">
   
      <a href="addnewadmin.jsp">Add new Admin</a>
      <a href="remadmin.jsp">Remove Admin</a>
    </div>
  </li>
    <li class="dropdown2">
    <a href="javascript:void(0)" class="dropbtn" onclick="myFunction2()">Restaurant Management</a>
    <div class="dropdown-content" id="myDropdown2">
      <a href="addrest.jsp">Add restaurant</a>
      <a href="removerest.jsp">Remove restaurant</a>
      <a href="addmenu.jsp">Menu Management</a>
    </div>
  </li>
  <li><a href="ordermgmt.jsp">Order Management</a></li>
  <li><a href="acontact.html">Contact</a></li>
  <li class="nav_li"><a href="aabout.html">About</a></li>
</ul>

<%
String userName = (String) session.getAttribute("mail_id");
if (null == userName) {
   request.setAttribute("SessionError", "Session has ended.  Please login.");
   RequestDispatcher rd = request.getRequestDispatcher("adminlogin.jsp");
   rd.forward(request, response);
}


HttpSession hp= request.getSession();
out.println("<div class=\"dropdownB\">");
out.println("<button onclick=\"dropFunction()\" class=\"dropbtnB\">"+hp.getAttribute("username")+" &#8711;</button>");
out.println("<div id=\"myDropdownB\" class=\"dropdown-contentB\">");
out.println("<a href=\"achpasswd.jsp\">Change password</a>");
out.println("<a href=\"alogout.jsp\">Logout</a>");
out.println("</div></div>");
%>
<br>
<h2> Order Management </h2>
<br>
<form action="ordermgmt.jsp" method="post">
<table><tr BGCOLOR=skyblue>
<td><input name="query" type="submit" value="Orders in last 24-Hour"> </td>
<td><input name="query" type="submit" value="All Orders"></td>
<td><input name="query" type="submit" value="INPROGRESS Orders"></td>
<td><input name="query" type="submit" value="COMPLETED Orders"></td>
<td><input name="query" type="submit" value="CANCELLED Orders"></td>
<td><input name="query" type="submit" value="CONFIRMED Orders"></td>
</tr></table>
</form>
<%
if(null!=request.getAttribute("updateSuccessful"))
{
out.println("<h3 align=\"left\" style=\"color:\red\">");
out.println(request.getAttribute("updateSuccessful"));
out.println("</h3>");
}
if(null!=request.getAttribute("updateFailed"))
{
out.println("<h3 align=\"left\" style=\"color:\red\">");
out.println(request.getAttribute("updateFailed"));
out.println("</h3>");
}
%>

<%

try
{
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","hr","hr");

String query=null;

query="select * from orders ORDER BY otime DESC";

if(request.getParameter("query")!= null && request.getParameter("query").isEmpty()!=true)
{
		
	String q=request.getParameter("query");

if(q.equalsIgnoreCase("Orders in last 24-Hour"))
{
query="select * from orders where otime>=sysdate-1 ORDER BY otime DESC";
}
else if (q.equalsIgnoreCase("All orders"))
{
query="select * from orders ORDER BY otime DESC";
}	
else if(q.equalsIgnoreCase("INPROGRESS Orders"))
{
query="select * from orders where status='INPROGRESS'";	
}
else if(q.equalsIgnoreCase("COMPLETED Orders"))
{
query="select * from orders where status='COMPLETED'";	
}
else if(q.equalsIgnoreCase("CANCELLED Orders"))
{
query="select * from orders where status='CANCELLED'";	
}
else if(q.equalsIgnoreCase("CONFIRMED Orders"))
{
query="select * from orders where status='CONFIRMED'";	
}
}
Statement s=con.createStatement();
ResultSet R=s.executeQuery(query);

java.text.SimpleDateFormat dateformat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");

int i=0;
while(R.next())
{
	int oid=R.getInt("order_id");
	int cid=R.getInt("cust_id");
	String q2="select * from customer where cust_id="+cid;
	Statement s2=con.createStatement();
	ResultSet R2=s2.executeQuery(q2); 

	String q3="select * from restaurant where rest_id="+R.getInt("rest_id");
	Statement s3=con.createStatement();
	ResultSet R3=s3.executeQuery(q3);

	
	if(R3.next()&& R2.next())
	{
	out.println("<br>");
	out.println("<table class=\"Maintable\" border=\"0\" bgcolor=\"#cceeff\">");
	out.println("<tr> <td style='width: 200px;' > Order ID:"+R.getInt("order_id") +"</td> <td style='width: 200px;' > Rest.ID: " + R3.getInt("rest_id") +" " +" </td><td style='width: 200px;'> Restaurant: " + R3.getString("rname") + " </td></tr>");
	out.println("<tr> <td  colspan=\"3\" > Order Placed On: " + dateformat.format(R.getTimestamp("otime")) + " </td></tr>");
	out.println("<tr><td style='width: 200px;'> Order Placed By: CustomerID :-</td> <td style='width: 200px;'>" + cid+"</td> <td style='width: 200px;'> Name: "+R2.getString("firstname")+" "+R2.getString("lastname") + " </td></tr>");
	out.println("<tr style=\"border-bottom: 1px solid #000;\"><tr>");
    out.println("<tr><td> Total </td><td>"+R.getDouble("total")+"</td></tr>");
    out.println("<tr><td colspan=\"3\">Current Status </td><td><strong>"+R.getString("status")+"</strong></td></tr>");
    out.println("<tr><td>");
    %>	
    <form name="statusform" action="OrderUpdateClass" method="post">
    <select name="status">
    <option value="INPROGRESS">INPROGRESS</option>
    <option value="CONFIRMED">CONFIRMED</option>
    <option value="CANCELLED">CANCELLED</option>
    <option value="COMPLETED">COMPLETED</option>
  </select>
  <input type="hidden" name="update_orderid" value="<%=R.getInt("order_id")%>">
  <input type="submit" value="Update">
  </form>
  <%
    out.println("</td><tr>");
    out.println("</table>");
    out.println("<br>");
    out.println("<br>");
    i++;
	}
}

if(i==0)
{
	out.println("No order Present.");
}


con.close();
}
catch (Exception e) {
e.printStackTrace();
}
%>
</body>
</html>