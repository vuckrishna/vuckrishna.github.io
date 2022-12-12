<?php
  include 'classes/bikelisting.php';

  define('CSS_PATH', 'css/'); //define bootstrap css path
  define('IMG_PATH','./img/'); //define img path
  $main_css = 'main.css'; // main css filename
  $flex_css = 'flex.css'; // flex css filename

  define('CURRENT_FILENAME','bikelisting.php'); // filename to define globally

  define('DB_ExpInterest', 'database/ExpInterest.txt'); //filepath to expinterest.txt
  define('DB_BikesforSale', 'database/BikesforSale.txt'); //filepath to expinterest.txt
?>

<!-- manage global variables -->
<?php
  $selectedBikeId = null;
  $successInterestSubmit = false;
  $bikeSearchQuery = '';

  //set search query
  if(isset($_GET['bikesearch-query'])) {
     $bikeSearchQuery = $_GET['bikesearch-query'];
  }

  //set bike ID
  if (isset($_GET['selectedBikeId'])) {
     $selectedBikeId = $_GET['selectedBikeId'];
  }
  //set interest list
  $ExpInterestList = file(DB_ExpInterest);
  //set BikesforSale
  function getBikeListFN($myList) {
    $result = array();
    foreach($myList as $lines) {
        $instance = bikelisting::initUsingFileLines($lines);
        $sn = $instance->serialnumber;
        $result[$sn] = $instance;
    }
    return $result;
  }
  $BikesforSale = file(DB_BikesforSale);
  $BikesforSale = getBikeListFN($BikesforSale);
  //if search is performed on the search bike
  if (isset($_GET['bikesearch-query'])) {
      //case insensetive search query
      function filterArray($myList,$query) {
          function textcontains($text,$search) {
              $text = strtolower($text);
              $search = strtolower($search);
              return (preg_match("/{$search}/i", $text)) ? true : false;
          }

          $result = array();
          foreach ($myList as $key => $value) {
              $validate = textcontains($key,$query);
              if($validate){
                $result[$key] = $value;
              }
          }
          return $result;
      } 
     //1 get the search query 
     $ID = $_GET['bikesearch-query'];
     //2. perform the filter and return the result
     $BikesforSale = filterArray($BikesforSale,$ID);
  }
  
