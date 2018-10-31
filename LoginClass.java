

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;
import java.io.*;
/**
 * Servlet implementation class LoginClass
 */
@WebServlet("/LoginClass")
public class LoginClass extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public LoginClass() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	//	response.getWriter().append("Served at: ").append(request.getContextPath());
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		//PrintWriter out=response.getWriter();
		HttpSession session=request.getSession();
		try
		{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","hr","hr");

		String umail=request.getParameter("umail");
		String passwd=request.getParameter("password");

		String temp=null;
		boolean b=false;
		String query="select * from customer";
		Statement s=con.createStatement();
		ResultSet R=s.executeQuery(query);
		while(R.next())
		{
			if(umail.equalsIgnoreCase(R.getString("mail_id")))
			{
			temp=R.getString("password");
			if(temp.equals(passwd))
			{
				session.setAttribute("mail_id", R.getString("mail_id"));
				session.setAttribute("username", R.getString("firstname"));
				session.setAttribute("uid", R.getInt("cust_id"));
			    String redirectURL ="restaurants.jsp";
			    response.sendRedirect(redirectURL);
		   		b=true;
			}
			}
		}
		if(b==false)
		{
		session.invalidate();
		request.setAttribute("errorMsg","*Wrong userid/password <br>");
		RequestDispatcher rd= request.getRequestDispatcher("/login.jsp");
		rd.forward(request, response);
		}
		con.close();
		}
		catch (Exception e) {
		e.printStackTrace();
		}
	}

}
