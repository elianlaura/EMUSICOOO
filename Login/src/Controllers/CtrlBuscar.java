package Controllers;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;
import java.text.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Buscar;
/**
 * Servlet implementation class CtrlBuscar
 */
@WebServlet("/CtrlBuscar")
public class CtrlBuscar extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Buscar m_buscar;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CtrlBuscar() {
        super();
        m_buscar = new Buscar();
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
		
		/*String primera_ocur = m_buscar.Search(request.getParameter("buscar")).elementAt(0);
		PrintWriter out = response.getWriter();
		out.println(primera_ocur);*/
		
		PrintWriter out = response.getWriter();
		//Vector<String> lista_canciones = m_buscar.Search(request.getParameter("buscar"));
		Vector<Vector<String>> lista_canciones = m_buscar.Search(request.getParameter("buscar"));
		
		//String lista_canciones = m_buscar.Search(request.getParameter("buscar")).elementAt(0);
		//String lista_canciones_str = "";
		String table = 
				"<table width=\"350\"  border=\"1\" align=\"center\" cellpadding=\"2\" cellspacing=\"2\">\n"
				+ "<tr>  <td colspan=\"3\">\n"
				+ "</td> \n "
				+ "</tr>\n";
				
				 
		for (int i=0; i<lista_canciones.size(); i++){
			String i_str = String.valueOf(i+1);
			table = table 
			  + "<tr> <td><font size=4 font-family=\"arial\" color =\"#0000\"> " + i_str + "</font></td>\n"
			  + "<td> .-</td>\n"
			      + "<td><div align=\"left\"><font size=4 font-family=\"arial\" color =\"#0000\">" + lista_canciones.elementAt(i).elementAt(1) + "</font></div></td> \n" 
			     			      
			      
			      
			 + "<td>"
			//text += "&nbsp;&nbsp;<a href='http://localhost:8080/Login/CtrlDetalleCancion?id_can="+m_buscar.m_data.elementAt(i).elementAt(0)+"'>Mas...</a>";
			
			+ "<form action='CtrlDetalleCancion' method='post' target='_blank'> \n"
			+ "<input type='hidden' name='accion' id='accion' value ='1'/> \n"   //
			+ "<input type='hidden' name='id_can' id='id_can' value ='" + lista_canciones.elementAt(i).elementAt(0)+"'/> \n"
			+ "<input  type='submit' value='Mas' /> \n"
			+ "</form> \n"	
			
			+ "</td>"
			      
		      + "</tr>\n";			
			
		}
		for (int i=lista_canciones.size(); i<10; i++){
			table = table 
					+ "<tr>  <td> </td>\n" 
				          + "<td> </td> \n"
				          + "<td> </td>\n"
     			    + "</tr>\n"; 
		}
		table = table + "</table>\n";
		//System.out.println(lista_canciones_str);
		out.println(table);
			
		
		
		
		
		
		
		
		
		
		
		
		
		
			/*PrintWriter pw = new PrintWriter(new FileWriter("other.html"));
          pw.println("<TABLE BORDER><TR><TH>Number<TH>Square of Number</TR>");
          for (int i = 1; i <= 20; i++) {
                 int square = i * i;
                 pw.println("<TR><TD>" + i + "<TD>" + square);
          }
          pw.println("</TABLE>");
          pw.close();*/

		
	}

}
