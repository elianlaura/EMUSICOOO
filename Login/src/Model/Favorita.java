package Model;


import java.sql.ResultSet;
import java.sql.Types;
import java.util.Vector;
import BackingBeans.FavoritaBean;

public class Favorita extends BDHandler {
	
	public int m_identificador;
	public String m_contador;
	
	public int m_id_user;
	
	public int m_id_cancion;
	public String m_nombre;
	public String m_letra;
	public String m_url;
	public String m_artista;
	public String m_categoria;

	public int m_id_usuario;
	public int m_id_artista;
	public int m_id_categoria;
	
	public Vector<Favorita> listaFavoritas;
	
	public Favorita(){
		super();
	}
	
	
public void ListarFavoritas(){
		
		listaFavoritas = new Vector<Favorita>();
		
		try{
			 //Vector<String> data = new  Vector<String>();
   		
   		this.m_conn.setAutoCommit(false);
   		this.m_proc = null;
   		this.m_proc = m_conn.prepareCall("{ call fx_listar_favoritas(?,?) }");
   		
   		//seteamos los parametros, el segundo parametro debe ser del USUARIO!
   		this.m_proc.setNull(1, Types.OTHER);
   		this.m_proc.registerOutParameter(1, Types.OTHER);
   		
   		this.m_proc.execute();
   		
   		//para el caso de nuestro cursosr, solo tenemos uno en nuestra funcion
   		this.m_result = null;
   		this.m_result = (ResultSet) m_proc.getObject(1);
   		this.m_result_metada = m_result.getMetaData();
   		Favorita fav;
   		
   		/*if (m_result.last()) { //Solo cuando resulset es scrollable
   		  rowcounts = m_result.getRow();
   		  m_result.beforeFirst(); // not rs.first() because the rs.next() below will move on, missing the first element
   		}*/
   		if(!m_result.next()){
   			listaFavoritas = null;
   		}
   		while (m_result.next()) {
   			fav = new Favorita();
   			fav.m_identificador		= m_result.getInt("id_fav");
   			fav.m_id_cancion		= m_result.getInt("id_can");
   			fav.m_id_user			= m_result.getInt("id_user");
   			fav.m_contador 			= m_result.getString("cont_fav");
   			// ... muchos otros PARAMETROS!
   			
   			listaFavoritas.add(fav);
   		}
   		this.m_result.close();
   		
   		this.m_conn.commit();
		this.m_conn.setAutoCommit(true);
   		
   		this.m_proc.close();    		    		
			
		}catch (Exception e) {
           System.err.println("El porque del cascar SQL: " + e.getMessage());
           e.printStackTrace();
       }
		
		
	}

	public Vector<FavoritaBean> ListarColeccion(int id){
	
		try{
			 //Vector<String> data = new  Vector<String>();
			Vector<FavoritaBean> col = new Vector<FavoritaBean>();
			
	   		this.m_conn.setAutoCommit(false);
	   		
	   		// Procedure call.
	   		this.m_proc = null;
	   		this.m_proc = m_conn.prepareCall("{ call fx_listar_coleccion (?, ?) }");
	   		
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
	   			String img = "<img src='/images/btn.png' alt='Smiley face' height='42' width='42'>";
	   			
	   			FavoritaBean fav = new FavoritaBean();
	   			fav.setIdentificador(this.m_result.getInt("id_can"));
	   			fav.setPathImg(this.m_result.getString("pho_can"));
	   			fav.setNombre(this.m_result.getString("nom_can"));
	   			fav.setArtista(this.m_result.getString("nom_art"));
	   			fav.setCategoria(this.m_result.getString("nom_cat"));
	   			fav.setNum_reproduccion(this.m_result.getInt("cont"));
	   			fav.setReproduccion(this.m_result.getString("fch_fav"));
	   			fav.setImg_reproduccion(img);
	   			
	   			col.add(fav);
	   		}
	   		this.m_result.close();
	   		this.m_proc.close();
	   		
	   		return col;
			
		}catch (Exception e) {
           System.err.println("El porque del cascar SQL: " + e.getMessage());
           e.printStackTrace();
       }		
		
		return null;
		
		
		
	}

}
