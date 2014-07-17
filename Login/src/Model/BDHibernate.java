package Model;


import org.hibernate.Session;  
import org.hibernate.SessionFactory;  
import org.hibernate.Transaction;  
import org.hibernate.cfg.Configuration; 

public class BDHibernate {
	
	
	
	private static BDHibernate instance = null;
	private static Configuration	m_cfg;
	
	public static SessionFactory 	m_factory;
	public static Session 			m_session;
	public static Transaction 		m_transaction;
	
	//private static BDHibernate instance = null;
	//private static Connection conn;

	private BDHibernate(){
		m_cfg			=	new Configuration();  
		m_cfg.configure();
	      
		m_factory		=	m_cfg.buildSessionFactory();
		//m_session		=	m_factory.openSession();		
	}

	public static BDHibernate getInstance() {
		if (instance == null)
			return new BDHibernate();
		else
			return instance;
	}

	public static Transaction getTransaction() {		  
		return m_transaction;
	}   
	
	public static Session getSession() {		  
		return m_session;
	}
	public static SessionFactory getFactory() {		  
		return m_factory;
	}

    public static void closeSession() {
    	m_session.close();
    }
}