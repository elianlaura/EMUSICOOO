package BD;


import javax.persistence.Column;  
import javax.persistence.Entity;  
import javax.persistence.GeneratedValue;  
import javax.persistence.GenerationType;
import javax.persistence.Id; 

@Entity(name="`Amistad`")
public class AmistadDB {
	
	@Id
	@Column(name = "id_amis", columnDefinition = "serial")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_amin;
	
	@Column(name="id_user1")  
	private int id_user1;
	
	@Column(name="id_user2")  
	private int id_user2;
	
	public AmistadDB(int id_user1, int id_user2) {
		super();
		this.id_user1 = id_user1;
		this.id_user2 = id_user2;
	}
			
	public int getId_amin() {
		return id_amin;
	}
	public void setId_amin(int id_amin) {
		this.id_amin = id_amin;
	}
	public int getId_user1() {
		return id_user1;
	}
	public void setId_user1(int id_user1) {
		this.id_user1 = id_user1;
	}
	public int getId_user2() {
		return id_user2;
	}
	public void setId_user2(int id_user2) {
		this.id_user2 = id_user2;
	}
	
	
	
	
}
