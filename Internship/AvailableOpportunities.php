<?php
session_start();
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Available opportunities</title>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
</head>
<body>

<h1>College Internship</h1>
<h2>Available Opportunities</h2>

<?php

/*
if (isset($_SESSION['internID']))
	$InternID = $_SESSION['internID'] ;
else	
	$InternID = −1;
*/
/*
if (isset($_GET['internID']))
	$InternID = $_GET['internID'];
else
		$InternID = −1;
*/
/*
if (isset($_REQUEST['internID']))
	$InternID = $_REQUEST['internID'];
else
		$InternID = −1;
*/

if (isset($_COOKIE['LastRequestDate']))
	$LastRequestDate = $_COOKIE['LastRequestDate'];
else
	$LastRequestDate = "";

$errors = 0;
$conn = @mysqli_connect("localhost", "root", ""); //mysql
if ($conn == FALSE) {
	echo "<p>Unable to connect to the database server. " . "Error code " . mysqli_connect_errno() . ": " .	mysqli_connect_error() . "</p>\n";
	++$errors;
}
else {
	$DBName = "internships";
	$result = @mysqli_select_db($conn, $DBName);
	if ($result == FALSE) {
		echo "<p>Unable to select the database. " . "Error code " . mysqli_errno($conn) . ": " . mysqli_error($conn) . "</p>\n";
		++$errors;
	}
}

$TableName = "interns";
if ($errors == 0) {
	$sql = "SELECT * FROM $TableName WHERE internID='" . $_SESSION['internID'] . "'";
	$qRes = @mysqli_query($conn, $sql);
	if ($qRes == FALSE) {
		echo "<p>Unable to execute the query. " . "Error code " . mysqli_errno($conn) . ": " . mysqli_error($conn) . "</p>\n";
		++$errors;
	}
	else {
		if (mysqli_num_rows($qRes) == 0) {
			echo "<p>Invalid Intern ID!</p>";
			++$errors;
		}
	}
}

if ($errors == 0) {
	$Row = mysqli_fetch_assoc($qRes);
	$InternName = $Row['first'] . " " . $Row['last'];
} else
	$InternName = "";

$TableName = "assigned_opportunities";
$ApprovedOpportunities = 0;
$sql = "SELECT COUNT(opportunityID) FROM $TableName WHERE internID='" . $_SESSION['internID'] . "' AND date_approved IS NOT NULL";
$qRes = @mysqli_query($conn, $sql);
if (mysqli_num_rows($qRes) > 0) {
	$Row = mysqli_fetch_row($qRes);
	$ApprovedOpportunities = $Row[0];
	mysqli_free_result($qRes);
	}
	
$SelectedOpportunities = array();
$sql = "SELECT opportunityID FROM $TableName WHERE internID='" . $_SESSION['internID'] . "'";
$qRes = @mysqli_query($conn, $sql);
if (mysqli_num_rows($qRes) > 0) {
	while (($Row = mysqli_fetch_row($qRes))!= FALSE)
		$SelectedOpportunities[] = $Row[0];
	mysqli_free_result($qRes);
}

$AssignedOpportunities = array();
$sql = "SELECT opportunityID FROM $TableName WHERE date_approved IS NOT NULL";
$qRes = @mysqli_query($conn, $sql);
if (mysqli_num_rows($qRes) > 0) {
	while (($Row = mysqli_fetch_row($qRes))!= FALSE)
		$AssignedOpportunities[] = $Row[0];
	mysqli_free_result($qRes);
}

$TableName = "opportunities";
$Opportunities = array();
$sql = "SELECT opportunityID, company, city, start_date, end_date, position, description FROM $TableName";
$qRes = @mysqli_query($conn, $sql);
if (mysqli_num_rows($qRes) > 0) {
	while (($Row = mysqli_fetch_assoc($qRes))!= FALSE)
		$Opportunities[] = $Row;
	mysqli_free_result($qRes);
}
mysqli_close($conn);

if (!empty($LastRequestDate))
	echo "<p>You last requested an internship opportunity on " . $LastRequestDate . ".</p>\n";

echo "<table border='1' width='100%'>\n";
echo "<tr>\n";
echo " <th style='background-color:cyan'>Company</th>\n";
echo " <th style='background-color:cyan'>City</th>\n";
echo " <th style='background-color:cyan'>StartDate</th>\n";
echo " <th style='background-color:cyan'>EndDate</th>\n";
echo " <th style='background-color:cyan'>Position</th>\n";
echo " <th style='background-color:cyan'>Description</th>\n";
echo " <th style='background-color:cyan'>Status</th>\n";
echo "</tr>\n";
foreach ($Opportunities as $Opportunity) {
	if (!in_array($Opportunity['opportunityID'], $AssignedOpportunities)) {
		echo "<tr>\n";
		echo " <td>" . htmlentities($Opportunity['company']) . "</td>\n";
		echo " <td>" . htmlentities($Opportunity['city']) . "</td>\n";
		echo " <td>" . htmlentities($Opportunity['start_date']) . "</td>\n";
		echo " <td>" . htmlentities($Opportunity['end_date']) . "</td>\n";
		echo " <td>" . htmlentities($Opportunity['position']) . "</td>\n";
		echo " <td>" . htmlentities($Opportunity['description']) . "</td>\n";
		echo " <td>";
		if (in_array($Opportunity['opportunityID'], $SelectedOpportunities))
			echo "Selected";
		else {
			if ($ApprovedOpportunities>0)
				echo "Open";
			else
				//echo "<a href='RequestOpportunity.php?" . "internID=$InternID&" . "opportunityID=" . $Opportunity['opportunityID'] . "'>Available</a>";
				echo "<a href='RequestOpportunity.php?" . SID . "&opportunityID=" . $Opportunity['opportunityID'] . "'>Available</a>";
		}
		echo "</td>\n";
		echo "</tr>\n";
	}
}

echo "</table>\n";
echo "<p><a href='InternLogin.php'>Log Out</a></p>\n";
?>
</body>
</html>
