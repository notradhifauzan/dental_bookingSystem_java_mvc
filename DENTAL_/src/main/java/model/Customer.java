package model;

public class Customer {
	int id;
	String username;
	String phone;
	String email;
	String password;
	String firstname;
	String lastname;
	
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
	public synchronized String getPhone() {
		return phone;
	}
	public synchronized void setPhone(String phone) {
		this.phone = phone;
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
	
}
