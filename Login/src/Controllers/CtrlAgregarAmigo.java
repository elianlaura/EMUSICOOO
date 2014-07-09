package Controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Amigo;
import Model.Cancion;
import Model.Amigo;
/**
 * Servlet implementation class CtrlAgregarAmigo
 */
@WebServlet("/CtrlAgregarAmigo")
public class CtrlAgregarAmigo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Amigo m_amigo;    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CtrlAgregarAmigo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("*"+request.getParameter("accion")+"*");
		
		//llamdo desde el boton agregar de la pagina amigo.jsp
		if(request.getParameter("accion").equals("1")){
			
			HttpSession session = request.getSession(true);
			session.setAttribute("id_user_amigo", request.getParameter("id_user_amigo")); 
			session.setAttribute("nom_user_amigo", request.getParameter("nom_user_amigo")); 
			
			
			//le mandaremos como paramtro al la pagina de agregar amigo, el nombre del amigo que agregara
			request.setAttribute("NomAmigo", request.getParameter("nom_user_amigo"));		
			
			RequestDispatcher rd = request.getRequestDispatcher("AgregarAmigo.jsp");
			rd.forward(request, response);
			
			//request.getRequestDispatcher("AgregarAmigo.jsp").forward(request, response);
		}
		
		//llamado desde el formulario de agregar amigos
		if(request.getParameter("accion").equals("2")){
			
			
			HttpSession session = request.getSession(true);
			String uId = session.getAttribute("id_user").toString();
			String uId_amigo = session.getAttribute("id_user_amigo").toString();
			
			int userId = Integer.parseInt(uId);
			int userIdAmigo = Integer.parseInt(uId_amigo);
			
			PrintWriter out = response.getWriter();
			
			//System.out.println(request.getParameter("nom_can"));
			//System.out.println(request.getParameter("let_can"));
			//System.out.println(request.getParameter("url_can"));
			
			
			m_amigo = new Amigo();
			
			m_amigo.AgregarAmigo(userId, userIdAmigo, (String)request.getParameter("mensaje"));
			
			
			String text = "<font color='black' size='4' >Registro exitoso!</font>";
			
			out.println(text);
			
			
		}
		
		
	}

}
