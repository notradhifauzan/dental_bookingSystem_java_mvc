<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>All Appointment</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">

<style>
.btn-action {
	width: 70px;
	margin-bottom: 10px;
}
</style>
</head>
<c:set var="cancel_success" value="${requestScope.cancel_success}" />
<c:set var="cancel_fail" value="${requestScope.cancel_fail}" />
<c:set var="confirm_success" value="${requestScope.confirm_success}" />
<c:set var="confirm_fail" value="${requestScope.confirm_fail}" />
<c:set var="staff" value="${sessionScope.staff}" />
<body>
	<h1>
		<c:out value="${staff.firstname}" />
	</h1>
	<header style="margin-bottom: 6%;">
		<!-- Fixed navbar -->
		<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
			<div class="container-fluid">
				<a class="navbar-brand" href="#">DENTAL</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
					aria-controls="navbarCollapse" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarCollapse">
					<ul class="navbar-nav me-auto mb-2 mb-md-0">
						<li class="nav-item"><a class="nav-link"
							href="Staffs?action=profile">Staff</a></li>
						<li class="nav-item"><a class="nav-link"
							 href="Staffs?action=appointments">Appointments</a></li>
						<li class="nav-item active"><a class="nav-link active"
							aria-current="page" href="Staffs?action=report">Report</a></li>
						<li class="nav-item"><a href="Staffs?action=feedbacks" class="nav-link">Feedbacks</a></li>
					</ul>
					<div class="d-flex" role="search">
						<form action="Staffs" method="POST">
							<input type="hidden" name="action" value="logout" />
							<button style="width: 90px;" type="submit"
								class="btn btn-outline-primary" type="submit">Log out</button>
						</form>
					</div>
				</div>
			</div>
		</nav>
	</header>

	<h1 style="text-align: center;">REPORT</h1>
	<div class="container">
		<div id="custom-flash-message">
			<c:if test="${not empty complete_success}">
				<div class="alert alert-success" role="alert">
					<c:out value="${complete_success}" />
				</div>
			</c:if>
			<c:if test="${not empty complete_fail}">
				<div class="alert alert-danger" role="alert">
					<c:out value="${complete_fail}" />
				</div>
			</c:if>
			<c:if test="${not empty cancel_success}">
				<div class="alert alert-info" role="alert">
					<c:out value="${cancel_success}" />
				</div>
			</c:if>
			<c:if test="${not empty cancel_fail}">
				<div class="alert alert-danger" role="alert">
					<c:out value="${cancel_fail}" />
				</div>
			</c:if>
			<c:if test="${not empty confirm_success}">
				<div class="alert alert-success" role="alert">
					<c:out value="${confirm_success}" />
				</div>
			</c:if>
			<c:if test="${not empty confirm_fail}">
				<div class="alert alert-danger" role="alert">
					<c:out value="${confirm_fail}" />
				</div>
			</c:if>
		</div>

		<table class="table">
			<thead class="table-light">
				<tr>
					<th>Booking ID</th>
					<th>Date</th>
					<th>Timeslot</th>
					<th>Customer's Name</th>
					<th>Phone</th>
					<th>Service</th>
					<th>Person in-charge</th>
					<th>Status</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${booking}" var="booking">
					<!-- Modal for cancellation -->
					<div class="modal fade" id="cancel<c:out value='${booking.id}'/>"
						tabindex="-1" aria-labelledby="exampleModalLabel"
						aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h1 class="modal-title fs-5"
										id="cancel<c:out value='${booking.id}'/>">Cancel
										confirmation</h1>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									Proceed to cancel this appointment on
									<c:out value='${booking.date}' />
									?
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Close</button>
									<form action="Staffs" method="POST"
										id="fc<c:out value='${booking.id}' />">
										<input type="hidden" name="action" value="cancel" /> <input
											type="hidden" name="bookingid"
											value="<c:out value='${booking.id}' />" />
										<button type="submit" class="btn btn-outline-danger">Cancel</button>
									</form>
								</div>
							</div>
						</div>
					</div>
					<!-- Modal for confirmation -->
					<div class="modal fade" id="confirm<c:out value='${booking.id}'/>"
						tabindex="-1" aria-labelledby="exampleModalLabel"
						aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h1 class="modal-title fs-5"
										id="confirm<c:out value='${booking.id}'/>">Appointment
										confirmation</h1>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									Proceed to confirm this appointment on
									<c:out value='${booking.date}' />
									?
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Close</button>
									<form action="Staffs" method="POST"
										id="form-confirm<c:out value='${booking.id}' />">
										<input type="hidden" name="action" value="confirm" /> <input
											type="hidden" name="bookingid"
											value="<c:out value='${booking.id}' />" />
										<button type="submit" class="btn btn-outline-info">Confirm</button>
									</form>
								</div>
							</div>
						</div>
					</div>

					<!-- Modal for completion -->
					<div class="modal fade" id="complete<c:out value='${booking.id}'/>"
						tabindex="-1" aria-labelledby="exampleModalLabel"
						aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h1 class="modal-title fs-5"
										id="complete<c:out value='${booking.id}'/>">Appointment
										completion</h1>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									Proceed to complete this appointment on
									<c:out value='${booking.date}' />
									?
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Close</button>
									<form action="Staffs" method="POST"
										id="form-complete<c:out value='${booking.id}' />">
										<input type="hidden" name="action" value="complete" /> <input
											type="hidden" name="bookingid"
											value="<c:out value='${booking.id}' />" />
										<button type="submit" class="btn btn-outline-success">Complete</button>
									</form>
								</div>
							</div>
						</div>
					</div>

					<tr>
						<td><c:out value="${booking.id}" /></td>
						<td><c:out value="${booking.date}" /></td>
						<td><c:out value="${booking.timeslot}" /></td>
						<td><c:out value="${booking.custname}" /></td>
						<td><c:out value="${booking.custphone}" /></td>
						<td><c:out value="${booking.service}" /></td>
						<td><c:out value="${booking.staffname}" /></td>
						<td><c:choose>
								<c:when test="${booking.progress == 'pending'}">
									<span class="badge rounded-pill text-bg-warning"> <c:out
											value="${booking.progress}" />
									</span>
								</c:when>
								<c:when test="${booking.progress == 'confirmed'}">
									<span class="badge rounded-pill text-bg-success"> <c:out
											value="${booking.progress}" />
									</span>
								</c:when>
								<c:when test="${booking.progress == 'rated'}">
									<span class="badge rounded-pill text-bg-primary"> <c:out
											value="${booking.progress}" />
									</span>
								</c:when>
								<c:when test="${booking.progress == 'cancelled'}">
									<span class="badge rounded-pill text-bg-danger"> <c:out
											value="${booking.progress}" />
									</span>
								</c:when>
								<c:when test="${booking.progress == 'completed'}">
									<span class="badge rounded-pill text-bg-success"> <c:out
											value="${booking.progress}" />
									</span>
								</c:when>
							</c:choose></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<footer class="my-5 pt-5 text-muted text-center text-small">
		<p class="mb-1">&copy; 2006–2022 the brand</p>
		<ul class="list-inline">
			<li class="list-inline-item"><a href="#">Privacy</a></li>
			<li class="list-inline-item"><a href="#">Terms</a></li>
			<li class="list-inline-item"><a href="#">Support</a></li>
		</ul>
	</footer>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
		crossorigin="anonymous"></script>
</body>
</html>