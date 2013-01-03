package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.Model;
import model.PostDAO;
import model.UserDAO;

import model.DAOException;
import org.mybeans.forms.FormBeanFactory;

import databean.Post;
import databean.User;

import formbean.SearchForm;

public class SearchAction extends Action{
	private FormBeanFactory<SearchForm> formBeanFactory =  FormBeanFactory.getInstance(SearchForm.class, "<>\"");
	private UserDAO userDAO;
	private PostDAO postDAO;
	
	public String getName() { return "search.do"; }
	
	public SearchAction(Model model){
		postDAO = model.getPostDAO();
		userDAO = model.getUserDAO();
	}
	
	public String perform(HttpServletRequest request){
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		SearchForm form = formBeanFactory.create(request);
		
	    // Set up the request attributes (the errors list and the form bean so
        // we can just return to the jsp with the form if the request isn't correct)
        List<String> errors = new ArrayList<String>();
        request.setAttribute("errors",errors);
        request.setAttribute("form",form);

        // If no params were passed, return with no errors so that the form will be
        // presented (we assume for the first time).
        if (!form.isPresent()) {
            return "search.jsp";
        }
        
        errors.addAll(form.getValidationErrors());
		if (errors.size() != 0) {
			request.setAttribute("postList", new Post[0]);
			request.setAttribute("location", null);
			request.setAttribute("userList", new User[0]);
			return "search.jsp";
		}
		
		String category = form.getCategory();
		String keywords = form.getKeywords();
		System.out.println("keywords"+keywords);
		try{
			if(category == null || category.length()==0){
				request.setAttribute("postList", new Post[0]);
				request.setAttribute("location", null);
				request.setAttribute("userList", new User[0]);
			}
			
			else if(category.equals("location")){
				Post[] postList = postDAO.getByLocation(keywords);
				request.setAttribute("postList", postList);
				request.setAttribute("userList", new User[0]);
				request.setAttribute("location", keywords);
			}
			else if(category.equals("people")){
				User[] userList = userDAO.search(keywords);
				request.setAttribute("postList", new Post[0]);
				request.setAttribute("userList", userList);
				request.setAttribute("location", null);
			}
			else{
				request.setAttribute("postList", new Post[0]);
				request.setAttribute("location", null);
				request.setAttribute("userList", new User[0]);
			}
			
		}catch (DAOException e) {
			errors.add(e.getMessage());
		}
		return "search.jsp";
			
		
	}
}
