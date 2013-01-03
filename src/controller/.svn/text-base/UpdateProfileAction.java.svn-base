package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.DAOException;
import model.Model;
import model.UserDAO;

import org.mybeans.forms.FormBeanFactory;

import databean.User;
import formbean.UpdateProfileForm;

public class UpdateProfileAction extends Action{
	private FormBeanFactory<UpdateProfileForm> formBeanFactory =  FormBeanFactory.getInstance(UpdateProfileForm.class, "<>\"");
	private UserDAO userDAO;
	
	public String getName() { return "updateProfile.do"; }
	
	public UpdateProfileAction(Model model){
		this.userDAO = model.getUserDAO();
	}
	
	public String perform(HttpServletRequest request){
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		UpdateProfileForm form = formBeanFactory.create(request);
		
		// Set up the request attributes (the errors list and the form bean so
        // we can just return to the jsp with the form if the request isn't correct)
        List<String> errors = new ArrayList<String>();
        request.setAttribute("errors",errors);
        
        // If no params were passed, return with no errors so that the form will be
        // presented (we assume for the first time).
        if (!form.isPresent()) {
            return "profile.jsp";
        }
        
        errors.addAll(form.getValidationErrors());
        if (errors.size() != 0) {
        	System.out.println("there is error when updating profile");
            return "profile.jsp";
        }
        
        if(form.getBirthday()!= null ) { user.setBirthday(form.getBirthday()); }
        if(form.getBlood()!= null )    { user.setBlood(form.getBlood());       }
        if(form.getGender()!= null )   { user.setGender(form.getGender());     }
        if(form.getLocation()!= null ) { user.setLocation(form.getLocation()); }
        if(form.getStatus()!= null )   { user.setStatus(form.getStatus());     }
        if(form.getUserName()!= null ) { user.setUserName(form.getUserName()); }
        
        try{
        	userDAO.update(user);
        }catch(DAOException e){
        	System.out.println("there is error when userDAO update");
        	errors.add(e.getMessage());
        }
           
        return "profile.jsp";
        
	}
}
