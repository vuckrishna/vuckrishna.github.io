const book1 = {
    name1:"Inspiring Lifes", author1:" Vikram", datepub1: " 2012 - 10 - 12", status1: " Available", info1: " This book includes life incidents of steve jobs. Steve Jobs is Founder of Apple company.",
    name2:"Thoughts of power", author2:" Vikram", datepub2: " 2012 - 10 - 12", status2: " Available", info2: " This book includes life incidents of steve jobs",
    name3:"Thoughts of Lifes", author3:" Vikram", datepub3: " 2012 - 10 - 12", status3: " Available", info3: " This book includes life incidents of steve jobs",
    name4:"Thoughts of power", author4:" Vikram", datepub4: " 2012 - 10 - 12", status4: " Available", info4: " This book includes life incidents of steve jobs",
    name5:"Thoughts of power", author5:" Vikram", datepub5: " 2012 - 10 - 12", status5: " Available", info5: " This book includes life incidents of steve jobs"
};

const studentid = ["ab456"];

function validateForm() {
    let x = document.forms["myForm"]["sid"].value;
    if (x == "") {
      alert("Name must be filled out");
      return false;
    }
    else if (x != "") {
        studentid.push(x);
        console.log(x)
    }
  }





