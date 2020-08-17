require('jquery');

require('global');
console.log("Yeah");

function updateNotifications(){

    $.get('/notifications',
        function (data, textStatus, jqXHR){
            alert("status: " + textStatus + ", data: " + data);
        }
    );
}

// setInterval(updateNotifications, 5000)
