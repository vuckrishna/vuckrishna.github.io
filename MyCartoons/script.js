// implementing objects

const movies = [
    {
    movieLink: "https://archive.org/details/totoro-foxdub",
    imagePath: "totoro2.jpg",
    movieName: "My Neighbour Totoro",
    genre:"cartoon"
    },
    {
    movieLink: "https://archive.org/details/totoro-foxdub",
    imagePath: "https://m.media-amazon.com/images/M/MV5BNTkzNjJhYjQtNjU0Yy00Y2M3LWI2ZDgtNDRhZmNlNDFjMjQ5XkEyXkFqcGdeQXVyODk2ODI3MTU@._V1_FMjpg_UX1000_.jpg",
    movieName: "Doraemon",
    genre:"cartoon"
    },
    {
    movieLink: "https://archive.org/details/totoro-foxdub",
    imagePath: "totoro2.jpg",
    movieName: "My Neighbour Totoro",
    genre:"movie"
    },
    {
    movieLink: "https://archive.org/details/totoro-foxdub",
    imagePath: "totoro.jpg",
    movieName: "My Neighbour Totoro",
    genre:"serial"
    },
    {
    movieLink: "https://archive.org/details/totoro-foxdub",
    imagePath: "totoro.jpg",
    movieName: "My Neighbour Totoro",
    genre:"movie"
    },
    {
    movieLink: "https://archive.org/details/totoro-foxdub",
    imagePath: "totoro.jpg",
    movieName: "My Neighbour Totoro",
    genre:"serial"
    },
    {
    movieLink: "https://archive.org/details/totoro-foxdub",
    imagePath: "totoro.jpg",
    movieName: "My Neighbour Totoro",
    genre:"movie"
    }

]



// need to implement better version of loop and variable names
// <p class="movieNames">${movie.movieName}</p> 
// <button type="button" class="movieNames">${movie.movieName}</button>
//<p class="movieNames" id="movieNames">${movie.movieName}</p> 
// <span class="fa fa-heart" onclick="favourite()"></span>

var index = 0; 
// var listItems = "";
var listItems = "";
while(index < movies.length){
  var movie = movies[index];
  listItems += `<div class="cards ${movie.genre}" id="cards">
      <a href= ${movie.movieLink}>
      <img src= ${movie.imagePath} alt="">
      </a>
      <p class="movieNames" id="movieNames">${movie.movieName}</p> 
      </div>`;
   index++;
}
document.getElementById("container").innerHTML = listItems;

function favourite(){
}
// dark mode code 
function darkMode(){
    let color1 = document.getElementById("darkMode").innerText;
    if ( color1 == "Light"){
      lightMode();
    }
    else{
      dark();
    }
}

function dark(){
  document.body.style.backgroundColor = "black";
  document.getElementById("darkMode").style.backgroundColor = "white";
  $(".movieNames").css("background-color", "black");
  $("#header").css("background-color", "black");
  // $(".filter-item").css("color", "white");
  document.getElementById("darkMode").innerText = "Light";
}

function lightMode(){
    document.body.style.backgroundColor = "white";
    document.getElementById("darkMode").style.backgroundColor = "white";
    $(".movieNames").css("background-color", "teal");
    $(".movieNames").css("color", "white");
    $("#header").css("background-color", "teal");
    // $(".filter-item").css("color", "teal");
    // $(".active-filter").css("background-color", "teal");
    // $(".active-filter").css("color", "white");
    document.getElementById("darkMode").innerText = "Dark";
}

// filter function 

$(document).ready(function () {
  $(".filter-item").click(function () {
      const value = $(this).attr("data-filter");
      if (value == "all"){
          $(".cards").show("10000")
      } else{
          $(".cards")
              .not("." + value)
              .hide(1);
          $(".cards")
          .filter("." + value)
          .show("3000")
      }
  });
  $(".filter-item").click(function () {
      $(this).addClass("active-filter").siblings().removeClass("active-filter")
  });
});
