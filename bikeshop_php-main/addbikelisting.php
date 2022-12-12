<?php
  include 'classes/bikelisting.php';

  define('CSS_PATH', 'css/'); //define bootstrap css path
  define('IMG_PATH','./img/'); //define img path
  $main_css = 'main.css'; // main css filename
  $flex_css = 'flex.css'; // flex css filename

  define('DB_ExpInterest', 'database/ExpInterest.txt'); //filepath to expinterest.txt
  define('DB_BikesforSale', 'database/BikesforSale.txt'); //filepath to expinterest.txt
?>

<!DOCTYPE HTML>  
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Takoko - Bike Shop</title>
    <!-- main CSS-->
    <link rel="stylesheet" href='<?php echo (CSS_PATH . "$main_css"); ?>' type="text/css">

<style>
.error {color: #FF0000;}
* {
  box-sizing: border-box;
}

input[type=text], select, textarea {
  width: 50%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}

input[type=number_format], select, textarea {
  width: 50%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}

label {
  padding: 12px 12px 12px 0;
  display: inline-block;
}

input[type=submit] {
  background-color: DodgerBlue;
  color: white;
  width: 50%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}



input[type=submit]:hover {
  background-color: primarycolor;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}


.col-25 {
  float: center;
  width: 50%;
  margin-top: 6px;
}

.col-75 {
  float: center;
  width: 50%;
  margin-top: 6px;
}


/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) { 
  .col-25, .col-75, input[type=submit] {
    width: 100%;
    margin-top: 10;
  }
}

form {
  display: block;
  margin-left: auto;
  margin-right: auto;
  width: 40%;
}
h2{
	color:DodgerBlue;
	text-align: center;
}
h2 {display: block;
  margin-left: auto;
  margin-right: auto;
  width: 100%;}
h3{
	color:DodgerBlue;
	text-align: center;
}
h3 {display: block;
  margin-left: auto;
  margin-right: auto;
  width: 100%;}
  
p {display: block;
  margin-left: auto;
  margin-right: auto;
  width: 40%;}
  
  
</style>
</head>
  <body>

      <div id="wrapper">

        <div id="header">
          <h1>Takoko</h1>
          <div id="nav">
            <ul>
              <li><a href="index.php">Home</a></li>
              <li><a href="addbikelisting.php">Add Listing</a></li>
              <li><a href="managelisting.php">Manage Listing</a></li>
              <li><a href="bikeListing.php">View Listing's</a></li>
            </ul>
          </div>
        </div> 

<?php
// define variables and set to empty values
// name phone email - serialnumber type description - yearofmanufacture of manufacture characteristics condition - website
$nameErr = $phoneErr = $emailErr = $titleErr = $serialnumberErr = $typeErr = $descriptionErr = $yearofmanufactureErr = $characteristicsErr = $conditionErr = $priceErr = "";
$name = $phone = $email = $title = $serialnumber = $type = $description = $yearofmanufacture = $characteristics = $condition = $price = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  if (empty($_POST["name"])) {
    $nameErr = "Name is required";
  } else {
    $name = test_input($_POST["name"]);
    // check if name only contains letters and whitespace
    if (!preg_match("/^[a-zA-Z-' ]*$/",$name)) {
      $nameErr = "Only letters and white space allowed";
    }
  }

  if (empty($_POST["phone"])) {
    $phoneErr = "Phone number is required";
  } else {
    $phone = test_input($_POST["phone"]);
    if (!preg_match("/^[0-9]*$/",$phone)) {
      $phoneErr = "Only numbers allowed";
    }
  }
  
  if (empty($_POST["email"])) {
    $emailErr = "Email is required";
  } else {
    $email = test_input($_POST["email"]);
    // check if e-mail address is well-formed
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
      $emailErr = "Invalid email format";
    }
  }
  
  if (empty($_POST["title"])) {
    $titleErr = "Vehicle title is required";
  } else {
    $title = test_input($_POST["title"]);
    // check if name is empty 
    if (empty($_POST["title"])) {
      $titleErr = "Title cannot be empty";
    }
  }
  
  if (empty($_POST["serialnumber"])) {
    $serialnumberErr = "Serial Number is required";
  } else {
	  $serialnumber = test_input($_POST["serialnumber"]);
    $yearofmanufacture = test_input($_POST['yearofmanufacture']);
    if (!preg_match("/^[[0-9]{2}-[0-9]{3}-[a-zA-Z-]{3}]*$/",$serialnumber)) {
      $serialnumberErr = "serial number does not following pattern";
    }
    if ((substr($serialnumber,0,2)) != substr($yearofmanufacture,2,4)) {
      $serialnumberErr = "the first two digits of serial number does not match with year of manufacture";
    }
  }
  
  if (empty($_POST["type"])) {
    $typeErr = "Vehicle Type is required";
  } else {
    $type = test_input($_POST["type"]);
    if (!preg_match("/^[a-zA-Z-' ]*$/",$type)) {
      $typeErr = "Only letters allowed";
    }
  }
  
  if (empty($_POST["description"])) {
    $descriptionErr = "Description is required";
  } else {
    $description = test_input($_POST["description"]);
  }
  
  if (empty($_POST["yearofmanufacture"])) {
	$yearofmanufactureErr = "year of Manufacture is required";
  } else {
	$yearofmanufacture = test_input($_POST["yearofmanufacture"]);
    if (!preg_match("/^[0-9]{4}$/",$yearofmanufacture)) {
	  $yearofmanufactureErr = "Please enter the correct year of manufacture";
    } 
  }
  
  
  if (empty($_POST["characteristics"])) {
    $characteristicsErr = "characteristics is required";
  } else {
    $characteristics = test_input($_POST["characteristics"]);
  }
  
  if (empty($_POST["condition"])) {
    $conditionErr = "Vehicle condition is required";
  } else {
    $condition = test_input($_POST["condition"]);
  }
  
  if (empty($_POST["price"])) {
    $priceErr = "Phone number is required";
  } else {
    $price = test_input($_POST["price"]);
    // check if price with numbers and decimal points
    if (!preg_match('/^\\d+(\\.\\d{1,2})?$/D', $price)) {
      $priceErr = "Only numbers allowed";
    } 
  }
}
    
