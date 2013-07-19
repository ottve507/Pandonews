jQuery(function() {
	function hidePlate() {
		var options = {};
		// run the effect
	jQuery( "#myplates" ).hide("blind", options );
	jQuery("#myplatesbutton").show();
	jQuery("#myplatesbutton2").hide();
};

function hideSecondaryPlate() {
	var options = {};
		// run the effect
	jQuery( "#secondaryplates" ).hide("blind", options );
	jQuery("#secondaryplatesbutton").show();
	jQuery("#secondaryplatesbutton2").hide();
};

function hideFriends() {
	var options = {};
		// run the effect
	jQuery( "#friendslist" ).hide("blind", options );
	jQuery("#friendslistbutton").show();
	jQuery("#friendslistbutton2").hide();
};

// set effect from select menu value
jQuery( "#myplatesbutton2" ).click(function() {
hidePlate();
return false;
});

jQuery( "#secondaryplatesbutton2" ).click(function() {
hideSecondaryPlate();
return false;
});

jQuery( "#friendslistbutton2" ).click(function() {
hideFriends();
return false;
});

});