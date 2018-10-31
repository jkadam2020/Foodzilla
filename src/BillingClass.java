

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.*;
import java.sql.*;

/**
 * Servlet implementation class BillingClass
 */
@WebServlet("/BillingClass")
public class BillingClass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BillingClass() {
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
		try{
			
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:ORCL","hr","hr");
		
		String[] schecked = request.getParameterValues("menu");
		//String[] squantity=request.getParameterValues("quantity");
		

		HttpSession session=request.getSession();
		int rest_id=(Integer)session.getAttribute("rest_id");
		//int rest_id=Integer.parseInt(srest_id);
		int user_id=(Integer)session.getAttribute("uid");
		//creating order
		if(schecked.length>0)
		{
		int oid=0;
		String plsql = "" +
		        " declare " +  
		        "    newid number; " +
		        " begin " +
		        "    INSERT INTO orders(rest_id,cust_id,status,otime) values(?,?,'INPROGRESS',sysdate) returning order_id into newid;"+
		        "    ? := newid;" +
		        " end;";
		CallableStatement cs = con.prepareCall(plsql);
        cs.setInt(1, rest_id);
        cs.setInt(2, user_id);
        cs.registerOutParameter(3,Types.INTEGER);

        cs.execute();
        oid=(Integer)cs.getObject(3);

		session.setAttribute("orderid", oid);

		//convert checked menu strings into integer
		int lchecked=schecked.length;
		int[] checked=new int[lchecked];
		for (int s=0;s<schecked.length;s++)
		{
			
			checked[s]=Integer.parseInt(schecked[s]);
		}

		String[] squantity=new String[checked.length];
		//getting quantity strings
		for(int w=0;w<checked.length;w++)
		{
			squantity[w]=request.getParameter("quantity_"+checked[w]);
		
		}
		//convert quantity strings into integer
			int l=squantity.length;
			int[] quantity=new int[l];
			for (int s=0;s<squantity.length;s++)
			{
				
				quantity[s]=Integer.parseInt(squantity[s]);
			}
		
		//insert order items
		int success=0;
		for(int i=0;i<checked.length;i++)
		{
				String query="insert into orderitems(order_id,item_id,quantity) values("+oid+","+checked[i]+","+quantity[i]+")";
				Statement stmt=con.createStatement();
				
				success=stmt.executeUpdate(query);

				
		}
		//BILL_GENERATION_PROCEDURE
		if(success>0)
		{
		String qp= "{call BILL_GENERATION_PROCEDURE(?)}";
		CallableStatement stmtp=con.prepareCall(qp);
		stmtp.setInt(1,oid);
		stmtp.execute();
		}
		
		if(success>0)
		{	
	    String redirectURL ="billtotal.jsp";
	    response.sendRedirect(redirectURL);					
		}
		else
		{
	request.setAttribute("billingErrorMsg","We are sorry, we are having technical issues. Kindly check later !!! <br>");
	RequestDispatcher rd= request.getRequestDispatcher("/order.jsp");
	rd.forward(request, response);
		}
		}//if
		con.close();
		}
		catch (Exception e) {
			e.printStackTrace();
			}	
	}

}
