let column1 = document.getElementById("col1");
let column2 = document.getElementById("col2");

let navButton = document.getElementsByClassName("flex-sm-fill");

const phoneInfo =
    {"pixel8pro": `
    <p id="col2" style="font-size: 15px; font-weight: 600; padding:  0px; width: 320px;">
        Full-screen 6.7-inch (170 mm)1 display <br><br>
        20:9 aspect ratio <br><br>
        Super Actua display <br><br>
        (1344 x 2992) LTPO OLED at 489 PPI <br><br>
        Smooth Display (1-120 Hz2) <br><br>
        Corning® Gorilla® Glass Victus® 2 cover glass <br><br>
        Always-on display with At a Glance and Now Playing <br><br>
        Up to 1600 nits (HDR) and up to 2400 nits (peak brightness)3 
    </p>
    `,
    "pixel8":`
    <p id="col2" style="font-size: 15px; font-weight: 600; padding:  0px; width: 320px;">
        Full-screen 6.2-inch (157 mm)1 display <br><br>
        20:9 aspect ratio <br><br>
        Actua display <br><br>
        (1080 x 2400) OLED at 428 PPI <br><br>
        Smooth Display (60-120 Hz2) <br><br>
        Corning® Gorilla® Glass Victus® cover glass <br><br>
        Always-on display with At a Glance and Now Playing <br><br>
        Up to 1400 nits (HDR) and up to 2000 nits (peak brightness)3 
    `,
    "pixel7pro": `
    <p id="col2" style="font-size: 15px; font-weight: 600; padding:  0px; width: 320px;">
        Full-screen 6.7-inch (170 mm)¹ display <br><br>
        19.5:9 aspect ratio <br><br>
        QHD+ (1440 x 3120) LTPO OLED at 512 PPI <br><br>
        Smooth Display (up to 120 HZ²) <br><br>
        Always-on display <br><br>
        Google Tensor G2 <br><br>
        Titan M2 TM security coprocessor <br><br>
        At a Glance <br><br>
        Now Playing 
    `,
    "pixel7": `
    <p id="col2" style="font-size: 15px; font-weight: 600; padding:  0px; width: 320px;">
        Full-screen 6.3-inch (160.5 mm)¹ display <br><br>
        20:9 aspect ratio <br><br>
        FHD+ (1080 x 2400) OLED at 416 PPI <br><br>
        Smooth Display (up to 90 HZ²) <br><br>
        Always-on display <br><br>
        Google Tensor G2 <br><br>
        Titan M2 TM security coprocessor <br><br>
        At a Glance <br><br>
        Now Playing 
    `,
    "pixel7a": `
    <p id="col2" style="font-size: 15px; font-weight: 600; padding:  0px; width: 320px;">
        6.1-inch (155 mm) display¹, up to 90Hz <br><br>
        20:9 aspect ratio <br><br>
        FHD+ (1080 x 2400) OLED at 429 PPI <br><br>
        Smooth Display2 (up to 90 Hz) <br><br>
        Always-on display <br><br>
        Google Tensor G2 <br><br>
        Titan M2 TM security coprocessor <br><br>
        At a Glance <br><br>
        Now Playing 
    `,
    "pixel6a": `
    <p id="col2" style="font-size: 15px; font-weight: 600; padding:  0px; width: 320px;">
        Full-screen 6.134-inch (152.2 mm)1 display <br><br>
        20:9 aspect ratio <br><br>
        FHD + (1080 x 2400) OLED at 429 ppi <br><br>
        Smooth Display (up to 60 Hz) <br><br>
        Always-on display  <br><br>
        Google Tensor G2 <br><br>
        Titan M2 TM security coprocessor <br><br>
        At a Glance <br><br>
        Now Playing 
    `
}

document.getElementById("p8p").addEventListener("click", function() {
    $(navButton).removeClass("active");
    $(this).addClass("active");
    myFunction("p8p");
  });

document.getElementById("p8").addEventListener("click", function() {
    $(navButton).removeClass("active");
    $(this).addClass("active");
    myFunction("p8");
  });

document.getElementById("p7p").addEventListener("click", function() {
    $(navButton).removeClass("active");
    $(this).addClass("active");
    myFunction("p7p");
});

document.getElementById("p7").addEventListener("click", function() {
    $(navButton).removeClass("active");
    $(this).addClass("active");
    myFunction("p7");
});

document.getElementById("p7a").addEventListener("click", function() {
    $(navButton).removeClass("active");
    $(this).addClass("active");
    myFunction("p7a");
});

document.getElementById("p6a").addEventListener("click", function() {
    $(navButton).removeClass("active");
    $(this).addClass("active");
    myFunction("p6a");
});

