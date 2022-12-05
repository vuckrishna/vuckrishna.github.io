<?php
$errors = 0;
$DBName = "library"; //internships
//$conn = @mysqli_connect ("localhost", "root", "mysql",$DBName );
$conn = @mysqli_connect("localhost", "root", "",$DBName );
if ($conn == FALSE) {
	echo "<p>Unable to connect to the database server. " . "Error code " . mysqli_connect_errno() . ": " . mysqli_connect_error() . "</p>\n";
	++$errors;
}
?>