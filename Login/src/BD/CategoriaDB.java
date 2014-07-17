package BD;

import javax.persistence.Column;  
import javax.persistence.Entity;  
import javax.persistence.GeneratedValue;  
import javax.persistence.GenerationType;
import javax.persistence.Id;  

import org.hibernate.annotations.Generated;
import org.hibernate.annotations.GenerationTime;


@Entity(name="`Categoria`") 
public class CategoriaDB {
	

	@Id
	@Column(name = "id_cat", columnDefinition = "serial")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_cat;
	
	@Column(name="nom_cat")  
	private String nom_cat;

	
	public CategoriaDB(String nom_cat) {
		super();
		this.nom_cat = nom_cat;
	}
	
	public int getId_cat() {
		return id_cat;
	}

	public void setId_cat(int id_cat) {
		this.id_cat = id_cat;
	}

	public String getNom_cat() {
		return nom_cat;
	}

	public void setNom_cat(String nom_cat) {
		this.nom_cat = nom_cat;
	}
	
	

}
