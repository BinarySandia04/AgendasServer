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

window.dropdownNavBarActive = function(){
    var x = document.getElementById("dropdown-content");
    x.className = "dropdown-content showed";
};

window.dropdownNavBarInactive = function(){
    setTimeout(function(){
        var x = document.getElementById("dropdown-content");
        x.className = "dropdown-content hidden";
    }, 200);
};

/**
 * @class CalendarPicker.
 * @description Provides a simple way to get a minimalistic calender in your DOM.
 * @author Mathias Picker - 29 July 2020.
 */

