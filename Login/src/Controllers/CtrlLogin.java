package Controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Login;

/**
 * Servlet implementation class CtrlLogin
 */
@WebServlet("/CtrlLogin")
public class CtrlLogin extends HttpServlet {
	private Login m_login;
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CtrlLogin() {
        super();
        m_login = new Login();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		//out.println("¡Bienvenido al mundo de los servlets!");
		
		out.println("<h1>Hola</h1>\n");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		//out.println("¡Bienvenido al mundo de los servlets!");
		m_login.Authenticate(request.getParameter("email"), request.getParameter("password"));
		
		if(m_login.m_id_user != -1){
			//out.println("<h1>BIENVENIDO "+ m_login.m_nom_user +"</h1>\n");
			
			//manejamos las sesiones
			HttpSession session = request.getSession(true);
			session.setAttribute("id_user", m_login.m_id_user); 
			session.setAttribute("nom_user", m_login.m_nom_user); 
			
			
			//System.out.print(session.getAttribute("userId")); 
			
			request.getRequestDispatcher("main.jsp").forward(request, response);
		}else
			request.getRequestDispatcher("ErrorLogin.jsp").forward(request, response);
		
		
		
	}

}
