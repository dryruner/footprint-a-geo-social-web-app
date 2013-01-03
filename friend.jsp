<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import = "databean.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
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
  
	<!--script type="text/javascript"
		src="https://maps.googleapis.com/maps/api/js?sensor=true">
	</script>
	<script type="text/javascript">
		var initialLocation;
		var cmu = new google.maps.LatLng(40.4426466, -79.9465405);
		var browserSupportFlag =  new Boolean();

		function initialize() {
			var myOptions = {
				zoom: 16,
	  			mapTypeId: google.maps.MapTypeId.ROADMAP
			};
			var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

			// Try W3C Geolocation (Preferred)
			if(navigator.geolocation) {
				browserSupportFlag = true;
				navigator.geolocation.getCurrentPosition(function(position) {
					initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
					var infowindow = new google.maps.InfoWindow({map: map,position: initialLocation,content: 'Location found using HTML5.'});
					map.setCenter(initialLocation);
				}, function() { handleNoGeolocation(browserSupportFlag); });
			// Try Google Gears Geolocation
			} else if (google.gears) {
				browserSupportFlag = true;
				var geo = google.gears.factory.create('beta.geolocation');
				geo.getCurrentPosition(function(position) {
					initialLocation = new google.maps.LatLng(position.latitude,position.longitude);
					map.setCenter(initialLocation);
				}, function() { handleNoGeoLocation(browserSupportFlag); });
			// Browser doesn't support Geolocation
			} else {
				browserSupportFlag = false;
				handleNoGeolocation(browserSupportFlag);
			}
			  
			function handleNoGeolocation(errorFlag) {
				if (errorFlag == true) {
					alert("Geolocation service failed.");
					initialLocation = cmu;
				} else {
					alert("Your browser doesn't support geolocation. We've placed you in Carnegie Mellon.");
					initialLocation = cmu;
				}
				map.setCenter(initialLocation);
			}
		}
	</script-->

  </head>

  <body>

    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="brand" href="home.do">Footprint</a>
		  <jsp:include page="navbar_search.jsp" />
          <div class="nav-collapse collapse">
            <ul class="nav pull-right">
              <li><a href="home.do" class="right_bar"><i class="icon-home"></i>${user.userName}</a></li>
        	  <li class="active"><a href="friend.do" class="right_bar"><i class="icon-user"></i>Friends</a></li>
			  <li><a href="statistic.do?email=${user.hashedEmail}" class="right_bar"><i class="icon-signal"></i>Statistics</a></li>
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
	  <!-- where: hashcode = Digest::MD5::hexdigest("jonnyhsy@foxmail.com")-->
	  <!-- hashed_md5_code could be derived form the MD5.java in helper_functions folder -->
	  <!-- Main hero unit for a primary marketing message or call to action -->
      <div class="hero-unit">
		<h3 style="display:inline;">Friends' activities&nbsp;&nbsp;&nbsp;</h3>
		<hr class="feed-item-spliter"/>
		
		<c:forEach var="friend_post" items="${friendPostList}">
			<div class="self_post">
				<div class="map_sign">
					<img src="https://secure.gravatar.com/avatar/${friend_post.author.hashedEmail}?s=80" class="img-polaroid">
				</div>
				<div class="feed_item" style="padding:0;">
					<p class="place" style="margin:0;"><a href="home.do?email=${friend_post.author.hashedEmail}"><i class="icon-user icon_hehe"></i>${friend_post.author.userName}</a><a href="search.do?category=location&keywords=${friend_post.location}"><i class="icon-map-marker icon_hehe"></i>${friend_post.location}</a></p>
					<div class="nima">
					  <c:if test="${!empty (friend_post.imgURL)}">
						<a href="${friend_post.imgURL}" class="cboxElement"><img src="${friend_post.imgURL}" class="item_image" style="padding:0 0 10px 0;"></img></a>
					  </c:if>
					</div>
					<div class="text_status" style="padding: 0 0 0 5px;font-family:'lucida grande',tahoma,verdana,arial,sans-serif;">
					  <c:if test="${!empty (friend_post.content)}">
						<p>"${friend_post.content}"</p>
					  </c:if>
					</div>
					<div class="small_line">
						<i class="icon-time"></i>&nbsp;${friend_post.createTime}
						<!--i class="icon-share"></i>&nbsp;<a href="#">Reply</a-->
					</div>
				</div>
				<div class="clearfix"></div>
				<hr class="feed-item-spliter"/>
			</div>
		</c:forEach>

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
