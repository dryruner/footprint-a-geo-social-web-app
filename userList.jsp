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
        	  <li><a href="friend.do" class="right_bar"><i class="icon-user"></i>Friends</a></li>
			  <li><a href="statistic.do?email=${user.hashedEmail}" class="right_bar"><i class="icon-signal"></i>Statistics</a></li>
			  <li class="active"><a href="userList.do" class="right_bar"><i class="icon-search"></i>Users</a></li>
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
		<h3 style="display:inline;">All users&nbsp;&nbsp;&nbsp;</h3>
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
      </div>
	
	  <jsp:include page="footer.jsp" />
    </div> <!-- /container -->
	
    <!-- Placed at the end of the document so the pages load faster -->
	<script src="./assets/js/jquery.js"></script>
    <script src="./assets/js/bootstrap-dropdown.js"></script>
    <script src="./assets/js/bootstrap-button.js"></script>
	<script src="./assets/js/bootstrap-select.js"></script>
	<script type="text/javascript">
		$('.selectpicker').selectpicker();
	</script>
  </body>
</html>
    
