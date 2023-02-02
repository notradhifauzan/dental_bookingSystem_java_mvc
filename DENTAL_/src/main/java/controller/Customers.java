package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Booking;
import model.Customer;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import dao.BookingDAO;
import dao.CustDAO;

@WebServlet("/Customers")
public class Customers extends HttpServlet {
	String task = "";
	String update_state = "";
	private static final long serialVersionUID = 1L;

	public Customers() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd;
		String dispatcher = "";
		CustDAO dao = new CustDAO();
		Customer cust = new Customer();
		BookingDAO b = new BookingDAO();

		String action = "";
		action = request.getParameter("action");

		//processing get request only
		if(action!=null) {
			try {
				if(action.equalsIgnoreCase("home")) {
					dispatcher = "custHome.jsp";
					System.out.println("why cannot go here?");
					System.out.println("dispatcher from home:get -> " + dispatcher);
					String username = (String)request.getSession().getAttribute("cust_username");
					cust = (Customer)request.getSession().getAttribute("customer");
					dao.get_customer(cust, username);

					request.getSession().setAttribute("customer", cust);
					Booking booking = b.getUpcomingAppointment(cust.getId());
					if(!booking.getStaffname().isEmpty()) {
						request.setAttribute("myBooking", b.getUpcomingAppointment(cust.getId()));
					} else {
						request.setAttribute("myBooking", "");
					}
					task = "";
				}
				else if(action.equalsIgnoreCase("cust_bookings")) {
					cust = (Customer)request.getSession().getAttribute("customer");
					dispatcher = "custBookings.jsp";
					request.setAttribute("customer_bookings", b.getAllBookings(cust.getId()));
					task = "";
				}
				else if(action.equalsIgnoreCase("cust_appt")) {
					dispatcher = "custAppt.jsp";
					System.out.println("currently viewing appointment page");
					task = "";
				}
			} catch(NullPointerException e) {
				System.out.println("no action");
			}
		} else {
			//implementing post-redirect-get to avoid duplicate form entries
			//processing POST request
			if(!task.isEmpty()) {
				if(task.equalsIgnoreCase("login")) {
					dispatcher = "custHome.jsp";
					String username = (String)request.getSession().getAttribute("cust_username");
					request.getSession().setAttribute("customer", cust);
					cust = (Customer)request.getSession().getAttribute("customer");
					dao.get_customer(cust, username);
					request.setAttribute("myBooking", b.getUpcomingAppointment(cust.getId()));
				}  
				else if(task.equalsIgnoreCase("booking_success")) {
					System.out.println("booking success");
					dispatcher = "custBookings.jsp";
					if(!update_state.isEmpty()) {
						if(update_state.equalsIgnoreCase("on")) {
							//for flash message purpose
							request.setAttribute("booking_success", "Successfully made appointment");
						}
					}
					cust = (Customer)request.getSession().getAttribute("customer");
					request.setAttribute("customer_bookings", b.getAllBookings(cust.getId()));
					update_state = "";
					System.out.println("from booking success: dispatcher-> " + dispatcher);
				} 
				else if(task.equalsIgnoreCase("booking_fail")) {
					dispatcher = "custAppt.jsp";
					if(update_state.equalsIgnoreCase("duplicate")) {
						request.setAttribute("booking_fail", "You already made an appointment with the given date and time");
					}
					else if(update_state.equalsIgnoreCase("full")) {
						request.setAttribute("booking_fail", "Time slot/Date is already full. Please select another timeslot or date.");
					}
					cust = (Customer)request.getSession().getAttribute("customer");
					request.setAttribute("customer_bookings", b.getAllBookings(cust.getId()));
					update_state = "";
					System.out.println("from booking fail: dispatcher-> " + dispatcher);
				}
				else if(task.equalsIgnoreCase("cancelBooking")) {
					dispatcher = "custBookings.jsp";
					if(update_state.equalsIgnoreCase("on")) {
						request.setAttribute("cancel_success", "Appointment successfully cancelled");
						update_state = "";
					} else if(update_state.equalsIgnoreCase("error")) {
						request.setAttribute("cancel_fail", "error 404: failed to cancel appointment");
						update_state = "";
					}
					cust = (Customer)request.getSession().getAttribute("customer");
					request.setAttribute("customer_bookings", b.getAllBookings(cust.getId()));
				}
				else if(task.equalsIgnoreCase("reviewBooking")) {
					dispatcher = "custBookings.jsp";
					if(update_state.equalsIgnoreCase("review_success")) {
						request.setAttribute("review_success", "Your review has been recorded");
						update_state = "";
					} else if(update_state.equalsIgnoreCase("review_fail")) {
						request.setAttribute("review_fail", "error 404: failed to review appointment");
						update_state = "";
					} else if(update_state.equalsIgnoreCase("empty_review")) {
						request.setAttribute("review_fail", "review should not be empty");
						update_state = "";
					} else if(update_state.equalsIgnoreCase("empty_rating")) {
						request.setAttribute("review_fail", "rating should not be empty");
						update_state = "";
					}
					cust = (Customer)request.getSession().getAttribute("customer");
					request.setAttribute("customer_bookings", b.getAllBookings(cust.getId()));
				}
			}
		}
		
