package Model;

import java.sql.ResultSet;
import java.sql.Types;
import java.util.Vector;

public class Artista extends BDHandler{
	
	public int m_identificador;
	public String m_nombre;
	public Vector<Artista> m_artistas;
	
	public Artista(){
		super();
	}
	
	public void Listar(){
		
		try{
			 //Vector<String> data = new  Vector<String>();
			m_artistas = new Vector<Artista>();
			
    		this.m_conn.setAutoCommit(false);
    		
    		// Procedure call.
    		this.m_proc = null;
    		this.m_proc = m_conn.prepareCall("{ call fx_listar_artistas (?) }");
    		
    		//seteamos los parametros, el primer parametro es po defecto el cursor
    		this.m_proc.setNull(1, Types.OTHER);
    		this.m_proc.registerOutParameter(1, Types.OTHER);
    		    		    		
    		this.m_proc.execute();
    		
    		//para el caso de nuestro cursosr, solo tenemos uno en nuestra funcion
    		this.m_result = null;
    		this.m_result = (ResultSet) m_proc.getObject(1);
    		this.m_result_metada = m_result.getMetaData();
    		while (m_result.next()) {
    			Artista art = new Artista();
    			art.m_identificador = this.m_result.getInt("id_art");
    			art.m_nombre = this.m_result.getString("id_art");
    			
    			m_artistas.add(art);
    		}
    		this.m_result.close();
    		this.m_proc.close();	    		
			
		}catch (Exception e) {
            System.err.println("El porque del cascar SQL: " + e.getMessage());
            e.printStackTrace();
        }		
		
	}

}
