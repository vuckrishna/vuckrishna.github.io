<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>subscribers Table</title>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
</head>
<body>
<h1>Newsletter subscribers</h1>
<?php
include("inc_db_newsletter.php");
$TableName = "subscribers";
if ($conn !== FALSE){
	$sql = "SELECT * FROM $TableName ORDER BY SubscriberID";
	$qRes = @mysqli_query($conn, $sql);
	if ($qRes !== FALSE)
	{
		echo "<table width='100%' border='1'>\n";
		echo "<tr><th>Subscriber ID</th>" .
			 "<th>Name</th><th>Email</th>" .
			 "<th>Subscribe Date</th>" .
			 "<th>Confirm Date</th></tr>\n";
		while (($Row = mysqli_fetch_assoc($qRes)) != FALSE) {
			echo "<tr><td>{$Row['subscriberID']}</td>";
			echo "<td>{$Row['name']}</td>";
			echo "<td>{$Row['email']}</td>";
			echo "<td>{$Row['subscribe_date']}</td>";
			echo "<td>{$Row['confirmed_date']}</td></tr>\n";
		};
		echo "</table>\n";

		echo "<p>Your query returned the above " . mysqli_num_rows($qRes) . " rows each with ". mysqli_num_fields($qRes) . " fields.</p>";
		mysqli_free_result($qRes);
		
		echo "<p><a href='subscribersAdd.php'> new subscriber</a></p>\n";
	}
	mysqli_close($conn);
}
else
	die("Connection failed: " . mysqli_connect_error());

?>
</body>
</html>