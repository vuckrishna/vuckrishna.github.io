<?php
  session_start();

  include 'classes/interestuser.php';
  include 'classes/bikelisting.php';

  define('CSS_PATH', 'css/'); //define bootstrap css path
  define('IMG_PATH','./img/'); //define img path
  $main_css = 'main.css'; // main css filename
  $flex_css = 'flex.css'; // flex css filename
  $tableui_css = 'tableui.css'; // flex css filename

  define('CURRENT_FILENAME','managelisting.php'); // filename to define globally

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
  //filter list by name only
  function filterBikeListByName($myList,$loginName) {
     $result = array();
     foreach ($myList as $key => $instance) {
        $verifyName = $instance->name;
        if(strtolower($loginName) === strtolower($verifyName)) {
            $sn = $instance->serialnumber;
            $result[$sn] = $instance;
        }
     }
     return $result;
  }
  $BikesforSale = file(DB_BikesforSale);
  $BikesforSale = getBikeListFN($BikesforSale);

  //if login session is available - filter only
  $loginSession = $_SESSION['login'];
  if(isset($loginSession) && !empty($loginSession)) {
      $BikesforSale = filterBikeListByName($BikesforSale,$loginSession);
  }

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
    <link rel="stylesheet" href='<?php echo (CSS_PATH . "$tableui_css"); ?>' type="text/css">

  </head>
  <body>

      <div id="wrapper">

        <div id="header">
          <h1>Takoko</h1>
          <div id="nav">
            <ul>
              <li><a href="index.php">Home</a></li>
              <li><a href="addbikelisting.php">Add Listing</a></li>
              <li><a href="<?php echo (CURRENT_FILENAME); ?>">Manage Listing</a></li>
              <li><a href="bikeListing.php">View Listing's</a></li>
            </ul>
          </div>
        </div>

        <div id="content">
           <div>
            <h2 class="centerText primarycolor">Manage Listing</h2>
            <!-- login using name -->
            <h3 class="centerText">Enter your name here to manage your listing</h3>
            <form 
            method='post'
            name='login-name'
            class="bikesearch boxsizing"
            action="#selectedBikeDashboard" 
            style="margin:auto;max-width:600px;margin-bottom: 2em;padding-left: 4em;padding-right: 2em;">
              <?php
              $login = $_SESSION["login"];
              $disabled = empty($_SESSION['login']) ? '' : 'disabled="true"';
              $bikesearchQuery =
              "<input class='boxsizing' type='text' placeholder='enter your name...' name='login' value='$login' $disabled >";
              echo $bikesearchQuery;
              ?>
              <button name='bikesearch-logout' class="boxsizing lightbluecolor" type="submit" value='logout'
              <?php echo empty($_SESSION['login']) ? 'disabled="true" style="background-color: #C0C0C0;pointer-events: none;"' : ''; ?>
              >logout</button>
              <button name='bikesearch-login' class="boxsizing" type="submit" value='submit'
              <?php echo empty($_SESSION['login']) ? '' : 'disabled="true" style="background-color: #C0C0C0;pointer-events: none;"'; ?>
              >login</button>
              <p class='required-text' style='padding-top: 1em;padding-right: 9em;'>
                <?php
                  //for detecting empty value (search button clicked but query is empty)
                  if (isset($_POST['bikesearch-login']) && empty($_POST['login'])) {
                      $_SESSION["login"] = '';
                      session_unset();
                      echo '*login cannot be blank'; 
                  }
                  elseif(isset($_POST['bikesearch-login']) && !empty($_POST['login'])) {
                      $bikeList = $GLOBALS['BikesforSale'];
                      $validateLogin = $_POST['login'];
                      $loginStatus = false;
                      //search for name
                      foreach ($bikeList as $key => $instance) {
                          $name = $instance->name;
                          if($validateLogin === $name) {
                            $loginStatus = true;
                              break;
                          }
                      }

                      //if login status is successful
                      if($loginStatus) { 
                         $_SESSION["login"] = $validateLogin;
                         //refresh UI to update session
                         header("Refresh: 0.1");
                      }
                      else {
                         $_SESSION["login"] = '';
                         session_unset();
                         echo '*name does not exist or not in system';
                      }
                  }
                  elseif(isset($_POST['bikesearch-logout'])) {
                      session_destroy();
                      header("Refresh: 0.1");
                  }
                ?>
              </p>
            </form>
            <!-- login using name -->
            <!-- search query -->
            <!-- empty (keep hidden) else (show) -->
                  <!--  -->
            <div style="<?php echo(empty($_SESSION['login']) ? 'display: none;' : '') ?>">
              <h3 class="centerText">Search for your listed bikes...</h3>
              <?php
                  //for clearing all query
                  if (isset($_GET['bikesearch-clear'])) {
                      header("Location: " . CURRENT_FILENAME . "#");
                      exit();
                  }
              ?>
              <form name='search-bike 'class="bikesearch boxsizing" action="#selectedBikeDashboard" style="margin:auto;max-width:600px;margin-bottom: 2em;">
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
            </div>
            <!-- search query -->
           </div>
        </div>

        <section style="<?php echo(empty($_SESSION['login']) ? 'display: none;' : '') ?>">
        <div 
        id="listing-dashboard" 
        class="flex-container"
        style="max-width: 80%; margin: auto;">
          <!-- start of selected listing -->
          <div class="flex-child dotted" >
            <h4>Selected Bike</h4>

            <?php
              //global variable
              $currentID = $GLOBALS['selectedBikeId'];

              

              if($currentID === null) {
                echo '<h5 class="center-text" style="padding-top: 3em;">No bike selected...</h5>';
              }
              else {
                function renderInterestedUsers($mylist,$bikeId,$peopleInterested) {
                  $output = '';
                  if(intval($peopleInterested) === 0) {
                      $output = '<h6 class="center-text" style="padding-top: 3em; padding-bottom: 3em;">No interested buyers...</h6>';
                  }
                  else {
                      //get assoc array containing interested users
                      function getinterestedUsrList($bikeId,$file) {
                          //explode each line to become interestUser Object
                          function mapToObject($file) {
                              $interestedUsrList = array();
                              foreach ($file as $line) {
                                  $instance = InterestUser::initUsingFileLines($line);
                                  array_push($interestedUsrList, $instance); 
                              }
                              return $interestedUsrList;
                          }
                          //group serial number using associative arrays
                          function groupSN($oldList) {
                              $myNewList = array();
                              foreach ($oldList as $instance) {
                                  $serialNo = $instance->serialnumber;
                                  //if key exist - group them together
                                  if(array_key_exists($serialNo , $myNewList)) {
                                      array_push($myNewList[$serialNo], $instance);
                                  }
                                  //else initialise the array
                                  else {
                                      $initArray = array();
                                      $initArray[] = $instance;
                                      $myNewList[$serialNo] = $initArray;
                                  }

                              }
                              return $myNewList;
                          }
                          //find serial key
                          function findSN($bikeId,$array) {
                              //if exist return counter
                              if(array_key_exists($bikeId, $array)) {
                                return $array[$bikeId];
                              }
                              else {
                                return array();
                              }
                          }

                          //1. get the file directory
                          $ExpInterestFile = $file;
                          //2. explode each line from file so as each line will be an array
                          $bikeIdList = mapToObject($ExpInterestFile);
                          //3. group same serial number and convert it into an assoc array
                          $bikeIdList = groupSN($bikeIdList);
                          //4. if serialNo in list return list, otherwise return blank list
                          $result = findSN($bikeId,$bikeIdList);
                          return $result; 
                      }

                      function deleteUsrInterestById($filename, $idToDelete) {
                          $result = false;
                          try {
                              $file = file($filename);
                              foreach ($file as $key => $lines) {
                                  $instance =  InterestUser::initUsingFileLines($lines);
                                  $name = $instance->name;
                                  $phone = $instance->phone;
                                  $email = $instance->email;
                                  $price = $instance->price;
                                  $uniqueKey = strtolower($name . $phone . $email . $price);
                                  //removing the line
                                  if($uniqueKey === $idToDelete) {
                                     unset($file[$key]);
                                     break;
                                  }
                              }
                              //reindexing array
                              $file = array_values($file);
                              //writing to file
                              file_put_contents($filename, implode($file));
                              $result = true;
                          }
                          catch (Exception $e) {
                              $result = false;
                          }
                          return $result;
                      }

                      //manage any HTTP request here
                      /* for delete option bikelisting */
                      if (!empty($_POST['userinterest-delete'])) {
                          deleteUsrInterestById(DB_ExpInterest,$_POST['userinterest-delete']);
                          //refresh UI to update session
                          header("Refresh: 0.1");
                          //header("Location: " . CURRENT_FILENAME . "#available-listing");
                      }

                      //create table rows
                      function createTableRows($mylist) {
                          $allRows = '';
                          foreach($mylist as $instance) {
                            //attributes
                            $name = $instance->name;
                            $phone = $instance->phone;
                            $email = $instance->email;
                            $price = $instance->price;
                            $uniqueKey = strtolower($name . $phone . $email . $price);

                            //build each row
                            $eachRow = 
                            "
                            <tr class='ei-table-row'>
                              <td>$name</td>
                              <td>$phone</td>
                              <td>$email</td>
                              <td>$price</td>
                              <form method='post'>
                                <td>
                                  <button style='color:red;border: 1px solid red;' type='submit' name='userinterest-delete' value='$uniqueKey'>
                                    delete
                                  </button>
                                </td>
                              </form>
                            </tr>
                            ";
                            $allRows .= $eachRow;
                          }
                          return $allRows;
                      }

                      

                      $filterArray = getinterestedUsrList($bikeId,$mylist);
                      $tableRows = createTableRows($filterArray);
                      $output =
                      "
                      <!-- each table table row consumes 30px of space -->
                      <div class='scrollfeature-table' style='height:180px;width:460px;'>
                        <table class='ei-table' style='font-size:13px;width:450px;'>

                          <tr>
                            <th>Name</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>Price</th>
                            <th>Action</th>
                          </tr>

                          <!-- table rows rendered here -->
                          $tableRows
                          <!-- table rows rendered here -->

                        </table>

                      </div>
                      ";
                  }
                  return $output;
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
                      function deleteBikeListingById($filename, $idToDelete) {
                          $result = false;
                          try {
                              $file = file($filename);
                              foreach ($file as $key => $lines) {
                                  $instance = bikelisting::initUsingFileLines($lines);
                                  $bikeId = $instance->serialnumber;
                                  //removing the line
                                  if($bikeId === $idToDelete) {
                                     unset($file[$key]);
                                     break;
                                  }
                              }
                              //reindexing array
                              $file = array_values($file);
                              //writing to file
                              file_put_contents($filename, implode($file));
                              $result = true;
                          }
                          catch (Exception $e) {
                              $result = false;
                          }
                          return $result;
                      }
                      //manage any HTTP request here
                      /* for delete option bikelisting */
                      if (!empty($_POST['bikelisting-delete'])) {
                          deleteBikeListingById(DB_BikesforSale,$currentID);
                          unset($_GET['selectedBikeId']);
                          unset($GLOBALS['selectedBikeId']);
                          //refresh UI to update session
                          //header("Refresh: 0.1");
                          header("Location: " . CURRENT_FILENAME . "#available-listing");
                          //refresh UI to update session
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
                      $renderInterestedUsers = renderInterestedUsers($GLOBALS['ExpInterestList'],$bikeID,$peopleInterested);
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

                        <!-- buttons -->
                        <div>
                          <form method='post' action='#available-listing' class='removeCSS'>
                            <button name='bikelisting-delete' class='btn-delete' value='$bikeID'>Delete</button>
                          </form>
                        </div>
                        <!-- buttons -->

                        <!-- display interested people -->
                        <div>
                          <p class='title-text text-leftalign'>Individuals Interested in Purchase:</p>

                          <!-- render table here -->
                          $renderInterestedUsers
                        </div>

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
            <h4 id='available-listing'>Available Listing's</h4>
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
    </section>


  </body>
</html>