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

@ManagedBean 
@RequestScoped 
public class FavoritaBean  {
	
	private int identificador; 
	private String pathImg; 
	private String nombre;
	private String artista;
	private String categoria;
	private String img_reproduccion;
	private int num_reproduccion; //numero de reproducciones
	private String reproduccion;  //fecha ultima reproduccion
	private FavoritaBean[] listaColeccion;
	
	
	public void init() {
		
		FacesContext facesContext = FacesContext.getCurrentInstance();
	    if (!facesContext.isPostback() && !facesContext.isValidationFailed()) {
	        System.out.print("entor al ini");
	        
	        
	        HttpSession session = (HttpSession) facesContext.getExternalContext().getSession(true);
	        int id_user = (Integer)session.getAttribute("id_user");
	        
	        System.out.print(id_user);
	        
	        Favorita fav = new Favorita();
	         
	        
	        Vector<FavoritaBean> vec = 	fav.ListarColeccion(id_user);
	        
	        listaColeccion = new FavoritaBean[vec.size()];
	        
	        for(int i = 0; i < vec.size(); i++){
	        	listaColeccion[i] = vec.elementAt(i);
	        	
	        }
	    }
	} 
	
	public String listener() {  
        
        //System.out.println("Event received for modelRow #" + identificador);  
		FacesContext ctx = FacesContext.getCurrentInstance();  
        String modelRowStr = (String) ctx.getExternalContext().getRequestParameterMap().get("modelRow");  
        int modelRow = Integer.parseInt(modelRowStr);  
          
        System.out.println("Event received for modelRow #" + modelRow);  
        
        HttpSession session = (HttpSession) ctx.getExternalContext().getSession(true);
        session.setAttribute("id_can", modelRow);
        
        return "result";
        
        /*try {  
        	 HttpServletRequest request = (HttpServletRequest) ctx.getExternalContext().getRequest();  
             HttpServletResponse response = (HttpServletResponse) ctx.getExternalContext().getResponse();  

             RequestDispatcher dispatcher = request.getRequestDispatcher("/CtrlDetalleCancion?accion=1&id_can=" + modelRow);  
             //RequestDispatcher dispatcher = request.getRequestDispatcher("../../CtrlDetalleCancion?accion=1&id_can=" + modelRow);
             
             dispatcher.forward(request, response);  
               
  
        } catch (Exception e) {  
            
        }  */
    }  
	
	public String display(FavoritaBean value){
        this.identificador =value.getIdentificador();
        return "result";
    }
	
	/*public void listener(ActionEvent evt) {  
        FacesContext ctx = FacesContext.getCurrentInstance();  
        String modelRowStr = (String) ctx.getExternalContext().getRequestParameterMap().get("modelRow");  
        int modelRow = Integer.parseInt(modelRowStr);  
          
        System.out.println("Event received for modelRow #" + modelRow);  
        
    }  */
	
	public String getPathImg() {
		return pathImg;
	}
	public void setPathImg(String pathImg) {
		this.pathImg = pathImg;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getArtista() {
		return artista;
	}
	public void setArtista(String artista) {
		this.artista = artista;
	}
	public String getCategoria() {
		return categoria;
	}
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	public String getReproduccion() {
		return reproduccion;
	}
	public void setReproduccion(String reproduccion) {
		this.reproduccion = reproduccion;
	}
	
	public int getNum_reproduccion() {
		return num_reproduccion;
	}

	public void setNum_reproduccion(int num_reproduccion) {
		this.num_reproduccion = num_reproduccion;
	}

	public FavoritaBean[] getListaColeccion() {
		return listaColeccion;
	}

	public void setListaColeccion(FavoritaBean[] listaColeccion) {
		this.listaColeccion = listaColeccion;
	}

	public int getIdentificador() {
		return identificador;
	}

	public void setIdentificador(int identificador) {
		this.identificador = identificador;
	}

	public String getImg_reproduccion() {
		return img_reproduccion;
	}

	public void setImg_reproduccion(String img_reproduccion) {
		this.img_reproduccion = img_reproduccion;
	}
	
	
	
	

	
}
