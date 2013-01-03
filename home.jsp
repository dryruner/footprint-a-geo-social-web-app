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
	<link href="./assets/css/box.css" type="text/css" rel="stylesheet" />
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
/*		var initialLocation;
		var cmu = new google.maps.LatLng(40.4426466, -79.9465405);
		var browserSupportFlag =  new Boolean();

		function initialize() 
		{
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
//		google.maps.event.addDomListener(window, 'load', initialize);
*/

	var geocoder;
	var map = null;
	var infowindow = new google.maps.InfoWindow();
	var markers = [];
	var content_string = "<br/><img style='width:200px;height:200px;'>";
	var iterator;
	var ani_marker;
	var done = false;

	function initialize() {
		geocoder = new google.maps.Geocoder();
		var cmu = new google.maps.LatLng(40.4426466, -79.9465405);
		var mapOptions = {
			zoom: 16,
			center: cmu,
	  		mapTypeId: google.maps.MapTypeId.ROADMAP
		}
		map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
		navigator.geolocation.getCurrentPosition(function(position){
			var initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
			get_and_mark_Address_full(initialLocation, 1);
			map.setCenter(initialLocation);
		});
/*		google.maps.event.addListener(map, "click", 
			function(event){
				get_and_mark_Address_full(event.latLng);
			}
		);*/
	}
