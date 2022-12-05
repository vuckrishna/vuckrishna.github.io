<?php
session_start();
$Body = "";
$errors = 0;
$email = "";
include('conn.php');

if (empty($_POST['email'])) {
	++$errors;
	$Body .= "<p>You need to enter an e-mail address.</p>\n";
	}
else {
	$email = stripslashes($_POST['email']);
	if (preg_match("/^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,3})$/i", $email) == 0) {
		
		++$errors;
		$Body .= "<p>You need to enter a valid " . "e-mail address.</p>\n";
		$email = "";
	}
}

if (empty($_POST['password'])) {
	++$errors;
	$Body .= "<p>You need to enter a password.</p>\n"; 
	$password = "";
}
else
	$password = stripslashes($_POST['password']);

if (empty($_POST['password2'])) {
	++$errors;
	$Body .= "<p>You need to enter a confirmation password.</p>\n";
	$password2 = "";
}
else
	$password2 = stripslashes($_POST['password2']);

if ((!(empty($password))) && (!(empty($password2)))) {
	if (strlen($password) < 6) {
		++$errors;
		$Body .= "<p>The password is too short.</p>\n";
		$password = "";
		$password2 = "";
	}
	if ($password <> $password2) {
		++$errors;
		$Body .= "<p>The passwords do not match.</p>\n";
		$password = "";
		$password2 = "";
	}
}

$TableName = "students"; // chamge table name
if ($errors == 0) {
	$sql = "SELECT count(*) FROM $TableName" . " where email='" . $email . "'";
	$qRes = @mysqli_query($conn, $sql);
	if ($qRes != FALSE) {
		$Row = mysqli_fetch_row($qRes);
		if ($Row[0]>0) {
			$Body .= "<p>The email address entered (" . htmlentities($email) . ") is already registered.</p>\n";
			++$errors;
		}
	}
}
if ($errors > 0) {	
	$Body .= "<p align='center'> <font color=white >>Please use your browser's BACK button to return" . " to the form and fix the errors indicated.</font>\n"; // change messages
}

if ($errors == 0) {
	$first = stripslashes($_POST['first']);
	$last = stripslashes($_POST['last']); 
	$phone = stripslashes($_POST['phone']);
	$type = stripslashes($_POST['type']);
	$sql = "INSERT INTO $TableName " . " (first, last, phone, type, email, password_md5) " . " VALUES( '$first', '$last', '$phone', '$type', '$email', " . " '" . md5($password) . "')"; // verify table name
	$qRes = @mysqli_query($conn, $sql);
	if ($qRes === FALSE) {
		$Body .= "<p>Unable to save your registration " . " information. Error code " . mysqli_errno($conn) . ": " . mysqli_error($conn) . "</p>\n";
		++$errors;
	}
	else {
		$StudentID = mysqli_insert_id($conn);
		$_SESSION['studentID'] = $StudentID; // student id
	}
	mysqli_close($conn);
}
if ($errors == 0) {
	$StudentName = $first . " " . $last;
	$Body .= "<p>Thank you, $StudentName. ";
	$Body .= "Your new Student ID is <strong>" . $_SESSION['studentID'] . "</strong>.</p>\n"; // student id	
}

if ($errors == 0) {
	$Body .= "<form method='post' " . 	" action='AvailableBooks.php?PHPSESSID=" . session_id() . "'>\n"; // ////////////////////////////////////////////////////////////////////////////////////////////
	$Body .= "<input type='submit' name='submit' " . " value='View Available Books'>\n";
	$Body .= "</form>\n";
}
?>
<!DOCTYPE html>
<html>
<head>
<title>LogIn/REGISTER</title>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
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
	</style>
</head>
<body>
		<div class="content">

<h2>Digital Library</h2>
<h2>Student Registration</h2>
<?php
echo $Body;
?>
</div>
</body>
</html>
