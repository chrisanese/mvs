Scuttle.signalSuccess = function() {
    Scuttle.$checkmark.show().delay(1000).fadeOut();
};

Scuttle.reportError = function(exception) {
    Scuttle.hideLoadingScreen();

    var template = Scuttle.getTemplate("_global", "error500");
    var html = template(exception);

    Scuttle.$bluescreen.html(html).fadeIn();
};

Scuttle.noSuchViewError = function(module, view) {
    console.log("COULD NOT LOAD VIEW " + view + " FOR MODULE " + module);
};

Scuttle.failedLoadingData = function(req, text, error) {
    console.log("FAILED LOADING DATA: " + error.statusCode());
    var exception = {};
    try {
        exception = JSON.parse(req.responseText);
    } catch (exc) {
        exception = {rawMessage: req.responseText};
    }
    Scuttle.reportError(exception);
};

Scuttle.failedLoadingTemplates = function(req, text, error) {
    console.log("FAILED LOADING TEMPLATES");
    Scuttle.reportError(text, error);
};

Scuttle.failedLoadingModule = function(req, text, error) {
    console.log("FAILED LOADING MODULE");
    Scuttle.reportError(text, error);
};

Scuttle.formSubmissionError = function(req, text, error) {
    console.log("FORM COULD NOT BE SUBMITTED");
    Scuttle.reportError(text, error);
};

Scuttle.unsuccessfullSubmission = function(response) {
    console.log("UNSUCCESSFULL SUBMISSION");
    Scuttle.reportError(text, error);
};

Scuttle.logoutError = function(req, text, error) {
    console.log("LOGOUT FAILED");
    Scuttle.reportError(text, error);
};
