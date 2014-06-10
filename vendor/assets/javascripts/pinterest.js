$(document).ready(function(){
	if (!$('#map-container').length) {
		// Pinterest
		(function(d){
		  var f = d.getElementsByTagName('SCRIPT')[0], p = d.createElement('SCRIPT');
		  p.type = 'text/javascript';
		  p.setAttribute('data-pin-hover', true);
		  p.async = true;
		  p.src = '//assets.pinterest.com/js/pinit.js';
		  f.parentNode.insertBefore(p, f);
		}(document));
	};
})
