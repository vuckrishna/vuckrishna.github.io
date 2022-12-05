<?php
session_start();
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>verify login</title>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
</head>
<body>
<h1>College Internship</h1>
<h2>Verify Intern Login</h2>

<?php
$errors = 0;
$DBName = "internships";
//$conn = @mysqli_connect ("localhost", "root", "mysql",$DBName );
$conn = @mysqli_connect("localhost", "root", "",$DBName );
if ($conn == FALSE) {
	echo "<p>Unable to connect to the database server. " . "Error code " . mysqli_connect_errno() . ": " . mysqli_connect_error() . "</p>\n";
	++$errors;
}

$TableName = "interns";
if ($errors == 0) {
	$SQLstring = "SELECT internID, first, last FROM $TableName" . " where email='" . stripslashes($_POST['email']) ."' and password_md5='" . md5(stripslashes($_POST['password'])) . "'";
	$qRes = @mysqli_query($conn, $SQLstring);
	if (mysqli_num_rows($qRes)==0) {
		echo "<p>The e-mail address/password " . " combination entered is not valid. </p>\n";
		++$errors;
	}
	else {
		$Row = mysqli_fetch_assoc($qRes);
		$InternID = $Row['internID'];
		$InternName = $Row['first'] . " " . $Row['last'];
		echo "<p>Welcome back, $InternName!</p>\n";
		$_SESSION['internID'] = $InternID;
	}
}
if ($errors > 0) {
	echo "<p>Please use your browser's BACK button to return " . " to the form and fix the errors indicated.</p>\n";
}
if ($errors == 0) {
	echo "<form method='post' " . " action='AvailableOpportunities.php?" . SID . "'>\n";
	echo "<input type='hidden' name='internID' " . " value='$InternID'>\n";
	echo "<input type='submit' name='submit' " . " value='View Available Opportunities'>\n";
	echo "</form>\n"; 
	//echo "<p><a href='AvailableOpportunities.php?" . "internID=$InternID'>Available " . " Opportunities</a></p>\n";
}
?>
</body>
</html>
