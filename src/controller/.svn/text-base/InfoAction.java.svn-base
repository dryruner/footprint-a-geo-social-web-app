package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.DAOException;
import model.Model;
import model.PostDAO;
import model.UserDAO;
import databean.Post;
import databean.User;

public class InfoAction extends Action{
	private UserDAO userDAO;
	private PostDAO postDAO;
	
	public String getName() { return "info.do"; }
	
	public InfoAction(Model model) {
		this.userDAO = model.getUserDAO();
		this.postDAO = model.getPostDAO();
	}
	
	public String perform(HttpServletRequest request){
		try{
			Post[] postList = postDAO.getAll();
			User[] userList = userDAO.getAll();
			request.setAttribute("postList", postList);
			request.setAttribute("userList", userList);
		}catch(DAOException e){
			System.out.println("1");
        	return "index.jsp";
        }
		return "info.jsp";
	}
}
