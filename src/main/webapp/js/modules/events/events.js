define("init", function() {

    $('#group-days input:radio').change(function() {
        var val1 = $('#group-days input:checked').val();
        var val2 = $('#group-timeslots input:checked').val();
        if (val1 == "none" || val2 == "none") {
            $(".roomId.dontShow").show();
            $("span.something").hide();
        } else {
            $(".roomId.dontShow").hide();
            $("span.something").show();
        }
    });

    $('#group-timeslots input:radio').change(function() {
        var val1 = $('#group-timeslots input:checked').val();
        var val2 = $('#group-timeslots input:checked').val();
        if (val1 == "none" || val2 == "none") {
            $(".roomId.dontShow").show();
            $("span.something").hide();
        } else {
            $(".roomId.dontShow").hide();
            $("span.something").show();
        }
    });

});

define("showDetails", function(roomDbId, roomTitle) {
    $("#roomName").text(': ' + roomTitle);
    $(".event").hide();
    $(".event.r" + roomDbId).show();
});