function myFunction(value){
    switch (value) {
        case "p8p":
            $("#col1").attr("src", "https://lh3.googleusercontent.com/j3IEmFCmrLpCi31821IGLaPdcyiPPTgM_43AsYxK-vw5wKBU9Jrct1YPgEPILecXY_5thUy1NuZciJciYj7-37svjbk-vcjdvg=w688");
            column2.innerHTML = phoneInfo.pixel8pro;
            $("#col3").attr("src", "https://lh3.googleusercontent.com/jcq1Gu64T1d6Ro3qCHAYZmpSvE3qFQlq0G2-EVOXrakMkC47XWsYZZf1AcTtEvlcDE2ohmCrWTAOXHsTzDrk943lWe00seL0Y_c=rw-e365-nu-w875");
            break;
        case "p8":
            $("#col1").attr("src", "https://lh3.googleusercontent.com/dnVuOak_oldMPAhcLhVx1pO6gJBmKVNSINNGFF-Ksa71bzVIVlexB50hxUKlTPu1cesU7aVrTkF67hZUdGDa57A4BwMAYGQ_tlLd=w688");
            column2.innerHTML = phoneInfo.pixel8;
            $("#col3").attr("src", "https://lh3.googleusercontent.com/Bvhjh0yqXYYr0PsUJHr-aaygbkgLFqIIgkhk6-BD8-RMmTzCfs0bmisqm000JV9G9bSUwfgO1QLwY694jmZ5ucd1dAzRmeNRfQ=rw-e365-nu-w875");
            break;
        case "p7p":
            $("#col1").attr("src", "https://lh3.googleusercontent.com/gOm_aGG65jiUWn1YkS7FS9xkanNuZFG-B0JVKnSMEUNWrJem4exCNlo8kBeVMB0-N3ous2W6xMEdx0PN-Ps0qQWV09kW9Y_kTg=w688");
            column2.innerHTML = phoneInfo.pixel7pro;
            $("#col3").attr("src", "https://lh3.googleusercontent.com/bQp_Fc5BL7phhrBRGxwD3B8VoUsFVeHYa3d7HFXKGBj7zLLVd19El5TbPVZ1TnImY2BeBry5NjQVlsZPW-VDPW0G9wfPXhbufw=rw-e365-nu-w875");
            break;
        case "p7":
            $("#col1").attr("src", "https://lh3.googleusercontent.com/YoiWjMRNztQ3F_A5gqTV3lOXwwZNpoxuEr9eQ7wi9c1RNNy3thP8GwHVOKqTolgdZbvoCm1sQ2zk-MJYQd2PXnWVMp6dRkTBbA=w688");
            column2.innerHTML = phoneInfo.pixel7;
            $("#col3").attr("src", "https://lh3.googleusercontent.com/98fyouFoVywHT4dP4NxwlrvR2YSAXyvCRntFNbrmK7Z88Op0iNxtgGgXtjyYxr9rXR0dwVGbWLTWoaYFHwC5L_1qPwZxELXMshw=rw-e365-nu-w875");
            break;
        case "p7a":
            $("#col1").attr("src", "https://lh3.googleusercontent.com/gOm_aGG65jiUWn1YkS7FS9xkanNuZFG-B0JVKnSMEUNWrJem4exCNlo8kBeVMB0-N3ous2W6xMEdx0PN-Ps0qQWV09kW9Y_kTg=w688");
            column2.innerHTML = phoneInfo.pixel7a;
            $("#col3").attr("src", "https://lh3.googleusercontent.com/lVj1qOm9FyXNrBNsQ_MIncBuN2e35_EHTdHp3CFByyAq33WG2p41heyHvdwl4cO2-VjP7USzeL5Wc08xhHM1eanYJFT-3_qVf8c=rw-e365-nu-w875");
            break;
        case "p6a":
            $("#col1").attr("src", "https://lh3.googleusercontent.com/cj_To45HV4ci4ABh94MTuovRhtFdbbrc8Acw6FoJTq8CTr_hQaulli6zIpymRawFjBSYZFaS2t2jW4mSayj6V3pgp-H5kSLu_cPH=w688");
            column2.innerHTML = phoneInfo.pixel6a;
            $("#col3").attr("src", "https://lh3.googleusercontent.com/bQp_Fc5BL7phhrBRGxwD3B8VoUsFVeHYa3d7HFXKGBj7zLLVd19El5TbPVZ1TnImY2BeBry5NjQVlsZPW-VDPW0G9wfPXhbufw=rw-e365-nu-w875");
            break;
      }
}

// navButton.addEventListener("click", myFunction);
