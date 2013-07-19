var $j = jQuery.noConflict();
	$j(function() {
		if ($j('.pagination').length) {
			$j(window).scroll(function() {
				var url;
				url = $j('.pagination .next_page').attr('href');
				if (url && $j(window).scrollTop() > $j(document).height() - $j(window).height() - 50) {
					$j('.pagination').text("Fetching more feeds");
					return $j.getScript(url);
				}
			});
			return $j(window).scroll();
		}
})