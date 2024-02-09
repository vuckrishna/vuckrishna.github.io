// dark mode code 
// function darkMode(){
//     let color1 = document.getElementById("darkMode").innerText;
//     if ( color1 == "Light"){
//       lightMode();
//     }
//     else{
//       dark();
//     }
// }

// function darkmodeCheck(){
//   // let check = document.body.style.backgroundColor;
//   if (document.body.style.backgroundColor != "white"){
//     dark();
//   }else {
//   }
// }
// localStorage.setItem("mode", "dark");



function dark(){
  let bodyColor = document.body;
  bodyColor.classList.toggle("darkmodeOn");

  let movieNames = document.getElementsByTagName("p");
  console.log(movieNames);
  for (let index of movieNames){
    index.classList.toggle("darkmodeOn");
  }

  let headerColor = document.getElementById("header");
  headerColor.classList.toggle("darkmodeOn");
  
  // document.body.style.backgroundColor = "black";
  // document.getElementById("darkMode").style.backgroundColor = "white";
  // $(".movieNames").css("background-color", "black");
  // $("#header").css("background-color", "black");
  // document.getElementById("darkMode").innerText = "Light";
}

// function lightMode(){
//     document.body.style.backgroundColor = "white";
//     document.getElementById("darkMode").style.backgroundColor = "white";
//     $(".movieNames").css("background-color", "teal");
//     $(".movieNames").css("color", "white");
//     $("#header").css("background-color", "teal");
//     document.getElementById("darkMode").innerText = "Dark";
// }