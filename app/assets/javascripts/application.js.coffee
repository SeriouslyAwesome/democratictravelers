#= require jquery
#= require jquery_ujs
#= require_tree ./vendor
#= require democratic.travelers
#= require_tree ./templates
#= require home
#= require map
#= require_tree ./map
#= require blog
#= require about
#= require admin
#= require_self

jQuery ->
  # Responsive Menu
  $('#toggle-menu').click ->
    $('#primary-nav ul').slideToggle(150)

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

  DemocraticTravelers.Blog.initialize()
