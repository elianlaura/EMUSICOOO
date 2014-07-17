package BD;

import javax.persistence.Column;  
import javax.persistence.Entity;  
import javax.persistence.GeneratedValue;  
import javax.persistence.GenerationType;
import javax.persistence.Id;  

import org.hibernate.annotations.Generated;
import org.hibernate.annotations.GenerationTime;


@Entity(name="`Artista`") 
public class ArtistaDB {
	
	@Id
	@Column(name = "id_art", columnDefinition = "serial")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_art;
	
	@Column(name="nom_art")  
	private String nom_art;
	
	
	public ArtistaDB(String nom_art) {
		super();
		this.nom_art = nom_art;
	}
	
	public int getId_art() {
		return id_art;
	}
	public void setId_art(int id_art) {
		this.id_art = id_art;
	}
	public String getNom_art() {
		return nom_art;
	}
	public void setNom_art(String nom_art) {
		this.nom_art = nom_art;
	}

}
