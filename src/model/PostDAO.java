package model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import databean.Post;
import databean.User;

public class PostDAO {
	private SessionFactory sessionFactory;
	
	public static PostDAO getHibernateInstance(SessionFactory sessionFactory)throws DAOException {
		return new PostDAO(sessionFactory);
	}
	
	public PostDAO(SessionFactory sessionFactory){
		this.sessionFactory = sessionFactory;
	}
	
	public void create(Post post) throws DAOException{
		Session session = sessionFactory.getCurrentSession();
		try{
			session.beginTransaction();
			session.save(post);
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
	
	public Post lookup(int id) throws DAOException {
		Session session = sessionFactory.getCurrentSession();
		try{
			session.beginTransaction();
			Post p = (Post) session.get(Post.class, id);
			session.getTransaction().commit();
			return p;
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
	
	public void delete(int id) throws DAOException{
		Session session = sessionFactory.getCurrentSession();
		try{
			session.beginTransaction();
			Post p = (Post)session.get(Post.class, id);
			session.delete(p);
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
	public Post[] getAll() throws DAOException{
		Session session = sessionFactory.getCurrentSession();
		session.beginTransaction();
		try {
			List<Post> postList = (List<Post>) session.createQuery("from Post")
					.list();
			if (postList == null)
				return new Post[0];
			return (Post[]) postList.toArray(new Post[0]);
		} finally {
			session.getTransaction().commit();
		}
	}
	
	@SuppressWarnings("unchecked")
	public Post[] getByUser(User user) throws DAOException{
		Session session = sessionFactory.getCurrentSession();
		session.beginTransaction();
		try{
			Query query = session.createQuery("from Post Post where Post.author.email=? order by Post.id desc");
			query.setString(0, user.getEmail());
			List<Post> postList = (List<Post>) query.list();
			if (postList == null)
				return new Post[0];
			return (Post[]) postList.toArray(new Post[0]);
		} finally {
			session.getTransaction().commit();
		}
	}
	
	@SuppressWarnings("unchecked")
	public Post[] getByUserList(Set<User> userList) throws DAOException{
		Session session = sessionFactory.getCurrentSession();
		session.beginTransaction();
		try{
			List<Post> postList = new ArrayList<Post>();
			for(User u: userList){
				Query query = session.createQuery("from Post Post where Post.author.email=?");
				query.setString(0, u.getEmail());
				List<Post> postListPerUser = (List<Post>) query.list();
				for(Post p:postListPerUser) postList.add(p);
			}
			Post[] postArray = postList.toArray(new Post[0]);
			Arrays.sort(postArray);
			return postArray;
		} finally {
			session.getTransaction().commit();
		}
	}
	
	@SuppressWarnings("unchecked")
	public Post[] getAllImg(User user) throws DAOException {
		Session session = sessionFactory.getCurrentSession();
		session.beginTransaction();
		try{
			Query query = session.createQuery("from Post Post where Post.imgURL is not null and Post.author.email=? order by Post.id desc");
			query.setString(0, user.getEmail());
			List<Post> postList = (List<Post>)query.list();
			if (postList == null) return new Post[0];
			return (Post[]) postList.toArray(new Post[0]);
		}finally {
			session.getTransaction().commit();
		}
	}
	
	@SuppressWarnings("unchecked")
	public Post[] getByLocation(String location) throws DAOException {
		Session session = sessionFactory.getCurrentSession();
		session.beginTransaction();
		try{
			Query query = session.createQuery("from Post Post where Post.imgURL is not null and Post.location like ? order by Post.id desc");
			query.setString(0, "%"+location+"%");
			List<Post> postList = (List<Post>)query.list();
			if (postList == null)     return new Post[0];
			return (Post[]) postList.toArray(new Post[0]);
		} finally {
			session.getTransaction().commit();
		}
		
	}

}
