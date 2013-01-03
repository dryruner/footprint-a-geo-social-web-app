package model;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import databean.User;


public class UserDAO {
	private SessionFactory sessionFactory;

	public static UserDAO getHibernateInstance(SessionFactory sessionFactory)
			throws DAOException {
		return new UserDAO(sessionFactory);
	}

	private UserDAO(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public void create(User newUser) throws DAOException {
		Session session = sessionFactory.getCurrentSession();
		try{
			session.beginTransaction();
			session.save(newUser);
			session.getTransaction().commit();
		}catch(RuntimeException e){
			if(session.getTransaction()!=null && session.getTransaction().isActive()){
				try{
					session.getTransaction().rollback();
				}catch(HibernateException el){
					throw new DAOException("Error rolling back transaction");
				}
			}
		}
	}
	
	public void update(User user) throws DAOException {
		Session session = sessionFactory.getCurrentSession();
		try{
			session.beginTransaction();
			session.update(user);
			session.getTransaction().commit();
		}catch(RuntimeException e){
			if(session.getTransaction()!=null && session.getTransaction().isActive()){
				try{
					session.getTransaction().rollback();
				}catch(HibernateException el){
					throw new DAOException("Error rolling back transaction");
				}
			}
		}
	}

	public void delete(String id) throws DAOException {
		Session session = sessionFactory.getCurrentSession();
		try{
			session.beginTransaction();
			User u = (User) session.get(User.class, id);
			session.delete(u);
			session.getTransaction().commit();
		}catch(RuntimeException e){
			if(session.getTransaction()!=null && session.getTransaction().isActive()){
				try{
					session.getTransaction().rollback();
				}catch(HibernateException el){
					throw new DAOException("Error rolling back transaction");
				}
			}
		}
		
	}

	public User lookup(String id) throws DAOException {
		Session session = sessionFactory.getCurrentSession();
		try{
			session.beginTransaction();
			User u = (User) session.get(User.class, id);
			session.getTransaction().commit();
			return u;
		}catch(RuntimeException e){
			if(session.getTransaction()!=null && session.getTransaction().isActive()){
				try{
					session.getTransaction().rollback();
				}catch(HibernateException el){
					throw new DAOException("Error rolling back transaction");
				}
			}
			throw new DAOException(e);
		}
		
	}
	
	public User lookupByHashedEmail(String hashedEmail) throws DAOException {
		Session session = sessionFactory.getCurrentSession();
		try{
			session.beginTransaction();
			Query query = session.createQuery("from User User where User.hashedEmail=?");
			query.setString(0, hashedEmail);
			User u = (User)query.uniqueResult();
			session.getTransaction().commit();
			return u;
		}catch(RuntimeException e){
			if(session.getTransaction()!=null && session.getTransaction().isActive()){
				try{
					session.getTransaction().rollback();
				}catch(HibernateException el){
					throw new DAOException("Error rolling back transaction");
				}
			}
			throw new DAOException(e);
		}
		
	}
	
	@SuppressWarnings("unchecked")
	public User[] search(String keywords) throws DAOException {
		Session session = sessionFactory.getCurrentSession();
		try{
			session.beginTransaction();
			Query query = session.createQuery("from User User where User.userName like ?");
			query.setString(0, "%"+keywords+"%");
			List<User> userList = (List<User>)query.list();
			System.out.println("search result:"+userList.size());
			session.getTransaction().commit();
			if(userList == null) return new User[0];
			return (User[])userList.toArray(new User[0]);		
		}catch(RuntimeException e){
			if(session.getTransaction()!=null && session.getTransaction().isActive()){
				try{
					session.getTransaction().rollback();
				}catch(HibernateException el){
					throw new DAOException("Error rolling back transaction");
				}
			}
			throw new DAOException(e);
		}
	}
	
	public void follow(User follower, User followed) throws DAOException {
		Session session = sessionFactory.getCurrentSession();
		try{
			session.beginTransaction();
			System.out.println("followed email: "+followed.getEmail());
			System.out.println("follower email: "+follower.getEmail());
			follower.getFollowedSet().add(followed);
			followed.getFollowerSet().add(follower); //for memory, no DB update
			session.update(follower);
			session.update(followed);                //prevent twice relations
			session.getTransaction().commit();
		}catch(RuntimeException e){
			if(session.getTransaction()!=null && session.getTransaction().isActive()){
				try{
					session.getTransaction().rollback();
				}catch(HibernateException el){
					throw new DAOException("Error rolling back transaction");
				}
			}
			throw new DAOException(e);
		}	
	}
	
	public void unfollow(User follower, User followed) throws DAOException{
		Session session = sessionFactory.getCurrentSession();
		try{
			session.beginTransaction();
			follower.getFollowedSet().remove(followed);
			followed.getFollowerSet().remove(follower);
			session.update(follower);
			session.update(followed);
			session.getTransaction().commit();
		}catch(RuntimeException e){
			if(session.getTransaction()!=null && session.getTransaction().isActive()){
				try{
					session.getTransaction().rollback();
				}catch(HibernateException el){
					throw new DAOException("Error rolling back transaction");
				}
			}
			throw new DAOException(e);
		}		
	}
	
	@SuppressWarnings("unchecked")
	public User[] getAll() throws DAOException {
		Session session = sessionFactory.getCurrentSession();
		session.beginTransaction();
		try {
			List<User> userList = (List<User>) session.createQuery("from User")
					.list();
			if (userList == null)
				return new User[0];
			return (User[]) userList.toArray(new User[0]);
		} finally {
			session.getTransaction().commit();
		}
	}

	public int getCount() throws DAOException {
		Session session = sessionFactory.getCurrentSession();
		session.beginTransaction();
		try {
			return ((Long) session.createQuery("select count(*) from User")
					.uniqueResult()).intValue();
		} finally {
			session.getTransaction().commit();
		}
		// return getAll().length;
	}

	public void setPassword(String userName, String password)
			throws DAOException {
		Session session = sessionFactory.getCurrentSession();
		session.beginTransaction();

		User dbUser = (User) session.get(User.class, userName);

		if (dbUser == null) {
			throw new DAOException("User " + userName + " no longer exists");
		}

		dbUser.setPassword(password);
		session.update(dbUser);
		session.getTransaction().commit();
	}

}
