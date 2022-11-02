<?php
session_start();
$_SESSION = array();
session_destroy();
?>
<!DOCTYPE html>
<html>
<head>
<title>LogIn/REGISTER</title>
<style>
	<style>
	<style>
	h1 {text-align: center;}
	h2 {text-align: center;}
	h3 {text-align: center;}
	p {text-align: center; text-color: white;}
	form {text-align: center;}
	th {text-align: center;}	
	.content {
	max-width: 700px;
	margin: auto;
	color: white;
	padding: 70px 0;
	}
	body {
	background-color: #DC143C;
	font-family: "Monaco", monospace;
	}
	a {
	color: white;
	}
	</style></head>
<body>
<div class="content">

<h2>Digital Library Staff</h2>
<h2>Register / Log In</h2>
<hr />
<h3>New Staff Registration</h3>
<form method="post" action="StaffRegister.php" > 
<tr>
<td><p>Your First Name: <input type="text" name="first" /></p></td>
<td><p>Your Last Name: <input type="text" name="last" /></p></td>
<td><p>Your Phone Number: <input type="text" name="phone" /></p></td>
<td><p>Type (Staff-Librarian): <input type="text" name="type" /></p></td>
<td><p>Enter your e-mail address: <input type="text" name="email" /></p></td>
<td><p>Enter a password for your account: <input type="password" name="password" /></p></td>
<td><p>Confirm your password: <input type="password" name="password2" /></p></td>
<td><p><em>(Passwords are case-sensitive and must be at least 6 characters long)</em></p></td>
<p><em>(Passwords are case-sensitive and must be at least 6 characters long)</em></p>
<input type="reset" name="reset" value="Reset Registration Form" />
<input type="submit" name="register" value="Register" />
</form>
<hr />
<h3>Returning Student Login</h3>
<form method="post" action="StaffVerifyLogin.php" >
<p>Enter your e-mail address: <input type="text" name="email" /></p>
<p>Enter your password: <input type="password" name="password" /></p>
<p><em>(Passwords are case-sensitive and must be at least 6 characters long)</em></p>
<input type="reset" name="reset" value="Reset Login Form" />
<input type="submit" name="login" value="Log In" />
</form>
<hr />
</tr>
</div>
</body>
</html>
