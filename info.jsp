<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import = "databean.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Footprint</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author" content="">

	<!-- Le styles -->
	<link href="./assets/css/bootstrap.css" rel="stylesheet">
	<style type="text/css">
		body {
		}
	</style>
</head>
<body>
	<div class="navbar navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<a class="brand" href="index.do">Footprint</a>
				<div class="nav-collapse collapse">
					<ul class="nav pull-right">
						<li><a href="login.do">Sign in </a></li>
					</ul>
				</div><!--/.nav-collapse -->
			</div>
		</div>
	</div>
	<div class="container" style="margin-top:30px;width:80%;height:100%;">
		<div class="hero-unit" style="text-align:center">
			<h1>Currently we have </h1>
			<h1>${fn:length(userList)} registered Users</h1>
			<h1>and ${fn:length(postList)} Posts.</h1> 
			<h1>Welcome to join us!</h1>
			<form method="post" action="register.do">
				<input type="submit" class="btn btn-large btn-primary"  style="margin-top:10px;" value="Join!" />
			</form>
		</div>
		<jsp:include page="footer.jsp" />
	</div>
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="./assets/js/jquery.js"></script>
    <script src="./assets/js/bootstrap.min.js"></script>	

</body>
</html>
