

import java.io.IOException;
import java.io.PrintWriter;
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
 * Servlet implementation class FeedbackClass
 */
@WebServlet("/FeedbackClass")
public class FeedbackClass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FeedbackClass() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		try
		{
		HttpSession session=request.getSession();

		String srating=(String)request.getParameter("rating");
		String comments=(String)request.getParameter("comments");
		int rest_id=(Integer)session.getAttribute("rest_id");
		int user_id=(Integer)session.getAttribute("uid");
		if(srating!=null && comments!=null )
		{
		int rating=Integer.parseInt(srating);
		//int rest_id=Integer.parseInt(srest_id);
		//int user_id=Integer.parseInt(suser_id);
		
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","hr","hr");
		String query="insert into reviews(rest_id,rating,review,cust_id,rtime) VALUES ("+rest_id+ ","+rating+",'"+comments+"',"+user_id+",sysdate)";
		Statement s=con.createStatement();
		int i=0;
		i=s.executeUpdate(query);
			if(i>0)
				{	
			    String redirectURL ="lastreview.jsp";
			    response.sendRedirect(redirectURL);
					
				}else
				{
			request.setAttribute("feedbackErrorMsg","We are sorry, we are having technical issues. Kindly check later !!! <br>");
			RequestDispatcher rd= request.getRequestDispatcher("/feedback.jsp");
			rd.forward(request, response);
				}
			
			con.close();	
		}		
		else
		{
			request.setAttribute("feedbackErrorMsg","*Please enter feedback <br>");
			RequestDispatcher rd= request.getRequestDispatcher("/feedback.jsp");
			rd.forward(request, response);
		}
		
		
		}
				
		catch (Exception e) {
			e.printStackTrace();
			}		

	}

}
