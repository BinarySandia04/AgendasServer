window.toggleDuration = function(){
    var div = document.getElementById("hide-from-toggle");
    var button = document.getElementById("toggle-button");
    var values = document.getElementsByClassName("reset-toggle");

    if(div.style.display === "none"){
        div.style.display = "block";
        button.className = "toggle-button on"
        button.innerText = "Si";

        var i = 0;
        for (let item of values){
            if(i == 0) item.value = "1";
            else item.value = "0";
            i++;
            item.setAttribute("value", item.value);
        }
    } else {
        div.style.display = "none";
        button.innerText = "No";
        button.className = "toggle-button off";

        for (let item of values){
            item.value = "0";
            item.setAttribute("value", item.value);
        }
    }
}