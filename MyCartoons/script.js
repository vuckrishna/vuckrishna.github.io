// implementing objects

const movies = [
  {
  movieLink: "https://www.wcofun.tv/anime/scooby-doo-where-are-you-1969",
  imagePath: "https://m.media-amazon.com/images/M/MV5BN2EyMmIyMWItZTRiYy00MmE1LTkyOTAtMTliMzYwZGJlYmFjXkEyXkFqcGdeQXVyNTgyNTA4MjM@._V1_FMjpg_UX1000_.jpg",
  movieName: "Scooby Doo",
  genre:"cartoon"
  },
  {
  movieLink: "https://archive.org/details/totoro-foxdub",
  imagePath: "https://m.media-amazon.com/images/M/MV5BNTkzNjJhYjQtNjU0Yy00Y2M3LWI2ZDgtNDRhZmNlNDFjMjQ5XkEyXkFqcGdeQXVyODk2ODI3MTU@._V1_FMjpg_UX1000_.jpg",
  movieName: "Doraemon",
  genre:"cartoon"
  },
  {
  movieLink: "https://www.wcofun.tv/anime/ben-10",
  imagePath: "https://m.media-amazon.com/images/M/MV5BZjg2ZjViMTktNWQ1Yy00ODZiLWE1OTgtNDY3MjI0OGUyNjNhXkEyXkFqcGdeQXVyNTk4NDI4NTE@._V1_.jpg",
  movieName: "Ben 10",
  genre:"cartoon"
  },
  {
  movieLink: "https://archive.org/details/totoro-foxdub",
  imagePath: "https://m.media-amazon.com/images/M/MV5BMTc1NjcxNzg4MF5BMl5BanBnXkFtZTgwOTMzNzgyMDE@._V1_.jpg",
  movieName: "Phineas and Ferb",
  genre:"cartoon"
  },
  {
  movieLink: "https://www.wcofun.tv/anime/avatar-the-last-airbender-book-1-water",
  imagePath: "https://m.media-amazon.com/images/I/916XiNKSc6L._AC_UF1000,1000_QL80_.jpg",
  movieName: "Avatar the last airbender",
  genre:"cartoon"
  },
  {
  movieLink: "https://archive.org/details/totoro-foxdub",
  imagePath: "https://m.media-amazon.com/images/M/MV5BMTY2NGRlZTgtZWU1ZC00NzhkLTgyMmYtYTQyZDgzYmE0ZmYzXkEyXkFqcGdeQXVyNTgyNTA4MjM@._V1_.jpg",
  movieName: "Mr Bean",
  genre:"cartoon"
  },
  {
  movieLink: "https://archive.org/details/totoro-foxdub",
  imagePath: "totoro.jpg",
  movieName: "My Neighbour Totoro",
  genre:"movie"
  },
  {
  movieLink: "https://www.wcofun.tv/anime/the-legend-of-korra",
  imagePath: "https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p9157227_b_v9_aw.jpg",
  movieName: "The Legend of Korra",
  genre:"cartoon"
  },
  {
  movieLink: "https://www.wcofun.tv/anime/the-legend-of-korra",
  imagePath: "https://m.media-amazon.com/images/M/MV5BMTM1MTI5ODU4MV5BMl5BanBnXkFtZTcwNTYyNTU4Mg@@._V1_.jpg",
  movieName: "A Christmas Carol",
  genre:"movie"
  },
  {
  movieLink: "https://www.wcofun.tv/anime/the-legend-of-korra",
  imagePath: "https://images.ottplay.com/posters/8cdd59ba436c0238dd52a9ee1c5d35a9.jpg",
  movieName: "Dude Season 1",
  genre:"serial"
  },
  {
  movieLink: "https://www.wcofun.tv/anime/the-legend-of-korra",
  imagePath: "https://m.media-amazon.com/images/M/MV5BMGM0NmQ0ZTMtOTY1Ni00OGI2LWJmYzctOGJlNmUxMjNhZTBkXkEyXkFqcGdeQXVyMjQwMDg0Ng@@._V1_.jpg",
  movieName: "Dude Season 2",
  genre:"serial"
  },
  {
  movieLink: "https://www.wcofun.tv/anime/the-legend-of-korra",
  imagePath: "https://m.media-amazon.com/images/M/MV5BNmZmNTA5ZTgtNTgzOS00YWQ5LTgxZTItYTc1NzNjOWNmMDA5XkEyXkFqcGdeQXVyMTExMTIzMTA5._V1_.jpg",
  movieName: "Sapne vs Everyone",
  genre:"serial"
  }

]



// Default Page

var index = 0; 
// var listItems = "";
var listItems = "";
while(index < movies.length){
  var movie = movies[index];
  listItems += `<div class="cards ${movie.genre}" id="cards">
      <a href= ${movie.movieLink}>
      <img src= ${movie.imagePath} alt="">
      <p class="movieNames" id="movieNames">${movie.movieName}</p> 
      </a>
      </div>`;
   index++;
}
document.getElementById("container").innerHTML = listItems;




// Event listeners

document.getElementById("home").addEventListener("click", function() {
  myFunction("home");
});
document.getElementById("addNew").addEventListener("click", function() {
  myFunction("addNew");
});
document.getElementById("favourites").addEventListener("click", function() {
  myFunction("favourites");
});
document.getElementById("devStack").addEventListener("click", function() {
  myFunction("dev_stack");
});


// Page data loading function 

  function myFunction(value) {
    var content = "";
      switch (value) {
        case "home":
          var index = 0; 
          while(index < movies.length){
            var movie = movies[index];
            content += `<div class="cards ${movie.genre}" id="cards">
                <a href= ${movie.movieLink}>
                <img src= ${movie.imagePath} alt="">
                <p class="movieNames" id="movieNames">${movie.movieName}</p> 
                </a>
                </div>`;
            index++;
          }
              break;
        case "addNew":
          content += ``;
            break;
        case "favourites":
          content += ``;
            break;
        case "dev_stack":
          content += `
          <div id="container2" style="display: flex; margin: 100px 200px;">
                <img src="https://clipart.info/images/ccovers/1499794874html5-js-css3-logo-png.png" alt="" style="width: auto; height: 250px;">
                <img src="https://logo-download.com/wp-content/data/images/svg/jQuery-logo.svg" alt="" style="width: auto; height: 250px;">
            </div>
          `;
            break;

        } 
    document.getElementById("container").innerHTML = content;
  }


// search function 

$(document).ready(function(){
  $("#searchInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#cards ").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});


function favourite(){
}



// filter function 

$(document).ready(function () {
  $(".filter-item").click(function () {
      const value = $(this).attr("data-filter");
      if (value == "all"){
          $(".cards").show("fast", "linear")
      } else{
          $(".cards")
              .not("." + value)
              .hide("fast", "linear");
          $(".cards")
          .filter("." + value)
          .show("3000")
      }
  });
  $(".filter-item").click(function () {
      $(this).addClass("active-filter").siblings().removeClass("active-filter")
  });
});



