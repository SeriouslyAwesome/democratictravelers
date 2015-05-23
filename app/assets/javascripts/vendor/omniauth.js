// var newwindow;
// function login(provider_url, width, height) {
//   var screenX     = typeof window.screenX != 'undefined' ? window.screenX : window.screenLeft,
//       screenY     = typeof window.screenY != 'undefined' ? window.screenY : window.screenTop,
//       outerWidth  = typeof window.outerWidth != 'undefined' ? window.outerWidth : document.body.clientWidth,
//       outerHeight = typeof window.outerHeight != 'undefined' ? window.outerHeight : (document.body.clientHeight - 22),
//       left        = parseInt(screenX + ((outerWidth - width) / 2), 10),
//       top         = parseInt(screenY + ((outerHeight - height) / 2.5), 10),
//       features    = ('width=' + width + ',height=' + height + ',left=' + left + ',top=' + top);
// 
//       newwindow = window.open(provider_url, 'Login', features);
// 
//   if (window.focus)
//     newwindow.focus();
// 
//   return false;
// }
// 
// $(function() {
// 	
// 	// close the popup window
// 
// 	if(window.opener) {
//     window.opener.location.reload(true);
//     window.close();
//   }
// 
// 	
// 	// Bind any link with a class of 'oauth'
// 	// so we can turn it into a popup window
// 	$('a.oauth').bind('click', function(e){
// 		e.preventDefault();
// 		login($(this).attr("href"), 1000, 500)
// 	});
// });