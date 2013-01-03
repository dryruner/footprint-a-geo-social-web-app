<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import = "databean.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Footprint</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <link href="./assets/css/bootstrap.css" rel="stylesheet">
    <link href="./assets/css/home.css" rel="stylesheet">
    <link href="./assets/css/bootstrap-responsive.css" rel="stylesheet">
	<link href="./assets/css/bootstrap-select.css" type="text/css" rel="stylesheet" />
	<style type="text/css">
    body {
    	padding-top: 36px;
    	padding-bottom: 40px;
    }
    </style>
	<style type="text/css">
		@import "./assets/css/jquery.datepick.css";
	</style>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
	<script src="./assets/js/jquery.js"></script>
	<script src="./assets/js/bootstrap-dropdown.js"></script>
	<script type="text/javascript" src="./assets/js/jquery.datepick.js"></script>
	<script src="./assets/js/bootstrap-tooltip.js"></script>
	<script type="text/javascript">
		function check_empty()
		{
			var uname = document.getElementById("c_username").value.trim();
			if(uname.length == 0)
			{
				document.getElementById("update_btn").disabled = true;
			}
			else
				document.getElementById("update_btn").disabled = false;
		}
	</script>
</head>
<body>

    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="brand" href="home.do">Footprint</a>
		  <jsp:include page="navbar_search.jsp"/>
          <div class="nav-collapse collapse">
            <ul class="nav pull-right">
              <li><a href="home.do" class="right_bar"><i class="icon-home"></i>${user.userName}</a></li>
			  <li><a href="friend.do" class="right_bar"><i class="icon-user"></i>Friends</a></li>
			  <li><a href="statistic.do?email=${user.hashedEmail}" class="right_bar"><i class="icon-signal"></i>Statistics</a></li>
			  <li><a href="userList.do" class="right_bar"><i class="icon-search"></i>Users</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle right_bar" data-toggle="dropdown"><i class="icon-off"></i>Account <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li class="active"><a href="updateProfile.do">Profile</a></li>
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
      <div class="hero-unit" style="position:relative">
		<div class="profile_info">
			<div style="margin:20px 0 0 20px;">
			<div class="avatar pull-left" style="padding:0 20px 0 0;">
				<a id="self_avatar" href="http://gravatar.com/emails" rel="tooltip" data-placement="bottom" data-original-title="Change avatar at gravatar.com">
					<img src="https://secure.gravatar.com/avatar/${user.hashedEmail}?s=150" class="img-polaroid">
				</a>
				<a href="javascript:void(0)" align="center" style="display:block;font-size:1.5em;padding:8px 0 0 0;">${user.userName}</a>
			</div>
			<div class="infoblock pull-left">
				<form class="info_title">
					<fieldset class="S_line2" style="border-style:solid;border-width:1px 0 0 0;border-color:#CCC;width:500px;">
						<legend class="tit S_txt1" style="margin:0 0 -10px 0;line-height:20px;font-size:1.2em;">Basic information</legend>
						<div class="btn btn-small" style="float:right;margin-top:-12px;border-radius:10px;" id="edit_btn">
							<a href="javascript:void(0)" action-type="edit" node-type="edit" action-data="edit=0">Edit</a>
						</div>
						<div class="btn btn-small" style="float:right;margin-top:-12px;border-radius:10px;display:none" id="cancel_btn">
							<a href="javascript:void(0)" action-type="edit" node-type="edit" action-data="edit=0">Cancel</a>
						</div>
					</fieldset>
				</form>
				<div class="base_view" id="base_view">
					<div class="pf_item clearfix">
						<div class="label_hsy"><i class="icon-envelope"></i>&nbsp;Email</div>
						<!-- This could not be modified -->
						<div class="con">
							${user.email}
						</div>
					</div>
					<div class="pf_item clearfix">
						<div class="label_hsy"><i class="icon-user"></i>&nbsp;User name</div>
						<div class="con">${user.userName}</div>
					</div>
					<div class="pf_item clearfix">
						<div class="label_hsy"><i class="icon-home"></i>&nbsp;Living in</div>
						<div class="con">${user.location}</div>
					</div>
					<div class="pf_item clearfix">
						<div class="label_hsy"><i class="icon-leaf"></i>&nbsp;Gender</div>
						<c:if test="${!empty (user.gender)}">
							<div class="con">${user.gender}</div>
						</c:if>
					</div>
					<div class="pf_item clearfix">
						<div class="label_hsy"><i class="icon-heart"></i>&nbsp;Status</div>
						<c:if test="${!empty (user.status)}">
							<div class="con">${user.status}</div>
						</c:if>
					</div>
					<div class="pf_item clearfix">
						<div class="label_hsy"><i class="icon-star-empty"></i>&nbsp;Birthday</div>
						<div class="con">${user.birthday}</div>
					</div>
					<div class="pf_item clearfix">
						<div class="label_hsy"><i class="icon-tint"></i>&nbsp;Blood type</div>
						<div class="con">${user.blood}</div>
					</div>
				</div><!--base-view-->
				
				<jsp:include page="error-list.jsp" />
				<div class="base" id="base_edit" style="display:none;">
				  <form id="update_profile" name="update_profile" method="POST" action="updateProfile.do">
					<div class="pf_item clearfix">
						<div class="label_hsy"><i class="icon-envelope"></i>&nbsp;Email</div>
						<!-- This could not be modified -->
						<div class="con">
							${user.email}
							<!--a href="#" style="font-size:0.8em;">Modify password</a-->
						</div>
					</div>
					<div class="pf_item clearfix">
						<div class="label_hsy"><i class="icon-user"></i>&nbsp;User name</div>
						<div class="con">
							<input type="text" name="userName" id="c_username" value="${user.userName}" onkeyup="check_empty()">
						</div>
					</div>
					<div class="pf_item clearfix">
						<div class="label_hsy"><i class="icon-home"></i>&nbsp;Living in</div>
						<div class="con">
							<input type="text" name="location" value="${user.location}">
						</div>
					</div>
					<div class="pf_item clearfix">
						<div class="label_hsy"><i class="icon-leaf"></i>&nbsp;Gender</div>
						<div class="con">
							<label class="con_label" for="man_radio"><input type="radio" name="gender" id="man_radio" value="Male">&nbsp;Male</label>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<label class="con_label" for="woman_radio"><input type="radio" name="gender" id="woman_radio" value="Female">&nbsp;Female</label>
						</div>
					</div>
					<div class="pf_item clearfix">
						<div class="label_hsy"><i class="icon-heart"></i>&nbsp;Status</div>
						<div class="con">
							<select class="status" name="status">
								<option value=""></option>
								<option selected="1" value="Single">Single</option>
								<option value="In a relationship">In a relationship</option>
								<option value="Engaged">Engaged</option>
								<option value="Married">Married</option>
								<option value="Separated">Separated</option>
								<option value="Divorced">Divorced</option>
							</select>
						</div>
					</div>
					<div class="pf_item clearfix">
						<div class="label_hsy"><i class="icon-star-empty"></i>&nbsp;Birthday</div>
						<div class="con">
							<input type="text" id="popupDatepicker" name="birthday" value="${user.birthday}">
						</div>
					</div>
					<div class="pf_item clearfix">
						<div class="label_hsy"><i class="icon-tint"></i>&nbsp;Blood type</div>
						<div class="con">
							<select class="blood_type" name="blood">
								<option value="A" selected>A</option>
								<option value="B">B</option>
								<option value="AB">AB</option>
								<option value="O">O</option>
								<option value="Other">Other</option>
							</select>
						</div>
					</div>
					<div class="pf_item clearfix">
						<div class="con">
							<button class="btn btn-primary pull-right" name="submit_update" id="update_btn">Update</button>
						</div>
					</div>
				  </form>
				</div><!--base_edit-->
			</div>
		</div><!--infoblock-->
	  	<div class="clearfix"></div>
		</div>
      </div>
	  <jsp:include page="footer.jsp" />
    </div> <!-- /container -->

	<script src="./assets/js/bootstrap-select.js"></script>
	<script type="text/javascript">
		$(function() {
			$("#popupDatepicker").datepick({yearRange: '1900:2012'});
		});
		$('#self_avatar').tooltip();
		$("#edit_btn").click(function(){
				$("#edit_btn").toggle();
				$("#cancel_btn").toggle();
				$("#base_view").toggle();
				$("#base_edit").toggle();
		});
		$("#cancel_btn").click(function(){
				$("#cancel_btn").toggle();
				$("#edit_btn").toggle();
				$("#base_view").toggle();
				$("#base_edit").toggle();
		});
		$('.selectpicker').selectpicker();
	</script>
</body>
</html>
