package Model;

import java.sql.ResultSet;
import java.sql.Types;
import java.util.Vector;

public class Amigo extends BDHandler{
	public int m_identificador;
	public String m_nombre;
	public String m_email;
	public Vector<Amigo> m_amigos;
	
	public Amigo(){
		super();
	}
	
	public void ListarAmigos(int id){
		
		try{
			 //Vector<String> data = new  Vector<String>();
			m_amigos = new Vector<Amigo>();
			
    		this.m_conn.setAutoCommit(false);
    		
    		// Procedure call.
    		this.m_proc = null;
    		this.m_proc = m_conn.prepareCall("{ call fx_listar_amigos (?, ?) }");
    		
    		//seteamos los parametros, el primer parametro es po defecto el cursor
    		this.m_proc.setNull(1, Types.OTHER);
    		this.m_proc.registerOutParameter(1, Types.OTHER);
    		this.m_proc.setInt(2, id);
    		
    		this.m_proc.execute();
    		
    		//para el caso de nuestro cursosr, solo tenemos uno en nuestra funcion
    		this.m_result = null;
    		this.m_result = (ResultSet) m_proc.getObject(1);
    		this.m_result_metada = m_result.getMetaData();
    		while (m_result.next()) {
    			Amigo ami = new Amigo();
    			ami.m_identificador = this.m_result.getInt("id_user");
    			ami.m_nombre = this.m_result.getString("nom_user");
    			ami.m_email = this.m_result.getString("ema_user");
    			
    			m_amigos.add(ami);
    		}
    		this.m_result.close();
    		this.m_proc.close();	    		
			
		}catch (Exception e) {
            System.err.println("El porque del cascar SQL: " + e.getMessage());
            e.printStackTrace();
        }		
		
	}
	
public void BuscarAmigos(int id, String nom){
		
		try{
			 //Vector<String> data = new  Vector<String>();
			m_amigos = new Vector<Amigo>();
			
    		this.m_conn.setAutoCommit(false);
    		
    		// Procedure call.
    		this.m_proc = null;
    		this.m_proc = m_conn.prepareCall("{ call fx_buscar_amigos (?, ?, ?) }");
    		
    		//seteamos los parametros, el primer parametro es po defecto el cursor
    		this.m_proc.setNull(1, Types.OTHER);
    		this.m_proc.registerOutParameter(1, Types.OTHER);
    		this.m_proc.setInt(2, id);
    		this.m_proc.setString(3, nom);
    		
    		this.m_proc.execute();
    		
    		//para el caso de nuestro cursosr, solo tenemos uno en nuestra funcion
    		this.m_result = null;
    		this.m_result = (ResultSet) m_proc.getObject(1);
    		this.m_result_metada = m_result.getMetaData();
    		while (m_result.next()) {
    			Amigo ami = new Amigo();
    			ami.m_identificador = this.m_result.getInt("id_user");
    			ami.m_nombre = this.m_result.getString("nom_user");
    			ami.m_email = this.m_result.getString("ema_user");
    			
    			m_amigos.add(ami);
    		}
    		this.m_result.close();
    		this.m_proc.close();	    		
			
		}catch (Exception e) {
            System.err.println("El porque del cascar SQL: " + e.getMessage());
            e.printStackTrace();
        }		
		
	}


	public void AgregarAmigo(int id, int id_amigo, String mensaje){
	
	try{
		 //Vector<String> data = new  Vector<String>();
		int result = -1 ;
		this.m_conn.setAutoCommit(false);
		this.m_proc = null;
		this.m_proc = m_conn.prepareCall("{ call fx_agregar_amigo (?,?,?, ?) }");
		
		
		//seteamos los parametros, el primer parametro es po defecto el cursor
		
		this.m_proc.setInt(1, id);
		this.m_proc.setInt(2, id_amigo);
		this.m_proc.setString(3, mensaje);
		this.m_proc.registerOutParameter(4, Types.INTEGER); //el parametro de salida
		
		this.m_proc.execute();
		
		result = this.m_proc.getInt(4);
		
		    		
		this.m_conn.commit();
		this.m_conn.setAutoCommit(true);
		
		this.m_proc.close();    		    		
		
	}catch (Exception e) {
        System.err.println("El porque del cascar SQL: " + e.getMessage());
        e.printStackTrace();
    }		
	
}

}