/*
	function drop()
	{
		if(done)
		{
			initialize();
			done = !done;
		}
		statistics();
		iterator = 0;
		ani_marker = null;
		for (var i = 0; i < latlon_array.length; i++) 
		{
			setTimeout(function() {
				addMarker();
				}, i * 250
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
		markers.push(marker);
		var info_content = "<strong>" + latlon_array[iterator][2] + "</strong><br/>";
		if(latlon_array[iterator][4])
			info_content += "<img style='width:200px;height:200px;' src=" + latlon_array[iterator][4] + " />";
		else
			info_content += "<p>\"" + latlon_array[iterator][3] + "\"</p>";

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
*/
	function get_and_mark_Address_full(loc, is_init) {
		geocoder.geocode( { 'latLng': loc}, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				var info_content = "You're currently here!<br/>" + results[0].formatted_address;
				var marker = new google.maps.Marker({
					map: map,
					position:loc,
					animation: (is_init==0)?google.maps.Animation.DROP:null,
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


		function get_and_mark_Address(loc) {
			geocoder.geocode( { 'latLng': loc}, function(results, status) {
				if (status == google.maps.GeocoderStatus.OK) {
					var info_content = results[0].formatted_address;
				} 
				else {
					alert('Geocode was not successful for the following reason: ' + status);
				}
			});
		}

		function locate()
		{
			navigator.geolocation.getCurrentPosition(function(position){
				document.getElementById("h_lat").value = parseFloat(position.coords.latitude);
				document.getElementById("h_lon").value = parseFloat(position.coords.longitude);
				var loc = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
				var geocoder = new google.maps.Geocoder();
				geocoder.geocode( { 'latLng': loc}, function(results, status) {
					if (status == google.maps.GeocoderStatus.OK) {
						document.getElementById("h_location").value = results[0].formatted_address;
					}
					else {
						alert('Geocode was not successful for the following reason: ' + status);
					}
				});
			});
			return true;
		}

		function calcute()
		{
			var content = document.getElementById("content").value.trim();
			if(content.length <= 100)
			{
				document.getElementById("count_total").innerHTML = content.length;
				if(content.length != 0)
				{
					document.getElementById("post_status").disabled=false;
					return true;
				}
				else
				{
					document.getElementById("post_status").disabled=true;
					return false;
				}
			}
			else
			{
				document.getElementById("post_status").disabled = true;
				return false;
			}
		}
		
		function image_upload()
		{
			var filename = document.getElementById("upload_photo").value;
			if(filename)
			{
				var hashed_email = document.getElementById("user_hashedEmail").value;
				var upload_type = filename.split('.').pop();
				if(upload_type == "png" || upload_type == "bmp" || upload_type == "jpg" || upload_type == "jpeg" || upload_type == "gif")
				{
					var real_name = hashed_email + btoa(filename) + "." + upload_type;
					document.getElementsByTagName("form")[2].action = "imgUpload.do?name=" + real_name;
					return true;
				}
				else
				{
					alert("Illegal type: " + upload_type);
					return false;
				}
			}
			else
				return false;
		}
/*	
		var latlon_array;
		var input_array = document.getElementsByName("latlonList");
		function statistics()
		{
			latlon_array = new Array(input_array.length);
			for(var i=0; i < latlon_array.length; i++)
			{
				latlon_array[i] = input_array[i].value.split('##');
//				alert(latlon_array[i][0] + ":" + latlon_array[i][1]);
			}
		}*/
	</script>
  </head>
  <body onload="initialize()">

    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="brand" href="javascript:void(0)">Footprint</a>
		  <jsp:include page="navbar_search.jsp" />
          <div class="nav-collapse collapse">
            <ul class="nav pull-right">
			  <c:if test="${ (user.hashedEmail)==(viewUser.hashedEmail) }">
			  	<li class="active">
			  </c:if>
			  <c:if test="${ (user.hashedEmail)!=(viewUser.hashedEmail) }">
			  	<li>
			  </c:if>
			  	<a href="home.do" class="right_bar"><i class="icon-home"></i>${user.userName}</a>
			  </li>
              <li><a href="friend.do" class="right_bar"><i class="icon-user"></i>Friends</a></li>
			  <li><a href="statistic.do?email=${user.hashedEmail}" class="right_bar"><i class="icon-signal"></i>Statistics</a></li>
			  <li><a href="userList.do" class="right_bar"><i class="icon-search"></i>Users</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle right_bar" data-toggle="dropdown"><i class="icon-off"></i>Account <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="updateProfile.do">Profile</a></li>
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
	  <div class="cover-image">
	  	<div class="" style="height:300px;background-image:url(http://img.t.sinajs.cn/t5/skin/public/profile_cover/028.jpg)">
		</div>
	  </div>
      <div class="hero-unit">
		<div style="position:relative;width:100%;" class="pull-left">
			<div class="head_panel pull-left" style="margin-left:180px;width:100%;">
				<div class="panel_username pull-left" style="margin:-20px 0 0 10px;width:100%;">
					<table class="pull-left">
						<tr><td>
							<h2>
								${viewUser.userName}
								<input type="hidden" id="user_hashedEmail" value=${viewUser.hashedEmail} />
								<c:if test="${!empty (isFollow)}">
									<c:if test="${isFollow == 0}">
										<form id="follow_form" name="follow_form" method="POST" action="follow.do" style="margin:0;">
											<input type="hidden" name="followedEmail" value="${viewUser.email }"/>
											<button class="btn btn-primary btn-small">Follow</button>
										</form>
									</c:if>
									<c:if test="${isFollow == 1}">
										<form id="unfollow_form" name="unfollow_form" method="POST" action="unFollow.do" style="margin:-10px 0;padding:0;">
											<input type="hidden" name="followedEmail" value="${viewUser.email }"/>
											<button class="btn btn-primary btn-small">unfollow</button>
										</form>
									</c:if>
								</c:if>
							</h2></tr></td>
						<tr><td>
							<c:choose>
								<c:when test="${!empty (viewUser.location)}">
									<i class="icon-home"></i>&nbsp;${viewUser.location}</td></tr>
								</c:when>
								<c:when test="${empty (viewUser.location)}">
									<c:if test="${(user.hashedEmail)==(viewUser.hashedEmail)}">
										<i class="icon-home"></i>&nbsp;<a href="updateProfile.do">Fill in your Location</a>
									</c:if>
								</c:when>
							</c:choose>
						<tr><td><i class="icon-envelope"></i>&nbsp;${viewUser.email}</td></tr>
						<tr><td>
							<c:choose>
								<c:when test="${!empty (viewUser.gender)}">
									<i class="icon-leaf"></i>&nbsp;${viewUser.gender}
								</c:when>
								<c:when test="${empty (viewUser.gender)}">
									<c:if test="${(user.hashedEmail)==(viewUser.hashedEmail)}">
										<i class="icon-leaf"></i>&nbsp;<a href="updateProfile.do">Fill in your gender</a>
									</c:if>
								</c:when>
							</c:choose>
						</td></tr>
						<tr><td>
							<c:choose>
								<c:when test="${!empty (viewUser.status)}">
									<i class="icon-heart"></i>&nbsp;${viewUser.status}
								</c:when>
								<c:when test="${empty (viewUser.status)}">
									<c:if test="${(user.hashedEmail)==(viewUser.hashedEmail)}">
										<i class="icon-heart"></i>&nbsp;<a href="updateProfile.do">Fill in your relationship status</a>
									</c:if>
								</c:when>
							</c:choose>
						</td></tr>
						<tr><td>
							<c:choose>
								<c:when test="${!empty (viewUser.blood)}">
									<i class="icon-tint"></i>&nbsp;${viewUser.blood}
								</c:when>
								<c:when test="${empty (viewUser.blood)}">
									<c:if test="${(user.hashedEmail)==(viewUser.hashedEmail)}">
										<i class="icon-tint"></i>&nbsp;<a href="updateProfile.do">Fill in your blood type</a>
									</c:if>
								</c:when>
							</c:choose>
						</td></tr>
						<tr><td>
							<c:choose>
								<c:when test="${!empty (viewUser.birthday)}">
									<i class="icon-star-empty"></i>&nbsp;${viewUser.birthday}
								</c:when>
								<c:when test="${empty (viewUser.birthday)}">
									<c:if test="${(user.hashedEmail)==(viewUser.hashedEmail)}">
										<i class="icon-star-empty"></i>&nbsp;<a href="updateProfile.do">Fill in your birthday</a>
									</c:if>
								</c:when>
							</c:choose>
						</td></tr>
					</table>
					<c:if test="${ (user.hashedEmail)==(viewUser.hashedEmail) }">
					<div class="boxbox pull-left">
						<div class="post_box" id="text_box">
						  <form id="Postform" name="Postform" method="post" action="createPost.do" style="margin:0;" onsubmit="return calcute()">
							<div class="title">
								<p><strong>&nbsp;What you're doing ...</strong></p>
								<p id="zhanwei"></p><p id="zhanwei"></p><p id="zhanwei"></p>
								<p style="padding:0 38px 0 0;"><span id="count_total">0</span>/100</p>
							</div>
							<textarea onfocus="locate()" onkeyup="calcute()" name="content" value="${Postform.content}" class="box_area" rows="5" id="content"></textarea>
							<input type="hidden" name="longitude" id="h_lon" value="${Postform.longitude}"/>
							<input type="hidden" name="latitude" id="h_lat" value="${Postform.latitude}"/>
							<input type="hidden" name="location" id="h_location" value="${Postform.location}"/>
							<div class="title">
								<div class="box_button">
									<button class="btn btn-small pull-right" id="post_status" disabled>Post</button>
									<a class="btn btn-small pull-left" id="open_photobox"><i class="icon-camera"></i></a>
									<div class="clearfix"></div>
								</div>
								<div class="clearfix"></div>
							</div>
						  </form>
						</div>
						<div class="post_box" id="photo_box" style="display:none;">
						  <form style="margin:0;" method="post" action="imgUpload.do?name=" enctype="multipart/form-data" onsubmit="return image_upload()">
							<div class="title">
								<p><strong>&nbsp;(Step 1)&nbsp;&nbsp;Add a photo</strong></p>
								<i class="icon-remove pull-right" id="click_me" style="margin:7px 7px 0 0;"></i>
							</div>
							<div>
								<div class="box_button">
									<input type="file" id="upload_photo" name="file" style="line-height:20px;" class="pull-left"/>
									<input type="submit" class="btn btn-mini pull-right" value="Select" />
									<div class="clearfix"></div>
								</div>
							</div>
						  </form>
						</div>
					</div><!--boxbox-->
					</c:if>
				</div>
			</div>
			<div class="head_panel_avatar" style="position:absolute;left:10px;top:-60px;background-color:#E7E7E7;">
				<img src="https://secure.gravatar.com/avatar/${viewUser.hashedEmail}?s=150" class="img-polaroid">
				<table style="width:100%;">
				<tr>
					<td class="weibo_like" style="width:37%;">
						<a href="javascript:void(0)">
							<strong>${fn:length(viewUser.followedSet)}</strong>
							<div class="hehe"><em>following</em></div>
						</a>
					</td>
					<td class="weibo_like" style="width:37%">
						<a href="javascript:void(0)">
							<strong>${fn:length(viewUser.followerSet)}</strong>
							<div class="hehe"><em>followers</em></div>
						</a>
					</td>
					<td class="weibo_like" style="width:26%;border-right:none;">
						<a href="javascript:void(0)">
							<strong>${fn:length(postList)}</strong>
							<div class="hehe"><em>posts</em></div>
						</a>
					</td>
				</tr>
				</table>
			</div>
		</div>
		<div class="clearfix"></div>
		<br/>

		<div class="hero-unit" style="margin:0px 1px 10px 10px;background-color:#ECEFF5;color:gray;position:relative;border:2px solid white">
			<div class="arrow" style="height:11px;left:43px;top:-13px;width:15px;position:absolute;">
				<i class="icon-chevron-up icon-white"></i>
			</div>
			<div class="photo_gallery">
				<c:if test="${ (user.hashedEmail)==(viewUser.hashedEmail) }">
					<c:if test="${!empty (imgList)}">
						<p>Recent photos:</p>
					</c:if>
					<c:if test="${empty (imgList)}">
						<p>No photos :(</p>
					</c:if>
				</c:if>
				<c:if test="${ (user.hashedEmail)!=(viewUser.hashedEmail)}">
					<c:if test="${!empty (imgList)}">
						<p><strong>${viewUser.userName}'s</strong> recent photos:</p>
					</c:if>
					<c:if test="${empty (imgList)}">
						<p><strong>${viewUser.userName}</strong> has no photos :(</p>
					</c:if>	
				</c:if>
				<c:forEach var="post" items="${imgList}" begin="0" end="4">
					<a href="${post.imgURL}" class="cboxElement"><img src="${post.imgURL}" class="gallery_image"></img></a>
				</c:forEach>
			</div>
			<div class="clearfix"></div>
		</div>
		
		<h3 style="display:inline;">Recent activity&nbsp;&nbsp;&nbsp;
			<c:if test="${!empty (isFollow)}">
				<c:if test="${ (isFollow)==1}">
					<a href="statistic.do?email=${viewUser.hashedEmail}" style="font-size:0.5em;">View ${viewUser.userName}'s statistics &raquo;</a>
				</c:if>
			</c:if>
		</h3>
        <hr class="feed-item-spliter"/>      
		
	   <c:forEach var="post" items="${postList}" varStatus="status">
		 <div class="self_post" id="post_${post.id}">
			<div class="map_sign">
				<img src="./assets/img/map.png">
			</div>
			<div class="feed_item" style="width:90%;">
				<c:if test="${!empty (post.location)}">
					<div style="width:100%;">
						<a class="place_home" href="search.do?category=location&keywords=${post.location}" style="display:inline;">&nbsp;${post.location}</a>
						<c:if test="${(user.hashedEmail) == (viewUser.hashedEmail)}">
							<!--form method="post" action="javascript:void(0)" style="display:inline;"-->
								<a class="pull-right btn btn-mini" id="delete_post" onclick="delete_this_post(${post.id})"><i class="icon-remove"></i></a>
							<!--/form-->
						</c:if>
					</div>
					<div class="clearfix"></div>
				</c:if>
				<!-- No matter there is image or not, the format will be OK! -->
				<div class="nima">
					<c:if test="${!empty (post.imgURL)}">
						<a href="${post.imgURL}" class="cboxElement"><img src="${post.imgURL}" class="item_image" style="padding:0 0 10px 0;"></img></a>
					</c:if>
				</div>
				<div class="text_status" style="padding: 0 0 0 5px;font-family:'lucida grande',tahoma,verdana,arial,sans-serif;">
					<c:if test="${!empty (post.content)}">
						<p>"${post.content}"</p>
					</c:if>
				</div>
				<div class="small_line">
					<i class="icon-time"></i>&nbsp;${post.createTime}
				</div>
			</div>
			<div class="clearfix"></div>
			<hr class="feed-item-spliter"/>
		  </div>
        </c:forEach> 

		<div>
			<br/>
			<div>
				<c:forEach var="post" items="${postList}" >
					<input type="hidden" name="latlonList" value="${post.latitude}##${post.longitude}##${post.location}##${post.content}##${post.imgURL}" />
				</c:forEach>
			</div>
			<c:if test="${(user.hashedEmail)==(viewUser.hashedEmail)}">
				<hr class="feed-item-spliter"/>
				<p>Current location</p>
        		<div id="map_canvas" style="width:100%; height:500px;"></div>
			 	<!--p><a class="btn btn-primary btn-large" onclick="drop()">Click me!!!! &raquo;</a></p-->
			</c:if>
		</div>
      </div>
      
    <jsp:include page="footer.jsp"  />
	</div> <!-- /container -->

    <!-- Placed at the end of the document so the pages load faster -->
	<script src="./assets/js/jquery.js"></script>
	<script src="./assets/js/jquery.colorbox.min.js"></script>
	<script src="./assets/js/jquery-ui-1.8.21.custom.min.js"></script>
    <script src="./assets/js/bootstrap-dropdown.js"></script>
    <script src="./assets/js/bootstrap-button.js"></script>
	<script src="./assets/js/bootstrap-select.js"></script>
	<script type="text/javascript">
		$("#click_me").click(function(){
				$("#photo_box").hide();
				$("#text_box").toggle();
		});
		$("#open_photobox").click(function() {
				$("#photo_box").toggle();
				$("#text_box").hide();
		});
		//gallery colorbox
		$('.nima a').colorbox({transition:"elastic", maxWidth:"95%", maxHeight:"95%"});
		$('.photo_gallery a').colorbox({rel:'photo_gallery a', transition:"elastic", maxWidth:"95%", maxHeight:"95%"});
		$('.selectpicker').selectpicker();

		function delete_this_post(p_id)
		{
			confirm_c = confirm("Are you sure you wanna delete this post?");
			if(confirm_c)
			{
				$.ajax({
					type:"post",
					url:('deletePost.do?postId=' + p_id),
					success: function() {
						$("#post_"+p_id).slideUp('1000',
							function()
							{
								$("#post_"+p_id).remove();
							}
						);
					}
				});
			}
		}

/*
		$("[id=delete_post]").click(function(){
			$(this).parent().parent().parent().slideUp('1000',
				function(){ 
					$(this).remove();
				});
		});*/
	</script>
  </body>
</html>
