package Model;

import java.util.Vector;

public class Login extends BDHandler {
	
	public String m_nom_user;
	public int m_id_user;
	
	public Login(){
		super();
	}
	
	public void Authenticate(String email, String password){
		Vector<String> data = new Vector<String>();
		data.add(email);
		data.add(password);
		
		//el primer parametro es el cursor, por eso no se envia en el vector
		this.QueryCursor("fx_login (?,?,?) ", data);
		
		if(this.m_data.size() == 1){
			m_id_user = Integer.parseInt(this.m_data.elementAt(0).elementAt(0));
			m_nom_user = this.m_data.elementAt(0).elementAt(1);			
		}
			
		else
			m_id_user = -1;
	}

}
