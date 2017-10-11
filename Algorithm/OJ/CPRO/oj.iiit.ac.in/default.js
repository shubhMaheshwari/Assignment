function validateReg()
{
	var valid = true;
	var emailchk = 	/^.+\@.+\..+$/;
	var form = document.account;
	document.getElementById("msg").innerHTML = "";
	if (document.account.passwd.value != document.account.passwd2.value)
	{
		document.getElementById("msg").innerHTML = "<h2>Mismatching password</h2>";
		valid = false;
	}
	else if(form.username.value.length < 1 || form.name.value.length < 1 || form.college.value.length < 1 || form.country.value.length < 1)
	{
		document.getElementById("msg").innerHTML = "<h2>Some Compulsory Entry is missing</h2>";
		valid = false;
	}
	else if(form.passwd.value.length<6)
	{
		document.getElementById("msg").innerHTML = "<h2>Minimum length for password is 6</h2>";
		valid = false;
	}
	else if(emailchk.test(form.email.value) == false)
	{
		document.getElementById("msg").innerHTML = "<h2>E-mail address doesn't seem to be correct, please re-check</h2>";
		valid = false;
	}
	return valid;
}
function validateSubmit()
{
	var valid = true;
	var form = document.submission;
	document.getElementById("msg").innerHTML = "";
	if(form.username.value.length < 1 || form.passwd.value.length < 1)
	{
		document.getElementById("msg").innerHTML = "<h2>Username/Password missing</h2>";
		valid = false;
	}
	return valid;
}
