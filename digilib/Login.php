<?php
session_start();
$_SESSION = array();
session_destroy();
?>
<!DOCTYPE html>
<html>
<head>
<title>Digital Library</title>
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
	</style>
</head>
<body>
<div class="content">
<h2>Digital Library</h2>
<h2>Register / Log In</h2>
<hr />
<h3>New Student Registration</h3>
<form method="post" action="Register.php" > 
<tr>
<td><p>Your First Name: <input type="text" name="first" /></p></td>
<td><p>Your Last Name: <input type="text" name="last" /></p></td>
<td><p>Your Phone Number: <input type="text" name="phone" /></p></td>
<td><p>Type (Student): <input type="text" name="type" /></p></td>
<td><p>Enter your e-mail address: <input type="text" name="email" /></p></td>
<td><p>Enter a password for your account: <input type="password" name="password" /></p></td>
<td><p>Confirm your password: <input type="password" name="password2" /></p></td>
<td><p><em>(Passwords are case-sensitive and must be at least 6 characters long)</em></p></td>
<input type="reset" name="reset" value="Reset Registration Form" />
<input type="submit" name="register" value="Register" />
</form>
<hr />
<h3>Returning Student Login</h3>
<form method="post" action="VerifyLogin.php" >
<td><p>Enter your e-mail address: <input type="text" name="email" /></p></td>
<td><p>Enter your password: <input type="password" name="password" /></p></td>
<td><p><em>(Passwords are case-sensitive and must be at least 6 characters long)</em></p></td>
<input type="reset" name="reset" value="Reset Login Form" />
<input type="submit" name="login" value="Log In" />
</form>
<hr />
</tr>
</div>
</body>
</html>
