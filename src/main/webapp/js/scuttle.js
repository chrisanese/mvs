var Scuttle = {};

Scuttle.templates = {};
Scuttle.isShowing = false;
Scuttle.isDebug = true;
Scuttle.globalTemplates = null;
Scuttle.$document = $(window.document);
Scuttle.handlers = {};

/**
 * Log a message (this might go to console.log as well as to a special DOM
 * object).
 */
Scuttle.log = function(message) {
	console.log(message);
};

/**
 * Report an error.
 */
Scuttle.report = function(message) {
	console.log(message);
};

/**
 * Ask the server for data (via POST).
 */
Scuttle.ask = function(what, data, onSuccess, onFail) {
	var buttons = $("input[type='submit']");
	buttons.attr('disabled', 'disabled');
	if (typeof data == 'string') {
		var formData = {};
		$(data).find("input[name]").each(function(index, element) {
			var value = null;
			element = $(element);
			switch (element.attr('type')) {
			case 'checkbox':
				value = element.is(":checked");
				break;
			default:
				value = element.val();
				break;
			}
			formData[element.attr('name')] = value;
		});
		data = formData;
	}
	$.ajax({
		type : "POST",
		dataType : 'json',
		url : 'backend/' + what,
		data : data
	}).done(function(data) {
		buttons.removeAttr('disabled');
		if (typeof onSuccess == 'function') {
			onSuccess(data);
		}
	}).fail(function(error) {
		buttons.removeAttr('disabled');
		Scuttle.notify("Fehler beim Kommunizieren mit dem Server.", 'fail');
		if (typeof onFail == 'function') {
			onFail(error);
		}
	});
};

/**
 * Attach an event handler to the document.
 */
Scuttle.on = function(selector, handler) {
	Scuttle.$document.on(selector, handler);
	if (typeof Scuttle.handlers[selector] == 'undefined') {
		Scuttle.handlers[selector] = [];
	}
	Scuttle.handlers[selector].push(handler);
};

/**
 * Remove all event handlers previously associated via Scuttle.on
 */
Scuttle.off = function() {
	for ( var selector in Scuttle.handlers) {
		for ( var ix in Scuttle.handlers[selector]) {
			Scuttle.$document.off(selector, Scuttle.handlers[selector][ix]);
		}
	}
};

Scuttle.timeout = {};

/**
 * Notify the user about something.
 */
Scuttle.notify = function(message, addClass) {
	var oldNotifications = $(".scuttle-notification");
	oldNotifications.fadeOut(function() {
		oldNotifications.remove();
	});
	var notification = $("<div class='scuttle-notification'><span>" + message
			+ "</span></div>");
	if (typeof addClass == 'string') {
		notification.addClass(addClass);
	}
	clearTimeout(Scuttle.timeout);
	notification.hide().appendTo(Scuttle.$body).fadeIn(function() {
		notification.on('click', function() {
			notification.fadeOut(function() {
				notification.remove();
			});
		});
	});
	Scuttle.timeout = setTimeout(function() {
		notification.click();
	}, 3000);
};

/**
 * Issue a warning to the user.
 */
Scuttle.warn = function(message) {
	Scuttle.notify(message, "warn");
};

/**
 * Load Scuttle. This function will replace itself with the empty function once
 * done.
 */
Scuttle.load = function(message) {
	// Cache the jQuery body element.
	Scuttle.$body = $("body");

	Scuttle.showLoadingScreen(message);

	// Remove all intermediate loading screens.
	$(".scuttle-interlude").remove();

	// Create the stage which contains the scenes.
	Scuttle.$stage = $("<div id='scuttle-stage'></div>'").appendTo(
			Scuttle.$body);

	// Create the scenery in which everything will happen.
	Scuttle.$scenery = $("<div id='scuttle-scenery'></div>").appendTo(
			Scuttle.$stage);

	// It should not be visible yet, therefor hide it.
	Scuttle.$stage.hide();

	// Zero out the function.
	Scuttle.load = function() {
	};
};

/**
 * Shows the loading screen.
 */
Scuttle.showLoadingScreen = function(message) {
	// Set a loading message if non has been given to this function.
	if (typeof message == 'undefined') {
		message = "Scuttle is loading...";
	}

	// Hide scrollbars of outer document.
	Scuttle.$body.addClass("scuttle-overflow-hidden");

	// Create the loading screen.
	Scuttle.$loading = $(
			"<div id='scuttle-loading'><span>" + message + "</span></div>")
			.appendTo(Scuttle.$body);
};

