package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.Model;

public class LogoutAction extends Action{
	
	public String getName() { return "logout.do"; }
	
	public LogoutAction(Model model){
		
	}

	public String perform(HttpServletRequest request){
		HttpSession session = request.getSession();
		session.setAttribute("user", null);
		return "index.jsp";
	}
}
