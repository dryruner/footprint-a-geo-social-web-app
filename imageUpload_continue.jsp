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
    <link href="./assets/css/colorbox.css" rel='stylesheet'>
	<link href="./assets/css/home.css" rel="stylesheet">
	<style type="text/css">
      body {
        padding-top: 100px;
      	padding-bottom: 40px;
      }
	</style>
	<link href="./assets/css/form.css" rel="stylesheet">
	<link href="./assets/css/box.css" type="text/css" rel="stylesheet" />
    <link href="./assets/css/bootstrap-responsive.css" rel="stylesheet">
	<script type="text/javascript"
		src="https://maps.googleapis.com/maps/api/js?sensor=true">
	</script>
	<script type="text/javascript">
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
					document.getElementById("post_status").disabled = false;
					return true;
				}
				else
				{
					document.getElementById("post_status").disabled = true;
					return false;
				}
			}
			else
			{
				document.getElementById("post_status").disabled = true;
				return false;
			}
		}
		
	</script>
</head>
<body onload="locate()">

    <h2 class="form-signin-heading" align="center">Preview</h2>
    <div class="container">
		<table style="width:50%;" align="center">
		<tr>
		<td>
			<div class="photo_gallery">
				<a href="userTest/${uploadedFile}" class="cboxElement"><img src="userTest/${uploadedFile}" class="gallery_image" style="width:100%;height:300px;padding:0;border:2px solid #DFDFDF;"></img></a>
				<!--img src="userTest/${uploadedFile}" alt=":-(," style="width:100%;height:300px;"></img-->
			</div>
			<div class="clearfix"></div>
		</td></tr>
		<tr>
		<td>
		<div class="post_box" id="text_box">
		  <form id="Postform" name="Postform" method="post" action="createPost.do" style="margin:0;">
			<div class="title">
				<p><strong>&nbsp;(Step 2)&nbsp;&nbsp;Say something about this picture:</strong></p>
				<p style="padding:0 38px 0 0;"><span id="count_total">0</span>/100</p>
			</div>
			<textarea name="content" value="${Postform.content}" class="box_area" rows="5" id="content" onkeyup="calcute()"></textarea>
			<input type="hidden" name="longitude" id="h_lon" value=""/>
			<input type="hidden" name="latitude" id="h_lat" value=""/>
			<input type="hidden" name="location" id="h_location" value=""/>
			<input type="hidden" name="imgURL" value="userTest/${uploadedFile}"/>
			<div class="title">
				<div class="box_button">
					<button class="btn btn-primary btn-primary pull-right" id="post_status" disabled>Complete upload</button>
					<div class="clearfix"></div>
				</div>
				<div class="clearfix"></div>
			</div>
		  </form>
		</div>
		</td></tr></table>
    </div> <!-- /container -->

    <!-- Placed at the end of the document so the pages load faster -->
    <script src="./assets/js/jquery.js"></script>
	<script src="./assets/js/jquery.colorbox.min.js"></script>
	<script type="text/javascript">
		$('.photo_gallery a').colorbox({rel:'photo_gallery a', transition:"elastic", });
	</script>
</body>
</html>
