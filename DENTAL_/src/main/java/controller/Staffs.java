package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Staff;

import java.io.IOException;

import dao.BookingDAO;
import dao.StaffDAO;

@WebServlet("/Staffs")
public class Staffs extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String task = "";
	String update_state = "";
	public Staffs() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd;
		String dispatcher = "";
		StaffDAO dao = new StaffDAO();
		Staff staff = new Staff();
		BookingDAO b = new BookingDAO();
		
		String action = "";
		action = request.getParameter("action");
		
		//processing get request
		if(action!=null) {
			try {
				if(action.equalsIgnoreCase("appointments")) {
					task = "";
					dispatcher = "apptLists.jsp";
					staff = (Staff)request.getSession().getAttribute("staff");
					request.setAttribute("staff", staff);
					request.setAttribute("booking", b.getAllBookings());
				}
				if(action.equalsIgnoreCase("profile")) {
					task = "";
					dispatcher = "staffProfile.jsp";
					staff = (Staff)request.getSession().getAttribute("staff");
					request.setAttribute("staff", staff);
					request.getSession().setAttribute("staff", staff);
				}
				if(action.equalsIgnoreCase("feedbacks")) {
					task = "";
					dispatcher = "feedbacks.jsp";
					staff = (Staff)request.getSession().getAttribute("staff");
					request.setAttribute("staff", staff);
					request.setAttribute("booking", b.getAllFeedbacks());
				}
				if(action.equalsIgnoreCase("report")) {
					task = "";
					dispatcher = "report.jsp";
					staff = (Staff)request.getSession().getAttribute("staff");
					request.setAttribute("staff", staff);
					request.setAttribute("booking", b.getReport());
				}
			} catch(NullPointerException e) {
				System.out.println("no action");
			}
		}
		
		//processing post-redirect-get request
		if(!task.isEmpty()) {
			if(task.equalsIgnoreCase("login")) {
				dispatcher = "staffProfile.jsp";
				String username = (String)request.getSession().getAttribute("staff_username");
				dao.get_staff(staff, username);
				request.getSession().setAttribute("staff", staff);
				System.out.println("login complete");
			}
			else if(task.equalsIgnoreCase("cancelBooking")) {
				if(update_state.equalsIgnoreCase("on")) {
					request.setAttribute("cancel_success", "Appointment successfully cancelled");
					update_state = "";
				} else if(update_state.equalsIgnoreCase("error")) {
					request.setAttribute("cancel_fail", "error 404: failed to cancel appointment");
					update_state = "";
				}
				staff = (Staff)request.getSession().getAttribute("staff");
				request.setAttribute(dispatcher, action);
				dispatcher = "apptLists.jsp";
				request.setAttribute("booking", b.getAllBookings());
			}
			else if(task.equalsIgnoreCase("confirmBooking")) {
				if(update_state.equalsIgnoreCase("on")) {
					request.setAttribute("confirm_success", "Successfully confirmed appointment");
					update_state = "";
				} else if(update_state.equalsIgnoreCase("error")) {
					request.setAttribute("confirm_fail", "error 404: failed to confirm appointment");
					update_state = "";
				}
				dispatcher = "apptLists.jsp";
				request.setAttribute("booking", b.getAllBookings());
			}
			else if(task.equalsIgnoreCase("completeBooking")) {
				if(update_state.equalsIgnoreCase("on")) {
					request.setAttribute("complete_success", "Successfully completed appointment");
					update_state = "";
				} else if(update_state.equalsIgnoreCase("error")) {
					request.setAttribute("complete_fail", "error 404: failed to complete appointment");
					update_state = "";
				}
				dispatcher = "apptLists.jsp";
				request.setAttribute("booking", b.getAllBookings());
			}
		}
		
		rd = request.getRequestDispatcher(dispatcher);
		rd.forward(request, response);
	}

	private void login(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		StaffDAO dao = new StaffDAO();

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
			if(dao.passwordVerify(username, password)) {
				//login ok
				task = "login";
				request.getSession().setAttribute("staff_username", username);
				response.sendRedirect("Staffs");
			} else {
				request.setAttribute("password_err", "incorrect password");
				RequestDispatcher rd = request.getRequestDispatcher("staffLogin.jsp");
				rd.forward(request, response);
			}
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("staffLogin.jsp");
			rd.forward(request, response);
		}
	}
	
	private void cancelBooking(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		int bookingid = Integer.parseInt(request.getParameter("bookingid"));
		BookingDAO b = new BookingDAO();
		task = "cancelBooking";
		if(b.cancelBooking(bookingid)) {
			update_state = "on";
		} else {
			update_state = "error";
		}
		response.sendRedirect("Staffs");
	}
	
	private void confirmBooking(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		int bookingid = Integer.parseInt(request.getParameter("bookingid"));
		Staff staff = new Staff();
		staff = (Staff)request.getSession().getAttribute("staff");
		BookingDAO b = new BookingDAO();
		task = "confirmBooking";
		
		if(b.confirmBooking(bookingid,staff.getId())){
			update_state = "on";
		} else {
			update_state = "error";
		}
		
		response.sendRedirect("Staffs");	
	}
	
	private void completeBooking(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		int bookingid = Integer.parseInt(request.getParameter("bookingid"));
		BookingDAO b = new BookingDAO();
		task = "completeBooking";
		
		if(b.completeBooking(bookingid)){
			update_state = "on";
		} else {
			update_state = "error";
		}
		
		response.sendRedirect("Staffs");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

		if(action.equalsIgnoreCase("login")) {
			login(request,response);
		} else if(action.equalsIgnoreCase("cancel")) {
			cancelBooking(request,response);
		} else if(action.equalsIgnoreCase("confirm")) {
			confirmBooking(request,response);
		} else if(action.equalsIgnoreCase("complete")) {
			completeBooking(request, response);
		} else if(action.equalsIgnoreCase("logout")) {
			request.getSession().removeAttribute("staff");
			response.sendRedirect("staffLogin.jsp");
		}
	}

}
