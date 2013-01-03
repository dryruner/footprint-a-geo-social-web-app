package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.*;


import org.mybeans.forms.FormBeanFactory;

import databean.Post;
import databean.User;

import formbean.RelationUserForm;

public class FollowAction extends Action{
	private FormBeanFactory<RelationUserForm> formBeanFactory = FormBeanFactory.getInstance(RelationUserForm.class, "<>\"");
	private UserDAO userDAO;
	private PostDAO postDAO;
	
	public String getName() { return "follow.do"; }
	
	public FollowAction(Model model){
		userDAO = model.getUserDAO();
		postDAO = model.getPostDAO();
	}
	
	public String perform(HttpServletRequest request){
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		RelationUserForm form = formBeanFactory.create(request);
		
		// Set up the request attributes (the errors list and the form bean so
        // we can just return to the jsp with the form if the request isn't correct)
        List<String> errors = new ArrayList<String>();
        request.setAttribute("errors",errors);
        request.setAttribute("form",form);
        
        try {
			Post[] postList = postDAO.getByUser(user);
			Post[] imgList = postDAO.getAllImg(user);
			//Post[] postList = postDAO.getAll();
			request.setAttribute("postList", postList);
			request.setAttribute("imgList", imgList);
			request.setAttribute("viewUser", user);
		} catch (DAOException e) {
			errors.add(e.getMessage());
		}
        
        // Any validation errors?
        errors.addAll(form.getValidationErrors());
        if (errors.size() != 0) {
        	System.out.println("there is error when creating post");
            return "home.jsp";
        }
        
        String FollowedEmail = form.getFollowedEmail();
        System.out.println(FollowedEmail);
        try{
        	User followed = userDAO.lookup(FollowedEmail);
        	if(followed == null){
        		errors.add("fail to follow the unknown user");
        		return "home.jsp";
        	}
        	else if(followed.equals(user)){
        		errors.add("fail to follow yourself");
        		return "home.jsp";
        	}
        	else if(user.isFollow(followed)){
        		errors.add("can not follow the already followed people");
        		return "home.jsp";
        	}
        	else{
        		userDAO.follow(user, followed);
        		request.setAttribute("isFollow", 1);
            	           	
            	request.setAttribute("viewUser", followed);
            	Post[] postList = postDAO.getByUser(followed);
            	Post[] imgList = postDAO.getAllImg(followed);
            	//Post[] postList = postDAO.getAll();
    			request.setAttribute("postList", postList);
    			request.setAttribute("imgList", imgList);
        	}
        	
        	
        }catch(DAOException e){
        	errors.add(e.getMessage());
        	return "home.jsp";
        }
        
        return "home.jsp";
        
        
        
	}
}
