function dropRoom($e, to) {
    
    if ($e.is("[data-sakvv-id]")) {
        var haus = $e.attr("data-sakvv-haus");
        var raum = $e.attr("data-sakvv-raum");
        var id = $e.attr("data-sakvv-id");
        
        console.log(sprintf("Associate %s - %s (%s) with %s", haus, raum, id, to));
        
    } else if ($e.is("[data-sakai-location]")) {
        var location = $e.attr("data-sakai-location");
        
        console.log(sprintf("Associate %s with %s", location, to));
        
    } else {
        console.log("Unknown thing dropped.");
    }
    
    $e.fadeOut();
    
}
define("dropRoom", dropRoom);
