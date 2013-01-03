package controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import databean.Post;
import databean.User;

import model.DAOException;
import model.Model;
import model.PostDAO;
import model.UserDAO;

public class FriendAction extends Action{
	private PostDAO postDAO;
	private UserDAO userDAO;
	
	public String getName() { return "friend.do"; }
	
	public FriendAction(Model model){
		postDAO = model.getPostDAO();
		userDAO = model.getUserDAO();
	}
	
	public String perform(HttpServletRequest request){
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		// Set up the request attributes (the errors list and the form bean so
        // we can just return to the jsp with the form if the request isn't correct)
        List<String> errors = new ArrayList<String>();
        request.setAttribute("errors",errors);
        
        try{
        	Set<User> followedSet =  user.getFollowedSet();
        	Post[] postList = postDAO.getByUserList(followedSet);
        	request.setAttribute("friendPostList", postList);
        }catch(DAOException e){
			errors.add(e.getMessage());
		}
        return "friend.jsp";
	}
}
