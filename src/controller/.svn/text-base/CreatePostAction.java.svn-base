package controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.Model;
import model.PostDAO;

import model.DAOException;
import org.mybeans.forms.FormBeanFactory;

import databean.Post;
import databean.User;

import formbean.PostForm;

/**
 * Processes the parameters from the post form in home.jsp.
 * If successful:
 *   (1) creates a new Post bean
 *   (2) redirects to home page view posts.
 */
public class CreatePostAction extends Action{
	private FormBeanFactory<PostForm> formBeanFactory = FormBeanFactory.getInstance(PostForm.class, "<>\"");
	
	private PostDAO postDAO;
	
	public String getName() { return "createPost.do"; }
	
	public CreatePostAction(Model model){
		postDAO = model.getPostDAO();
	}
	
	public String perform(HttpServletRequest request){
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		
		PostForm form = formBeanFactory.create(request);
		System.out.println("latitude: "+form.getLatitude());
		System.out.println("longitude:"+form.getLongitude());
		System.out.println("location:"+form.getLocation());
		
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
        	System.out.println("there is error when creating post");
            return "home.jsp";
        }
        
        //create a Post bean
        Post post = new Post();
        post.setContent(form.getContent());
        post.setLatitude(form.getLatitude());
        post.setLongitude(form.getLongitude());
        post.setLocation(form.getLocation());
        post.setAuthor(user);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date = dateFormat.format(new Date());
        post.setCreateTime(date);
        System.out.println("date="+date);
        if(form.getImgURL()!=null) post.setImgURL(form.getImgURL());
        try{
        	postDAO.create(post);
        	
        	Post[] postList = postDAO.getByUser(user);
        	Post[] imgList = postDAO.getAllImg(user);
        	//Post[] postList = postDAO.getAll();
        	request.setAttribute("postList", postList);
        	request.setAttribute("imgList", imgList);
        	request.setAttribute("viewUser", user);
        }catch(DAOException e){
        	System.out.println("there is error when postDAO");
        	errors.add(e.getMessage());
        }
           
        return "home.jsp";

	}
}
