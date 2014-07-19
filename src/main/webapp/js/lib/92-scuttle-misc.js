Scuttle.showLoadingScreen = function() {
    Scuttle.$body.addClass("scuttle-no-overflow");
    Scuttle.$loading.fadeIn();
};

Scuttle.hideLoadingScreen = function() {
    Scuttle.$loading.stop().fadeOut();
    Scuttle.$body.removeClass("scuttle-no-overflow");
};

Scuttle.adjustPage = function($page) {

    // prepare hyperlinks with @data-go
    $page.find("a[data-go]").each(function(ix, e) {
        var a = $(e);
        var path = a.attr("data-go");
        var reloadData = true;
        if (path.startsWith("//")) {
            path = '/' + Scuttle._currentModule + path.slice(1);
        }
        if (path.charAt(0) == ':') {
            reloadData = false;
            if (Scuttle._currentSubpath.length > 0) {
                path = '/' + Scuttle._currentSubpath + path;
            }
            path = '/' + Scuttle._currentModule + path;
        }
        a.attr("href", Scuttle.path(path));
        if (reloadData) {
            a.on('click', function(ev) {
                if (ev.which == 2) {
                    return true;
                }
                Scuttle.go(path);
                return false;
            });
        } else {
            a.on('click', function(ev) {
                if (ev.which == 2) {
                    return true;
                }
                Scuttle.go(path, Scuttle._currentData);
                return false;
            });
        }
    });

    // make tables sortable
    $page.find("table.sortable").each(function(ix, e) {
        sorttable.makeSortable(e);
    });

    // resizable
    $page.find(".resizable").each(function(ix, e) {
        $(e).resizable();
    });
    
    // draggable foo
    $page.find(".draggable").each(function(ix, e) {
        
        var $e = $(e);
        var options = {};

        if ($e.is("[data-drag-revert-invalid]")) {
            options.revert = "invalid";
        }
        if ($e.is("[data-drag-handle]")) {
            options.handle = $e.attr("data-drag-handle");
        }


        $e.draggable(options);
    });

    // droppable foo
    $page.find("[data-on-drop]").each(function(ix, e) {
        var $e = $(e);
        var options = {};

        options.drop = function(ev, ui) {
            eval($e.attr("data-on-drop"));
        };
        if ($e.is("[data-drop-accept]")) {
            options.accept = $e.attr("data-drop-accept");
        }

        $e.droppable(options);
    });

    // selectable foo
    $page.find("[data-on-select]").each(function(ix, e) {
        var $e = $(e);
        var options = {};

        options.stop = function() {
            eval($e.attr("data-on-select"));
        };

        $e.selectable(options);
    });

    // sortable foo
    $page.find("[data-on-sort]").each(function(ix, e) {
        var $e = $(e);
        var options = {};

        options.stop = function() {
            eval($e.attr("data-on-sort"));
        };
        if ($e.is("[data-sort-axis]")) {
            options.axis = $e.attr("data-sort-axis");
        }
        if ($e.is("[data-sort-handle]")) {
            options.handle = $e.attr("data-sort-handle");
        }

        $e.sortable(options);
    });

    // activate jquery ui elements
    $page.find("[data-ui]").each(function(ix, e) {
        var $e = $(e);
        var ui = $e.attr("data-ui");
        switch (ui) {
        case "accordion":
            $e.accordion({
                heightStyle : "content"
            });
            break;
        case "datepicker":
            $e.datepicker({
                showWeek : true,
                firstDay : 1,
                changeMonth : true,
                changeYear : true
            });
            break;
        case "tabs":
            $e.tabs();
            break;
        case "button":
            $e.button();
            break;
        case "buttonset":
            $e.buttonset();
            break;
        case "combobox":
            $e.combobox();
            break;
        case "menu":
            $e.menu();
            break;
        }
    });

    // Enable jQuery UI tooltips
    $page.tooltip({
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

    // prepare hyperlinks and buttons with @data-do
    var selector = "a[data-do]";
    selector += ", button[data-do]";
    selector += ", input[type='button'][data-do]";
    $page.find(selector).each(function(ix, e) {
        var a = $(e);
        var action = a.attr("data-do");
        if (a.is("a")) {
            a.attr("href", "javascript:void(0)");
        }
        a.on('click', function() {
            eval(action);
            return false;
        });
    });

    // prepare forms
    $page.find("form[data-go], a[data-go]").each(function(ix, e) {
        var form = $(e);
        var goTo = form.attr("data-go");
        var sendTo = form.attr("data-to");
        var fieldSelector = "textarea";
        fieldSelector += ", input[type='password']";
        fieldSelector += ", input[type='text']";
        var fields = form.find(fieldSelector);

        form.on('submit', function() {
            if (form.is("[data-do]")) {
                var action = form.attr("data-do");
                var result = eval(action);
                if (!result) {
                    return false;
                }
            }

            var data = {};
            fields.each(function(ix, e) {
                var f = $(e);
                data[f.attr("name")] = f.val();
            });

            $.ajax({
                url : Scuttle.path("/backend" + sendTo),
                type : "POST",
                data : data
            }).done(function(response) {
                function success() {
                    Scuttle.signalSuccess();
                    Scuttle.go(goTo);
                }
                if (typeof response.success == 'undefined') {
                    success();
                } else if (response.success == true) {
                    success();
                } else {
                    Scuttle.unsuccessfullSubmission(response);
                }
            }).fail(function(req, text, exc) {
                Scuttle.formSubmissionError(req, text, exc);
            });

            return false;
        });
    });

};