?>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Takoko - Bike Shop</title>
    <!-- main CSS-->
    <link rel="stylesheet" href='<?php echo (CSS_PATH . "$main_css"); ?>' type="text/css">
    <link rel="stylesheet" href='<?php echo (CSS_PATH . "$flex_css"); ?>' type="text/css">

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
              <li><a href="<?php echo (CURRENT_FILENAME); ?>">View Listing's</a></li>
            </ul>
          </div>
        </div>

        <div id="content">
           <div>
            <h2 class="centerText primarycolor">View Listing's</h2>
            <h3 class="centerText">Search For your favourite bike's here today...</h3>
            <!-- search query -->
            <?php
                //for clearing all query
                if (isset($_GET['bikesearch-clear'])) {
                    header("Location: " . CURRENT_FILENAME . "#");
                    exit();
                }
            ?>
            <form class="bikesearch boxsizing" action="#selectedBikeDashboard" style="margin:auto;max-width:600px;margin-bottom: 2em;">
              <?php
              $query = $GLOBALS['bikeSearchQuery'];
              $bikesearchQuery =
              "<input class='boxsizing' type='text' placeholder='Search bike serial number...' name='bikesearch-query' value='$query'>";
              echo $bikesearchQuery;
              ?>
              <button name='bikesearch-clear' class="boxsizing" type="submit" value='clear'>Clear</button>
              <button name='bikesearch-search' class="boxsizing" type="submit" value='submit'>search</button>
              <p class='required-text' style='padding-top: 1em;'>
                <?php
                  //for detecting empty value (search button clicked but query is empty)
                  if (isset($_GET['bikesearch-search']) && empty($_GET['bikesearch-query'])) {
                    echo '*Search field cannot be blank'; 
                  }
                ?>
              </p>
            </form>
            <!-- search query -->
           </div>
        </div>

        <div 
        id="listing-dashboard" 
        class="flex-container"
        style="max-width: 80%; margin: auto;">
          <!-- start of selected listing -->
          <div class="flex-child dotted" >
            <h4>Selected Bike</h4>

            <?php
              $currentID = $GLOBALS['selectedBikeId'];

              if($currentID === null) {
                echo '<h5 class="center-text" style="padding-top: 3em;">No bike selected...</h5>';
              }
              else {
                function expressInterestForm($currentID) {
                    //save data into file
                    function persistData($currentID,$name,$phone,$email,$expectedPrice) {
                       $ExpInterestFile = fopen(DB_ExpInterest,"ab");
                       fwrite($ExpInterestFile, "$currentID,$name,$phone,$email,$expectedPrice" . "\n");
                       fclose($ExpInterestFile);
                    }
                    //button
                    $disabled = "";
                    $disabledColor = "bgprimarycolor";
                    $successMsg = "";
                    //err variables
                    $nameErr = "";
                    $emailErr = "";
                    $phoneErr = "";
                    $expectedPriceErr = "";

                    //variables to store into textfile
                    $name = null;
                    $phone = null;
                    $email = null;
                    $expectedPrice = null;

                    

                    if ($_SERVER["REQUEST_METHOD"] == "POST") {
                        function cleanInput($data) {
                          $data = trim($data);
                          $data = stripslashes($data);
                          $data = htmlspecialchars($data);
                          return $data;
                        }
                         //name validation
                         if (empty($_POST["name"])) {
                            $nameErr = "Name is required";
                         } 
                         else {
                            $name = cleanInput($_POST["name"]);
                            //if there is any digit throw error
                            $pattern = "/\d+/";
                            if (preg_match($pattern , $name) > 0) {
                              $nameErr = "Invalid name format";
                            }
                         }
                         //phone validation
                         if (empty($_POST["phone"])) {
                            $phoneErr = "phone is required";
                         } 
                         else {
                            $phone = cleanInput($_POST["phone"]);
                            //if there is any string throw error
                            $pattern = "/[a-zA-Z]+/";
                            if (preg_match($pattern , $phone) > 0) {
                              $phoneErr = "Invalid phone format";
                            }
                         }
                        //email validation
                        if (empty($_POST["email"])) {
                          $emailErr = "Email is required";
                        } else {
                          $email = cleanInput($_POST["email"]);
                          // check if e-mail address is well-formed
                          if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                            $emailErr = "Invalid email format";
                          }
                        }
                        //price validation
                        if (empty($_POST["expectedPrice"])) {
                          $expectedPriceErr = "Price is required";
                        } else {
                          $expectedPrice = cleanInput($_POST["expectedPrice"]);
                          // check for number, if value is lesser than 1, then it is not numeric
                          if(!is_numeric($expectedPrice)) {
                             $expectedPriceErr = "Invalid price format";
                          }
                        }

                        //if all validation is successful - all fields are blank, then save data
                        if($nameErr === $emailErr && $phoneErr === $expectedPriceErr) {
                            $disabledColor = "";
                            $disabled = 'disabled';
                            $successMsg = 'You have successfully submitted!';
                            //perform data persistence
                            persistData($currentID,$name,$phone,$email,$expectedPrice);
                            //refresh UI to update counter
                            header("Refresh: 3");
                        }
                    }

                    $eachBox = 
                    "
                    <div>
                      <p class='title-text text-leftalign'>Express Interest For Purchase:</p>

                      <p class='required-text' style='float: left;'>* required field</p><br>
                      <form method='post' accept-charset='utf-8'>
                        <input class='inputstyling' type='text' name='name'  placeholder='your name...' value='$name'>
                        <span class='required-text'>* ${nameErr}</span><br>
                        <input class='inputstyling' type='text' name='phone' placeholder='your phonenumber...' value='$phone'>
                        <span class='required-text'>* ${phoneErr}</span><br>
                        <input class='inputstyling' type='text' name='email' placeholder='your email...' value='$email'>
                        <span class='required-text'>* ${emailErr}</span><br>
                        <input class='inputstyling' type='string' name='expectedPrice' placeholder='your expected price...' value='$expectedPrice'>
                        <span class='required-text'>* ${expectedPriceErr}</span><br>
                        <button
                         $disabled
                         type='submit'
                         class='$disabledColor'
                         style='height: 2em; width: 8em;'
                         >
                         Submit
                         </button>
                         <span class='required-text' style='color: green;'>$successMsg</span>
                      </form>
                    </div>
                    ";
                    return $eachBox;
                }
                function renderSelectedBicycle($currentID) {
                      //get data from db
                      function retireveData($bikeId,$file) {
                         //get serial number from file
                         function getSerialNoFromFileArray($file) {
                              $bikeIdList = array();
                              foreach ($file as $line) {
                                  $currentLine = explode(",",$line);
                                  $bikeID = $currentLine[0];
                                  array_push($bikeIdList, $bikeID); 
                              }
                              return $bikeIdList;
                          }
                         //group serial number using associative arrays
                         function groupSerialNumber($oldList) {
                            $myNewList = array();
                              foreach ($oldList as $index) {
                                  //if key exist - increment the counter
                                  if(array_key_exists(strval($index), $myNewList)){
                                      $currentCounter = $myNewList[strval($index)];
                                      $myNewList[strval($index)] = $currentCounter + 1;
                                  }
                                  //else initialise the value
                                  else {
                                      $myNewList[strval($index)] = 1; 
                                  }

                              }
                              return $myNewList;
                          }
                          //find serial key
                          function findSerialKey($bikeId,$array) {
                              //if exist return counter
                              if(array_key_exists($bikeId, $array)) {
                                return $array[$bikeId];
                              }
                              else {
                                return 0;
                              }
                          }

                          //1. get the file directory
                          $ExpInterestFile = $file;
                          //2. extract bike id from the file
                          $bikeIdList = getSerialNoFromFileArray($ExpInterestFile);
                          //3. group same serial number
                          $bikeIdList = groupSerialNumber($bikeIdList);
                          //4. if serialNo in list return noOfPeopleInterested, otherwise return 0
                          $result = findSerialKey($bikeId,$bikeIdList);
                          return $result; 
                      }
                      function findIdInBikeList($bikeId,$associativeArray) {
                          $find = $associativeArray[$bikeId];
                          if($find) {
                              return $find;
                          }
                          else {
                              return bikeListing::init();
                          }
                      }
                      //extract data from bikeList
                      $bikeList = $GLOBALS['BikesforSale'];
                      $bikeInfo = findIdInBikeList($currentID,$bikeList);

                      //contact info
                      $name = $bikeInfo->name;
                      $phone = $bikeInfo->phone;
                      $email = $bikeInfo->email;
                      $contactDetails = "$phone , $email";
                      //bike info
                      $bikeID = $currentID;
                      $yearofmanufacture = $bikeInfo->yearofmanufacture;
                      $peopleInterested = retireveData($bikeID,$GLOBALS['ExpInterestList']);
                      $condition = $bikeInfo->condition;
                      $title = "$bikeInfo->title"  . "   " . "[$condition]";
                      $description = $bikeInfo->description;
                      $type = $bikeInfo->type;
                      $characteristics = $bikeInfo->characteristics;
                      $price = $bikeInfo->price;
                      $imgURL = IMG_PATH . 'bicycle-placeholder.jpeg';
                      $expressInterestForm = expressInterestForm($currentID);
                      $eachBox =
                      "
                      <div class='flex-bikelisting-child' style='width:450px'>
                      
                      <div><img src='$imgURL' class='bike-img-format' /></div>
                      
                        <div class='text-leftalign'>
                          <p class='bikeid-text text-leftalign'>$bikeID <span style='float: right;'>Year Of Manufacture: $yearofmanufacture</span></p>
                          <p class='title-text text-leftalign'>$title</p>
                          <p class='description-text text-leftalign'>$description</p>
                          <p class='attributes-text text-leftalign'><b>Type: </b> $type</p>
                          <p class='attributes-text text-leftalign'><b>Characteristics: </b> $characteristics</p>
                          <p class='attributes-text text-leftalign'><b>Contact Name: </b> $name</p>
                          <p class='attributes-text text-leftalign'><b>Contact Details: </b> $contactDetails</p>
                        </div>

                        
                        <div>
                          <button 
                          name='selectedBikeId'
                          value='$bikeID'
                          style='margin-top: 0.25em;'
                          class='bgteritarycolor1'
                          style='padding: 0.5em;'
                          disabled
                          >
                          $peopleInterested people are interested right now !
                          </button>
                         <div class='price-text-div primarycolor'><p class='price-text'>$price</p></div>
                        </div>

                        <!-- express interest form -->
                        $expressInterestForm

                      </div>
                      ";
                      echo $eachBox;
                }
                echo "<div id='selectedBikeDashboard' class='solidborder flex-container' style='margin-top: 2em;'>";
                echo renderSelectedBicycle($currentID);
                echo "</div>";
              }
            ?>
          </div>
          <!-- end of selected listing -->
          <!-- start of listing -->
          <div class="flex-child">
            <h4>Available Listing's</h4>
            <?php
            //feed bike listing data here
            $bikeList = $GLOBALS['BikesforSale'];
            //if listing is 0, display no results
            if(count($bikeList) === 0) {
               echo '<h5 class="center-text" style="padding-top: 3em;">No bike listings available or<br> found at the current moment...</h5>';
               // echo '<h6 class="center-text">No bike listings available at the current moment...</h6>';
            }
            else {
               function renderBoxes($list,$searchquery) {
                  $finalOutput = "";
                  foreach ($list as $sn => $bikeListing) {
                      $currentFilename = CURRENT_FILENAME;
                      $bikeID = $bikeListing->serialnumber;
                      $condition = $bikeListing->condition;
                      $title = "$bikeListing->title"  . "   " . "[$condition]";
                      $description = $bikeListing->description;
                      $price = $bikeListing->price;
                      $imgURL = IMG_PATH . 'bicycle-placeholder.jpeg';
                      $eachBox =
                      "
                      <div class='flex-bikelisting-child'>
                      
                      <div><img src='$imgURL' class='bike-img-format' /></div>
                      
                      <div class='text-leftalign'>
                        <p class='bikeid-text text-leftalign'>$bikeID</p>
                        <p class='title-text text-leftalign'>$title</p>
                        <p class='description-text text-leftalign'>$description</p>
                      </div>

                      <div>
                        <form action='$currentFilename#selectedBikeDashboard' method='get' class='removeCSS'>
                          <button 
                          type='submit'
                          name='selectedBikeId'
                          value='$bikeID'
                          class='bgsecondarycolor'
                          style='padding: 0.5em;'
                          >
                          View Detail
                          </button>
                          <input type='text' name='bikesearch-query' value='$searchquery' hidden>
                        </form>
                        <div class='price-text-div primarycolor'><p class='price-text'>$price</p></div>
                      </div>

                      </div>
                      ";
                      //append to final output
                      $finalOutput .= $eachBox;
                  }
                  echo $finalOutput;
               }

               //get the current search query
               //this is REQUIRED, otherwise after selecting a bike, the available listing will reset
               $searchquery = $GLOBALS['bikeSearchQuery'];

               echo '<div class="scrollfeature">';
               echo '<div class="flex-bikelisting-parent">';
               echo renderBoxes($bikeList,$searchquery);
               echo '</div>';
               echo '</div>';
            }

            ?>
            
          </div>
          <!-- end of listing -->
        </div>

        <div id="footer">
          <p>
            &copy;
            <?php 
            $currentYear = date('Y'); 
            echo $currentYear; 
            ?>
            All rights reserved.
          </p>
        </div>

    </div>


  </body>
</html>