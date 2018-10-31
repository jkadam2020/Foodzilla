

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AdminLogin
 */
@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		HttpSession session=request.getSession();
		try
		{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","hr","hr");

		String umail=request.getParameter("umail");
		String passwd=request.getParameter("password");

		String temp=null;
		boolean b=false;
		String query="select * from admin";
		Statement s=con.createStatement();
		ResultSet R=s.executeQuery(query);
		while(R.next())
		{
			if(umail.equalsIgnoreCase(R.getString("admin_mail")))
			{
			temp=R.getString("password");
			if(temp.equals(passwd))
			{
				session.setAttribute("mail_id", R.getString("admin_mail"));
				session.setAttribute("uid", R.getInt("admin_id"));
				session.setAttribute("username", R.getString("firstname"));
			    String redirectURL ="welcomeadmin.jsp";
			    response.sendRedirect(redirectURL);
		   		b=true;
			}
			}
		}
		if(b==false)
		{
		session.invalidate();
		request.setAttribute("errorMsg","*Wrong userid/password <br>");
		RequestDispatcher rd= request.getRequestDispatcher("/adminlogin.jsp");
		rd.forward(request, response);
		}
		con.close();
		}
		catch (Exception e) {
		e.printStackTrace();
		}

	}

}
