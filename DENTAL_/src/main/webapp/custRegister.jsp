<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Patient Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
</head>

<!-- user input variable -->
<c:set var="fname" value="${param.firstname}" />
<c:set var="lname" value="${param.lastname}" />
<c:set var="username" value="${param.username}" />
<c:set var="email" value="${param.email}" />
<c:set var="phone" value="${param.phone}" />
<c:set var="password" value="${param.password}" />
<c:set var="confirm_password" value="${param.confirm_password}" />

<!-- error message variable -->
<c:set var="fname_err" value="${requestScope.fname_err}" />
<c:set var="lname_err" value="${requestScope.lname_err}" />
<c:set var="username_err" value="${requestScope.username_err}" />
<c:set var="email_err" value="${requestScope.email_err}" />
<c:set var="phone_err" value="${requestScope.phone_err}" />
<c:set var="pass_err" value="${requestScope.pass_err}" />
<c:set var="confirm_pass_err" value="${requestScope.confirm_pass_err}" />

<body>
    <div style="margin-left: 100px;margin-right: 100px;margin-top: 80px;">
        <form action="Customers" method="post">
        	<input type="hidden" name="action" value="register">
            <h1 style="text-align: center;">CREATE YOUR ACCOUNT</h1>
            <br>
            <div class="row">
                <div class="col">
                    <div class="mb-3">
                        <label for="firstname" class="form-label">First Name</label>
                        <input value='<c:out value="${fname}"></c:out>' type="text" class="form-control" name="firstname" placeholder="Mark">
                        <p style="color: red;">
	                        <c:if test="${not empty fname_err }">
	                        	<c:out value="${fname_err}"></c:out>
	                        </c:if>
                        </p>
                    </div>
                </div>
                <div class="col">
                    <div class="mb-3">
                        <label for="lastname" class="form-label">Last name</label>
                        <input value='<c:out value="${lname}"></c:out>' type="text" class="form-control" name="lastname" placeholder="Otto">
                        <p style="color: red;">
	                        <c:if test="${not empty lname_err }">
	                        	<c:out value="${lname_err}"></c:out>
	                        </c:if>
                        </p>
                    </div>
                </div>
                <div class="col">
                    <label for="username" class="form-label">Username</label>
                    <div class="input-group mb-0">
                        <span class="input-group-text" id="basic-addon1">@</span>
                        <input value='<c:out value="${username}"></c:out>' type="text" name="username" class="form-control" placeholder="at least 6 characters"
                            aria-label="Username" aria-describedby="basic-addon1">
                    </div>
                    <p style="color: red;">
	                        <c:if test="${not empty username_err }">
	                        	<c:out value="${username_err}"></c:out>
	                        </c:if>
                        </p>
                </div>
            </div>
            <div class="row">
                <div class="col-8">
                    <div class="mb-3">
                        <label for="exampleFormControlInput1" class="form-label">Email address</label>
                        <input value='<c:out value="${email}"></c:out>' type="email" class="form-control" name="email"
                            placeholder="name@example.com">
                            <p style="color: red;">
	                        <c:if test="${not empty email_err }">
	                        	<c:out value="${email_err}"></c:out>
	                        </c:if>
                        </p>
                    </div>
                </div>
                <div class="col">
                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone</label>
                        <input value='<c:out value="${phone}"></c:out>' type="tel" class="form-control" name="phone" placeholder="phone">
                        <p style="color: red;">
	                        <c:if test="${not empty phone_err }">
	                        	<c:out value="${phone_err}"></c:out>
	                        </c:if>
                        </p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input value="<c:out value='${password}' />" type="password" class="form-control" name="password">
                        <p style="color: red;">
	                        <c:if test="${not empty pass_err }">
	                        	<c:out value="${pass_err}"></c:out>
	                        </c:if>
                        </p>
                        <div class="form-text">Your password must be 8-20 characters long, contain letters and numbers
                            and must not contain spaces, special characters or emoji</div>
                    </div>
                </div>
                <div class="col">
                    <div class="mb-3">
                        <label for="confirm_password" class="form-label">Confirm password</label>
                        <input value="<c:out value='${confirm_password}' />" type="password" class="form-control" name="confirm_password">
                        <p style="color: red;">
	                        <c:if test="${not empty confirm_pass_err }">
	                        	<c:out value="${confirm_pass_err}"></c:out>
	                        </c:if>
                        </p>
                    </div>
                </div>
            </div>
                <button type="submit" class="btn btn-primary">Register</button>
        </form>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
        crossorigin="anonymous"></script>
</body>
</html>