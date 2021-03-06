

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
/**
 * Servlet implementation class LogoutClass
 */
@WebServlet("/LogoutClass")
public class LogoutClass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogoutClass() {
        super();
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
		String actionYN = request.getParameter("logoutbtn");
		if("Yes".equals(actionYN))
		{
		HttpSession session=request.getSession();
		session.invalidate();
	    String redirectURL ="logout.html";
	    response.sendRedirect(redirectURL);
		}
		else if("No".equals(actionYN))
		{
		    String redirectURL ="restaurants.jsp";
		    response.sendRedirect(redirectURL);
		}			
	}

}
