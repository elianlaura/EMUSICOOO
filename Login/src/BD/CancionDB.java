package BD;


import javax.persistence.Column;  
import javax.persistence.Entity;  
import javax.persistence.GeneratedValue;  
import javax.persistence.GenerationType;
import javax.persistence.Id; 

@Entity(name="`Cancion`")
public class CancionDB {
	@Id
	@Column(name = "id_can", columnDefinition = "serial")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_can;
	
	@Column(name="nom_can")  
	private String nom_can;
	
	@Column(name="let_can")  
	private String let_can;
	
	@Column(name="url_can")  
	private String url_can;
	
	@Column(name="id_cat")  
	private int id_cat;
	
	@Column(name="id_art")  
	private int id_art;
	
	@Column(name="id_user")  
	private int id_user;
	
	public CancionDB(String nom_can, String let_can, String url_can,
			int id_cat, int id_art, int id_user) {
		super();
		this.nom_can = nom_can;
		this.let_can = let_can;
		this.url_can = url_can;
		this.id_cat = id_cat;
		this.id_art = id_art;
		this.id_user = id_user;
	}
	
	public int getId_can() {
		return id_can;
	}
	public void setId_can(int id_can) {
		this.id_can = id_can;
	}
	public String getNom_can() {
		return nom_can;
	}
	public void setNom_can(String nom_can) {
		this.nom_can = nom_can;
	}
	public String getLet_can() {
		return let_can;
	}
	public void setLet_can(String let_can) {
		this.let_can = let_can;
	}
	public String getUrl_can() {
		return url_can;
	}
	public void setUrl_can(String url_can) {
		this.url_can = url_can;
	}
	public int getId_cat() {
		return id_cat;
	}
	public void setId_cat(int id_cat) {
		this.id_cat = id_cat;
	}
	public int getId_art() {
		return id_art;
	}
	public void setId_art(int id_art) {
		this.id_art = id_art;
	}
	public int getId_user() {
		return id_user;
	}
	public void setId_user(int id_user) {
		this.id_user = id_user;
	}
	
	
}
