<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Create 'subscribers' Table</title>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
</head>
<body>
<?php
$TableName = "subscribers";
include("inc_db_newsletter.php");

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
else
{
	$SQLstring = "SHOW TABLES LIKE '$TableName'";
	$QueryResult = @mysqli_query($conn, $SQLstring);
	if (mysqli_num_rows($QueryResult) == 0) {
		$SQLstring = "CREATE TABLE subscribers (subscriberID SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
						name VARCHAR(80), email VARCHAR(100), subscribe_date DATE, confirmed_date DATE)";
		$QueryResult = @mysqli_query($conn, $SQLstring);
		if ($QueryResult === FALSE)
			echo "<p>Unable to create the subscribers table.</p>" . "<p>Error code " . mysql_errno($conn) . ": " . mysql_error($conn) . "</p>";
		else
			echo "<p>Successfully created the " . "subscribers table.</p>";
	}
	else
		echo "<p>The subscribers table already exists.</p>";
}

//delete table
/*
$SQLstring = "DROP TABLE $TableName";
$QueryResult = @mysqli_query($conn, $SQLstring);
if ($QueryResult === FALSE)
	echo "<p>Unable to execute the query.</p>" . "<p>Error code " . mysqli_errno($conn) . ": " . mysqli_error($conn) . "</p>";
else
	echo "<p>Successfully deleted the table.</p>";
*/

mysqli_close($conn);
?>
</body>
</html>
