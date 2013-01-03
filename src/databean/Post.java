package databean;


public class Post implements Comparable<Post>{
	private int id;
	
	private User author      = null;
	private String content = "";
	private String createTime;
	private String latitude;
	private String longitude;
	private String location;
	private String imgURL;
	
	public int getId()          { return id; }
	public User getAuthor()     { return author; }
	public String getContent()  { return content; }
	public String getCreateTime() { return createTime; }
	public String getLatitude() { return latitude; }
	public String getLongitude(){ return longitude; }
	public String getLocation() { return location; }
	public String getImgURL()   { return imgURL; }

	private void setId(int id)                 { this.id = id; }
	public void setAuthor(User user)           { this.author = user; }
	public void setContent(String content)     { this.content = content; }
	public void setCreateTime(String createTime) { this.createTime = createTime; }
	public void setLatitude(String latitude)   { this.latitude = latitude; }
	public void setLongitude(String longitude) { this.longitude = longitude; }
	public void setLocation(String location)   { this.location = location; }
	public void setImgURL(String imgURL)       { this.imgURL = imgURL; }
	
	@Override
	public String toString() {
		return "Post [content=" + content + ", id=" + id + ", author=" + author
				+ "]";
	}
	
	public int compareTo(Post other) {
		return other.id-id;
	}
}
