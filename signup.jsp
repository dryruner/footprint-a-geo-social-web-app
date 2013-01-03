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
        padding-top: 100px;
      	padding-bottom: 40px;
      }
	</style>
	<link href="./assets/css/form.css" rel="stylesheet">
    <link href="./assets/css/bootstrap-responsive.css" rel="stylesheet">
  </head>

  <body>

    <!--div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="brand" href="user_profile.html">Footprint</a>
		      <form class="navbar-search pull-left">
		  	    <div class="input-append">
			     	  <input type="text" class="span4" id="appendedInputButton" placeholder="Find something you like..." style="border:1px #CCC;border-radius:10px 0 0 10px;">
				      <button class="btn" type="button" style="border:1px #CCC;border-radius:0 10px 10px 0;">
              <i class="icon-search"></i></button>
		      	</div>
		      </form>
		  <div class="nav-collapse collapse">
            <ul class="nav pull-right">
              <li><a href="signin.html">Sign in </a></li>
            </ul>
          </div>
        </div>
      </div>
    </div-->

    <h2 class="form-signin-heading" align="center">Join us on FootPrint!</h2><br/><br/>
    <div class="container">
      <!--div class="hero-unit"-->
		<form class="form-signin" method="post" action="register.do">
		  <jsp:include page="error-list.jsp" />
		  <input type="text" class="input-block-level" id="username" placeholder="Username/Nickname" onchange="check_name(this.value)" name="userName" ><span id="usernameTip"></span>
		  <input type="text" class="input-block-level" placeholder="Where you're living..." id="placename" onchange="check_place(this.value)" name="location" ><span id="placenameTip"></span>
		  <input type="text" class="input-block-level" placeholder="Email address" id="email" onchange="check_email(this.value)" name="email" ><span id="emailTip"></span>
		  <input type="text" class="input-block-level" placeholder="Confirm Email address" id="email_c" onchange="check_confirm(this.parentNode.email.value, this.value, 'e')" name="confirmEmail" ><span id="email_c_Tip"></span>
		  <input type="password" class="input-block-level" placeholder="Password" id="password" onchange="check_password(this.value)"  name="password" ><span id="passwordTip"></span>
		  <input type="password" class="input-block-level" placeholder="Confirm Password" id="password_c" onchange="check_confirm(this.parentNode.password.value, this.value, 'p')" name="confirmPassword" ><span id="password_c_Tip"></span>
		  <br/>
          <button name="signup" class="btn btn-primary" type="submit">Sign up</button>
		  <a href="index.do" class="btn btn-primary">cancel</a>
		</form>
		
		 
      <!--/div>
      <footer>
        <p>&copy; Footprint 2012</p>
      </footer-->
    </div> <!-- /container -->

    <!-- Placed at the end of the document so the pages load faster -->
    <script src="./assets/js/jquery.js"></script>
    <script src="./assets/js/form_validate.js"></script>
	</body>
</html>
