package Model;

import java.sql.Types;
import java.util.Vector;

public class User extends BDHandler {
	public String m_nom_user;
	
	public User(){
		super();
	}
	
	public int RegisterUser(String name, String email, String password){
		int result = -1 ;
		try{
			
			
			this.m_conn.setAutoCommit(false);
    		// Procedure call.
			this.m_proc = null;
			this.m_proc = m_conn.prepareCall("{ call fx_user_register (?,?,?,?)  }");				
			
			this.m_proc.setString(1, name);			
			this.m_proc.setString(2, email);
			this.m_proc.setString(3, password);
			this.m_proc.registerOutParameter(4, Types.INTEGER); //el parametro de salida
			
			this.m_proc.execute();
			
			result = this.m_proc.getInt(4);
			
			
			this.m_conn.commit();
			this.m_conn.setAutoCommit(true);
			
			this.m_proc.close();
			return result;
		}catch (Exception e) {
            System.err.println("El porque del cascar SQL: " + e.getMessage());
            e.printStackTrace();
        }
		
		return result; 
	}
}
