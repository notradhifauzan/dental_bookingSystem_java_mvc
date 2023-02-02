<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Appointment Form</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
</head>
<c:set var="booking_success" value="${requestScope.booking_success}" />
<c:set var="booking_fail" value="${requestScope.booking_fail}" />
<c:set var="service_err" value="${requestScope.service_err}" />
<c:set var="date_err" value="${requestScope.date_err}" />
<c:set var="timeslot_err" value="${requestScope.timeslot_err}" />

<c:set var="service" value="${param.services}" />
<c:set var="date" value="${param.date}" />
<c:set var="timeslot" value="${param.timeslot}" />
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
						<li style="text-color:white;" class="nav-item"><a class="nav-link active"
							aria-current="page" href="Customers?action=cust_appt">Appointment</a></li>
						<li class="nav-item"><a href="Customers?action=cust_bookings"
							class="nav-link">Status</a></li>
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

	<h1 style="text-align: center;">BOOK YOUR APPOINTMENT</h1>
	<div class="container">
		<hr>
		<c:if test="${not empty booking_success}">
				<div class="alert alert-success" role="alert">
					<c:out value="${booking_success}" />
				</div>
			</c:if>
			<c:if test="${not empty booking_fail}">
				<div class="alert alert-danger" role="alert">
					<c:out value="${booking_fail}" />
				</div>
			</c:if>
		<div class="card border-dark mb-3"
			style="width: 50%; margin-top: 10px; margin-left: 25%;">
			<form action="Customers" id="appt_form" method="POST">
				<input type="hidden" name="action" value="make_booking">
				<div class="card-header">Fill in the booking details below</div>
				<div class="card-body">
					<label for="services">Service</label> <select class="form-select"
						id="services" name="services" aria-label="Default select example">
						<option selected value="0">Open this select menu</option>
						<option
							<c:if test="${service == '1'}"> <c:out value="selected" /> </c:if>
							value="1">Scaling</option>
						<option
							<c:if test="${service == '2'}"> <c:out value="selected" /> </c:if>
							value="2">Whitening</option>
						<option
							<c:if test="${service == '3'}"> <c:out value="selected" /> </c:if>
							value="3">Oral Surgery</option>
					</select>
					<c:if test="${not empty service_err}">
						<p style="color: red;">
							<c:out value="${service_err}"></c:out>
						</p>
					</c:if>
					<hr>
					<label for="appt_date">Date</label> <br> <input name="date"
						value="<c:out value="${date}" />" type="date" id="appt_date"
						min="">
					<c:if test="${not empty date_err}">
						<p style="color: red;">
							<c:out value="${date_err}"></c:out>
						</p>
					</c:if>
					<hr>
					Time slot <br>
					<div id="timeslot-button-container">
						<div class="row">
							<div class="container" style="margin-bottom: 10px;">
								<button onclick="timeSlotSelector(0)"
									class="btn btn-outline-primary ts-btn ">9 AM</button>
								<button onclick="timeSlotSelector(1)"
									class="btn btn-outline-primary ts-btn">10 AM</button>
								<button onclick="timeSlotSelector(2)"
									class="btn btn-outline-primary ts-btn">11 AM</button>
								<button onclick="timeSlotSelector(3)"
									class="btn btn-outline-primary ts-btn">12 PM</button>
							</div>
						</div>
						<div class="row">
							<div class="container">
								<button onclick="timeSlotSelector(4)"
									class="btn btn-outline-primary ts-btn">2 PM</button>
								<button onclick="timeSlotSelector(5)"
									class="btn btn-outline-primary ts-btn">3 PM</button>
								<button onclick="timeSlotSelector(6)"
									class="btn btn-outline-primary ts-btn ">4 PM</button>
								<button onclick="timeSlotSelector(7)"
									class="btn btn-outline-primary ts-btn ">5 PM</button>
							</div>
						</div>
						<c:if test="${not empty timeslot_err}">
							<p style="color: red;">
								<c:out value="${timeslot_err}"></c:out>
							</p>
						</c:if>
					</div>

					<select class="form-select" id="timeslot" name="timeslot"
						aria-label="Default select example">
						<option value="9AM">9AM</option>
						<option value="10AM">10AM</option>
						<option value="11AM">11AM</option>
						<option value="12PM">12PM</option>
						<option value="2PM">2PM</option>
						<option value="3PM">3PM</option>
						<option value="4PM">4PM</option>
						<option value="5PM">5PM</option>
						<option selected value="0">none</option>
					</select>
					<hr>
					<button type="submit" class="btn btn-success">Book</button>
				</div>
			</form>
		</div>
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
<script>
	document.getElementById("appt_date").min = new Date().toISOString().split(
			"T")[0];

	function timeSlotSelector(timeslot) {
		var selectForm = document.getElementById("timeslot");
		selectForm.selectedIndex = timeslot;
	}

	var container = document.getElementById("timeslot-button-container");
	var btns = container.getElementsByClassName("ts-btn");
	for (var i = 0; i < btns.length; i++) {
		btns[i].addEventListener("click", function() {
			event.preventDefault();
			var current = document.getElementsByClassName("active");
			current[0].className = current[0].className.replace(" active", "");
			this.className += " active";
		});
	}
</script>
<style>
#timeslot {
	display: none;
}

.btn {
	width: 80px;
}
</style>

</html>