
<?php
session_start();
$Body = "";
$errors = 0;
$email = "";
include('conn.php');

$TableName = "books"; // chamge table name

if ($errors == 0) {
	$title = stripslashes($_POST['title']);
	$author = stripslashes($_POST['author']); 
	$publisher = stripslashes($_POST['publisher']);
	$isbn = stripslashes($_POST['isbn']);
	$sql = "INSERT INTO $TableName " . " (title, author, publisher, isbn) " . " VALUES( '$title', '$author', '$publisher', '$isbn')"; // verify table name
	$qRes = @mysqli_query($conn, $sql);
	if ($qRes === FALSE) {
		$Body .= "<p align='center'> <font color=white >Unable to save your registration " . " information. Error code " . mysqli_errno($conn) . ": " . mysqli_error($conn) . "</font>\n";
		++$errors;
	}
	else {
		$BookID = mysqli_insert_id($conn);
		$_SESSION['bookID'] = $BookID; // student id
	}
	mysqli_close($conn);
}
if ($errors == 0) {
	$Body .= "<p align='center'> <font color=white >Your have added bookID <strong>" . $_SESSION['bookID'] . "</strong>.</font>\n"; // student id
}

if ($errors == 0) {
	$Body .= "<form method='post' " . 	" action='StaffPage.php?PHPSESSID=" . session_id() . "'>\n"; 
	$Body .= "<input type='submit' name='submit' " . " value='View Available Books'>\n";
	$Body .= "</form>\n";
}
?>
<!DOCTYPE html>
<html>
<head>
<title>Insert New Books</title>
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
<h2>Newly arrived books collection</h2>
<?php
echo $Body;
?>
</div>
</body>
</html>
