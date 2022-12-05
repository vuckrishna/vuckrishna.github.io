<?php
session_start();
$Body = "";
$errors = 0;
$StudentID = 0;
include('conn.php');


if (isset($_SESSION['studentID'])) // student id
	$StudentID = $_SESSION['studentID']; 
else {
	$Body .= "<p align='center'> <font color=white >You have not logged in or registered. Please return to the <a href='Login.php'>Registration / Log In page</a>.</font>"; // ////////////////////////////////////////////////////////////////////////
	++$errors;
}
if ($errors == 0) {
	if (isset($_GET['bookID']))
		$BookID = $_GET['bookID']; // book id
	else {
		$Body .= "<p align='center'> <font color=white >You have not selected an book. Please return to the <a href='AvailableBooks.php?". SID . "'>Available Books page</a>.</font>"; // //////////////////////////////////////////////////////////
		++$errors;
	}
}
if ($errors == 0) {
	if (isset($_GET['title']))
		$Title = $_GET['title']; // book id
	else {
		$Body .= "<p align='center'> <font color=white >You have not selected an book title. Please return to the <a href='AvailableBooks.php?". SID . "'>Available Books page</a>.</font>"; // //////////////////////////////////////////////////////////
		++$errors;
	}
}

$DisplayDate = date("Y-m-d");
$DatabaseDate = date("Y-m-d H:i:s");
if ($errors == 0) {
	$TableName = "assigned_books"; // assigned books
	$sql = "INSERT INTO $TableName (bookID, title, studentID, date_selected) VALUES ('$BookID', '$Title','$StudentID','$DatabaseDate')"; // values change
	$qRes = @mysqli_query($conn, $sql) ;
	if ($qRes == FALSE) {
		$Body .= "<p align='center'> <font color=white >Unable to execute the query. Error code " . mysqli_errno($conn) . ": " . mysqli_error($conn) . "</font>\n";
		++$errors;
	}
	else {
		$Body .= "<p align='center'> <font color=white >Your request for book # " . " $BookID has been entered on $DisplayDate.</font>\n";
	}
	mysqli_close($conn);
}

if ($StudentID > 0)
	$Body .= "<p align='center'> <font color=white >Return to the <a href='AvailableBooks.php?". SID . "'>Available Books</a> page.</font>\n"; // change page name // ///////////////////////////////////////////////////////////////////////////////////////////
else
	$Body .= "<p align='center'> <font color=white >Please <a href='Login.php'>Register or Log In</a> to use this page.</font>\n"; // /////////////////////////////////////////////////////////////////////////////////////////////////

if ($errors == 0)
	setcookie("LastRequestDate", urlencode($DisplayDate), time()+60*60*24*7); //, "/examples/internship/");
?>
<!DOCTYPE html>
<html>
<head>
<title>Request Books</title>
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

<h1>Digital Library</h1>
<h2>Books requested to Borrow</h2>
<?php
echo $Body;
?>
</div>
</body>
</html>
