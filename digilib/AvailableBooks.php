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

<h2>Digital Library</h2>
<h2>Available Books</h2>

<?php
include('conn.php');

if (isset($_COOKIE['LastRequestDate']))
	$LastRequestDate = $_COOKIE['LastRequestDate'];
else
	$LastRequestDate = "";

$TableName = "students"; // student
if ($errors == 0) {
	$sql = "SELECT * FROM $TableName WHERE studentID='" . $_SESSION['studentID'] . "'"; // studentID
	$qRes = @mysqli_query($conn, $sql);
	if ($qRes == FALSE) {
		echo "<p>Unable to execute the query. " . "Error code " . mysqli_errno($conn) . ": " . mysqli_error($conn) . "</p>\n";
		++$errors;
	}
	else {
		if (mysqli_num_rows($qRes) == 0) {
			echo "<p>Invalid Student ID!</p>"; // Invalid student ID
			++$errors;
		}
	}
}

if ($errors == 0) {
	$Row = mysqli_fetch_assoc($qRes);
	$StudentName = $Row['first'] . " " . $Row['last']; // student name
} else
	$StudentName = ""; // student name

$TableName = "assigned_books"; // the books requested by other person
$ApprovedBooks = 0; // borowwed books
$sql = "SELECT COUNT(bookID) FROM $TableName WHERE studentID='" . $_SESSION['studentID'] . "' AND date_approved IS NOT NULL"; //book id and student id
$qRes = @mysqli_query($conn, $sql);
if (mysqli_num_rows($qRes) > 0) {
	$Row = mysqli_fetch_row($qRes);
	$ApprovedBooks = $Row[0]; // borrowwed books
	mysqli_free_result($qRes);
	}
	
$SelectedBooks = array(); // requested books
$sql = "SELECT bookID FROM $TableName WHERE studentID='" . $_SESSION['studentID'] . "'"; // book id and student id
$qRes = @mysqli_query($conn, $sql);
if (mysqli_num_rows($qRes) > 0) {
	while (($Row = mysqli_fetch_row($qRes))!= FALSE)
		$SelectedBooks[] = $Row[0]; // requested books
	mysqli_free_result($qRes);
}

$AssignedBooks = array(); // assigning books to the user that they have requested.
$sql = "SELECT bookID FROM $TableName WHERE date_approved IS NOT NULL"; // book id and student id
$qRes = @mysqli_query($conn, $sql);
if (mysqli_num_rows($qRes) > 0) {
	while (($Row = mysqli_fetch_row($qRes))!= FALSE)
		$AssignedBooks[] = $Row[0]; // approved books
	mysqli_free_result($qRes);
}

$TableName = "books"; // available books database
$Books = array(); // available books 
$sql = "SELECT bookID, isbn, title, author, publisher FROM $TableName"; // books information
$qRes = @mysqli_query($conn, $sql);
if (mysqli_num_rows($qRes) > 0) {
	while (($Row = mysqli_fetch_assoc($qRes))!= FALSE)
		$Books[] = $Row; // books
	mysqli_free_result($qRes);
}
mysqli_close($conn);

if (!empty($LastRequestDate))
	echo "<p align='center'> <font color=white >You last requested an book on " . $LastRequestDate . ".</font>\n";

echo "<table border='1' width='100%'>\n";
echo "<tr>\n";
echo " <th style='background-color:cyan'>Title</th>\n"; // change the elements to book information
echo " <th style='background-color:cyan'>Author</th>\n";
echo " <th style='background-color:cyan'>Publisher</th>\n";
echo " <th style='background-color:cyan'>ISBN</th>\n";
echo " <th style='background-color:cyan'>Status</th>\n";
echo "</tr>\n";
foreach ($Books as $Book) { //books
	if (!in_array($Book['bookID'], $AssignedBooks)) { // to assign books
		echo "<tr>\n";
		echo " <td align='center'> <font color=white>" . htmlentities($Book['title']) . "</font></td>\n"; // chnage the elements to book information
		echo " <td align='center'> <font color=white>" . htmlentities($Book['author']) . "</font></td>\n";
		echo " <td align='center'> <font color=white>" . htmlentities($Book['publisher']) . "</font></td>\n";
		echo " <td align='center'> <font color=white>" . htmlentities($Book['isbn']) . "</font></td>\n";
		echo " <td align='center'> <font color=white>";
		if (in_array($Book['bookID'], $SelectedBooks)) // tell the user that the book is been requested or borrowed
			echo "Borrowed";
		else {
			if ($ApprovedBooks>0) //already taken books
				echo "Open";
			else
				//echo "<a href='RequestOpportunity.php?" . "internID=$InternID&" . "opportunityID=" . $Opportunity['opportunityID'] . "'>Available</a>";
				echo "<a href='RequestBooks.php?" . SID . "&bookID=" . $Book['bookID'] . "&title=" . $Book['title'] . "'>Available</a>"; // //////////////////////////////////////////////////////////////////////////////////////////////////
		}
		echo "</td>\n";
		echo "</tr>\n";
	}
}

echo "</table>\n";
echo "<p><a href='a3form.php'>Log Out</a></p>\n"; // //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
?>
</div>
</body>
</html>
