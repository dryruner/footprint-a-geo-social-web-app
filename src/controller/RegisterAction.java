package controller;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.*;
import org.mybeans.forms.FormBeanFactory;
import databean.User;
import formbean.RegisterForm;

/*
 * Processes the parameters from the form in register.jsp.
 * If successful:
 *   (1) creates a new User bean
 *   (2) sets the "user" session attribute to the new User bean
 *   (3) redirects to view the originally requested photo.
 * If there was no photo originally requested to be viewed
 * (as specified by the "redirect" hidden form value),
 * just redirect to manage.do to allow the user to add some
 * photos.
 */
public class RegisterAction extends Action{
	private FormBeanFactory<RegisterForm> formBeanFactory =  FormBeanFactory.getInstance(RegisterForm.class, "<>\"");

	private UserDAO userDAO;
	
	public RegisterAction(Model model){
		userDAO = model.getUserDAO();
	}
	
	public String getName(){return "register.do";}
	
	public String perform(HttpServletRequest request){
		RegisterForm form = formBeanFactory.create(request);
		
        // Set up the request attributes (the errors list and the form bean so
        // we can just return to the jsp with the form if the request isn't correct)
        List<String> errors = new ArrayList<String>();
        request.setAttribute("errors",errors);
        request.setAttribute("form",form);


        // If no params were passed, return with no errors so that the form will be
        // presented (we assume for the first time).
        if (!form.isPresent()) {
            return "signup.jsp";
        }

        // Any validation errors?
        errors.addAll(form.getValidationErrors());
		try {
			if (userDAO.lookup(form.getEmail()) != null) {
				errors.add("Email has been registered!");
			}
		} catch (DAOException e) {
			errors.add(e.getMessage());
			return "signup.jsp";
		}
        
        if (errors.size() != 0) {
            return "signup.jsp";
        }

        // Create the user bean
        User user = new User(form.getEmail());
        System.out.println("1. now hashemail is "+user.getHashedEmail());
        user.setLocation(form.getLocation());
        user.setUserName(form.getUserName());
        user.setPassword(form.getPassword());
        System.out.println("clear email"+form.getEmail());
        System.out.println("2 .now hashemail is "+user.getHashedEmail());
        
        user.setHashedEmail(user.md5Email(form.getEmail()));
        System.out.println("3 .now hashemail is "+user.getHashedEmail());
        
        try {
        	userDAO.create(user);
        	System.out.println("4 .now hashemail is "+user.getHashedEmail());
        } catch (DAOException e) {
        	errors.add(e.getMessage());
        	return "signup.jsp";
        }
        
        // Create the user data folder
        //File userFolder = new File("../webapps/Footprint/userTest/"+user.getHashedEmail());
	    //System.out.println(request.getContextPath());
        //userFolder.mkdirs();
        
		// Attach (this copy of) the user bean to the session
        HttpSession session = request.getSession(false);
        session.setAttribute("user",user);

        // After successful registration (and login) send to...
        String redirectTo = (String) session.getAttribute("redirectTo");
        if (redirectTo != null) return redirectTo;
        
        // If redirectTo is null, redirect to the "your-course" action
		String webapp = request.getContextPath();
		return webapp + "/home.do";
    }		
}