/**
 * Hides the loading screen if it is shown. It is shown iff Scuttle.$loading is
 * not undefined.
 */
Scuttle.hideLoadingScreen = function() {
	if (typeof Scuttle.$loading != 'undefined') {
		Scuttle.$loading.fadeOut(function() {
			Scuttle.$loading.remove();
			delete Scuttle.$loading;
		});
	}
};

/**
 * Load the templates for a specific module from the given jsonData.
 * 
 * This method does not perform an AJAX request, but merely does the mustache.js
 * compilation of templates.
 */
Scuttle.loadTemplates = function(what, jsonData) {
	Scuttle[what].partials = {};
	Scuttle[what].templates = {};

	if (what != "_global") {
		// Compile the templates for this Module
		for ( var name in jsonData.templates) {
			var rawTemplate = jsonData.templates[name];
			var template = Mustache.compile(rawTemplate);
			Scuttle[what].templates[name] = template;
		}

		// Also create references to the existing global templates,
		// prefixed with _global.
		for ( var name in Scuttle._global.partials) {
			Scuttle[what].partials[name] = Scuttle._global.partials[name];
		}
	}

	// Compile the partials for this Module
	for ( var name in jsonData.partials) {
		var rawTemplate = jsonData.partials[name];
		if (what == "_global") {
			name = "global_" + name;
		}
		var template = Mustache.compilePartial(name, rawTemplate);
		Scuttle[what].partials[name] = template;
	}
};

/**
 * Open a certain Module screen.
 * 
 * This methods calls Scuttle.load() which will load Scuttle if it is not yet
 * there already. It will than load the Module if that is not there already. It
 * goes on to render the result from module.show(). See Scuttle.render() below.
 */
Scuttle.show = function(what, options) {
	Scuttle.load();
	Scuttle.off();

	if (typeof options == 'undefined') {
		options = {};
	}

	if (typeof Scuttle._global == 'undefined') {
		$.ajax({
			url : "backend/templates/_global",
			dataType : "json"
		}).done(function(jsonData) {
			Scuttle._global = {};
			Scuttle.loadTemplates("_global", jsonData);
			Scuttle.show(what, options);
		}).fail(
				function() {
					Scuttle.notify("Could not load templates from the server.",
							'fail');
				});
		return;
	}

	var render = function() {
		if (typeof options == 'string') {
			$.ajax({
				type : "POST",
				url : "backend/" + options,
				dataType : "json"
			}).done(function(jsonData) {
				var data = Scuttle[what].show(jsonData);
				Scuttle.render(data);
			});
		} else {
			var data = Scuttle[what].show(options);
			Scuttle.render(data);
		}
	};
	render;

	var show = function() {
		if (typeof Scuttle[what].templates == 'undefined'
				&& typeof Scuttle[what].partials == 'undefined') {
			$.ajax({
				url : "backend/templates/" + what,
				dataType : "json"
			}).done(function(jsonData) {
				Scuttle.loadTemplates(what, jsonData);
				render();
			}).fail(function() {
				Scuttle.report("Could not load templates.");
			});
		} else {
			render();
		}
	};

	if (typeof Scuttle[what] == 'undefined') {
		$.getScript("backend/scripts/" + what).done(function() {
			setTimeout(show, 250);
		}).fail(function() {
			Scuttle.report("Could not load modules.");
		});
	} else {
		show();
	}
};

/**
 * Creates a new view inside the Scuttle.$scenery.
 */
Scuttle.render = function(html) {
	Scuttle.hideLoadingScreen();

	// Remove the old children
	var children = Scuttle.$scenery.children();
	children.hide().remove();

	// Insert the newly generated html
	Scuttle.$scenery.html(html);

	// Turn on jQuery ui Accordions
	Scuttle.$scenery.find(".fx-accordion").accordion({
		heightStyle : "content",
		activate : function(event, ui) {
			ui.newPanel.find("input[type='text']:first").focus();
		}
	});

	if (!Scuttle.isShowing) {
		Scuttle.$body.addClass("scuttle-overflow-hidden");
		Scuttle.$stage.fadeIn();
		Scuttle.isShowing = true;
	}
};

/**
 * Hide the whole Scuttle thingie (which is in Scuttle.$stage).
 */
Scuttle.hide = function() {
	Scuttle.$stage.fadeOut(function() {
		Scuttle.$body.removeClass("scuttle-overflow-hidden");
		Scuttle.isShowing = false;
	});
};
