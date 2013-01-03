package formbean;

import java.util.ArrayList;
import java.util.List;

public class UpdateProfileForm {
	private String userName;
	private String location;
	private String gender;
	private String status;
	private String birthday;
	private String blood;
	
	public String getUserName()  { return userName;  }
	public String getLocation()  { return location;  }
	public String getGender()    { return gender;    }
	public String getStatus()    { return status;    }
	public String getBirthday()  { return birthday;  }
	public String getBlood()     { return blood; }
	
	public void setUserName(String userName)   { this.userName = userName; }
	public void setLocation(String location)   { this.location = location; }
	public void setGender(String gender)       { this.gender = gender; }
	public void setStatus(String status)       { this.status = status; }
	public void setBirthday(String birthday)   { this.birthday = birthday; }
	public void setBlood(String bloodType)     { this.blood = bloodType; }
	
	public List<String> getValidationErrors() {
		List<String> errors = new ArrayList<String>();

		//if (userName == null || userName.length() == 0) {
		//	errors.add("UserName is required");
		//}
		
		//TODO length
		if(userName.length()>=30){
			errors.add("UserName should not be longer than 30 characters");
		}
		
		//if (location == null || location.length() == 0) {
		//	errors.add("Location is required");
		//}
		
		//TODO length
		if(location.length()>=50){
			errors.add("Location should not be longer than 50 characters");
		}
		return errors;
	}
	
	public boolean isPresent() {
		if (userName != null) return true;
		if (location != null) return true;
		if (gender != null) return true;
		if (status != null) return true;
		if (birthday != null) return true;
		if (blood != null) return true;
		return false;
	}
}
