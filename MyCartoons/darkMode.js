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
  document.getElementById("darkMode").innerText = "Light";
}

function lightMode(){
    document.body.style.backgroundColor = "white";
    document.getElementById("darkMode").style.backgroundColor = "white";
    $(".movieNames").css("background-color", "teal");
    $(".movieNames").css("color", "white");
    $("#header").css("background-color", "teal");
    document.getElementById("darkMode").innerText = "Dark";
}