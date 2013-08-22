jQuery(function() {
	function runEffect() {
		var options = {};
	jQuery("#myplates").show("blind", options, 0, callback );
	jQuery("#myplatesbutton").hide();
	jQuery("#myplatesbutton2").show();
						};
						
    function replyComment() {
		var options = {};
		jQuery("#replywindow").show();
		jQuery("#replytocomment").hide();
		jQuery("#replytocomment2").show();
		
	};

     function replyComment2() {
			var options = {};
	      		jQuery("#replywindow").hide();
			    jQuery("#replytocomment").show();
                jQuery("#replytocomment2").hide();
	    };
			
	function showSecondary() {
			var options = {};
	jQuery("#secondaryplates").show("blind", options, 0, callback );
	jQuery("#secondaryplatesbutton").hide();
	jQuery("#secondaryplatesbutton2").show();
								};
								
	function showFriends() {
			var options = {};
	jQuery("#friendslist").show("blind", options, 0, callback );
	jQuery("#friendslistbutton").hide();
	jQuery("#friendslistbutton2").show();
															};	
															
															


	function callback() {
			setTimeout(function() {
					}, 1000 );
					};
	
jQuery( "#myplatesbutton" ).click(function() {
runEffect();
return false;
});

jQuery( "#replytocomment" ).click(function() {
replyComment();
return false;
});

jQuery( "#replytocomment2" ).click(function() {
replyComment2();
return false;
});

jQuery( "#secondaryplatesbutton" ).click(function() {
showSecondary();
return false;
});

jQuery( "#friendslistbutton" ).click(function() {
showFriends();
return false;
});

jQuery( "#myplates" ).hide();
jQuery( "#replywindow" ).hide();
jQuery("#myplatesbutton2").hide();
jQuery("#secondaryplates").hide();
jQuery("#secondaryplatesbutton2").hide();
jQuery("#friendslist").hide();
jQuery("#friendslistbutton2").hide();
jQuery("#replytocomment2").hide();
});