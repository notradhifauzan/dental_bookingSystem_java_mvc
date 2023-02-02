package model;

import java.sql.Date;

public class Booking {
	
	int id;
	int custid;
	int staffid;
	String custname;
	String custphone;
	String staffname;
	Date date;
	String timeslot;
	String service;
	double price;
	int feedbackid;
	String progress;
	String feedbacks;
	double rating;
	
	public synchronized double getRating() {
		return rating;
	}
	public synchronized void setRating(double rating) {
		this.rating = rating;
	}
	public synchronized void setRating(int rating) {
		this.rating = rating;
	}
	public synchronized String getFeedbacks() {
		return feedbacks;
	}
	public synchronized void setFeedbacks(String feedbacks) {
		this.feedbacks = feedbacks;
	}
	public synchronized String getCustphone() {
		return custphone;
	}
	public synchronized void setCustphone(String custphone) {
		this.custphone = custphone;
	}
	public synchronized int getId() {
		return id;
	}
	public synchronized void setId(int id) {
		this.id = id;
	}
	public synchronized int getCustid() {
		return custid;
	}
	public synchronized void setCustid(int custid) {
		this.custid = custid;
	}
	public synchronized int getStaffid() {
		return staffid;
	}
	public synchronized void setStaffid(int staffid) {
		this.staffid = staffid;
	}
	public synchronized String getCustname() {
		return custname;
	}
	public synchronized void setCustname(String custname) {
		this.custname = custname;
	}
	public synchronized String getStaffname() {
		return staffname;
	}
	public synchronized void setStaffname(String staffname) {
		this.staffname = staffname;
	}
	public synchronized Date getDate() {
		return date;
	}
	public synchronized void setDate(Date date) {
		this.date = date;
	}
	public synchronized String getTimeslot() {
		return timeslot;
	}
	public synchronized void setTimeslot(String timeslot) {
		this.timeslot = timeslot;
	}
	public synchronized String getService() {
		return service;
	}
	public synchronized void setService(String service) {
		this.service = service;
	}
	public synchronized double getPrice() {
		return price;
	}
	public synchronized void setPrice(double price) {
		this.price = price;
	}
	public synchronized int getFeedbackid() {
		return feedbackid;
	}
	public synchronized void setFeedbackid(int feedbackid) {
		this.feedbackid = feedbackid;
	}
	public synchronized String getProgress() {
		return progress;
	}
	public synchronized void setProgress(String progress) {
		this.progress = progress;
	}
	
	
	
}
