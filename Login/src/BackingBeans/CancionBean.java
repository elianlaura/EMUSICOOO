package BackingBeans;

import java.awt.event.ActionEvent;
import java.io.Serializable;
import java.net.URL;
import java.net.URLConnection;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.Vector;

import Model.Favorita;
import Model.Cancion;

@ManagedBean 
@RequestScoped 
public class CancionBean  {
	private String url;
	private String name;
	private String artist;
	private String category;
	private String lyric;
	
	public void init() {
		
		FacesContext facesContext = FacesContext.getCurrentInstance();
		HttpSession session = (HttpSession) facesContext.getExternalContext().getSession(true);
        int id_can = (Integer)session.getAttribute("id_can");
        int id_user = (Integer)session.getAttribute("id_user");
        
	    System.out.print("can " + id_can);
	    
	    Cancion m_cancion = new Cancion();
	    m_cancion.AgregarLogReproducion(id_user, id_can);
		
		m_cancion.ListarDetalleCancion(id_can);
		
		
		 System.out.print("can " +  m_cancion.m_url);
		
		url = m_cancion.m_url;
		name = m_cancion.m_nombre;
		artist = m_cancion.m_artista;
		category = m_cancion.m_categoria;
		lyric = m_cancion.m_letra.replace("\n", "<br>");
		//lyric = m_cancion.m_letra;
		
} 
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getArtist() {
		return artist;
	}
	public void setArtist(String artist) {
		this.artist = artist;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getLyric() {
		return lyric;
	}
	public void setLyric(String lyric) {
		this.lyric = lyric;
	}
	
	
	
	
	
	
	
	

	
}
