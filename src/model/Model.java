package model;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;


public class Model {
	//TODO
	private UserDAO userDAO;
	private PostDAO postDAO;


	//private String  localNetAddr;
	//private String  localNetPrefix;
	private boolean requireSSL;

	private SessionFactory hibSessionFactory = null;

	public Model(ServletConfig config) throws ServletException {
		//localNetAddr   = config.getInitParameter("localNetAddr");
        //localNetPrefix = config.getInitParameter("localNetPrefix");
        requireSSL     = new Boolean(config.getInitParameter("requireSSL"));

        initUsingHibernate(config);
	}
	
	//public String   getLocalNetAddr()   { return localNetAddr;   }
	//public String   getLocalNetPrefix() { return localNetPrefix; }
	public boolean  getRequireSSL()     { return requireSSL;     }
	//TODO
	public UserDAO  getUserDAO()        { return userDAO;        }
	public PostDAO  getPostDAO()        { return postDAO;        }
	
	public void initUsingHibernate(ServletConfig config) throws ServletException {
	    try {
            hibSessionFactory = new Configuration().configure().buildSessionFactory();
        } catch (Throwable e) {
            throw new ServletException(e);
        }
        
	    try {
	    	//TODO
	    	userDAO   = UserDAO.getHibernateInstance(hibSessionFactory);
	    	postDAO   = PostDAO.getHibernateInstance(hibSessionFactory);

	    } catch (DAOException e) {
	    	throw new ServletException(e);
	    }
	}
}