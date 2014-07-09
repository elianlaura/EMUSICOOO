package actions;

import java.io.File;

import Model.Cancion;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.interceptor.ServletRequestAware;

import Model.Cancion;

import com.opensymphony.xwork2.ActionSupport;
 
public class FileUploadAction extends ActionSupport implements
        ServletRequestAware {
    private File userImage;
    private String userImageContentType;
    private String userImageFileName;
    
    private String url;
	private String name;
	private String artist;
	private String category;
	private String lyric;
    
 
    private HttpServletRequest servletRequest;
 
    public String execute() {
        try {
        
        	
        	//registramos la cancion
        	
        	Cancion m_cancion = new Cancion();
    		m_cancion.m_nombre = this.name;
    		m_cancion.m_letra = this.lyric;
    		m_cancion.m_url = "https://" + this.url;
    		m_cancion.m_id_artista = Integer.parseInt(this.artist);
    		m_cancion.m_id_categoria = Integer.parseInt(this.category);
    		m_cancion.m_id_usuario = Integer.parseInt("4");
    		
    		int id_can = m_cancion.AgregarCancion();
        	
            //String filePath = servletRequest.getSession().getServletContext().getRealPath("/");
            //System.out.println("Server path:" + filePath);
        	//String filePath = "\\\\192.168.1.35\\photos_song";
    		String filePath = "\\\\ELIAN-PC\\Users\\Elian\\photos_song";
    		
        	//System.out.println("Server path:" + filePath);
            
            //File fileToCreate = new File(filePath, this.userImageFileName);
        	File fileToCreate = new File(filePath, id_can + ".jpg");
 
            FileUtils.copyFile(this.userImage, fileToCreate);
        } catch (Exception e) {
            e.printStackTrace();
            addActionError(e.getMessage());
 
            return INPUT;
        }
        return SUCCESS;
    }
 
    public File getUserImage() {
        return userImage;
    }
 
    public void setUserImage(File userImage) {
        this.userImage = userImage;
    }
 
    public String getUserImageContentType() {
        return userImageContentType;
    }
 
    public void setUserImageContentType(String userImageContentType) {
        this.userImageContentType = userImageContentType;
    }
 
    public String getUserImageFileName() {
        return userImageFileName;
    }
 
    public void setUserImageFileName(String userImageFileName) {
        this.userImageFileName = userImageFileName;
    }
 
    @Override
    public void setServletRequest(HttpServletRequest servletRequest) {
        this.servletRequest = servletRequest;
 
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

	public HttpServletRequest getServletRequest() {
		return servletRequest;
	}
}