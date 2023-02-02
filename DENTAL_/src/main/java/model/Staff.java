package model;

public class Staff {

	int id;
	String username;
	String email;
	String password;
	String firstname;
	String lastname;
	String address;
	String city;
	int postcode;
	String state;
	
	public synchronized int getId() {
		return id;
	}
	public synchronized void setId(int id) {
		this.id = id;
	}
	public synchronized String getUsername() {
		return username;
	}
	public synchronized void setUsername(String username) {
		this.username = username;
	}
	public synchronized String getEmail() {
		return email;
	}
	public synchronized void setEmail(String email) {
		this.email = email;
	}
	public synchronized String getPassword() {
		return password;
	}
	public synchronized void setPassword(String password) {
		this.password = password;
	}
	public synchronized String getFirstname() {
		return firstname;
	}
	public synchronized void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public synchronized String getLastname() {
		return lastname;
	}
	public synchronized void setLastname(String lastname) {
		this.lastname = lastname;
	}
	public synchronized String getAddress() {
		return address;
	}
	public synchronized void setAddress(String address) {
		this.address = address;
	}
	public synchronized String getCity() {
		return city;
	}
	public synchronized void setCity(String city) {
		this.city = city;
	}
	public synchronized int getPostcode() {
		return postcode;
	}
	public synchronized void setPostcode(int postcode) {
		this.postcode = postcode;
	}
	public synchronized String getState() {
		return state;
	}
	public synchronized void setState(String state) {
		this.state = state;
	}
	
}
