<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>‘subscribers’</title>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
</head>
<body>
<h1>Subscribe to our Newsletter</h1>
<?php
if (isset($_POST['Submit'])) 
{
	$FormErrorCount = 0;
	if (isset($_POST['SubName'])) {
		$SubscriberName = stripslashes($_POST['SubName']);
		$SubscriberName = trim($SubscriberName);
		if (strlen($SubscriberName) == 0) {
			echo "<p>You must include your name!</p>\n";
			++$FormErrorCount;
		}
	}
	else {
		echo "<p>Form submittal error (No 'SubName' field)!</p>\n";
		++$FormErrorCount;
	}
	if (isset($_POST['SubEmail'])) {
		$SubscriberEmail = stripslashes($_POST['SubEmail']);
		$SubscriberEmail = trim($SubscriberEmail);
		if (strlen($SubscriberEmail) == 0) {
			echo "<p>You must include your email address!</p>\n";
			++$FormErrorCount;
		}
	}
	else {
		echo "<p>Form submittal error (No 'SubEmail' field)!</p>\n";
		++$FormErrorCount;
	}
	if ($FormErrorCount==0)
	{
		$ShowForm = FALSE;
		include("inc_db_newsletter.php");
		if ($conn != FALSE){
			$TableName = "subscribers";
			$SubscriberDate = date("Y-m-d");
			$sql = "INSERT INTO $TableName " . "(name, email, subscribe_date) VALUES " . "('$SubscriberName', '$SubscriberEmail', '$SubscriberDate')";
			$qRes = @mysqli_query($conn, $sql);
			if ($qRes === FALSE)
				echo "<p>Unable to insert the values into the subscriber table.</p>" . "<p>Error code " . mysqli_errno($conn). ": " . mysqli_error($conn) . "</p>";
			else {
				$SubscriberID = mysqli_insert_id($conn);
				echo "<p>" . htmlentities($SubscriberName) . ", you are now subscribed to our newsletter.<br />";
				echo "Your subscriber ID is $SubscriberID.<br />";
				echo "Your email address is " . htmlentities($SubscriberEmail) . ".</p>";
				echo "<p><a href='". $_SERVER['PHP_SELF'] . "'> new subscriber</a></p>\n";
				echo "<p><a href='subscribersList.php'> see all subscibers</a></p>\n";
			}
			mysqli_close($conn);
		}
	}
	else
		$ShowForm = TRUE;
}
else {
	$ShowForm = TRUE;
	$SubscriberName = "";
	$SubscriberEmail = "";
}

if ($ShowForm) {
	?>
	<form action="<?echo $_SERVER['PHP_SELF']; ?>" method="POST">
	<p><strong>Your Name: </strong>
	<input type="text" name="SubName" value="<?php echo $SubscriberName; ?>" /></p>
	<p><strong>Your Email Address: </strong>
	<input type="text" name="SubEmail" value="<?php echo $SubscriberEmail; ?>" /></p>
	<p><input type="Submit" name="Submit" value="Submit"/></p>
	</form>
	<?php
	
}
?>
</body>
</html>
