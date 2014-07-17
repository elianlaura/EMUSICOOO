package BD;


import javax.persistence.Column;  
import javax.persistence.Entity;  
import javax.persistence.GeneratedValue;  
import javax.persistence.GenerationType;
import javax.persistence.Id; 

import com.sun.jmx.snmp.Timestamp;

@Entity(name="`SolicitudAmistad`")
public class SolicitudAmistadDB {
	
	
	
	@Id
	@Column(name = "id_sol", columnDefinition = "serial")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_sol;
	
	@Column(name="id_user1")  
	private int id_user1;
	
	@Column(name="id_user2")  
	private int id_user2;
	
	@Column(name="flg_sol")  
	private int flg_sol;
	
	//@Column(name="fch_envio_sol")  
	//private Timestamp  fch_envio_sol;
	
	//@Column(name="fch_acept_sol")  
	//private Timestamp fch_acept_sol;
	
	@Column(name="msg_sol")  
	private String msg_sol;
	
	//public SolicitudAmistadDB(int id_user1, int id_user2, int flg_sol,
	//		Timestamp fch_envio_sol, Timestamp fch_acept_sol, String msg_sol) {
	//	super();
	//	this.id_user1 = id_user1;
	//	this.id_user2 = id_user2;
	//	this.flg_sol = flg_sol;
	//	this.fch_envio_sol = fch_envio_sol;
	//	this.fch_acept_sol = fch_acept_sol;
	//	this.msg_sol = msg_sol;
	//}	
	
	public SolicitudAmistadDB(int id_user1, int id_user2, String msg_sol) {
		super();
		this.id_user1 = id_user1;
		this.id_user2 = id_user2;
		this.msg_sol = msg_sol;
	}
	
	public int getId_sol() {
		return id_sol;
	}
	public void setId_sol(int id_sol) {
		this.id_sol = id_sol;
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
	public int getFlg_sol() {
		return flg_sol;
	}
	public void setFlg_sol(int flg_sol) {
		this.flg_sol = flg_sol;
	}
	//public Timestamp getFch_envio_sol() {
	//	return fch_envio_sol;
	//}
	//public void setFch_envio_sol(Timestamp fch_envio_sol) {
	//	this.fch_envio_sol = fch_envio_sol;
	//}
	//public Timestamp getFch_acept_sol() {
	//	return fch_acept_sol;
	//}
	//public void setFch_acept_sol(Timestamp fch_acept_sol) {
	//	this.fch_acept_sol = fch_acept_sol;
	//}
	public String getMsg_sol() {
		return msg_sol;
	}
	public void setMsg_sol(String msg_sol) {
		this.msg_sol = msg_sol;
	}
	
	
}
