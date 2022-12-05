<?php
$DBName = "newsletter";
$conn = @mysqli_connect("localhost", "root", "");
if ($conn ===FALSE)
	echo "<p>Connection error: " . mysqli_connect_error() . "</p>\n";
else {
	if (@mysqli_select_db($conn, $DBName) === FALSE) {
		echo "<p>Could not select the \"$DBName\" " . "database: " . mysqli_error($conn) . "</p>\n";
		mysqli_close($conn);
		$conn = FALSE;
	}
}
?>
