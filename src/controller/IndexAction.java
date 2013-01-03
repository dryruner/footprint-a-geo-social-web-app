package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.Model;

import databean.User;

/**
 * Show the static index page 
 * @author Administrator
 *
 */
public class IndexAction extends Action{

	public String getName() { return "index.do"; }
	
	public IndexAction(Model model) {
		
	}
	
	public String perform(HttpServletRequest request){
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		return "index.jsp";
	}
}
