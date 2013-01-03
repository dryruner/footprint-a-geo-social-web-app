package formbean;

import java.util.ArrayList;
import java.util.List;

public class LoginForm {

	private String email;
	private String password;
	
	public String getEmail()    {return email;}
	public String getPassword() {return password;}
	
	public void setEmail(String email)       {this.email = email.trim();}
	public void setPassword(String password) {this.password = password.trim();}
	
	public List<String> getValidationErrors() {
		List<String> errors = new ArrayList<String>();

		if (email == null || email.length() == 0) {
			errors.add("User account(email) is required");
		}

		if (password == null || password.length() == 0) {
			errors.add("Password is required");
		}
		
		return errors;
	}
	
	public boolean isPresent() {
		if (email != null)    return true;
		if (password != null) return true;
		return false;
	}
	
	
}
