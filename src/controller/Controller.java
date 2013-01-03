package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import databean.User;
import model.*;

public class Controller extends HttpServlet{
	Model model;
	
	public void init() throws ServletException {
		model = new Model(getServletConfig());
		
		//TODO
		Action.add(new IndexAction(model));
		Action.add(new InfoAction(model));
		Action.add(new RegisterAction(model));
		Action.add(new LoginAction(model));
		Action.add(new LogoutAction(model));
		Action.add(new HomeAction(model));
		Action.add(new FriendAction(model));
		Action.add(new CreatePostAction(model));
		Action.add(new DeletePostAction(model));
		Action.add(new UserListAction(model));
		Action.add(new FollowAction(model));
		Action.add(new UnFollowAction(model));
		Action.add(new SearchAction(model));
		Action.add(new UpdateProfileAction(model));
		Action.add(new StatisticAction(model));
		Action.add(new UploadImgAction(model));
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (model.getRequireSSL() && !request.isSecure()) {
			// If we're required to use SSL and we're not on a secure connection, redirect
        	String host = request.getServerName();
        	String port = (request.getServerPort()==80) ? "" : ":8443";
            response.sendRedirect("https://"+host+port+request.getRequestURI());
            return;
        }

        //try {
	        //model.getLogDAO().write(request, "doGet: "+request.getRequestURI());
	        String nextPage = performTheAction(request);
	        sendToNextPage(nextPage,request,response);
       // } catch (DAOException e) {
       // 	e.printStackTrace();
       // 	request.setAttribute("dbError",e.getMessage());
	   //     sendToNextPage("db-error.jsp",request,response);
       // }
    }
	
	/*
     * Extracts the requested action and (depending on whether the user is logged in)
     * perform it (or make the user login).
     * @param request
     * @return the next page (the view)
     */
    private String performTheAction(HttpServletRequest request) {
        HttpSession session     = request.getSession(true);
        String      servletPath = request.getServletPath();
        User        user = (User) session.getAttribute("user");
        String      action = getActionName(servletPath);

        System.out.println("servletPath="+servletPath+" requestURI="+request.getRequestURI()+"  user="+user);
        System.out.println("contextPath="+request.getContextPath());
        System.out.println("session ID="+session.getId());

        if (action.equals("register.do") || action.equals("login.do")|| action.equals("info.do")) {
        	// Allow these actions without logging in
			return Action.perform(action,request);
        }
        
        if (user == null) {
        	// If the user hasn't logged in, direct him to the login page
			return Action.perform("index.do",request);
        }
        
        if (action.equals("start")) {
        	// If he's logged in but back at the /start page, send him to manage his pics
			return Action.perform("home.do",request);
        }

      	// Let the logged in user run his chosen action
		return Action.perform(action,request);
    }
    
    /*
     * If nextPage is null, send back 404
     * If nextPage starts with a '/', redirect to this page.
     *    In this case, the page must be the whole servlet path including the webapp name
     * Otherwise dispatch to the page (the view)
     *    This is the common case
     * Note: If nextPage equals "image", we will dispatch to /image.  In the web.xml file, "/image"
     *    is mapped to the ImageServlet will which return the image bytes for display.
     */
    private void sendToNextPage(String nextPage, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    	// System.out.println("nextPage="+nextPage);
    	
    	if (nextPage == null) {
    		response.sendError(HttpServletResponse.SC_NOT_FOUND,request.getServletPath());
    		return;
    	}
    	
    	if (nextPage.charAt(0) == '/') {
    		String proto = request.isSecure() ? "https://" : "http://";
			String host  = request.getServerName();
			String port  = ":"+String.valueOf(request.getServerPort());
			if (port.equals(":80")) port = "";
			if (port.equals(":443")) port = "";
			response.sendRedirect(proto+host+port+nextPage);
			return;
    	}
    	
   		RequestDispatcher d = request.getRequestDispatcher(nextPage);
   		d.forward(request,response);
    }
    
    /*
	 * Returns the path component after the last slash removing any "extension"
	 * if present.
	 */
    private String getActionName(String path) {
    	// 
        int slash = path.lastIndexOf('/');
        int dot = path.lastIndexOf('.');
        //TODO
        //要考虑重命名action的名称么
        //if (dot == -1) dot = path.length();
        //return path.substring(slash+1,dot);
        return path.substring(slash+1);
    }
}
