package formbean;

import java.util.ArrayList;
import java.util.List;

public class RegisterForm {
	private String userName;
	private String location;
	private String email;
	private String confirmEmail;
	private String password;
	private String confirmPassword;

	public String getUserName()        { return userName;  }
	public String getLocation()        { return location;  }
	public String getEmail()           { return email;     }
	public String getConfirmEmail()    { return confirmEmail; }
	public String getPassword()        { return password;  }
	public String getConfirmPassword() { return confirmPassword; }

	public void setUserName(String s)        { userName = s.trim();  }
	public void setLocation(String s)        { location = s.trim();  }
	public void setEmail(String s)           { email    = s.trim();  }
	public void setConfirmEmail(String s)    { confirmEmail = s.trim(); }
	public void setPassword(String s)        { password = s.trim();  }
	public void setConfirmPassword(String s) { confirmPassword = s.trim(); }

	public List<String> getValidationErrors() {
		List<String> errors = new ArrayList<String>();

		if (userName == null || userName.length() == 0) {
			errors.add("UserName is required");
		}
		
		//TODO length
		else if(userName.length()>=30){
			errors.add("UserName should not be longer than 30 characters");
		}
		
		if (location == null || location.length() == 0) {
			errors.add("Location is required");
		}
		
		//TODO length
		else if(location.length()>=50){
			errors.add("Location should not be longer than 50 characters");
		}

		if (email == null || email.length() == 0) {
			errors.add("User email is required");
		}
		
		else if(email.length()>=50){
			errors.add("Email should not be longer than 50 characters");
		}
		
		if (confirmEmail == null || confirmEmail.length() == 0) {
			errors.add("Confirm email is required");
		}

		if (password == null || password.length() == 0) {
			errors.add("Password is required");
		}
		
		else if( password.length()>=30){
			errors.add("Password should not be longer than 30 characters");
		}

		if (confirmPassword == null || confirmPassword.length() == 0) {
			errors.add("Confirm password is required");
		}
		
		if (errors.size() > 0) {
			return errors;
		}
		
		if (!email.equals(confirmEmail)){
			errors.add("Emails are not the same");
		}
		
		if (!password.equals(confirmPassword)) {
			errors.add("Passwords are not the same");
		}
		
		return errors;
	}
	
	public boolean isPresent() {
		if (userName  != null)       return true;
		if (location  != null)       return true;
		if (email     != null)       return true;
		if (confirmEmail != null)    return true;
		if (password  != null)       return true;
		if (confirmPassword != null) return true;
		return false;
	}
}
