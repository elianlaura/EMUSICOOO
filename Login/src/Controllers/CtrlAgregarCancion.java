package Controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Cancion;
import org.json.JSONObject;

/**
 * Servlet implementation class CtrlAgregarCancion
 */
@WebServlet("/CtrlAgregarCancion")
public class CtrlAgregarCancion extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Cancion m_cancion;   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CtrlAgregarCancion() {
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
		
		HttpSession session = request.getSession(true);
		String uId = session.getAttribute("id_user").toString();
		String uNom = session.getAttribute("nom_user").toString();
		int userId = Integer.parseInt(uId);
		
		//System.out.println("ide: "+userId);
		//System.out.println("nom: "+uNom);
		
		PrintWriter out = response.getWriter();
		
		//System.out.println(request.getParameter("nom_can"));
		//System.out.println(request.getParameter("let_can"));
		//System.out.println(request.getParameter("url_can"));
		System.out.println("art:"+request.getParameter("cmbArtistas"));
		System.out.println("cat:"+request.getParameter("cmbCategorias"));
		
		m_cancion = new Cancion();
		m_cancion.m_nombre = request.getParameter("nom_can");
		m_cancion.m_letra = request.getParameter("let_can");
		m_cancion.m_url = "https://" + request.getParameter("url_can");
		m_cancion.m_id_artista = Integer.parseInt(request.getParameter("cmbArtistas"));
		m_cancion.m_id_categoria = Integer.parseInt(request.getParameter("cmbCategorias"));
		m_cancion.m_id_usuario = Integer.parseInt(uId);
		
		m_cancion.AgregarCancion();
		
		//String text = "<font color='black' size='4' >Registro exitoso!</font>";
		
		JSONObject json = new JSONObject();
		json.put("result", 1);
		String text = json.toString();
		
				
		out.println(text);	    
        
	}

}