function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}

?>

<h2>Bike Information</h2>
<p><span class="error">* required field</span></p>
<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>"> 
<ul> 
  Name:<br><br> <input type="text" name="name" value="<?php echo $name;?>">
  <span class="error">* <?php echo $nameErr;?></span>
  <br><br>
  Phone:<br><br> <input type="number_format" name="phone" value="<?php echo $phone;?>">
  <span class="error">* <?php echo $phoneErr;?></span>
  <br><br>
  E-mail:<br><br> <input type="text" name="email" value="<?php echo $email;?>">
  <span class="error">* <?php echo $emailErr;?></span>
  <br><br>
  Title:<br><br> <input type="text" name="title" value="<?php echo $title;?>">
  <span class="error">* <?php echo $titleErr;?></span>
  <br><br>
  Serial Number:<br><br> Serial number format is 'yy-nnn-ccc' yy-last two digit of Year of Manufacture, n for numbers, c for letters. <br><br> <input type="text" name="serialnumber" value="<?php echo $serialnumber;?>">
  <span class="error">* <?php echo $serialnumberErr;?></span>
  <br><br>
  Type:<br><br> <input type="text" name="type" value="<?php echo $type;?>">
  <span class="error">* <?php echo $typeErr;?></span>
  <br><br>
  Description:<br><br> <textarea name="description" rows="5" cols="40"><?php echo $description;?></textarea>
  <span class="error">* <?php echo $descriptionErr;?></span>
  <br><br>
  Year of Manufacture:<br><br> <input type="number_format" name="yearofmanufacture" value="<?php echo $yearofmanufacture;?>">
  <span class="error">* <?php echo $yearofmanufactureErr;?></span>
  <br><br>
  characteristics:<br><br> <textarea name="characteristics" rows="5" cols="40"><?php echo $characteristics;?></textarea>
  <span class="error">* <?php echo $characteristicsErr;?></span>
  <br><br>
  Condition:<br><br>
  <select name="condition">
  <option value="">Select...</option>
  <option value="NEW">NEW</option>
  <option value="USED">USED</option>
  </select>
  <span class="error">* <?php echo $conditionErr;?></span>
  <br><br>
  Price:<br><br> <input type="number_format" name="price" value="<?php echo $price;?>">
  <span class="error">* <?php echo $priceErr;?></span>
  <br><br>
  <br><br> <input type="submit" name="submit" value="Submit">  
  <br><br>
</ul>
</form>





<?php

if(isset($_POST['submit'])){
	if($nameErr == "" && $phoneErr == "" && $emailErr == "" && $titleErr == "" && $serialnumberErr == "" && $typeErr == "" && $descriptionErr == "" && $yearofmanufactureErr == "" && $characteristicsErr == "" && $conditionErr == "" && $priceErr == ""){
		echo "<p align='left'> <font color=blue  size='5pt'>The Vehicle details have been successfully submitted</font> </p>";
		$name = $_POST['name'];
		$phone = $_POST['phone'];
		$email = $_POST['email'];
		$title = $_POST['email'];
		$serialnumber = strtolower($_POST['serialnumber']);
		$type = $_POST['type'];
		$description = $_POST['description'];
		$yearofmanufacture = $_POST['yearofmanufacture'];
		$characteristics = $_POST['characteristics'];
		$condition = $_POST['condition'];
		$price = $_POST['price'];

		$line = "$name,$phone,$email,$title,$serialnumber,$type,$description,$yearofmanufacture,$characteristics,$condition,$price\n";

		$file=fopen(DB_BikesforSale, "a");
		fwrite($file, "$line");
		fclose($file);
		echo "<meta http-equiv='refresh' content='10'>";
		} else {  
        echo "<h3> <b>You didn't filled up the form correctly.</b> </h3>";  
		}  
	//header("Refresh: 1");
	//refresh UI to update counter
	}
	// $nameErr = $phoneErr = $emailErr = $titleErr = $serialnumberErr = $typeErr = $descriptionErr = $yearofmanufactureErr = $characteristicsErr = $conditionErr = $priceErr = "";
	// if($nameErr == "" && $phoneErr == "" && $emailErr == "" && $titleErr == "" && $serialnumberErr == "" && $typeErr == "" && $descriptionErr == "" && $yearofmanufactureErr == "" && $characteristicsErr == "" && $conditionErr == "" && $priceErr = "") { 

?>

</body>
</html>
