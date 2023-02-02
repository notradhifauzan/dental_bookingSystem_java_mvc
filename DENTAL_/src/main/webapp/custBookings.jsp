<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Patient Bookings</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">

</head>
<c:set var="booking_success" value="${requestScope.booking_success}" />
<c:set var="booking_fail" value="${requestScope.booking_fail}" />
<c:set var="cancel_success" value="${requestScope.cancel_success}" />
<c:set var="cancel_fail" value="${requestScope.cancel_fail}" />
<body>
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
							href="Customers?action=home">Home</a></li>
						<li class="nav-item"><a class="nav-link"
							href="Customers?action=cust_appt">Appointment</a></li>
						<li class="nav-item"><a class="nav-link active"
							href="Customers?action=cust_bookings" aria-current="page">Status</a></li>
					</ul>
					<div class="d-flex" role="search">
						<form action="Customers" method="POST">
							<input type="hidden" name="action" value="logout" />
							<button style="width: 90px;" type="submit"
								class="btn btn-outline-primary" type="submit">Log out</button>
						</form>
					</div>
				</div>
			</div>
		</nav>
	</header>

	<h1 style="text-align: center;">APPOINTMENT STATUS</h1>

	<div class="container">
		<div id="custom-flash-message">
			<c:if test="${not empty booking_success}">
				<div class="alert alert-success" role="alert">
					<c:out value="${booking_success}" />
				</div>
			</c:if>
			<c:if test="${not empty review_success}">
				<div class="alert alert-success" role="alert">
					<c:out value="${review_success}" />
				</div>
			</c:if>
			<c:if test="${not empty review_fail}">
				<div class="alert alert-warning" role="alert">
					<c:out value="${review_fail}" />
				</div>
			</c:if>
			<c:if test="${not empty cancel_success}">
				<div class="alert alert-success" role="alert">
					<c:out value="${cancel_success}" />
				</div>
			</c:if>
			<c:if test="${not empty cancel_fail}">
				<div class="alert alert-danger" role="alert">
					<c:out value="${cancel_fail}" />
				</div>
			</c:if>
		</div>
		<table class="table">
			<thead class="table-light">
				<tr>
					<th>Booking ID</th>
					<th>Date</th>
					<th>Timeslot</th>
					<th>Service</th>
					<th style="text-align: center;">Person in-charge</th>
					<th>Status</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${customer_bookings}" var="booking">
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
									<form action="Customers" method="POST"
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

					<!-- Modal for review -->
					<div class="modal fade" id="review<c:out value='${booking.id}'/>"
						tabindex="-1" aria-labelledby="exampleModalLabel"
						aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<form id="form-review<c:out value='${booking.id}'/>"
									action="Customers" method="POST">
									<input type="hidden" name="action" value="review" />
									<input type="hidden" name="bookingid" value="<c:out value='${booking.id}'/>" />
									 <input
										type="hidden" name="staffid"
										value="<c:out value='${booking.staffid}'/>" />
									<div class="modal-header">
										<h1 class="modal-title fs-5"
											id="review<c:out value='${booking.id}'/>">Appointment
											feedback</h1>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<div class="mb-3">
											<label for="exampleFormControlTextarea1" class="form-label">
												Write your review </label>
											<textarea onkeyup="allowSubmit()" name="review"
												class="form-control review-appt-form"
												id="exampleFormControlTextarea1" rows="3"></textarea>
											
											<label style="margin-top:5px;" for="exampleFormControlTextarea1" class="form-label">
												Rate </label>
											<select name="rating" class="form-select"
												aria-label="Default select example">
												<option selected value="0">Open this select menu</option>
												<option value="1">Poor</option>
												<option value="2">Satisfactory</option>
												<option value="3">Good</option>
												<option value="4">Excellent</option>
											</select>
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-bs-dismiss="modal">Close</button>
										<button type="submit"
											class="btn btn-outline-success submit-review-btn">Submit</button>
									</div>
								</form>
							</div>
						</div>
					</div>
					<tr>
						<td><c:out value="${booking.id}" /></td>
						<td><c:out value="${booking.date}" /></td>
						<td><c:out value="${booking.timeslot}" /></td>
						<td><c:out value="${booking.service}" /></td>
						<td style="text-align: center;"><c:choose>
								<c:when test="${empty booking.staffname}">
									<c:out value=""></c:out>
								</c:when>
								<c:otherwise>
									<c:out value="${booking.staffname}" />
								</c:otherwise>
							</c:choose></td>
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
						<td><c:choose>
								<c:when test="${booking.progress == 'pending'}">
									<button type="button" data-bs-toggle="modal"
										data-bs-target="#cancel<c:out value='${booking.id}' />"
										class="btn btn-sm btn-outline-danger">cancel</button>
								</c:when>
								<c:when test="${booking.progress == 'completed'}">
									<button type="button" data-bs-toggle="modal"
										data-bs-target="#review<c:out value='${booking.id}' />"
										class="btn btn-sm btn-outline-success">review</button>
									<br>
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
<script type="text/javascript">
	function allowSubmit() {
		if (this.value.length > 0) {
			document.getElementByClassName("submit-review-btn").disabled = false;
		} else {
			document.getElementByClassName("submit-review-btn").disabled = true;
		}
	}
</script>
</html>