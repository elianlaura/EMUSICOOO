package BD;

import javax.persistence.Column;  
import javax.persistence.Entity;  
import javax.persistence.GeneratedValue;  
import javax.persistence.GenerationType;
import javax.persistence.Id;  

import org.hibernate.annotations.Generated;
import org.hibernate.annotations.GenerationTime;


@Entity(name=" Usuario`") 
public class UsuarioDB {
	
	

	@Id
	@Column(name = "id_user", columnDefinition = "serial")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_user;
	
	@Column(name="use_user")  
	private String use_user;
	
	@Column(name="pas_user")  
	private String pas_user;
	
	@Column(name="nom_user")  
	private String nom_user;
	
	@Column(name="ema_user")  
	private String ema_user;

	
	public UsuarioDB(String use_user, String pas_user, String nom_user,
			String ema_user) {
		super();
		this.use_user = use_user;
		this.pas_user = pas_user;
		this.nom_user = nom_user;
		this.ema_user = ema_user;
	}
	
	public int getId_user() {
		return id_user;
	}

	public void setId_user(int id_user) {
		this.id_user = id_user;
	}

	public String getUse_user() {
		return use_user;
	}

	public void setUse_user(String use_user) {
		this.use_user = use_user;
	}

	public String getPas_user() {
		return pas_user;
	}

	public void setPas_user(String pas_user) {
		this.pas_user = pas_user;
	}

	public String getNom_user() {
		return nom_user;
	}

	public void setNom_user(String nom_user) {
		this.nom_user = nom_user;
	}

	public String getEma_user() {
		return ema_user;
	}

	public void setEma_user(String ema_user) {
		this.ema_user = ema_user;
	}
	
	

}
