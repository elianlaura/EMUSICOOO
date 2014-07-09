package Controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Cancion;

import org.json.JSONObject;
/**
 * Servlet implementation class CtrlDetalleCancion
 */
@WebServlet("/CtrlDetalleCancion")
public class CtrlDetalleCancion extends HttpServlet {
	
	private Cancion m_cancion;
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CtrlDetalleCancion() {
        super();
        m_cancion = new Cancion();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//int result = m_user.RegisterUser(request.getParameter("name"), request.getParameter("email"), request.getParameter("password"));
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession(true);
		String uId = session.getAttribute("id_user").toString();
		
		if(request.getParameter("accion").equals("1")){	//se llama cuando quieres ver detalle de una cancion
			
			m_cancion.AgregarLogReproducion(Integer.parseInt(uId), Integer.parseInt(request.getParameter("id_can")));
			
			m_cancion.ListarDetalleCancion(Integer.parseInt(request.getParameter("id_can")));
			request.setAttribute("Cancion", m_cancion);		
			
			RequestDispatcher rd = request.getRequestDispatcher("Cancion.jsp");
			rd.forward(request, response);
		}else if(request.getParameter("accion").equals("2")){ //se llama cunado se agregar cancniones a la coleccion
			
			//System.out.print("chamare");
			m_cancion.AgregarAColeccion(Integer.parseInt(uId), Integer.parseInt(request.getParameter("id_can")));
			
			JSONObject json = new JSONObject();
			json.put("result", 1);
			String text = json.toString();
			
			PrintWriter out = response.getWriter();		
			out.println(text);	    
		}
		
	}

}
