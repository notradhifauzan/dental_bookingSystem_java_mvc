<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!doctype html>
<html lang="en">

<c:set var="myBooking" value="${requestScope.myBooking}" />
<c:set var="customer" value="${sessionScope.customer}" />

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Patient Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
</head>

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
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="Customers?action=home">Home</a></li>
						<li class="nav-item"><a class="nav-link"
							href="Customers?action=cust_appt">Appointment</a></li>
						<li class="nav-item"><a class="nav-link"
							href="Customers?action=cust_bookings">Status</a></li>
					</ul>
					<div class="d-flex" role="search">
						<form action="Customers" method="POST" >
							<input type="hidden" name="action" value="logout" />
							<button type="submit" class="btn btn-outline-primary"
								type="submit">Log out</button>
						</form>
					</div>
				</div>
			</div>
		</nav>
	</header>

	<h1 style="text-align: center;">
		WELCOME BACK,
		<c:out value="${customer.lastname}"></c:out>
		!
	</h1>
	<div class="container">
		<hr>
		<div class="row border" style="height: 250px;">
			<div class="col">
				<div class="container " style="height: 200px; margin-top: 20px;">
					<div class="row">
						<div class="col "
							style="height: 200px; width: 20px; text-align: center;">
							<div class="container" style="margin-top: 20px; height: 140px;">
								<img style="width: 60%; padding: 2px;" class="border"
									src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
									alt="">
							</div>
						</div>
						<div class="col">
							<div class="row" style="text-align: right;">
								<h3 style="margin-top: 10px;">My Profile</h3>
								<br>
								<p class="text-muted">
									<c:out value="${customer.firstname}" />
									<c:out value="${customer.lastname}" />
								</p>
							</div>
							<div class="row" style="text-align: right;">
								<p>This is your dental dashboard. Look around and act.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="container"
					style="height: 75%; width: 75%; margin-top: 5%; margin-left: 25%;">
					<div class="card border-light mb-3" style="max-width: 18rem;">
						<div class="card-header">Current Appointment</div>
						<div class="card-body">
							<c:choose>
								<c:when test="${not empty myBooking}">
									<!-- if got appointment-->
									<p class="card-text">
										<fmt:formatDate type="date" value="${myBooking.date}" />
									</p>
									<p class="class-text">
										<c:out value="${myBooking.service}" />
										Appointment
									</p>
									<p class="class-text">
										Dentist:
										<c:out value="${myBooking.staffname}" />
									</p>
								</c:when>
								<c:otherwise>
									<!-- if no appointment-->
									<h5 class="card-title">No Upcoming Appointment</h5>
									<p class="card-text">Visit your dentist at least once a
										year, even if you have no natural teeth or have dentures.</p>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
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

</html>