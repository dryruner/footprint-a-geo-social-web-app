<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import = "databean.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Footprint</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

	<link href="./assets/css/colorbox.css" rel='stylesheet'>
    <link href="./assets/css/bootstrap.css" rel="stylesheet">
    <link href="./assets/css/home.css" rel="stylesheet">
	<link href="./assets/css/bootstrap-select.css" type="text/css" rel="stylesheet" />
	<style type="text/css">
    body {
    	padding-top: 36px;
    	padding-bottom: 40px;
    }
	
	input.file{
		vertical-align:middle;
		position:relative;
		left:68px;
	 	*left:-218px;
		filter:alpha(opacity=0);
		opacity:0;
		z-index:1;
		*width:223px;
		display:none;
	}

	form input.viewfile {
		z-index:99;
		border:1px solid #ccc;
		padding:2px;
		width:120px;
		vertical-align:middle;
		color:#999;
	}
	
	p.filep {
		height:23px;
	}
    </style>
    <link href="./assets/css/bootstrap-responsive.css" rel="stylesheet">
  
	<script type="text/javascript"
		src="https://maps.googleapis.com/maps/api/js?sensor=true">
	</script>
<script type="text/javascript">
	var geocoder;
	var map = null;
	var infowindow = new google.maps.InfoWindow();
	var markers = [];
	var content_string = "<br/><img style='width:200px;height:200px;'>";
	var iterator;
	var ani_marker;
	var done = false;
	var latlon_array;
	var input_array = document.getElementsByName("latlonList");
	
	function initialize() {
		geocoder = new google.maps.Geocoder();
		var cmu = new google.maps.LatLng(40.4426466, -79.9465405);
			var mapOptions = {
			zoom: 14,
			center: cmu,
	  		mapTypeId: google.maps.MapTypeId.ROADMAP
		}
		map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
		navigator.geolocation.getCurrentPosition(function(position){
			var initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
			get_and_mark_Address_full(initialLocation, 1);
			map.setCenter(initialLocation);
		});
		statistics();
	}

	function get_and_mark_Address_full(loc, is_init) {
		geocoder.geocode( { 'latLng': loc}, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				var info_content = "You're currently here!<br/>" + results[0].formatted_address;
				var marker = new google.maps.Marker({
					map: map,
					position:loc,
					animation: (is_init == 0)? google.maps.Animation.DROP:null,
				});
				markers.push(marker);
				google.maps.event.addListener(markers[markers.length-1], 'click', function () {
					// Calling the open method of the infoWindow 
					infowindow.close();
					infowindow.setContent(info_content);
					infowindow.open(map, marker);
				});
			} 
			else {
				alert('Geocode was not successful for the following reason: ' + status);
			}
		});
	}

	function drop()
	{
		if(done)
		{
			initialize();
			done = !done;
		}
		iterator = 0;
		ani_marker = null;
		for (var i = 0; i < latlon_array.length; i++) 
		{
			setTimeout(function() {
				addMarker();
				}, i * 300
			);
		}
		done = true;
	}

	function addMarker()
	{
		var loc = new google.maps.LatLng(parseFloat(latlon_array[iterator][0]), parseFloat(latlon_array[iterator][1]));
		var marker = new google.maps.Marker({
			map: map,
			position:loc,
			animation: google.maps.Animation.DROP,
		});
		map.setCenter(loc);
		markers.push(marker);
		var info_content = "<i class='icon-time'></i> " + latlon_array[iterator][5]
			+ "<br/><strong><i class='icon-map-marker'></i> " + latlon_array[iterator][2] + "</strong> (" + "latitude:" + latlon_array[iterator][0] + ", longitude:" + latlon_array[iterator][1] + ")<br/>";
		if(latlon_array[iterator][4])
			info_content += "<img style='max-width:100%;max-height:100%;padding:0 0 0 100px;' src=" + latlon_array[iterator][4] + " /><br/>";
		if(latlon_array[iterator][3].length != 0)
			info_content += "<i class='icon-file'></i> \"" + latlon_array[iterator][3] + "\"";

		google.maps.event.addListener(markers[markers.length-1], 'click', function() {
			if(ani_marker != null && ani_marker.getAnimation() != null)
				ani_marker.setAnimation(null);
			
			ani_marker = marker;
			ani_marker.setAnimation(google.maps.Animation.BOUNCE);
			// Calling the open method of the infoWindow 
			infowindow.close();
			infowindow.setContent(info_content);
			infowindow.open(map, marker);
		});
		iterator++;
	}

	
	function statistics()
	{
		latlon_array = new Array(input_array.length);
		for(var i=0; i < latlon_array.length; i++)
		{
			latlon_array[i] = input_array[i].value.split('##');
//			alert(latlon_array[i][0] + ":" + latlon_array[i][1]);
		}
		document.getElementById("location_num").innerHTML = latlon_array.length + " footprint(s)";
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
			  <c:if test="${ (user.hashedEmail)==(viewUser.hashedEmail) }">
			  	<li class="active">
			  </c:if>
			  <c:if test="${ (user.hashedEmail)!=(viewUser.hashedEmail) }">
			  	<li>
			  </c:if>
			  	<a href="statistic.do?email=${user.hashedEmail}" class="right_bar"><i class="icon-signal"></i>Statistics</a>
			  </li>
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
      <!-- hardcode https://secure.gravatar.com/avatar/hashcode?s=size -->
	  <!-- hashed_md5_code could be derived form the MD5.java in helper_functions folder -->
      <div class="hero-unit">
		<c:if test="${ (user.hashedEmail)==(viewUser.hashedEmail)}">
			<h3 style="display:inline;">My statistics&nbsp;&nbsp;&nbsp;</h3>
		</c:if>
		<c:if test="${ (user.hashedEmail) != (viewUser.hashedEmail)}">
			<h3 style="display:inline;"><a href="home.do?email=${viewUser.hashedEmail}">${viewUser.userName}'s statistics&nbsp;&nbsp;&nbsp;</a></h3>
		</c:if>
		<hr class="feed-item-spliter"/>
	
		<div>
			<c:forEach var="post" items="${postList}" >
				<input type="hidden" name="latlonList" value="${post.latitude}##${post.longitude}##${post.location}##${post.content}##${post.imgURL}##${post.createTime}" />
			</c:forEach>
		</div>
		<div style="padding:5px;">
			<table align="center" style="font-size:1.15em;width:40%;">
			  <tr >
				<td style="width:33%;"><a href="javascript:void(0)" id="location_num"></a></td>
			  	<td style="width:33%;" align="center"><a href="javascript:void(0)">${fn:length(postList)} post(s)</a></td>
				<td style="width:33%;" align="center"><a href="javascript:void(0)">${fn:length(imgList)} image(s)</a></td>
			  </tr>
			</table>
		</div>
        <div id="map_canvas" style="height:400px;"></div>
		<p><a class="btn btn-primary btn-large" onclick="drop()">
			<c:if test="${ (user.hashedEmail)==(viewUser.hashedEmail) }">
				View my footprints
			</c:if>
			<c:if test="${ (user.hashedEmail)!=(viewUser.hashedEmail) }">
				View ${viewUser.userName}'s footprints
			</c:if>	
		</a></p>

      </div>
	  <jsp:include page="footer.jsp" />
    </div> <!-- /container -->

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="./assets/js/jquery.js"></script>
	<script src="./assets/js/jquery.js"></script>
	<script src="./assets/js/jquery.colorbox.min.js"></script>
	<script src="./assets/js/jquery-ui-1.8.21.custom.min.js"></script>
    <script src="./assets/js/bootstrap-dropdown.js"></script>
    <script src="./assets/js/bootstrap-button.js"></script>
	<script src="./assets/js/bootstrap-select.js"></script>
	<script type="text/javascript">
		//gallery colorbox
		$('.nima a').colorbox({transition:"elastic", maxWidth:"95%", maxHeight:"95%"});
		$('.photo_gallery a').colorbox({rel:'photo_gallery a', transition:"elastic", maxWidth:"95%", maxHeight:"95%"});
		$('.selectpicker').selectpicker();
	</script>
  </body>
</html>
