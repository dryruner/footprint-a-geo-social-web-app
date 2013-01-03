package formbean;

import java.util.ArrayList;
import java.util.List;

public class DeletePostForm {
	private String postId;

	public String getPostId() {
		return postId;
	}

	public void setPostId(String id){
		this.postId = id;
	}

	public List<String> getValidationErrors() {
		List<String> errors = new ArrayList<String>();

		if (postId == null || postId.length() == 0) {
			errors.add("postId is required");
		}
		return errors;
	}
	
	public boolean isPresent() {
		if (postId != null)    return true;
		return false;
	}
}
