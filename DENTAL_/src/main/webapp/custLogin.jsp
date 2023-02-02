<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Patient Login</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
</head>

<c:set var="username" value="${param.username}" />
<c:set var="reg_success" value="${requestScope.reg_success}" />
<c:set var="pass_err" value="${requestScope.password_err}" />
<c:set var="username_err" value="${requestScope.username_err}" />

<body>
	<div style="margin-right: 10%; margin-top: 5%;">

		<div class="row" style="margin-left: 10%; margin-right: 10%;">
			<c:if test="${not empty reg_success }">
				<div class="alert alert-success" style="text-align: center;"
					role="alert">Register success, proceed to login.</div>
			</c:if>
			<div class="col-9">
				<div class="row">
					<h1 style="text-align: center;">WELCOME</h1>
				</div>
				<div class="row" style="justify-content: center;">
					<img style="height: 50%; width: 50%; margin-top: 10px;"
						src="https://static.vecteezy.com/system/resources/previews/003/225/082/original/teeth-dental-cute-illustration-set-emoticon-tooth-icon-sign-teeth-free-vector.jpg"
						alt="">
				</div>
			</div>
			<div class="col border">
				<div
					style="margin-left: 10px; margin-right: 10px; margin-bottom: 10px; margin-top: 5%;">
					<form action="Customers" method="POST">
						<input type="hidden" name="action" value="login">
						<h4 style="margin-top: 5px;">Sign in</h4>
						<hr>
						<div class="mb-3">
							<label for="username" class="form-label">Username</label> <input
								type="text" value='<c:out value="${username}"></c:out>' class="form-control" name="username" placeholder="">
							<p style="color: red;">
								<c:if test="${not empty username_err }">
									<c:out value="${username_err}"></c:out>
								</c:if>
							</p>
						</div>
						<div class="mb-3">
							<label for="password" class="form-label">Password</label> <input
								type="password" class="form-control" name="password">
							<p style="color: red;">
								<c:if test="${not empty pass_err }">
									<c:out value="${pass_err}"></c:out>
								</c:if>
							</p>
						</div>
						<button type="submit" class="btn btn-primary">Login</button>
						<hr>
					</form>
					<p>
						New user? <a href="custRegister.jsp">Register!</a>
					</p>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
		crossorigin="anonymous"></script>
</body>

</html>