		System.out.println("current task: " + task);
		System.out.println("current action: " + action);
		System.out.println("current dispatcher: " + dispatcher);
		rd = request.getRequestDispatcher(dispatcher);
		rd.forward(request, response);
	}

	private String getServiceName(String service_id) {
		switch(service_id) {
		case "1" : return "Scaling";
		case "2" : return "Whitening";
		case "3" : return "Oral Surgery";
		default : return "";
		}
	}

	private void makeBooking(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		request.setAttribute("service_err", "");
		request.setAttribute("date_err", "");
		request.setAttribute("timeslot_err", "");

		String service = request.getParameter("services");
		String date = request.getParameter("date");
		String timeslot = request.getParameter("timeslot");

		if(service.isEmpty()) {
			request.setAttribute("service_err", "Please select service");
		}  else {
			if(service.equalsIgnoreCase("0")) {
				request.setAttribute("service_err", "Please select service");
			}
		}
		if(date.isEmpty()) {
			request.setAttribute("date_err", "Please select date");
		}
		if(timeslot.isEmpty()) {
			request.setAttribute("timeslot_err", "Please select timeslot");
		} else {
			if(timeslot.equalsIgnoreCase("0")) {
				request.setAttribute("timeslot_err", "Please select timeslot");
			}
		}

		String service_err = (String)request.getAttribute("service_err");
		String date_err = (String)request.getAttribute("date_err");
		String timeslot_err = (String)request.getAttribute("timeslot_err");

		if(service_err.isEmpty() && date_err.isEmpty() && timeslot_err.isEmpty()) {
			//check if clash
			service = getServiceName(service);
			if(!service.isEmpty()) {
				Booking booking = new Booking();
				Customer bean = new Customer();
				bean = (Customer)request.getSession().getAttribute("customer");

				booking.setCustid(bean.getId());
				booking.setDate(Date.valueOf(date));
				booking.setTimeslot(timeslot);
				booking.setService(service);
				booking.setProgress("pending");

				BookingDAO bookdao = new BookingDAO();
				if(!bookdao.isDuplicateBooking(bean.getId(), timeslot, Date.valueOf(date))) {
					if(bookdao.bookingAvailable(booking)) {
						if(bookdao.makeBooking(booking)) {
							task = "booking_success";
							update_state = "on";
							response.sendRedirect("Customers");
						} else {
							response.getWriter().append("something went wrong with the database.");
						}
					} else {
						task = "booking_fail";
						update_state = "full";
						response.sendRedirect("Customers");
					}
				} else {
					task = "booking_fail";
					update_state = "duplicate";
					response.sendRedirect("Customers");
				}

			}
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("custAppt.jsp");
			rd.forward(request, response);
		}
	}

	private void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CustDAO dao = new CustDAO();

		request.setAttribute("fname_err", "");
		request.setAttribute("lname_err", "");
		request.setAttribute("username_err", "");
		request.setAttribute("email_err", "");
		request.setAttribute("phone_err", "");
		request.setAttribute("pass_err", "");
		request.setAttribute("confirm_pass_err", "");

		String fname = request.getParameter("firstname");
		String lname = request.getParameter("lastname");
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String password = request.getParameter("password");
		String confirm_password = request.getParameter("confirm_password");

		if(fname.isEmpty()) {
			request.setAttribute("fname_err", "Please enter your first name");
		} else {
			if(fname.length()>20) {
				request.setAttribute("fname_err", "first name should not be more than 20 characters");
			}
		}
		if(lname.isEmpty()) {
			request.setAttribute("lname_err", "Please enter your last name");
		} else {
			if(lname.length()>20) {
				request.setAttribute("lname_err", "last name should not be more than 20 characters");
			}
		}
		if(username.isEmpty()) {
			request.setAttribute("username_err", "Please enter your username");
		} else {
			if(dao.usernameExist(username)) {
				request.setAttribute("username_err","username is already taken");
			}
			if(username.length()<6) {
				request.setAttribute("username_err","username should be at least 6 characters");
			}
		}
		if(email.isEmpty()) {
			request.setAttribute("email_err", "Please enter your email");
		} else {
			String regex = "^(.+)@(.+)$";
			Pattern pattern = Pattern.compile(regex);
			Matcher matcher = pattern.matcher(email);

			if(!matcher.matches()) {
				request.setAttribute("email_err", "Not a valid email");
			}
		}
		if(phone.isEmpty()) {
			request.setAttribute("phone_err", "Please enter your phone number");
		} else {
			if(phone.length()>11 || phone.length()<9) {
				request.setAttribute("phone_err", "Not a valid phone number");
			}
			try {
				Double.parseDouble(phone);
			} catch (NumberFormatException e) {
				request.setAttribute("phone_err", "Not a valid phone number");
			}
		}
		if(password.isEmpty()) {
			request.setAttribute("pass_err", "Please enter your password");
		} else {
			if(!isValidPassword(password)) {
				request.setAttribute("pass_err", "weak password");
			}
		}
		if(confirm_password.isEmpty()) {
			request.setAttribute("confirm_pass_err", "Please Confirm your password");
		}

		if(!password.isEmpty() && !confirm_password.isEmpty()) {
			if(!password.equals(confirm_password)) {
				request.setAttribute("confirm_pass_err", "Password did not match");
			}
		}

		String fname_err = (String)request.getAttribute("fname_err");
		String lname_err = (String)request.getAttribute("lname_err");
		String username_err = (String)request.getAttribute("username_err");
		String email_err = (String)request.getAttribute("email_err");
		String phone_err = (String)request.getAttribute("phone_err");
		String password_err = (String)request.getAttribute("pass_err");
		String confirm_pass_err = (String)request.getAttribute("confirm_pass_err");

		if(fname_err.isEmpty() && lname_err.isEmpty() && username_err.isEmpty() && email_err.isEmpty() && phone_err.isEmpty()
				&& password_err.isEmpty() && confirm_pass_err.isEmpty()) {
			//hash password
			password = hash_password(password);

			Customer bean = new Customer();
			bean.setFirstname(fname);
			bean.setLastname(lname);
			bean.setUsername(username);
			bean.setPhone(phone);
			bean.setEmail(email);
			bean.setPassword(password);

			int key = dao.register(bean);
			if(key>0) {
				//go to get method
				request.setAttribute("reg_success", "true");
				RequestDispatcher rd = request.getRequestDispatcher("custLogin.jsp");
				rd.forward(request, response);
			} else {
				//something went wrong
				request.setAttribute("error404", "something wrong somewhere");
				RequestDispatcher rd = request.getRequestDispatcher("custRegister.jsp");
				rd.forward(request, response);
			}

		} else {
			RequestDispatcher rd = request.getRequestDispatcher("custRegister.jsp");
			rd.forward(request, response);
		}
	}

	private void login(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		CustDAO dao = new CustDAO();

		request.setAttribute("username_err", "");
		request.setAttribute("password_err", "");

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		if(username.isEmpty()) {
			request.setAttribute("username_err", "Please enter your username");
		} else {
			if(!dao.usernameExist(username)) {
				request.setAttribute("username_err","Username not found");
			}
		}
		if(password.isEmpty()) {
			request.setAttribute("password_err", "Please enter your password");
		}

		if(!username.isEmpty() && !password.isEmpty()) {
			password = hash_password(password);
			if(dao.passwordVerify(username, password)) {
				//login ok
				task = "login";
				request.getSession().setAttribute("cust_username", username);
				response.sendRedirect("Customers");
			} else {
				request.setAttribute("password_err", "incorrect password");
				RequestDispatcher rd = request.getRequestDispatcher("custLogin.jsp");
				rd.forward(request, response);
			}
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("custLogin.jsp");
			rd.forward(request, response);
		}
	}

	public static boolean isValidPassword(String password)
	{
		String regex = "^(?=.*[0-9])"
				+ "(?=.*[a-z])(?=.*[A-Z])"
				+ "(?=.*[@#$%^&+=])"
				+ "(?=\\S+$).{8,20}$";
		Pattern p = Pattern.compile(regex);
		if (password == null) {
			return false;
		}
		Matcher m = p.matcher(password);
		return m.matches();
	}

	static String hash_password(String password) {
		String hashed = null;
		try {
			MessageDigest m = MessageDigest.getInstance("MD5");
			m.update(password.getBytes());
			byte[] bytes = m.digest();

			StringBuilder s = new StringBuilder();

			for(int i=0;i<bytes.length;i++) {
				s.append(Integer.toString((bytes[i] & 0xff)+0x100,16).substring(1));
			}

			hashed = s.toString();
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return hashed;
	}

	private void cancelBooking(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		int bookingid = Integer.parseInt(request.getParameter("bookingid"));
		BookingDAO b = new BookingDAO();
		if(b.cancelBooking(bookingid)) {
			update_state = "on";
			task = "cancelBooking";
		} else {
			update_state = "error";
			task = "cancelBooking";
		}
		response.sendRedirect("Customers");
	}

	private void reviewBooking(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		task = "reviewBooking";
		BookingDAO dao = new BookingDAO();
		Customer cust = (Customer)request.getSession().getAttribute("customer");
		int bookingid = Integer.parseInt(request.getParameter("bookingid"));
		int staffid = Integer.parseInt(request.getParameter("staffid"));
		int custid = cust.getId();
		String review = "";
		int rating = 0;
		
		review = request.getParameter("review");
		try {
			rating = Integer.parseInt(request.getParameter("rating")); 			
		} catch(NullPointerException e) {
			rating = 0;
		}
		
		if(!review.isEmpty()&& rating!=0) {
			int feedbackid = dao.reviewBooking(bookingid, staffid, custid, review, rating);
			if(feedbackid > 0) {
				dao.updateFeedbackInBooking(feedbackid, bookingid);
				update_state = "review_success";
			} else {
				update_state = "review_fail";
			}
		} else {
			if(review.isEmpty()) {
				update_state = "empty_review";
			} else if(rating == 0) {
				update_state = "empty_rating";
			}
		}

		response.sendRedirect("Customers");
	}

	//post method will handle any update/changes in database
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

		if(action.equalsIgnoreCase("register")) {
			register(request,response);
		} else if(action.equalsIgnoreCase("login")) {
			login(request,response);
		} else if(action.equalsIgnoreCase("make_booking")) {
			makeBooking(request,response);
		} else if(action.equalsIgnoreCase("cancel")) {
			cancelBooking(request,response);
		}else if(action.equalsIgnoreCase("review")) {
			reviewBooking(request,response);
		}
		else if(action.equalsIgnoreCase("logout")) {
			request.getSession().removeAttribute("customer");
			response.sendRedirect("custLogin.jsp");
		}

	}

}
