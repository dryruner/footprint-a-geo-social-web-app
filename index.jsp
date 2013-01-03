<!DOCTYPE html>
<html lang="en">
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
				<a class="brand" href="javascript:void(0)">Footprint</a>
				<div class="nav-collapse collapse">
					<ul class="nav pull-right">
						<li><a href="login.do">Sign in </a></li>
					</ul>
				</div><!--/.nav-collapse -->
			</div>
		</div>
	</div>
	<div class="container" style="width:100%;height:100%;">
		<div id="myCarousel" class="carousel slide">
			<div class="carousel-inner">
				<div class="item active">
					<img src="./assets/img/examples/slide-01.jpg" alt="" style="width:100%;height:90%;">
					<div class="container">
						<div class="carousel-caption" >
							<h1>Footprint</h1>
							<p class="lead" >Print your life with foot.</p>
							<a class="btn btn-large btn-primary" href="register.do" style="margin-top:10px;">Sign up today</a>
						</div>
					</div>
				</div>

				<div class="item">
					<img src="./assets/img/examples/slide-02.jpg" alt="" style="width:100%;height:90%;">
					<div class="container">
						<div class="carousel-caption">
							<h1>Footprint</h1>
							<p class="lead">a geolocation based social network, find your friends here.</p>
							<a class="btn btn-large btn-primary" href="info.do" style="margin-top:10px;">Learn more</a>
						</div>
					</div>
				</div>

				<div class="item">
					<img src="./assets/img/examples/slide-03.jpg" alt="" style="width:100%;height:90%;">
					<div class="container">
						<div class="carousel-caption">
							<h1>Footprint</h1>
							<p class="lead"><a href="http://www.cmu.edu">CMU</a> 15-637 <a href="http://www.cs.cmu.edu/~charlie/courses/webapps/2012-fall/">Web Application</a> project, built by Linkai Xi & Siyuan Hua</p>
							<a class="btn btn-large btn-primary" href="aboutUs.html" style="margin-top:10px;">about us</a>
						</div>
					</div>
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">&lsaquo;</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">&rsaquo;</a>
		</div>
		<jsp:include page="footer.jsp" />
	</div> <!-- /container -->

	<!-- Placed at the end of the document so the pages load faster -->
	<script src="./assets/js/jquery.js"></script>
	<!--script src="http://code.jquery.com/jquery-latest.js"></script-->
    <script src="./assets/js/bootstrap.min.js"></script>	

</body>
</html>
