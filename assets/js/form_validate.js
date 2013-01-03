function check_name(str){
	if(str.trim().length == 0)
	{
		document.getElementById("usernameTip").innerHTML = " <img src='./assets/img/error.png'></img><font color='#c33'> Username required!</font>";
	}
	else
	{
		document.getElementById("usernameTip").innerHTML = " <img src='./assets/img/accept.png'></img>";
	}
}

function check_place(str){
	if(str.trim().length == 0)
	{
		document.getElementById("placenameTip").innerHTML = " <img src='./assets/img/error.png'></img><font color='#c33'> Living place required!</font>";
	}
	else
	{
		document.getElementById("placenameTip").innerHTML = " <img src='./assets/img/accept.png'></img>";
	}
}

function check_email(str){
	var email_regex = /^(\w+)@\w+\.([\w\.]+)$/;
	if(email_regex.test(str.trim()))
	{
		document.getElementById("emailTip").innerHTML = " <img src='./assets/img/accept.png'></img>";
	}
	else
	{
		document.getElementById("emailTip").innerHTML = " <img src='./assets/img/error.png'></img><font color='#c33'> Invalid email!</font>";
	}
}

function check_password(str){
	if(str.length < 6)
	{
		document.getElementById("passwordTip").innerHTML = " <img src='./assets/img/error.png'></img><font color='#c33'> At least 6 characters!</font>";
	}
	else
	{
		document.getElementById("passwordTip").innerHTML = " <img src='./assets/img/accept.png'></img>";
	}
}

function check_confirm(pass_1, pass_2, type){
	if(type == 'p')
	{
		if(pass_1 != pass_2)
		{
			document.getElementById("password_c_Tip").innerHTML = " <img src='./assets/img/error.png'></img><font color='#c33'> Password differs!</font>";
		}
		else
		{
			document.getElementById("password_c_Tip").innerHTML = " <img src='./assets/img/accept.png'></img>";
		}
	}
	else if(type == 'e')
	{
		if(pass_1 != pass_2)
		{
			document.getElementById("email_c_Tip").innerHTML = " <img src='./assets/img/error.png'></img><font color='#c33'> Email differs!</font>";
		}
		else
		{
			document.getElementById("email_c_Tip").innerHTML = " <img src='./assets/img/accept.png'></img>";
		}
	}
}
