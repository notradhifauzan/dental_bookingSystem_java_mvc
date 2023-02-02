package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Booking;

public class BookingDAO {
	static private Connection con;
	static private ResultSet rs;
	static private PreparedStatement ps;

	public List<Booking> getAllBookings(){
		List<Booking> list = new ArrayList<Booking>();

		final String sql = "select bookings.id,bookings.staffid,bookings.date,timeslot,customer.username as custname,\r\n"
				+ "	customer.phone as custphone, service, staff.username as staffname, progress\r\n"
				+ "    from bookings\r\n"
				+ "    left join customer on bookings.custid = customer.id\r\n"
				+ "    left join staff on bookings.staffid = staff.id\r\n"
				+ "    where bookings.progress not in ('completed','rated')\r\n"
				+ "    order by bookings.date ASC;";

		try {
			con = ConnectionManager.getConnection();
			ps = con.prepareStatement(sql);

			rs = ps.executeQuery();

			while(rs.next()) {
				String dr_name = "";

				if(rs.getString("staffname") != null) {
					String staffname = rs.getString("staffname");
					dr_name = staffname.substring(0,1).toUpperCase() + staffname.substring(1);
					dr_name = "Dr." + dr_name;
				}

				Booking b = new Booking();

				b.setId(rs.getInt("id"));
				b.setDate(rs.getDate("date"));
				b.setTimeslot(rs.getString("timeslot"));
				b.setStaffid(rs.getInt("staffid"));
				b.setCustname(rs.getString("custname"));
				b.setCustphone(rs.getString("custphone"));
				b.setService(rs.getString("service"));
				b.setStaffname(dr_name);
				b.setProgress(rs.getString("progress"));

				list.add(b);
			}
			con.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public List<Booking> getReport(){
		List<Booking> list = new ArrayList<Booking>();

		final String sql = "select bookings.id,bookings.staffid,bookings.date,timeslot,customer.username as custname,\r\n"
				+ "	customer.phone as custphone, service, staff.username as staffname, progress\r\n"
				+ "    from bookings\r\n"
				+ "    left join customer on bookings.custid = customer.id\r\n"
				+ "    left join staff on bookings.staffid = staff.id\r\n"
				+ "    where bookings.progress in ('completed','rated')\r\n"
				+ "    order by bookings.date DESC;";

		try {
			con = ConnectionManager.getConnection();
			ps = con.prepareStatement(sql);

			rs = ps.executeQuery();

			while(rs.next()) {
				String dr_name = "";

				if(rs.getString("staffname") != null) {
					String staffname = rs.getString("staffname");
					dr_name = staffname.substring(0,1).toUpperCase() + staffname.substring(1);
					dr_name = "Dr." + dr_name;
				}

				Booking b = new Booking();

				b.setId(rs.getInt("id"));
				b.setDate(rs.getDate("date"));
				b.setTimeslot(rs.getString("timeslot"));
				b.setStaffid(rs.getInt("staffid"));
				b.setCustname(rs.getString("custname"));
				b.setCustphone(rs.getString("custphone"));
				b.setService(rs.getString("service"));
				b.setStaffname(dr_name);
				b.setProgress(rs.getString("progress"));

				list.add(b);
			}
			con.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	public Booking getUpcomingAppointment(int custid) {
		Booking b = new Booking();

		final String sql = "select bookings.date, service,staff.username as staffname\r\n"
				+ "	from bookings\r\n"
				+ "		left join staff on bookings.staffid = staff.id\r\n"
				+ "		where bookings.custid = ? and bookings.progress = 'confirmed'\r\n"
				+ "		order by bookings.date ASC\r\n"
				+ "		limit 1;";

		try {
			con = ConnectionManager.getConnection();
			ps = con.prepareStatement(sql);
			ps.setInt(1, custid);

			rs = ps.executeQuery();
			int i=0;
			while(rs.next()) {
				i++;
				String dr_name = "";

				if(rs.getString("staffname") != null) {
					String staffname = rs.getString("staffname");
					dr_name = staffname.substring(0,1).toUpperCase() + staffname.substring(1);
					dr_name = "Dr." + dr_name;
				}

				b.setDate(rs.getDate("date"));
				b.setService(rs.getString("service"));
				b.setStaffname(dr_name);

			}

			if(i>0) {
				return b;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	public List<Booking> getAllFeedbacks(){
		List<Booking> list = new ArrayList<Booking>();
		
		final String sql = "select bookings.id, bookings.date, bookings.timeslot, bookings.service, staff.username as staffname,\r\n"
				+ "		customer.username as custname,feedbacks.description as feedbacks, feedbacks.rating as rating\r\n"
				+ "	from bookings\r\n"
				+ "    	inner join customer on bookings.custid = customer.id\r\n"
				+ "        inner join staff on bookings.staffid = staff.id\r\n"
				+ "        inner join feedbacks on bookings.feedbackid = feedbacks.id";
		
		try {
			con = ConnectionManager.getConnection();
			ps = con.prepareStatement(sql);

			rs = ps.executeQuery();

			while(rs.next()) {
				String dr_name = "";

				if(rs.getString("staffname") != null) {
					String staffname = rs.getString("staffname");
					dr_name = staffname.substring(0,1).toUpperCase() + staffname.substring(1);
					dr_name = "Dr." + dr_name;
				}
				Booking b = new Booking();
				b.setId(rs.getInt("id"));
				b.setDate(rs.getDate("date"));
				b.setTimeslot(rs.getString("timeslot"));
				b.setService(rs.getString("service"));
				b.setStaffname(dr_name);
				b.setFeedbacks(rs.getString("feedbacks"));
				b.setCustname(rs.getString("custname"));
				
				int temp = rs.getInt("rating");
				double currentRating = temp;
				double percentageRating = currentRating/4*100;
				System.out.println("percentage rating: " + percentageRating);
				b.setRating(percentageRating);
				
				list.add(b);
			}

			con.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public List<Booking> getAllBookings(int custid){
		List<Booking> list = new ArrayList<Booking>();

		final String sql = "select customer.id as custid,staff.id as staffid, bookings.id,bookings.date,timeslot,service,staff.username as staffname,progress\r\n"
				+ "from bookings\r\n"
				+ "left join customer on bookings.custid = customer.id\r\n"
				+ "left JOIN staff on bookings.staffid = staff.id\r\n"
				+ "where bookings.custid = ? ORDER BY bookings.date DESC;";

		try {
			con = ConnectionManager.getConnection();
			ps = con.prepareStatement(sql);
			ps.setInt(1, custid);

			rs = ps.executeQuery();

			while(rs.next()) {
				String dr_name = "";

				if(rs.getString("staffname") != null) {
					String staffname = rs.getString("staffname");
					dr_name = staffname.substring(0,1).toUpperCase() + staffname.substring(1);
					dr_name = "Dr." + dr_name;
				}
				Booking b = new Booking();
				b.setId(rs.getInt("id"));
				b.setDate(rs.getDate("date"));
				b.setTimeslot(rs.getString("timeslot"));
				b.setService(rs.getString("service"));
				b.setStaffname(dr_name);
				b.setProgress(rs.getString("progress"));
				b.setStaffid(rs.getInt("staffid"));
				b.setCustid(rs.getInt("custid"));

				list.add(b);
			}

			con.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean completeBooking(int bookingid) {

		final String sql = "update bookings set progress = ? where id=?";

		try {
			con = ConnectionManager.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, "completed");
			ps.setInt(2, bookingid);

			if(ps.executeUpdate()>0) {
				return true;
			}

			con.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}

		return false;
	}

	public boolean cancelBooking(int bookingid) {
		final String sql = "update bookings set progress = ? where id=?";

		try {
			con = ConnectionManager.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, "cancelled");
			ps.setInt(2, bookingid);

			if(ps.executeUpdate()>0) {
				return true;
			}

			con.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}

		return false;
	}

	public boolean isDuplicateBooking(int custid,String timeslot,Date date) {

		final String sql = "select custid, timeslot, bookings.date, progress\r\n"
				+ "	from bookings\r\n"
				+ "	where custid = ? and timeslot = ? and bookings.date = ? and\r\n"
				+ "			progress in ('pending','confirmed','completed','rated') ;";

		try {
			con = ConnectionManager.getConnection();
			ps = con.prepareStatement(sql);

			ps.setInt(1, custid);
			ps.setString(2, timeslot);
			ps.setDate(3, date);
			
			rs = ps.executeQuery();

			int count = 0;
			while(rs.next()) {
				count ++;
			}

			if(count>0)
				return true;

			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}

	public void updateFeedbackInBooking(int feedbackid,int bookingid) {
		final String sql = "update bookings set feedbackid=?,progress=? where id =?";
		
		try {
			con = ConnectionManager.getConnection();
			ps = con.prepareStatement(sql);
			ps.setInt(1, feedbackid);
			ps.setString(2, "rated");
			ps.setInt(3, bookingid);

			if(ps.executeUpdate()>0) {
				System.out.println("feedback in bookings successfully updated");
			}

			con.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

	public int reviewBooking(int bookingid,int staffid,int custid,String review ,int rating) {
		final String sql = "insert into feedbacks (bookingid,custid,staffid,description,rating) " +
				"values(?,?,?,?,?);";

		try {
			con = ConnectionManager.getConnection();
			ps = con.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, bookingid);
			ps.setInt(2, staffid);
			ps.setInt(3, custid);
			ps.setString(4, review);
			ps.setInt(5, rating);

			int row = ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if(rs.next() && row>0) {
				return rs.getInt(1);
			}
			
			con.close();
		}  catch (SQLException e) {
			e.printStackTrace();
		}

		return 0;
	}

	public boolean confirmBooking(int bookingid,int staffid) {
		final String sql = "update bookings set progress = ?,staffid=? where id=?";

		try {
			con = ConnectionManager.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, "confirmed");
			ps.setInt(2, staffid);
			ps.setInt(3, bookingid);

			if(ps.executeUpdate()>0) {
				return true;
			}

			con.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}

		return false;
	}

	public boolean bookingAvailable(Booking book) {
		boolean available = true;
		final String sql = "select id \r\n"
				+ "from bookings where timeslot = ? and bookings.date = ?\r\n"
				+ "and progress in ('pending','confirmed','completed','rated');";

		try {
			con = ConnectionManager.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, book.getTimeslot());
			ps.setDate(2, book.getDate());

			rs = ps.executeQuery();
			
			int count = 0;
			while(rs.next()) {
				count ++;
			}
			
			if(count>3) {
				System.out.println("from BookingDAO: appointment full");
				available = false;
			} else {
				available = true;
			}

			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return available;
	}

	public boolean makeBooking(Booking book) {

		final String sql = "insert into bookings (date,timeslot,custid,progress,service) " +
				"values(?,?,?,?,?);";
		try {
			con = ConnectionManager.getConnection();
			ps = con.prepareStatement(sql);
			ps.setDate(1, book.getDate());
			ps.setString(2, book.getTimeslot());
			ps.setInt(3, book.getCustid());
			ps.setString(4, book.getProgress());
			ps.setString(5, book.getService());

			int row = ps.executeUpdate();

			if (row > 0) {
				return true;
			}

			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}
}
