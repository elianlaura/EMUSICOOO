package Model;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.sql.Types;
import java.util.Vector;

public class BDHandler {
	Connection m_conn = null;
	Statement m_statement = null;
    public ResultSet m_result = null;
    public boolean m_result_state ;
    public ResultSetMetaData m_result_metada = null; 
    Vector<Vector<String>> m_data = null;
    
    public CallableStatement m_proc = null;
    
    
    BDConnection m_connection;
    
    public BDHandler(){
    	m_connection = m_connection.getInstance();
    	m_conn = m_connection.getConnection();
    }
    
    
    public void QueryBuscar(String cadena){
    	try{
    		m_data = new Vector<Vector<String>>();
	    	Statement stmt = m_conn.createStatement();
	    	ResultSet rs;
	    	
	    	//String query = "select * from \"Cancion\" where let_can like '%vivir%'; ";
	    	String query = "select * from \"Cancion\" where let_can ilike '%"+ cadena + "%' OR nom_can ilike '%"+ cadena + "%'; ";
	    	rs = stmt.executeQuery(query);
	    	m_result_metada = rs.getMetaData();
	    	
	    	while(rs.next()){
	    		Vector<String> temp = new Vector<String>();
	    		System.out.println(rs.getString("id_can") + " " + rs.getString("nom_can")); 
	    		temp.add(rs.getString("id_can"));
	    		temp.add(rs.getString("nom_can")); 
	    		//Para obtener data de cada columna
    			//for(int i = 1; i <= m_result_metada.getColumnCount(); i++){
    				//temp.add(rs.getString(i));            		
    			//}
	    		m_data.add(temp); 
	    	}
			
	    	
	    	stmt.execute("END");
	    	stmt.close();
	    	//m_conn.close();
    	}
    	catch( Exception e ){
    		//Por si ocurre un error
    		System.err.println("El porque del cascar SQL: " + e.getMessage());
            e.printStackTrace();
    	}
    	
    }
    
    public void QueryFunction(String function_name){
    	try{
    		m_data = new Vector<Vector<String>>();
    		
    		m_conn.setAutoCommit(false);
    		// Procedure call.
    		m_proc = null;
    		m_proc = m_conn.prepareCall("{ call "+function_name+" }");	
    		
    	}catch (Exception e) {
            System.err.println("El porque del cascar SQL: " + e.getMessage());
            e.printStackTrace();
        }     
    }
    
    public void QueryFunctionExecute(){
    	try{  		
    		
    		m_proc.execute();
    		
    		//para el caso de nuestro cursosr, solo tenemos uno en nuestra funcion
    		/*m_result = null;
    		m_result = (ResultSet) m_proc.getObject(1);
    		m_result_metada = m_result.getMetaData();
    		while (m_result.next()) {
    			Vector<String> temp = new Vector<String>();
    		    // do something with the results...
    			//System.out.println(m_result.getString("id_user"));
    			//System.out.println(m_result.getString("nom_user"));
    			
    			//obtenemos la data de cada columna con el un for
    			for(int i = 1; i <= m_result_metada.getColumnCount(); i++){
    				temp.add(m_result.getString(i));            		
    			}    			
        		m_data.add(temp);
    			
    		}
    		m_result.close();
    		m_proc.close();*/
    		
    	}catch (Exception e) {
            System.err.println("El porque del cascar SQL: " + e.getMessage());
            e.printStackTrace();
        }     
    }

    
    //para llamar a funciones postgresql, tomando en consideracion que el primer parametro es el nombre del cursor
    public void QueryCursor(String function_name, Vector<String> parameters){
    	try{
    		m_data = new Vector<Vector<String>>();
    		
    		m_conn.setAutoCommit(false);
    		// Procedure call.
    		m_proc = null;
    		m_proc = m_conn.prepareCall("{ call "+function_name+" }");
    		
    		//seteamos los parametros, el primer parametro es po defecto el cursor
    		m_proc.setNull(1, Types.OTHER);
    		m_proc.registerOutParameter(1, Types.OTHER);
    		
    		//seteamos los demas parametros provenientes del vector de parametros
    		for(int i =0; i < parameters.size(); i++){
    			m_proc.setString(i + 2, parameters.elementAt(i));        		
    		}
    		//proc.setString(2, "enriquefirst@gmail.com");
    		//proc.setString(3, "123");
    		
    		m_proc.execute();
    		
    		//para el caso de nuestro cursosr, solo tenemos uno en nuestra funcion
    		m_result = null;
    		m_result = (ResultSet) m_proc.getObject(1);
    		m_result_metada = m_result.getMetaData();
    		while (m_result.next()) {
    			Vector<String> temp = new Vector<String>();
    		    // do something with the results...
    			//System.out.println(m_result.getString("id_user"));
    			//System.out.println(m_result.getString("nom_user"));
    			
    			//obtenemos la data de cada columna con el un for
    			for(int i = 1; i <= m_result_metada.getColumnCount(); i++){
    				temp.add(m_result.getString(i));            		
    			}    			
        		m_data.add(temp);
    			
    		}
    		m_result.close();
    		m_proc.close();
    		
    	}catch (Exception e) {
            System.err.println("El porque del cascar SQL: " + e.getMessage());
            e.printStackTrace();
        } 
    	
    	/*try {
    		
    		m_statement = m_conn.createStatement();
    		
    		m_data = null;
    		m_data = new Vector<Vector<String>>();
	    	 	
	    	m_result_state = m_statement.execute(sql);	    	   
	    	
	    	while (m_result_state) {
	    		m_result = m_statement.getResultSet(); 	    		
	            
	            //caso curioso, como que la primero fila es el cursor r ????, por eso el try catch
	            Vector<String> temp = new Vector<String>();
	            while (m_result.next()) {
	            	try{
	            		m_result_metada = m_result.getMetaData();
	            		System.out.println("cols: "+m_result_metada.getColumnCount());
	            		temp.add(m_result.getString("id_user"));
	            		temp.add(m_result.getString("nom_user"));
	            		m_data.add(temp);
	            	
	            	}catch(Exception e){}
	            	finally{}	            	
	            }
	            m_result.close();

	         //Check for next result set
	         m_result_state = m_statement.getMoreResults();
	       } 
	    	m_statement.close();
	      
	    	
    	} 
        catch (Exception e) {
            System.err.println("El porque del cascar SQL: " + e.getMessage());
        } 
        finally {
        	//m_connection.closeConnection(m_conn);
        }*/
    }
}
