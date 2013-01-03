<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import = "databean.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Footprint</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author" content="">

	<style type="text/css">
		body {
			padding-top: 60px;
			padding-bottom: 40px;
		}
	</style>
	<link href="./assets/css/colorbox.css" rel='stylesheet'>
	<link href="./assets/css/bootstrap-responsive.css" rel="stylesheet">
	<link href="./assets/css/bootstrap.css" rel="stylesheet">
	<link href="./assets/css/home.css" rel="stylesheet">
	<link href="./assets/css/hover.css" rel="stylesheet">
	<link href="./assets/css/bootstrap-select.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript"
		src="https://maps.googleapis.com/maps/api/js?sensor=true">
	</script>
<script type="text/javascript">
	var geocoder;
	var map = null;
	var infowindow = new google.maps.InfoWindow();
	var markers = [];
	var content_string = "<br/><img style='width:200px;height:200px;'>";
	var iterator = 0;
	var ani_marker;

	function initialize() {
		geocoder = new google.maps.Geocoder();
		var cmu = new google.maps.LatLng(40.4426466, -79.9465405);
//		var cmu = new google.maps.LatLng(40.443159, -79.943068);
		var mapOptions = {
			zoom: 10,
			center: cmu,
	  		mapTypeId: google.maps.MapTypeId.ROADMAP
		}
		map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
		codeAddress(cmu);
	}

	var hehe;
	function codeAddress(cmu) 
	{
		var addr = decodeURIComponent(window.location.href.split("=").pop());
		geocoder.geocode( { 'address': addr}, function(results, status) {
			if(status == google.maps.GeocoderStatus.OK) 
			{
				document.getElementById("search_result").innerHTML = (results?results.length:0) + " result(s)";
				var reg = new RegExp(/\+/gm);
				document.getElementById("hsy_location_1").innerHTML = addr.replace(reg," ");
				document.getElementById("hsy_location_2").innerHTML = addr.replace(reg," ");
				hehe = addr;
				var marker;
				hehe = results;
				for(var i = 0; i < results.length; i++)
				{
					marker = new google.maps.Marker({
								map: map,
								position: results[i].geometry.location,
								animation: google.maps.Animation.DROP,
					});
					markers.push(marker);
					var info_content = "<strong>"
						+ results[i].formatted_address + "<br/>"
						+ "latitude:" + results[i].geometry.location.$a
						+ ", longitude:" + results[i].geometry.location.ab + "<br/>" + "<br/></strong>";
					google.maps.event.addListener(markers[markers.length-1], 'click', function() 
					{
						if(ani_marker != null && ani_marker.getAnimation() != null)ani_marker.setAnimation(null);
						ani_marker = marker;
						ani_marker.setAnimation(google.maps.Animation.BOUNCE);
						// Calling the open method of the infoWindow 
						infowindow.close();
						infowindow.setContent(info_content);
						infowindow.open(map, marker);
					});
					iterator++;
				}
				if(results.length == 1)
				{
					map.setZoom(14);
				}
				else
				{
					map.setZoom(2);
				}
				map.setCenter(results[0].geometry.location);
			} 
			else 
			{
				document.getElementById("hsy_location_1").innerHTML = "CMU";
				document.getElementById("hsy_location_2").innerHTML = "CMU";
				var marker = new google.maps.Marker({
					map: map,
					position:  cmu,
					animation: google.maps.Animation.DROP,
				});
				map.setCenter(cmu);
				alert("Geocode was not successful for the following reason: " + status + "\n\nAnd you're directed to Carnegie Mellon University.");
			}
		});
	}

	function addMarker(result)
	{
		var marker = new google.maps.Marker({
			map: map,
			position: result.geometry.location,
			animation: google.maps.Animation.DROP,
		});
		map.setCenter(result.geometry.location);
	}

