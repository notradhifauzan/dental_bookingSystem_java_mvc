<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Staff Profile</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
</head>
<c:set var="staff" value="${sessionScope.staff}"/>

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
								aria-current="page" href="Staffs?action=profile">Staff</a></li>
							<li class="nav-item"><a class="nav-link" href="Staffs?action=appointments">Appointments</a>
							</li>
							<li class="nav-item"><a class="nav-link"
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
		<div
			style="margin-left: 100px; margin-right: 100px; margin-top: 80px;">
			<form action="">
				<div class="container row row-cols-lg-auto g-3 align-items-center" style="margin-left: 30%;">
                                <img style="width: 10%;padding: 2px;" class="border"
                                src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
                                alt="">
                                <h1>STAFF PROFILE</h1>
                            </div>
				<br>
				<div class="row">
					<div class="col">
						<div class="mb-3">
							<label for="firstname" class="form-label">First Name</label> <input
								value="<c:out value='${staff.firstname}' />" disabled
								type="text" class="form-control" id="firstname">
						</div>
					</div>
					<div class="col">
						<div class="mb-3">
							<label for="lastname" class="form-label">Last name</label> <input
								value="<c:out value='${staff.lastname}' />" disabled type="text"
								class="form-control" id="lastname">
						</div>
					</div>
					<div class="col">
						<label for="username" class="form-label">Username</label>
						<div class="input-group mb-0">
							<span class="input-group-text" id="basic-addon1">@</span> <input
								value="<c:out value='${staff.username}' />" disabled type="text"
								id="username" class="form-control" aria-label="Username"
								aria-describedby="basic-addon1">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-8">
						<div class="mb-3">
							<label for="exampleFormControlInput1" class="form-label">Email
								address</label> <input value="<c:out value='${staff.email}' />" disabled
								type="email" class="form-control" id="exampleFormControlInput1">
						</div>
					</div>
					<div class="col" style="display: none;">
						<div class="mb-3">
							<label for="phone" class="form-label">Phone</label> <input
								type="text" class="form-control" id="phone" placeholder="phone">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<div class="mb-3">
							<label for="address" class="form-label">Address</label> <input
								value="<c:out value='${staff.address}' />" disabled type="text"
								class="form-control" id="address"/>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<div class="mb-3">
							<label for="city" class="form-label">City</label> <input
								value="<c:out value='${staff.city}' />" disabled type="text"
								class="form-control" id="city">
						</div>
					</div>
					<div class="col">
						<div class="mb-3">
							<label for="state" class="form-label">State</label> <input
								value="<c:out value='${staff.state}' />" disabled type="text"
								class="form-control" id="state">
						</div>
					</div>
					<div class="col-2">
						<div class="mb-3">
							<label for="lastname" class="form-label">Postcode</label> <input
								value="<c:out value='${staff.postcode}' />" disabled type="text"
								class="form-control" id="lastname">
						</div>
					</div>
				</div>
			</form>
		</div>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
			crossorigin="anonymous"></script>
	</body>
</html>