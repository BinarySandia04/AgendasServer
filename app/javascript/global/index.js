window.responsiveMenuNavBar = function(){
    var x = document.getElementById("topnavbar");
    if(x.className === "navmargin navbar"){
        x.className += " responsive";
        console.log("Ahora es responsive");
    } else {
        x.className = "navmargin navbar";
        console.log("Ahora ya no");
    }
};