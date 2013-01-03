package formbean;

import java.util.ArrayList;
import java.util.List;

public class PostForm {

	private String content;
	private String latitude;
	private String longitude;
	private String location;
	private String imgURL;

	public String getContent()   { return content; }
	public String getLatitude()  { return latitude; }
	public String getLongitude() { return longitude;}
	public String getLocation()  { return location; }
	public String getImgURL()    { return imgURL; }

	public void setContent(String content)     { this.content = content; }
	public void setLatitude(String latitude)   { this.latitude = latitude; }
	public void setLongitude(String longitude) { this.longitude = longitude; }
	public void setLocation(String location)   { this.location = location; }
	public void setImgURL(String imgURL)       { this.imgURL = imgURL; }
	
	public List<String> getValidationErrors() {
		List<String> errors = new ArrayList<String>();

		if (content == null || content.length() == 0) {
			errors.add("content is required");
		}
		else if ( content.length()>= 100 ) {
			errors.add("Content should not be longer than 100 characters");
		}
		if (latitude == null || latitude.length() == 0 ) {
			errors.add("latitude is required");
		}
		if (longitude == null|| longitude.length() == 0  ) {
			errors.add("longitude is required");
		}
		if (location == null || location.length() == 0  ) {
			errors.add("location is required");
		}
		
		return errors;
	}
	
	public boolean isPresent() {
		if (content != null) return true;
		if (latitude != null) return true;
		if (longitude != null) return true;
		if (location != null) return true;
		return false;
	}
}
