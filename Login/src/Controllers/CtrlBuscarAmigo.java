package Controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Amigo;
import Model.Amigo;
/**
 * Servlet implementation class CtrlBuscarAmigo
 */
@WebServlet("/CtrlBuscarAmigo")
public class CtrlBuscarAmigo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Amigo m_amigo;     
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CtrlBuscarAmigo() {
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
		
		m_amigo = new Amigo();
		m_amigo.BuscarAmigos(userId, request.getParameter("buscar"));
		
		
		PrintWriter out = response.getWriter();
		//Vector<String> lista_canciones = m_buscar.Search(request.getParameter("buscar"));		
		
		//String lista_canciones = m_buscar.Search(request.getParameter("buscar")).elementAt(0);
		//String lista_canciones_str = "";
		String table = 
				"<table width=\"350\"  border=\"1\" align=\"center\" cellpadding=\"2\" cellspacing=\"2\">\n"
				+ "<tr>  <td colspan=\"3\">\n"
				+ "</td> \n "
				+ "</tr>\n";
				
				 
		for (int i=0; i<m_amigo.m_amigos.size(); i++){
			String i_str = String.valueOf(i+1);
			table = table 
			  + "<tr>\n"
			  + "<td> <font size=3 font-family=\"arial\" color =\"#0000\"> - </font></td>\n"
			      + "<td><div align=\"left\"><font size=3 font-family=\"arial\" color =\"#0000\">" + m_amigo.m_amigos.elementAt(i).m_nombre + "</font></div></td> \n"
			      + "<td><div align=\"left\"><font size=3 font-family=\"arial\" color =\"#0000\">" + m_amigo.m_amigos.elementAt(i).m_email + "</font></div></td> \n"
			     			      
			      + "<td>"
			//text += "&nbsp;&nbsp;<a href='http://localhost:8080/Login/CtrlDetalleCancion?id_can="+m_buscar.m_data.elementAt(i).elementAt(0)+"'>Mas...</a>";
			
			+ "<form action='CtrlAgregarAmigo' method='POST'> \n"
			+ "<input type='hidden' name='accion' id='accion' value ='1'/> \n"
			+ "<input type='hidden' name='nom_user_amigo' id='nom_user_amigo' value ='" + m_amigo.m_amigos.elementAt(i).m_nombre + "'/> \n"
			+ "<input type='hidden' name='id_user_amigo' id='id_user_amigo' value ='" + m_amigo.m_amigos.elementAt(i).m_identificador+"'/> \n"
			+ "<input  type='submit' value='Agregar' /> \n"
			+ "</form> \n"	
			
			+ "</td>"
			      
			 + "<td>"
			//text += "&nbsp;&nbsp;<a href='http://localhost:8080/Login/CtrlDetalleCancion?id_can="+m_buscar.m_data.elementAt(i).elementAt(0)+"'>Mas...</a>";
			
			
			
			+ "</td>"
			      
		      + "</tr>\n";			
			
		}
		
		table = table + "</table>\n";
		//System.out.println(lista_canciones_str);
		out.println(table);
		
	}

}
