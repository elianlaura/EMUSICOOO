package Controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Model.Artista;
/**
 * Servlet implementation class CtrlArtista
 */
@WebServlet("/CtrlArtista")
public class CtrlArtista extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Artista m_artista;   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CtrlArtista() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void ListarArtistas(){
    	
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
	}

}
