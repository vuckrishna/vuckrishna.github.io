<?php
session_start();
$Body = "";
$errors = 0;
$InternID = 0;
/*
if (isset($_GET['internID']))
	$InternID = $_GET['internID']; */
if (isset($_SESSION['internID']))
	$InternID = $_SESSION['internID']; 
else {
	$Body .= "<p>You have not logged in or registered. Please return to the <a href='InternLogin.php'>Registration / Log In page</a>.</p>";
	++$errors;
}
if ($errors == 0) {
	if (isset($_GET['opportunityID']))
		$OpportunityID = $_GET['opportunityID'];
	else {
		$Body .= "<p>You have not selected an opportunity. Please return to the <a href='AvailableOpportunities.php?". SID . "'>Available Opportunities page</a>.</p>";
		++$errors;
	}
}

if ($errors == 0) {
	$conn = @mysqli_connect("localhost", "root",""); //mysql
	if ($conn == FALSE) {
		$Body .= "<p>Unable to connect to the database server. Error code " . mysqli_connect_errno() . ": " . mysqli_connect_error() . "</p>\n";
		++$errors;
	}
	else {
		$DBName = "internships";
		$result = @mysqli_select_db($conn, $DBName);
		if ($result == FALSE) {
			$Body .= "<p>Unable to select the database. Error code " . mysqli_errno($conn) . ": " . mysqli_error($conn) . "</p>\n";
			++$errors;
		}
	}
}

$DisplayDate = date("Y-m-d");
$DatabaseDate = date("Y-m-d H:i:s");
if ($errors == 0) {
	$TableName = "assigned_opportunities";
	$sql = "INSERT INTO $TableName (opportunityID, internID, date_selected) VALUES ($OpportunityID, $InternID, '$DatabaseDate')";
	$qRes = @mysqli_query($conn, $sql) ;
	if ($qRes == FALSE) {
		$Body .= "<p>Unable to execute the query. Error code " . mysqli_errno($conn) . ": " . mysqli_error($conn) . "</p>\n";
		++$errors;
	}
	else {
		$Body .= "<p>Your request for opportunity # " . " $OpportunityID has been entered on $DisplayDate.</p>\n";
	}
	mysqli_close($conn);
}

if ($InternID > 0)
	$Body .= "<p>Return to the <a href='AvailableOpportunities.php?". SID . "'>Available Opportunities</a> page.</p>\n";
else
	$Body .= "<p>Please <a href='InternLogin.php'>Register or Log In</a> to use this page.</p>\n";

if ($errors == 0)
	setcookie("LastRequestDate", urlencode($DisplayDate), time()+60*60*24*7); //, "/examples/internship/");
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Request opportunities</title>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
</head>
<body>
<h1>College Internship</h1>
<h2>Oportunity requested Registration</h2>
<?php
echo $Body;
?>
</body>
</html>