</script>
</head>
<body onload="initialize()">

	<div class="navbar navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<a class="brand" href="home.do">Footprint</a>
				<jsp:include page="navbar_search.jsp" />
				<div class="nav-collapse collapse">
					<ul class="nav pull-right">
						<li><a href="home.do" class="right_bar"><i class="icon-home"></i>${user.userName}</a></li>
  			      		<li><a href="friend.do" class="right_bar"><i class="icon-user"></i>Friends</a></li>
  			      		<li><a href="statistic.do?email=${user.hashedEmail}" class="right_bar" class="right_bar"><i class="icon-signal"></i>Statistics</a></li>
						<li><a href="userList.do" class="right_bar"><i class="icon-search"></i>Users</a></li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle right_bar" data-toggle="dropdown"><i class="icon-off"></i>Account <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="updateProfile.do">Profile</a></li>
								<li class="divider"></li>
								<li><a href="logout.do">Logout</a></li>
							</ul>
						</li>
					</ul>
				</div><!--/.nav-collapse -->  
			</div>
		</div>
	</div>

	<div class="container">
	  <div class="hero-unit">
		<c:if test="${(fn:length(userList)) != 0}">
			<h3 style="display:inline;">Find users:&nbsp;&nbsp;&nbsp;</h3>
		  	<hr class="feed-item-spliter"/>
			<c:forEach var="each_user" items="${userList}">
				<c:if test="${ (each_user.hashedEmail) != (user.hashedEmail)}">
			  		<div class="self_post">
						<div class="map_sign">
							<img src="https://secure.gravatar.com/avatar/${each_user.hashedEmail}?s=80" class="img-polaroid">
						</div>
						<p class="place" style="line-height:0;"><br/></p>
						<div class="feed_item all_user" >
							<p class="place" style="margin:0;line-height:0;">
								<i class="icon-user icon_hehe"></i><strong><a href="home.do?email=${each_user.hashedEmail}" style="color:#317EAC;">${each_user.userName}</a></strong>
							</p>
							<p class="place" style="margin:0;line-height:0;">
								<i class="icon-home icon_hehe"></i><a href="javascript:void(0)" style="color:black;font-size:0.8em;">${each_user.location}</a>
							</p>
							<c:if test="${!empty (each_user.gender)}">
								<p class="place" style="margin:0;line-height:0;">
									<i class="icon-leaf icon_hehe"></i><a href="javascript:void(0)" style="color:black;font-size:0.8em;">${each_user.gender}</a>
								</p>
							</c:if>
						</div>
						<div class="clearfix"></div>
						<hr class="feed-item-spliter"/>
				  	</div>
				</c:if>
			</c:forEach>
		</c:if>
		<c:if test="${fn:length(userList) == 0}">
		<c:if test="${!empty (location)}">
		  <div align="center">
			<h3 align="center" id="s_title"><i class="icon-map-marker" style="margin:10px;"></i><span id="hsy_location_1"></span></h3>
			<span id="search_result"></span>
        	<div id="map_canvas" style="width:91%;height:300px;"></div>
			<br/>
		  </div>

		  <div>
			<h3 align="center"><i class="icon-camera" style="margin:8px;"></i>Photos at <span id="hsy_location_2"></span></h3>
			<div class="container">
				<ul class="hoverbox">
					<c:forEach var="post" items="${postList}" >
						<c:if test="${!empty (post.imgURL)}" >
							<li class="thumbnail"><a href="${post.imgURL}" class="cboxElement"><img class="original" src="${post.imgURL}" alt=""><img class="preview" src="${post.imgURL}" alt=""></a></li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		  </div>
		</c:if><!-- location !empty -->
		<c:if test="${empty (location)}">
			<a href="javascript:void(0)" style="font-size:1.2em;">Find nothing  :( ...</a>
		</c:if>
		</c:if>			
	  </div><!--hero-unit-->
	  <jsp:include page="footer.jsp" />
	</div> <!-- /container -->

	<!-- Placed at the end of the document so the pages load faster -->
	<script src="./assets/js/jquery.js"></script>
	<script src="./assets/js/jquery.colorbox.min.js"></script>
	<script src="./assets/js/jquery-ui-1.8.21.custom.min.js"></script>
	<script src="./assets/js/bootstrap-dropdown.js"></script>
	<script src="./assets/js/bootstrap-button.js"></script>
	<script src="./assets/js/bootstrap-select.js"></script>
	<script type="text/javascript">
		//gallery colorbox
		$('.thumbnail a').colorbox({rel:'thumbnail a', transition:"elastic", maxWidth:"95%", maxHeight:"95%"});
		$('.selectpicker').selectpicker();
	</script>
</body>
</html>
