package Model;

import java.util.Vector;

public class Buscar extends BDHandler{
	
	String id_cancion;
	public Buscar(){
		super();
	}
	
	public Vector<Vector<String>> Search(String cadena){
		//Vector<String> data = new Vector<String>();
		//data.add(cadena);
		
		////el primer parametro es el cursor, por eso no se envia en el vector
		//this.QueryCursor("fx_login (?,?,?) ", data);
		this.QueryBuscar(cadena);
		
		return this.m_data;
		
	}

}
