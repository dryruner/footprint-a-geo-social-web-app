package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.DAOException;
import model.Model;
import model.PostDAO;
import model.UserDAO;

import org.mybeans.forms.FormBeanFactory;

import databean.Post;
import databean.User;

import formbean.BrowseUserForm;

public class StatisticAction extends Action{
	private FormBeanFactory<BrowseUserForm> formBeanFactory =  FormBeanFactory.getInstance(BrowseUserForm.class, "<>\"");
	private PostDAO postDAO;
	private UserDAO userDAO;
	
	public String getName() { return "statistic.do"; }
	
	public StatisticAction(Model model){
		this.postDAO = model.getPostDAO();
		this.userDAO = model.getUserDAO();
	}
	
	public String perform(HttpServletRequest request){
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		BrowseUserForm form = formBeanFactory.create(request);
	    
		// Set up the request attributes (the errors list and the form bean so
        // we can just return to the jsp with the form if the request isn't correct)
        List<String> errors = new ArrayList<String>();
        request.setAttribute("errors",errors);
        
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
        
        try{
			Post[] postList;
			Post[] imgList;
			if (form.isPresent()) {
				User viewUser = userDAO.lookupByHashedEmail(form.getEmail());
				if(viewUser == null ) { return "home.jsp"; }
				else{
					request.setAttribute("viewUser", viewUser);
					if(user.equals(viewUser)){
						postList = postDAO.getByUser(viewUser);
						imgList = postDAO.getAllImg(viewUser);
						request.setAttribute("isFollow", null);
					}
					else if(user.isFollow(viewUser)){
						postList = postDAO.getByUser(viewUser);
						imgList = postDAO.getAllImg(viewUser);
						request.setAttribute("isFollow", 1);
					}
					else{
						postList = new Post[0];
						imgList = new Post[0];
						request.setAttribute("isFollow", 0);
					}
				}		
			}
			else{
				request.setAttribute("viewUser", user);
				postList = postDAO.getByUser(user);
				imgList = postDAO.getAllImg(user);
				request.setAttribute("isFollow", null);
			}
			request.setAttribute("postList", postList);
			request.setAttribute("imgList", imgList);
        }catch(DAOException e){
			errors.add(e.getMessage());
		}
		
		
		return "statistic.jsp";
	}
}
