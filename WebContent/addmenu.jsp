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
/*number textbox formatting */ 
input[type='number'] {
    -moz-appearance:textfield;
}
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
    -webkit-appearance: none;
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

</style>
<script>
/* When the user clicks on the button, 
toggle between hiding and showing the dropdown content */
function myFunction1() {
    document.getElementById("myDropdown").classList.toggle("show");
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
  <li class="dropdown">
    <a href="javascript:void(0)" class="dropbtn" onclick="myFunction1()">Admin Functions</a>
    <div class="dropdown-content" id="myDropdown">
   
      <a href="addnewadmin.jsp">Add new Admin</a>
      <a href="remadmin.jsp">Remove Admin</a>
    </div>
  </li>
    <li class="dropdown">
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
<h3>Menu Management</h3>
<br>
<%
try
{
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","hr","hr");

String query="select * from restaurant";

out.println("<form name=\"restSelectionForm\" action=\"addmenu.jsp\" method=\"POST\">");
out.println("<table border=\"0\" bgcolor=\"#cceeff\">");
out.println("<tr><td style='width: 150px; color: blue;'>Rest ID</td>");
out.println("<td style='width: 150px; color: blue;'>Restaurant</td>");
out.println("<td style='width: 150px; color: blue; '>Address</td>");
out.println("<td style='width: 50px; color: blue;'>  </td></tr>");

Statement s=con.createStatement();
ResultSet R=s.executeQuery(query);

while(R.next())
{
	out.println("<tr><td style='width: 150px;'>" + R.getInt("rest_id") + "  </td>");
	out.println("<td style='width: 150px;'>" + R.getString("rname") + "  </td>");
    out.println("<td style='width: 150px; '>" + R.getString("address") + "   </td>");
    out.println("<td style='width: 50px;'> <button type =\"submit\" name =\"selectbtn\" value=\""+R.getInt("rest_id")+ "\">Select </button></td></tr>");
    
}
out.println("</table>");
out.println("</form>");

con.close();
}
catch (Exception e) {
e.printStackTrace();
}
%>

<%
if(request.getParameter("selectbtn")!= null && request.getParameter("selectbtn").isEmpty()!=true)
{	
	try
	{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","hr","hr");

	String srest_id=(String)request.getParameter("selectbtn");
	int rest_id=Integer.parseInt(srest_id);
	String query=null;
	query="SELECT * FROM menu WHERE REST_ID="+rest_id;
	//Statement s=con.createStatement();
    PreparedStatement ps=con.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
	ResultSet R=ps.executeQuery();
	
	out.println("<br><br>");
	out.println("<table border=\"0\" bgcolor=\"#cceeff\">");
	out.println("<tr><td style='width: 150px; color: blue;'>Menu Item ID</td>");
	out.println("<td style='width: 150px; color: blue;'>Item Name</td>");
	out.println("<td style='width: 150px; color: blue; '>Price</td>");
	out.println("<td style='width: 50px; color: blue;'>  </td></tr></table>");
	
	if(R.next())
	{
		//moving cursor at start
		R.beforeFirst();
	out.println("<br>");
	out.println("<form name=\"MenuDeleteForm\" action=\"addmenu.jsp\" method=\"POST\">");
	out.println("<table border=\"0\" bgcolor=\"#cceeff\">");

	while(R.next())
	{
		out.println("<tr><td style='width: 150px;'>" + R.getInt("item_id") + "  </td>");
		out.println("<td style='width: 150px;'>" + R.getString("iname") + "  </td>");
	    out.println("<td style='width: 150px; '>" + R.getDouble("price") + "   </td>");
	    out.println("<td style='width: 50px;'> <button type =\"submit\" name =\"removebtn\" value=\""+R.getInt("item_id")+ "\">Remove </button></td></tr>");
  
	} 
	out.println("</table>");
	out.println("</form>");
	out.println("<br>");
	}
	else{
		out.println("<strong>Restaurant does not have any items.</strong>");	
		out.println("<br><br>");
	}
	out.println("<strong>Please add the details below for new item.</strong>");	
	out.println("<form name=\"MenuAddForm\" action=\"addmenu.jsp\" method=\"POST\">");
	out.println("<table border=\"0\" bgcolor=\"#cceeff\">");
	out.println("<tr><td style='width: 150px;'>(Auto Item ID) </td>");
	out.println("<td style='width: 150px;'> <input type=\"text\" name=\"iname\" required> </td>");
    out.println("<td style='width: 150px; '><input type=\"number\" step=\"0.01\" name=\"price\" required>  </td>"); 
    out.println("<td style='width: 50px;'> <button type =\"submit\" name =\"addbtn\" value=\""+rest_id+ "\">Add </button></td></tr>");
	out.println("</table>");
	out.println("</form>");
	

	con.close();
	}
	catch (Exception e) {
	e.printStackTrace();
	}
	}

%>

<%
if(request.getParameter("removebtn")!= null && request.getParameter("removebtn").isEmpty()!=true)
{

	try
	{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","hr","hr");


	String sitem_id=(String)request.getParameter("removebtn");
	int item_id=Integer.parseInt(sitem_id);
	String query=null;
	query="DELETE FROM MENU WHERE ITEM_ID="+item_id;
	
	Statement s=con.createStatement();
	int i=0;
	i=s.executeUpdate(query);
	if(i>0)
	{
			out.println("Item removed successfully. <br>");
		
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
<%
if(request.getParameter("addbtn")!= null && request.getParameter("addbtn").isEmpty()!=true)
{

	try
	{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","hr","hr");

	String item_name=(String)request.getParameter("iname");
	
	String sprice=(String)request.getParameter("price");
	double price=Double.parseDouble(sprice);
	
	String srest_id=(String)request.getParameter("addbtn");
	int rest_id=Integer.parseInt(srest_id);
	String query=null;
	query="INSERT INTO MENU(rest_id,iname,price) VALUES("+rest_id+",'"+item_name+"',"+price+")";
	
	Statement s=con.createStatement();
	int i=0;
	i=s.executeUpdate(query);
	if(i>0)
	{
			out.println("Item added successfully. <br>");
		
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