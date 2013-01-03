package formbean;

import java.util.ArrayList;
import java.util.List;

public class RelationUserForm {
	private String followedEmail;

	public String getFollowedEmail() { return followedEmail; }

	public void setFollowedEmail(String followedEmail) { this.followedEmail = followedEmail; }
	
	public List<String> getValidationErrors() {
		List<String> errors = new ArrayList<String>();

		if (followedEmail == null || followedEmail.length() == 0) {
			errors.add("User account(email) is required");
		}
		
		return errors;
	}
	
	public boolean isPresent() {
		if (followedEmail != null) return true;
		return false;
	}
	
}
