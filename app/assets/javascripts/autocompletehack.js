jQuery(function() {
  return jQuery('#feed_url').autocomplete({
    source: $j('#feed_url').data('autocomplete-source')
  });
});