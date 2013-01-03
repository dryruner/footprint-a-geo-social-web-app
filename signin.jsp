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
	<script type="text/javascript">
		function check_email(str)
		{
			if(str.trim().length == 0)
			{
				document.getElementById("emailTip").innerHTML = " <img src='./assets/img/error.png'></img><font color='#c33'> Email is required!</font>";
				document.getElementById("email").focus();
			}
			else{
				var email_regex = /^(\w+)@\w+\.([\w\.]+)$/;
				if(!email_regex.test(str.trim()))
				{   
					document.getElementById("emailTip").innerHTML = " <img src='./assets/img/error.png'></img><font color='#c33'> Not a valid email!</font>";
					document.getElementById("email").focus();
				}   
				else{
					document.getElementById("emailTip").innerHTML = " <img src='./assets/img/accept.png'></img>";
				}
			}
		}
		function check_password(str)
		{
			if(str.length < 6)
			{
				document.getElementById("passwordTip").innerHTML = " <img src='./assets/img/error.png'></img><font color='#c33'> At least 6 characters!</font>";
				document.getElementById("password").focus();
			}
			else
				document.getElementById("passwordTip").innerHTML = " <img src='./assets/img/accept.png'></img>";
		}
	</script>
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
              <li><a href="signup.html">Sign up </a></li>
            </ul>
          </div>
        </div>
      </div>
    </div-->

    <div class="container">
    	<h2 class="form-signin-heading" align="center">Please sign in</h2>
		<form class="form-signin" method = "post" action = "login.do">
		  <jsp:include page="error-list.jsp" />
		  <input type="text" class="input-block-level" placeholder="Email address" id="email" onchange="check_email(this.value)" name="email"><span id="emailTip"></span>
		  <input type="password" class="input-block-level" placeholder="Password"id="password" onchange="check_password(this.value)" name="password" ><span id="passwordTip"></span>
		  <p></p>
          <button class="btn btn-primary" type="submit">Sign in</button>
		  <a href="index.do" class="btn btn-primary">cancel</a>
		</form>
    </div> <!-- /container -->

    <!-- Placed at the end of the document so the pages load faster -->
    <script src="./assets/js/jquery.js"></script>
	<!--script src="../assets/js/bootstrap-transition.js"></script>
    <script src="../assets/js/bootstrap-alert.js"></script>
    <script src="../assets/js/bootstrap-modal.js"></script>
    <script src="../assets/js/bootstrap-dropdown.js"></script>
    <script src="../assets/js/bootstrap-scrollspy.js"></script>
    <script src="../assets/js/bootstrap-tab.js"></script>
    <script src="../assets/js/bootstrap-tooltip.js"></script>
    <script src="../assets/js/bootstrap-popover.js"></script>
    <script src="../assets/js/bootstrap-button.js"></script>
    <script src="../assets/js/bootstrap-collapse.js"></script>
    <script src="../assets/js/bootstrap-carousel.js"></script>
    <script src="../assets/js/bootstrap-typeahead.js"></script-->

  </body>
</html>
