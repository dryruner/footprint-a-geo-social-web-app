package formbean;

import java.util.ArrayList;
import java.util.List;

public class BrowseUserForm {
	private String email;
	
	public String getEmail()    {return email;}
	
	public void setEmail(String email)       {this.email = email.trim();}

	
	public List<String> getValidationErrors() {
		List<String> errors = new ArrayList<String>();

		if (email == null || email.length() == 0) {
			errors.add("User account(email) is required");
		}
		
		return errors;
	}
	
	public boolean isPresent() {
		if (email != null)    return true;
		return false;
	}
	
	
}
