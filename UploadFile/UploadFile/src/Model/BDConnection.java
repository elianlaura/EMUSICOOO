package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class BDConnection {
	private static BDConnection instance = null;
	private static Connection conn;

	private BDConnection()
	{
		String dbDriver = "org.postgresql.Driver";
		String url = "jdbc:postgresql://localhost:5432/EMUSICOOO";
		String username= "postgres";
		String password = "1234";
		try
		{
			Class.forName( dbDriver);
			conn = DriverManager.getConnection(url,username, password);
		}
		catch(ClassNotFoundException cnfErr)
		{
			System.out.print("No reconoce el driver");
			cnfErr.printStackTrace();
		}
		catch(SQLException err)
		{
			err.printStackTrace();
		}
	}

	public static BDConnection getInstance() {
		if (instance == null)
			return new BDConnection();
		else
			return instance;
	}

	public static Connection getConnection() {
		return conn;
	}


    public static void closeConnection(Connection conn) {

	    try {
	
	        conn.close();
	
	    } catch (SQLException e) {
	
	    }

    }
}