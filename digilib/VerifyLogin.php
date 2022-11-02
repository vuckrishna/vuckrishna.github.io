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

<h2 style="text-color: white;">Digital Library</h2>

<?php
include('conn.php');

$TableName = "students"; // change table name 
if ($errors == 0) { // change the values
	$SQLstring = "SELECT studentID, first, last FROM $TableName" . " where email='" . stripslashes($_POST['email']) ."' and password_md5='" . md5(stripslashes($_POST['password'])) . "'";
	$qRes = @mysqli_query($conn, $SQLstring);
	if (mysqli_num_rows($qRes)==0) {
		echo "<p align='center'> <font color=white>The e-mail address/password " . " combination entered is not valid. </font>\n";
		++$errors;
	}
	else {
		$Row = mysqli_fetch_assoc($qRes);
		$StudentID = $Row['studentID']; // student id
		$StudentName = $Row['first'] . " " . $Row['last'];
		echo "<p align='center'> <font color=white>Welcome back, $StudentName!</font>\n";
		$_SESSION['studentID'] = $StudentID;
	}
}
if ($errors > 0) {
	echo "<p>Please use your browser's BACK button to return " . " to the form and fix the errors indicated.</p>\n";
}
if ($errors == 0) {
	echo "<form method='post' " . " action='AvailableBooks.php?" . SID . "'>\n"; // change values //////////////////////////////////////////////////////////////////////////////////////////////////////////
	echo "<input type='hidden' name='studentID' " . " value='$StudentID'>\n";
	echo "<input type='submit' name='submit' " . " value='View Available Books'>\n";
	echo "</form>\n"; 
	//echo "<p><a href='AvailableOpportunities.php?" . "internID=$InternID'>Available " . " Opportunities</a></p>\n";
}
?>
</div>
</body>
</html>
