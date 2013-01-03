package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.DAOException;
import org.mybeans.forms.FormBeanFactory;

import databean.User;

import formbean.LoginForm;

import model.Model;
import model.UserDAO;

public class LoginAction extends Action{
	private FormBeanFactory<LoginForm> formBeanFactory = FormBeanFactory.getInstance(LoginForm.class, "<>\"");
	private UserDAO userDAO;
	
	public String getName() { return "login.do"; }
	
	public LoginAction(Model model){
		userDAO = model.getUserDAO();
	}
	
	public String perform(HttpServletRequest request){
		LoginForm form = formBeanFactory.create(request);
		
		 // Set up the request attributes (the errors list and the form bean so
        // we can just return to the jsp with the form if the request isn't correct)
        List<String> errors = new ArrayList<String>();
        request.setAttribute("errors",errors);
        request.setAttribute("form",form);
        
        // If no params were passed, return with no errors so that the form will be
        // presented (we assume for the first time).
        if (!form.isPresent()) {
            return "signin.jsp";
        }
        
        // Any validation errors?
        errors.addAll(form.getValidationErrors());
        if (errors.size() != 0) {
            return "signin.jsp";
        }
        
        // Look up the user
        User user;
        try {
        	user = userDAO.lookup(form.getEmail());
        } catch (DAOException e) {
        	errors.add(e.getMessage());
        	return "signin.jsp";
        }
        
        if (user == null) {
            errors.add("User Name not found");
            return "signin.jsp";
        }

        // Check the password
        if (!user.checkPassword(form.getPassword())) {
            errors.add("Incorrect password");
            return "signin.jsp";
        }

        // Attach (this copy of) the user bean to the session
        HttpSession session = request.getSession();
        session.setAttribute("user",user);

        // After successful login send to...
        String redirectTo = (String) session.getAttribute("redirectTo");
        if (redirectTo != null) return redirectTo;
        
        
        // If redirectTo is null, redirect to the "your-course" action
		String webapp = request.getContextPath();
		return webapp + "/home.do";
	}
}
