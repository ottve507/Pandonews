jQuery(function() {
    jQuery('#dialog').dialog({
        autoOpen: false,
		resizable: false,
		modal: true,
		height:300,
		width:300
    });
    jQuery('#create-user').click(function() {
        jQuery('#dialog').dialog('open');
    });
});