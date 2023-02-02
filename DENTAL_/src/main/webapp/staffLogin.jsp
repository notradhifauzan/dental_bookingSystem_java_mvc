<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.108.0">
<title>Staff Login</title>

<link rel="canonical"
	href="https://getbootstrap.com/docs/5.3/examples/sign-in/">

<link href="/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">

<!-- Favicons -->
<link rel="apple-touch-icon"
	href="/docs/5.3/assets/img/favicons/apple-touch-icon.png"
	sizes="180x180">
<link rel="icon" href="/docs/5.3/assets/img/favicons/favicon-32x32.png"
	sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.3/assets/img/favicons/favicon-16x16.png"
	sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.3/assets/img/favicons/manifest.json">
<link rel="mask-icon"
	href="/docs/5.3/assets/img/favicons/safari-pinned-tab.svg"
	color="#712cf9">
<link rel="icon" href="/docs/5.3/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#712cf9">

<!-- Custom styles for this template -->
<jsp:include page="staff_login_css.jsp" />

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
</head>
<c:set var="username_err" value="${requestScope.username_err}" />
<c:set var="password_err" value="${requestScope.password_err}" />
<c:set var="username" value="${param.username}" />
<c:set var="password" value="${param.password}" />
<body class="text-center">
	<main class="form-signin w-100 m-auto">
		<form action="Staffs" method="POST">
			<input type="hidden" name="action" value="login">
			<div class="row row-cols-lg-auto g-3 align-items-center">
				<img class="mb-4"
					src="https://static.vecteezy.com/system/resources/previews/003/225/082/original/teeth-dental-cute-illustration-set-emoticon-tooth-icon-sign-teeth-free-vector.jpg"
					alt="" width="72" height="57">
				<h1 class="h3 mb-3 fw-normal">DENTAL CLINIC</h1>

			</div>
			<div class="alert alert-info" style="height: 18px;" role="alert">
				<p style="position: relative; bottom: 12px;">
					<small>Doctor Login Page</small>
				</p>
			</div>
			<div class="form-floating">
				<input type="text" name="username" class="form-control" value="<c:out value='${username}' />"
					id="floatingInput" placeholder="Username"> <label
					for="floatingInput">Username</label>
				<c:if test="${not empty username_err}">
					<p class="form-err" style="color: red;">
						<c:out value="${username_err}" />
					</p>
				</c:if>
			</div>
			<div class="form-floating">
				<input type="password" name="password" class="form-control" value="<c:out value='${password}' />"
					id="floatingPassword" placeholder="Password"> <label
					for="floatingPassword">Password</label>
				<c:if test="${not empty password_err}">
					<p class="form-err" style="color: red;">
						<c:out value="${password_err}" />
					</p>
				</c:if>
			</div>

			<div class="checkbox mb-3">
				<label> <input type="checkbox" value="remember-me">
					Remember me
				</label>
			</div>
			<button class="w-100 btn btn-lg btn-primary" type="submit">Sign
				in</button>
			<p class="mt-5 mb-3 text-muted">&copy; 2017–2022</p>
		</form>
	</main>
</body>
</html>