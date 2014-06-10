#= require jquery
#= require jquery_ujs
#= require galleria-1.3.5
#= require galleria.classic
#= require handlebars
#= require baseline
#= require waitForImages
#= require history
#= require router
#= require home
#= require blog
#= require about
#= require admin
#= require instafeed
#= require instagram
#= require social
#= require jquery-fileupload
#= require jquery.caret
#= require jquery.ui.draggable
#= require jquery.ui.droppable
#= require democratic.travelers
#= require handlebars.runtime
#= require_tree ./templates
#= require_tree ./modules
#= require_self

jQuery ->	
  # Responsive Menu
  $('#toggle-menu').click ->
    $('#primary-nav ul').slideToggle(150)

  # Initialize Map
  if $('#map').length
    DemocraticTravelers.Map.initialize()

  # Universal Form Handlers
  $('.toggler').click (e) ->
    e.preventDefault()
    target = $(this).attr('href')
    $(target).slideToggle('fast')

  $('.cancel').click (e) ->
    e.preventDefault()
    $(this).closest('form').slideToggle('fast')

  $('form .loader').hide()
  $('form').on 'ajax:before', ->
    $(this).find('.loader').show()
    $(this).find('p.error').remove()

  $('form').on 'ajax:complete', ->
    $(this).find('.loader').hide()