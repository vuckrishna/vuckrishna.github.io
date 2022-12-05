<?php
session_start();
?>
<!DOCTYPE html>
<html>
<head>
<title>verify login</title>
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

<h2>Digital Library</h2>

<?php
include('conn.php');

$TableName = "staff"; // change table name 
if ($errors == 0) { // change the values
	$SQLstring = "SELECT staffID, first, last FROM $TableName" . " where email='" . stripslashes($_POST['email']) ."' and password_md5='" . md5(stripslashes($_POST['password'])) . "'";
	$qRes = @mysqli_query($conn, $SQLstring);
	if (mysqli_num_rows($qRes)==0) {
		echo "<p align='center'> <font color=white >The e-mail address/password " . " combination entered is not valid. </font>\n";
		++$errors;
	}
	else {
		$Row = mysqli_fetch_assoc($qRes);
		$StaffID = $Row['staffID']; // student id
		$StaffName = $Row['first'] . " " . $Row['last'];
		echo "<p align='center'> <font color=white >Welcome back, $StaffName!</font>\n";
		$_SESSION['staffID'] = $StaffID;
	}
}
if ($errors > 0) {
	echo "<p align='center'> <font color=white >Please use your browser's BACK button to return " . " to the form and fix the errors indicated.</font>\n";
}
if ($errors == 0) {
	echo "<form method='post' " . " action='StaffPage.php?" . SID . "'>\n"; // change values //////////////////////////////////////////////////////////////////////////////////////////////////////////
	echo "<input type='hidden' name='staffID' " . " value='$StaffID'>\n";
	echo "<input type='submit' name='submit' " . " value='View Available Books'>\n";
	echo "</form>\n"; 
}
?>
</div>

</body>
</html>
