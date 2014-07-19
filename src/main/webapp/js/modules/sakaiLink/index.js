function reinitialize() {
    $.ajax({
        url : path("/backend/sakaiLink/reinitialize")
    }).done(function(data) {
        if (data.success) {
            signalSuccess();
        } else {
            console.log("FAIL: ");
            console.log(data);
        }
    }).fail(function(req, text, error) {
        console.log("ERROR " + error);
    });
}
define("reinitialize", reinitialize);

