package formbean;

import java.util.ArrayList;
import java.util.List;

public class SearchForm {
	private String keywords;
	private String category;
	
	public String getKeywords() { return keywords; }
	public String getCategory() { return category; }

	public void setKeywords(String keywords) { this.keywords = keywords; }
	public void setCategory(String category) { this.category = category; }

	public List<String> getValidationErrors(){
		List<String> errors = new ArrayList<String>();
		
		if (keywords == null || keywords.length() == 0) {
			errors.add("keywords is required");
		}
		else if ( keywords.length()>= 50 ) {
			errors.add("Content should not be longer than 50 characters");
		}
		if (category == null || category.length() == 0) {
			errors.add("category is required");
		}
		
		return errors;
	}
	
	public boolean isPresent() {
		if (keywords != null)    return true;
		if (category != null)    return true;
		return false;
	}
}
