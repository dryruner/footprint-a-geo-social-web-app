package databean;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.*;


public class User {
	private String  userName = "footprint";
	private String  email = null;
	private String  hashedEmail;
	private String  location = null;
	private String  hashedPassword = "*";
	private int     salt           = 0;
	private Set<User> followerSet = new HashSet<User>();
	private Set<User> followedSet = new HashSet<User>();
	
	private String gender;
	private String blood;
	private String birthday;
	private String status;

	public User(String email){
		this.email = email;
	}
	
	public User(){}
	
	public String  getHashedPassword() { return hashedPassword; }
	public String  getUserName()       { return userName;       }
	public String  getLocation()       { return location;       }
	public int     getSalt()           { return salt;           }
	public String  getEmail()          { return email;	        }
	public String  getHashedEmail()       { return hashedEmail;       }
	public Set<User> getFollowerSet()    { return followerSet;    }
	public Set<User> getFollowedSet()    { return followedSet;    }

	public String getGender()          { return gender; }
	public String getBlood()           { return blood; }
	public String getBirthday()        { return birthday; }
	public String getStatus()          { return status; }

	public int     hashCode()          { return email.hashCode(); }

	private void setEmail(String s)         { email = s;}
	public void setHashedEmail(String s)    { System.out.println("s="+s); hashedEmail = s; }
	public void setUserName(String s)       { userName = s;}
	public void setLocation(String s)       { location = s; }
	public void setHashedPassword(String s) { hashedPassword = s; }
	public void setPassword(String s)       { salt = newSalt(); hashedPassword = hash(s); }
	public void setSalt(int s)              { salt = s;           }
	public void setFollowerSet(Set<User> s)       { this.followerSet = s;}
	public void setFollowedSet(Set<User> s)       { this.followedSet = s; }

	public void setGender(String gender)     { this.gender = gender; }
	public void setBlood(String blood)       { this.blood = blood; }
	public void setBirthday(String birthday) { this.birthday = birthday; }
	public void setStatus(String status)     { this.status = status; }

	public String toString() {
		return email;
	}
	
	public boolean equals(Object obj){
		if (obj instanceof User) {
			User other = (User) obj;
			return email.equals(other.email);
		}
		return false;
	}
	
	public String md5Email(String clearEmail){
		MessageDigest md = null;
		try{
			md = MessageDigest.getInstance("MD5");
		}
		catch(NoSuchAlgorithmException e)
		{
			throw new AssertionError("Can't find MD5 algorithm in the java.security package");
		}
		String email_before =clearEmail;
        //String email_before = "jonnyhsy@foxmail.com";
		System.out.println("Email before md5: " + email_before);
		md.update(email_before.getBytes());
		byte[] byte_after = md.digest();
		StringBuffer sb = new StringBuffer(); 
		for(int i = 0;i < byte_after.length;i++){  //convert byte[] array to hex-string to form the final passcode 
			int v = byte_after[i] & 0xff; 
			if(v < 16){ 
				sb.append(0); 
			}
        //System.out.println(v + " | " + Integer.toHexString(v));
			sb.append(Integer.toHexString(v)); 
		}
		System.out.println("Email after md5: " + sb.toString()); 
		return sb.toString();
	}
	
	public boolean checkPassword(String password) {
		return hashedPassword.equals(hash(password));
	}
	
	private String hash(String clearPassword) {
		if (salt == 0) return null;

		MessageDigest md = null;
		try {
		  md = MessageDigest.getInstance("SHA1");
		} catch (NoSuchAlgorithmException e) {
		  throw new AssertionError("Can't find the SHA1 algorithm in the java.security package");
		}

		String saltString = String.valueOf(salt);
		
		md.update(saltString.getBytes());
		md.update(clearPassword.getBytes());
		byte[] digestBytes = md.digest();

		// Format the digest as a String
		StringBuffer digestSB = new StringBuffer();
		for (int i=0; i<digestBytes.length; i++) {
		  int lowNibble = digestBytes[i] & 0x0f;
		  int highNibble = (digestBytes[i]>>4) & 0x0f;
		  digestSB.append(Integer.toHexString(highNibble));
		  digestSB.append(Integer.toHexString(lowNibble));
		}
		String digestStr = digestSB.toString();

		return digestStr;
	}

	private int newSalt() {
		Random random = new Random();
		return random.nextInt(8192)+1;  // salt cannot be zero
	}

	public boolean isFollow(User viewUser){
		if(getFollowedSet().contains(viewUser)){ System.out.println(1); return true; }
		if(viewUser.getFollowerSet().isEmpty()){ System.out.print("empty!"); }
		Iterator i = viewUser.getFollowerSet().iterator();
		while(i.hasNext()){ System.out.println(i.next()); }
		if(viewUser.getFollowerSet().contains(this)){ System.out.println(2); return true; }
		else return false;
	}
}
