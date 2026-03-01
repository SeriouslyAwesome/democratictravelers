//= require jquery
//= require rails-ujs
//= require jquery-fileupload
//= require jquery-ui/widgets/draggable
//= require jquery-ui/widgets/droppable
//= require_tree ./vendor
//= require democratic.travelers
//= require_tree ./templates
//= require home
//= require map
//= require_tree ./map
//= require blog
//= require about
//= require admin
//= require instagram
//= require_self

$(document).ready(function() {
  // Responsive Menu
  $('#toggle-menu').click(function() {
    $('#primary-nav ul').slideToggle(150);
  });

  // Universal Form Handlers
  $('.toggler').click(function(e) {
    e.preventDefault();
    var target = $(this).attr('href');
    $(target).slideToggle('fast');
  });

  $('.cancel').click(function(e) {
    e.preventDefault();
    $(this).closest('form').slideToggle('fast');
  });

  $('form .loader').hide();
  $('form').on('ajax:before', function() {
    $(this).find('.loader').show();
    $(this).find('p.error').remove();
  });

  $('form').on('ajax:complete', function() {
    $(this).find('.loader').hide();
  });

  DemocraticTravelers.Blog.initialize();
});
