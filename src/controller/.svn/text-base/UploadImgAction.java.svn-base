package controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import model.Model;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class UploadImgAction extends Action {
	public String getName() {
		return "imgUpload.do";
	}
	
	public UploadImgAction(Model model){
		
	}

	@SuppressWarnings("unchecked")
	public String perform(HttpServletRequest request) {
		DiskFileItemFactory factory = new DiskFileItemFactory();
		//factory.setRepository(new File("./imgUploadTemp"));
		factory.setSizeThreshold(10 * 1024);
		ServletFileUpload servletFileUpload = new ServletFileUpload(factory);
		servletFileUpload.setSizeMax(10 * 1024 * 1024);
		try {
			if (ServletFileUpload.isMultipartContent(request)) {
				List<FileItem> items = (List<FileItem>) servletFileUpload
						.parseRequest(request);
				for (FileItem item : items) {
					if (item.isFormField()) {
						System.out.println("1");
						String fieldName = item.getFieldName();
						String value = item.getString();
						return request.getContextPath()+"/home.do";
						// String value = item.getString("UTF-8");
					} else {
						System.out.println("2");
						long fileSize = item.getSize();
						String fileName = item.getName();
						System.out.println("fileSize "+fileSize);
						System.out.println("fileName "+fileName);
						String name = request.getParameter("name");
						if( name == null || name.length()==0){
							return request.getContextPath()+"/home.do";
						}
						else{
							System.out.println("url"+ name);							
							item.write(new File("../webapps/Footprint/userTest/"+name));
							request.setAttribute("uploadedFile", name);
							item.delete();
						}					
					}

				}
			}else{
				return request.getContextPath()+"/home.do";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return request.getContextPath()+"/home.do";
		}
		return "imageUpload_continue.jsp";
	}
}
