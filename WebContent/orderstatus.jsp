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

/*table style */
table {
    border-collapse: collapse;
    border: 1px solid black;
}
tr:nth-child(even) {background-color: #f2f2f2}
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
out.println("<h2> Orders </h2>");
out.println("<form name=\"feedbackform\" action=\"feedback.jsp\" method=\"post\">");
out.println("<input type=\"submit\" value=\"Give Feedback\">");
out.println("</form>");

try
{
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","hr","hr");

HttpSession hps= request.getSession();
int cid=(Integer)session.getAttribute("uid");
String query="select * from orders where cust_id="+cid+" ORDER BY otime DESC";
Statement s=con.createStatement();
ResultSet R=s.executeQuery(query);

java.text.SimpleDateFormat dateformat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");

int i=0;
while(R.next())
{
	int oid=R.getInt("order_id");
	String q2="select * from orderitems where order_id="+oid;
	Statement s2=con.createStatement();
	ResultSet R2=s2.executeQuery(q2);

	String q3="select * from restaurant where rest_id="+R.getInt("rest_id");
	Statement s3=con.createStatement();
	ResultSet R3=s3.executeQuery(q3);

	
	if(R3.next())
	{
	out.println("<br>");
	out.println("<table border=\"0\" bgcolor=\"#cceeff\">");
	out.println("<tr><td style='width: 200px;' colspan=\"2\"> Restaurant: " + R3.getString("rname") + " </td>");
	out.println("<td style='width: 200px;'> Order Placed On: " + dateformat.format(R.getTimestamp("otime")) + " </td></tr>");
	out.println("<tr style=\"border-bottom: 1px solid #000;\"><tr>");
	out.println("<tr><td style='width: 200px;'> Item (Single Rate) </td>");
	out.println("<td style='width: 100px;'> Qty " + " </td>");
	out.println("<td style='width: 100px;'> Total " + " </td></tr>");
	while(R2.next())
	{
		String q4="select * from menu where item_id="+R2.getInt("item_id");
		Statement s4=con.createStatement();
		ResultSet R4=s4.executeQuery(q4);
		if(R4.next())
		{
	out.println("<tr><td style='width: 200px;'>  " + R4.getString("iname")+" ("+R4.getDouble("price") + ")</td>");
	out.println("<td style='width: 100px;'> " + R2.getInt("quantity")+ " </td>");
	out.println("<td style='width: 100px;'> " +R2.getInt("quantity")*R4.getDouble("price") + " </td></tr>");
		}
	}
	out.println("<tr style=\"border-bottom: 1px solid #000;\"><tr>");
	DecimalFormat df=new DecimalFormat("#0.00");
	out.println("<tr><td colspan=\"2\"> SubTotal</td><td>"+R.getDouble("subtotal")+"</td></tr>");
    out.println("<tr><td colspan=\"2\"> Sales Tax: 10% </td><td>"+df.format((R.getDouble("subtotal")*0.10))+"</td></tr>");
    out.println("<tr><td colspan=\"2\"> Total </td><td>"+R.getDouble("total")+"</td></tr>");
    out.println("<tr><td colspan=\"2\"> Status </td><td><strong>"+R.getString("status")+"</strong></td></tr>");
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