package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.DAOException;
import model.Model;
import model.PostDAO;

import org.mybeans.forms.FormBeanFactory;

import databean.Post;
import databean.User;

import formbean.DeletePostForm;


public class DeletePostAction extends Action{
	private FormBeanFactory<DeletePostForm> formBeanFactory = FormBeanFactory.getInstance(DeletePostForm.class, "<>\"");
	private PostDAO postDAO;
	
	public String getName() { return "deletePost.do"; }
	
	public DeletePostAction(Model model){
		this.postDAO = model.getPostDAO();
	}
	
	public String perform(HttpServletRequest request){
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		
		DeletePostForm form = formBeanFactory.create(request);
		
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
        	System.out.println("there is error when deleting post");
            return "home.jsp";
        }
        
        
        
		try{
			int id = Integer.parseInt(form.getPostId());
			Post post = postDAO.lookup(id);
			if( post == null){
				return "home.jsp";
			}
			else if( !post.getAuthor().equals(user)){
				return "home.jsp";
			}else{
				postDAO.delete(id);
				Post[] postList = postDAO.getByUser(user);
				Post[] imgList = postDAO.getAllImg(user);
				request.setAttribute("postList", postList);
				request.setAttribute("imgList", imgList);
				request.setAttribute("viewUser", user);
			}	
		}catch(NumberFormatException el){
			return "home.jsp";
		}catch (DAOException e) {
			System.out.println("there is error when delete postDAO");
			errors.add(e.getMessage());
		}
		
		return "home.jsp";
	}
}
