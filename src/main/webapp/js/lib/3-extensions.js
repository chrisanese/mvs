/* extend jQuery for elementFromPoint, from: http://www.zehnet.de/2010/11/19/document-elementfrompoint-a-jquery-solution/ */
(function($) {
    var check = false, isRelative = true;

    $.elementFromPoint = function(x, y) {
        if (!document.elementFromPoint)
            return null;

        if (!check) {
            var sl;
            if ((sl = $(document).scrollTop()) > 0) {
                isRelative = (document.elementFromPoint(0, sl
                        + $(window).height() - 1) == null);
            } else if ((sl = $(document).scrollLeft()) > 0) {
                isRelative = (document.elementFromPoint(sl + $(window).width()
                        - 1, 0) == null);
            }
            check = (sl > 0);
        }

        if (!isRelative) {
            x += $(document).scrollLeft();
            y += $(document).scrollTop();
        }

        return $(document.elementFromPoint(x, y));
    };
})(jQuery);

$.expr[":"].contains = $.expr.createPseudo(function(arg) {
    return function(elem) {
        return $(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
    };
});

/* Array Remove - By John Resig (MIT Licensed) */
Array.prototype.remove = function(from, to) {
    var rest = this.slice((to || from) + 1 || this.length);
    this.length = from < 0 ? this.length + from : from;
    return this.push.apply(this, rest);
};

/* http://stackoverflow.com/questions/646628/javascript-startswith */
if (typeof String.prototype.startsWith != 'function') {
    String.prototype.startsWith = function(str) {
        return this.lastIndexOf(str, 0) === 0;
    };
}

/* jQuery UI Combobox from http://jqueryui.com/autocomplete/#combobox */
(function($) {
    $
            .widget(
                    "custom.combobox",
                    {
                        _create : function() {
                            this.wrapper = $("<span>").addClass(
                                    "custom-combobox")
                                    .insertAfter(this.element);

                            this.element.hide();
                            this._createAutocomplete();
                            this._createShowAllButton();
                        },

                        _createAutocomplete : function() {
                            var selected = this.element.children(":selected"), value = selected
                                    .val() ? selected.text() : "";

                            this.input = $("<input>")
                                    .appendTo(this.wrapper)
                                    .val(value)
                                    .attr("title", "")
                                    .addClass(
                                            "custom-combobox-input ui-widget ui-widget-content ui-state-default ui-corner-left")
                                    .autocomplete({
                                        delay : 0,
                                        minLength : 0,
                                        source : $.proxy(this, "_source")
                                    }).tooltip({
                                        tooltipClass : "ui-state-highlight"
                                    });

                            this._on(this.input, {
                                autocompleteselect : function(event, ui) {
                                    ui.item.option.selected = true;
                                    this._trigger("select", event, {
                                        item : ui.item.option
                                    });
                                },

                                autocompletechange : "_removeIfInvalid"
                            });
                        },

                        _createShowAllButton : function() {
                            var input = this.input, wasOpen = false;

                            $("<a>").attr("tabIndex", -1).attr("title",
                                    "Show All Items").tooltip().appendTo(
                                    this.wrapper).button({
                                icons : {
                                    primary : "ui-icon-triangle-1-s"
                                },
                                text : false
                            }).removeClass("ui-corner-all").addClass(
                                    "custom-combobox-toggle ui-corner-right")
                                    .mousedown(
                                            function() {
                                                wasOpen = input.autocomplete(
                                                        "widget")
                                                        .is(":visible");
                                            }).click(function() {
                                        input.focus();

                                        // Close if already visible
                                        if (wasOpen) {
                                            return;
                                        }

                                        // Pass empty string as value to search
                                        // for, displaying all results
                                        input.autocomplete("search", "");
                                    });
                        },

                        _source : function(request, response) {
                            var matcher = new RegExp($.ui.autocomplete
                                    .escapeRegex(request.term), "i");
                            response(this.element.children("option").map(
                                    function() {
                                        var text = $(this).text();
                                        if (this.value
                                                && (!request.term || matcher
                                                        .test(text)))
                                            return {
                                                label : text,
                                                value : text,
                                                option : this
                                            };
                                    }));
                        },

                        _removeIfInvalid : function(event, ui) {

                            // Selected an item, nothing to do
                            if (ui.item) {
                                return;
                            }

                            // Search for a match (case-insensitive)
                            var value = this.input.val(), valueLowerCase = value
                                    .toLowerCase(), valid = false;
                            this.element
                                    .children("option")
                                    .each(
                                            function() {
                                                if ($(this).text()
                                                        .toLowerCase() === valueLowerCase) {
                                                    this.selected = valid = true;
                                                    return false;
                                                }
                                            });

                            // Found a match, nothing to do
                            if (valid) {
                                return;
                            }

                            // Remove invalid value
                            this.input.val("").attr("title",
                                    value + " didn't match any item").tooltip(
                                    "open");
                            this.element.val("");
                            this._delay(function() {
                                this.input.tooltip("close").attr("title", "");
                            }, 2500);
                            this.input.data("ui-autocomplete").term = "";
                        },

                        _destroy : function() {
                            this.wrapper.remove();
                            this.element.show();
                        }
                    });
})(jQuery);