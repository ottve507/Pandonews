jQuery(function() {
  return jQuery('#feed_category_name').autocomplete({
	select: function(event, ui){		
		$j('#cronfeed_hidden_field_url').val(ui.item.id);
		$j('#cronfeed_hidden_field_lang').val(ui.item.value);
		$j('#feed_category_name').val(ui.item.value);		
		return true;
	},
    source: $j('#feed_category_name').data('autocomplete-source')
  }).data( "ui-autocomplete" )._renderItem = function( ul, item ) {
	return $( "<li>" )
	.append( "<a>"+ '<img src="' + item.feedpic + '"> ' + item.feed_title + "<br>"+ item.address + "</a>" )
	.appendTo( ul );
  };
}
);

jQuery(function submitMyForm(){
    $j('#new_feed').submit(function(){
	    $j('#cronfeed_hidden_field_type').val($('#feed_category_name').val());	
	});
});