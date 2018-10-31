<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Foodzilla</title>
<style>
/*number textbox formatting */ 
input[type='number'] {
    -moz-appearance:textfield;
}
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
    -webkit-appearance: none;
}
/*body*/
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
<br>
<h3>Please enter restaurant details below :</h3>
<div  align="left">
<form name="AddRestForm1" action="addrest.jsp" method="post" accept-charset="utf-8">  
    <table style="">
        <tr><td><label for="rname">Restaurant Name</label></td>  
       <td> <input type="text" name="rname"  required></td>
        </tr>  
        <tr></tr> 
        <tr>
        <td><label for="rmail">Email</label></td>  
        <td><input type="email" name="rmail" placeholder="mailid@email.com" required></td>  
        </tr>   
        <tr></tr>
        <tr>
        <td><label for="address">Apartment,Street</label>  
        <td><input type="text" name="address" required></td>
        </tr>  
        <tr></tr>
        <tr>
        <td><label for="city">City</label>  
        <td><input type="text" name="city" required></td>
        </tr> 
        <tr></tr>
        <tr>
        <td><label for="state">State</label>  
        <td><input type="text" name="state" required></td>
        </tr> 
        <tr></tr>
        <tr>
        <td><label for="zipcode">ZipCode</label>  
        <td><input type="number" name="zipcode" required></td>
        </tr> 
        <tr></tr>
        <tr>
        <td><label for="phone">Phone</label> 
        <td><input type="number" name="phone" required></td>  
        </tr>  
        <tr></tr>
        <tr> 
        <td><input type="submit" name="add_restaurant" value="Add Restaurant">
        <input type="reset" value="Reset">
        </td> 
        </tr>        
    </table>
    <br>
</form>  
</div>
<%
if(request.getParameter("add_restaurant")!= null && request.getParameter("add_restaurant").isEmpty()!=true)
{
try
{
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","hr","hr");

String rname=request.getParameter("rname");
String rmail=request.getParameter("rmail");
String address=request.getParameter("address");
String city=request.getParameter("city");
String state=request.getParameter("state");
String szipcode=request.getParameter("zipcode");
String phone=request.getParameter("phone");

int zipcode=Integer.parseInt(szipcode);

String query="insert into restaurant(rname,mail_id,address,zipcode,city,state,phno) VALUES(?,?,?,?,?,?,?)";
PreparedStatement ps = con.prepareStatement(query);

ps.setString(1,rname);
ps.setString(2,rmail);
ps.setString(3,address);
ps.setInt(4,zipcode);
ps.setString(5,city);
ps.setString(6,state);
ps.setString(7,phone);

int i=0;
i=ps.executeUpdate();
if(i>0)
{
		out.println("Restaurant added successfully !!! <br>");
	
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