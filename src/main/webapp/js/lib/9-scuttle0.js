Scuttle = {

    _initialized : false,

    _modules : {},

    _templates : {},

    _partials : {},

    _handlers : {},

    _currentPath : "",
    _currentData : {},
    _currentModule : "",

    $document : $(window.document),

    $body : null,

    $preLoading : $("#scuttle-pre-loading"),
    $loading : $("<div id='scuttle-loading'><span>Lade...</span></div>"),
    $bluescreen : $("<div id='scuttle-bluescreen'></div>"),
    $checkmark : $("<div id='scuttle-checkmark'>&#x2713;</div>"),

    $stage0 : $("<div id='scuttle-stage0'></div>"),
    $stage1 : $("<div id='scuttle-stage1'></div>"),
    $stage2 : $("<div id='scuttle-stage2'></div>"),
    $stage3 : $("<div id='scuttle-stage3'></div>"),

    $scene : $("<div id='scuttle-scene' class='scuttle'></div>"),
};
