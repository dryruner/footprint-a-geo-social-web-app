package controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybeans.forms.FormBeanFactory;

import databean.Post;
import databean.User;
import formbean.BrowseUserForm;

import model.*;

public class HomeAction extends Action{
	private FormBeanFactory<BrowseUserForm> formBeanFactory =  FormBeanFactory.getInstance(BrowseUserForm.class, "<>\"");
	private PostDAO postDAO;
	private UserDAO userDAO;
	
	public String getName() { return "home.do"; }
	
	public HomeAction(Model model){
		postDAO = model.getPostDAO();
		userDAO = model.getUserDAO();
	}
	
	public String perform(HttpServletRequest request){
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		BrowseUserForm form = formBeanFactory.create(request);
	    
		// Set up the request attributes (the errors list and the form bean so
        // we can just return to the jsp with the form if the request isn't correct)
        List<String> errors = new ArrayList<String>();
        request.setAttribute("errors",errors);
        
		try{
			Post[] postList;
			Post[] imgList;
			if (form.isPresent()) {
				if( form.getEmail().length()==0){
					System.out.println("1");
					System.out.println("email:"+form.getEmail());
					request.setAttribute("viewUser", user);
					request.setAttribute("isFollow", null);
					postList = postDAO.getByUser(user);	
					imgList = postDAO.getAllImg(user);
					request.setAttribute("imgList", imgList);
					request.setAttribute("postList", postList);
					return "home.jsp";
				}
				else{
					System.out.println("2");
					System.out.println("email:"+form.getEmail());
					User viewUser = userDAO.lookupByHashedEmail(form.getEmail());
					if(viewUser == null){
						request.setAttribute("viewUser", user);
						request.setAttribute("isFollow", null);
						postList = postDAO.getByUser(user);	
						imgList = postDAO.getAllImg(user);
						request.setAttribute("imgList", imgList);
						request.setAttribute("postList", postList);
						return "home.jsp";
					}
					else{
						request.setAttribute("viewUser", viewUser);
						if( user.equals(viewUser)){
							request.setAttribute("isFollow", null);
						}else{
							if( user.isFollow(viewUser)){
								request.setAttribute("isFollow", 1);
							}else{
								request.setAttribute("isFollow", 0);
							}
						}
						postList = postDAO.getByUser(viewUser);
						imgList = postDAO.getAllImg(viewUser);
					}					
				}			
			}
			else{
				request.setAttribute("viewUser", user);
				postList = postDAO.getByUser(user);
				imgList = postDAO.getAllImg(user);
			}
			
			//Set<Post> postList =  user.getPostSet();
			//Post[] postList = postDAO.getAll();
			request.setAttribute("postList", postList);
			request.setAttribute("imgList", imgList);
		}catch(DAOException e){
			errors.add(e.getMessage());
		}
		
		
		return "home.jsp";
	}
}
