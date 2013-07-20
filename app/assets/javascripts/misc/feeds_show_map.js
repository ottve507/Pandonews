jQuery(function() {
	function showMap() {
		var options = {};
	jQuery("#feed_show_map").show("blind", options, 0, callback );
	jQuery(".feeds_show_locations").hide();
						};												
															


	function callback() {
			setTimeout(function() {
					}, 1000 );
					};

jQuery( '.feeds_show_locations' ).click(function() {
showMap();
return false;
});

//Hide map in feeds/show
jQuery("#feed_show_map").hide();
});