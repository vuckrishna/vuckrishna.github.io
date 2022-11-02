<?php
session_start();
?>
<!DOCTYPE html>
<html>
<head>
<title>Available Books</title>
<style>
	<style>
	h1 {text-align: center;}
	h2 {text-align: center;}
	h3 {text-align: center;}
	p {text-align: center; text-color: white;}
	form {text-align: center;}
	th {text-align: center;}	
	.content {
	max-width: 1000px;
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

<h3>New Books Arrival registration</h3>
<form method="post" action="InsertBooks.php" > 
<p>Enter the Book name: </p>
<p>Title: <input type="text" name="title" /></p>
<p>ISBN: <input type="text" name="isbn" /></p>
<p>Author: <input type="text" name="author" /></p>
<p>Publisher: <input type="text" name="publisher" /></p>
<input type="reset" name="reset" value="Reset Registration Form" />
<input type="submit" name="register" value="Register" />
</form>
<br>
<br>


<?php
include('conn.php');

echo "<p><a href='a3form.php'>Log Out</a></p>\n"; 
echo "<br>";

if (isset($_COOKIE['LastRequestDate']))
	$LastRequestDate = $_COOKIE['LastRequestDate'];
else
	$LastRequestDate = "";

echo "<h2>Available Books</h2>";

$dbtable="books";
$sql = "SELECT bookID, isbn, title, author, publisher FROM $dbtable";
$result = $conn->query($sql);

if ($result->num_rows > 0)
{
	while ($row=$result->fetch_assoc())
	{
		echo "BookId:" . $row["bookID"] . ",  Title:" . $row["title"] . ",  Author:" . $row["author"] . ",  Publisher:" . $row["publisher"] . ",  ISBN:" . $row["isbn"] . "<br>";
		echo "<br>";
	}
}
else
{ echo "no record","<br>"; }


echo "<h2> Borrowed Books </h2>";
$dbtable="assigned_books";
$sql = "SELECT bookID, title, studentID, date_selected, date_approved FROM $dbtable";
$result2 = $conn->query($sql);

if ($result2->num_rows > 0)
{
	while ($row=$result2->fetch_assoc())
	{
		echo "<br>";
		echo "BookId:" . $row["bookID"] . ",  Title:" . $row["title"] . ",  StudentID:" . $row["studentID"] ."<br>";
	}
}
else
{ echo "no record","<br>"; }


?>


</div>
</body>
</html>
