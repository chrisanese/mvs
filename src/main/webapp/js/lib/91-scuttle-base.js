Scuttle.init = function(callback) {

    Scuttle.$body = $("body");

    Scuttle.$scene.appendTo(Scuttle.$stage0);

    Scuttle.$stage0.appendTo(Scuttle.$stage1);
    Scuttle.$stage1.appendTo(Scuttle.$stage2);
    Scuttle.$stage2.appendTo(Scuttle.$stage3);

    Scuttle.$preLoading.after(Scuttle.$stage3);
    Scuttle.$preLoading.remove();

    Scuttle.$loading.hide().appendTo(Scuttle.$body);
    Scuttle.$bluescreen.hide().appendTo(Scuttle.$body);
    Scuttle.$checkmark.hide().appendTo(Scuttle.$body);

    Scuttle.$bluescreen.on('click', function() {
        Scuttle.$bluescreen.hide();
    });

    Scuttle.adjustPage(Scuttle.$body);

    window.onpopstate = function(ev) {
        if (ev.state) {
            Scuttle.showLoadingScreen();
            Scuttle.show(ev.state.path);
        }
    };

    Scuttle.loadTemplates("_global", function() {
        Scuttle._initialized = true;
        callback();
    });

    $(function() {
        Scuttle.$document.tooltip({
            position : {
                my : "center bottom-20",
                at : "center top",
                using : function(position, feedback) {
                    $(this).css(position);
                    $("<div>").addClass("arrow").addClass(feedback.vertical)
                            .addClass(feedback.horizontal).appendTo(this);
                }
            }
        });
    });
};

Scuttle.path = function(path) {
    return Scuttle.contextPath + path;
};

Scuttle.getModule = function(name) {
    return Scuttle._modules[name];
};

Scuttle.getTemplate = function(module, view) {
    return Scuttle._templates[module][view];
};

Scuttle.getPartial = function(module, view) {
    return Scuttle._partials[module][view];
};

/**
 * Navigate to a given path. A path is relative to the context. A path consists
 * of two potions: (1) the actual path and (2) the view which is to be used to
 * render the response. The second potion is separated by a colon:
 * 
 * http://localhost:8080/scuttle/start-index
 * 
 * In the above example the path is /start:index and 'index' is the view which
 * is to be used to render the response from
 * http://localhost:8080/scuttle/start.
 * 
 * This function creates a new history entry using pushState.
 */
Scuttle.go = function(path, data) {

    history.pushState({
        path : path
    }, window.title, Scuttle.path(path));

    Scuttle.show(path, data);
};

/**
 * Like Scuttle.go(), but instead of creating a new history entry it replaces
 * the current one. This is useful at the first page load.
 */
Scuttle.show = function(path, data) {
    if (!Scuttle._initialized) {
        Scuttle.init(function() {
            Scuttle.show(path);
        });
        return;
    }
    Scuttle.showLoadingScreen();

    var pathAndView = path.split(':', 2);
    var moduleAndSubpath = pathAndView[0].split('/');
    var view = typeof pathAndView[1] == 'undefined' ? "index" : pathAndView[1];
    
    moduleAndSubpath.shift();
    var module = moduleAndSubpath[0];
    
    moduleAndSubpath.shift();
    var subpath = moduleAndSubpath.join('/');

    history.replaceState({
        path : path
    }, window.title, Scuttle.path(path));

    Scuttle._currentPath = path;

    if (typeof data == 'undefined') {
        Scuttle.loadModule(module, function() {
            Scuttle.loadData(module, subpath, function(data) {
    
                Scuttle._currentData = data;
                Scuttle._currentPath = path;
                Scuttle._currentModule = module;
                Scuttle._currentSubpath = subpath;
    
                Scuttle.showView(module, view, data);
            });
        });
    } else {
        Scuttle.loadModule(module, function() {
            Scuttle._currentData = data;
            Scuttle._currentPath = path;
            Scuttle._currentModule = module;
            Scuttle._currentSubpath = subpath;
    
            Scuttle.showView(module, view, data);
        });
    }
};

/**
 * Loads a module, if it is not loaded already. Executes the given callback in
 * any case (except if there is an error).
 */
Scuttle.loadModule = function(module, callback) {
    if (typeof Scuttle._modules[module] != 'undefined') {
        Scuttle.loadTemplates(module, callback);
    } else {
        $.ajax({
            dataType : "script",
            url : Scuttle.path("/backend/scripts/" + module)
        }).done(function(script, textStatus) {
            Scuttle.loadTemplates(module, callback);
        }).fail(function(req, text, error) {
            Scuttle.hideLoadingScreen();
            Scuttle.failedLoadingModule(req, text, error);
        });
    }
};

Scuttle.loadTemplates = function(module, callback) {
    if (typeof Scuttle._templates[module] != 'undefined') {
        callback();
    } else {
        $.ajax({
            type : "GET",
            url : Scuttle.path("/backend/templates/" + module),
            dataType : "json"
        }).done(function(data) {
            Scuttle._templates[module] = {};
            for ( var name in data.templates) {
                var rawTemplate = data.templates[name];
                var template = Mustache.compile(rawTemplate);
                Scuttle._templates[module][name] = template;
            }
            Scuttle._partials[module] = {};
            for ( var name in data.partials) {
                var rawTemplate = data.partials[name];
                var template = Mustache.compilePartial(name, rawTemplate);
                Scuttle._partials[module][name] = template;
            }
            callback();
        }).fail(function(req, text, error) {
            Scuttle.hideLoadingScreen();
            Scuttle.failedLoadingTemplates(req, text, error);
        });
    }
};

Scuttle.loadData = function(module, subpath, callback) {
    $.ajax({
        type : "POST",
        url : Scuttle.path("/backend/" + module + "/" + subpath),
        dataType : "json"
    }).done(function(data) {
        callback(data);
    }).fail(function(req, text, error) {
        Scuttle.hideLoadingScreen();
        Scuttle.failedLoadingData(req, text, error);
    });
};

Scuttle.showView = function(module, view, data) {
    if (typeof Scuttle._templates[module][view] == 'undefined') {
        Scuttle.noSuchViewError(module, view);
    } else {
        var html = Scuttle._templates[module][view](data);
        Scuttle.$scene.html(html);
        Scuttle.adjustPage(Scuttle.$scene);
        Scuttle.hideLoadingScreen();
    }
};

Scuttle.logout = function() {
    $.ajax({
        url : Scuttle.path("/backend/start/logout"),
        type : "POST"
    }).done(function() {
        Scuttle.signalSuccess();
        Scuttle.go("/start:index");
    }).fail(function(req, text, exc) {
        Scuttle.logoutError(req, text, exc);
    });
};