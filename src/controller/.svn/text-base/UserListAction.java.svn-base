package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.*;


import org.mybeans.forms.FormBeanFactory;

import databean.User;

import formbean.*;


public class UserListAction extends Action{
	
	private UserDAO userDAO;
	public String getName() { return "userList.do"; }
	public UserListAction(Model model){
		userDAO = model.getUserDAO();
	}
	public String perform(HttpServletRequest request){
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		
		
		// Set up the request attributes (the errors list and the form bean so
        // we can just return to the jsp with the form if the request isn't correct)
        List<String> errors = new ArrayList<String>();
        request.setAttribute("errors",errors);
        
      //set Attributes
        try{
        	User[] userList = userDAO.getAll();
        	//System.out.println(userDAO.getCount());
        	request.setAttribute("userList", userList);
        	
        }catch(DAOException e){
			errors.add(e.getMessage());
			return "userList.jsp";
		}
        
        return "userList.jsp";
	}
}
