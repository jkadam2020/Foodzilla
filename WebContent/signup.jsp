<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome</title>
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
<%
try
{
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","hr","hr");

String fname=request.getParameter("fname");
String lname=request.getParameter("lname");
String passwd=request.getParameter("password");
String umail=request.getParameter("umail");
String address=request.getParameter("address");
String city=request.getParameter("city");
String state=request.getParameter("state");
String szipcode=request.getParameter("zipcode");
String phone=request.getParameter("phone");

int zipcode=Integer.parseInt(szipcode);

String query="insert into customer(mail_id,firstname,lastname,password,address,zipcode,city,state,phno) VALUES ('"+umail+ "','"+fname+"','"+lname +"','"+passwd+"','"+address+"',"+zipcode+",'"+city+"','"+state+"',"+phone+")";
Statement s=con.createStatement();
int i=0;
i=s.executeUpdate(query);
if(i>0)
{
		out.println("Registration successful !!! <br>");
		out.println("Thank you for registering. <br>");
		out.println("<b><a href=\"login.jsp\">Login Here!!!</a></b>");		
}else
{
	out.println("We are sorry, we are having technical issues. Kindly check later !!! <br>");
}

con.close();
}
catch (Exception e) {
e.printStackTrace();
}
%>
</body>
</html>