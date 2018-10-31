

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.Types;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class OrderUpdateClass
 */
@WebServlet("/OrderUpdateClass")
public class OrderUpdateClass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderUpdateClass() {
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
		try{

		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","hr","hr");
		
		String status = request.getParameter("status");
		String sorder_id=request.getParameter("update_orderid");
		
		int success=0;
		//updating order status
		if(status.isEmpty()!=true)
		{
		int order_id=Integer.parseInt(sorder_id);
		
		String query="UPDATE ORDERS SET STATUS='"+status+"' WHERE ORDER_ID="+order_id;
		Statement stmt=con.createStatement();
		success=stmt.executeUpdate(query);
				
		}
		//BILL_GENERATION_PROCEDURE
		if(success>0)
		{
			request.setAttribute("updateSuccessful","Updated Order Status. <br>");
			RequestDispatcher rd= request.getRequestDispatcher("/ordermgmt.jsp");
			rd.forward(request, response);				
		}
		else
		{
	request.setAttribute("updateFailed","We are sorry, we are having technical issues. Kindly check later. Please inform support team. <br>");
	RequestDispatcher rd= request.getRequestDispatcher("/ordermgmt.jsp");
	rd.forward(request, response);
		}
		
		con.close();
		}
		catch (Exception e) {
			e.printStackTrace();
			}	
	}

}
