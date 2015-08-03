# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
new_match_cnt = 1
$('document').ready ->
  $('.delete-game').click ->
    $('#delete_game_link').attr("href","/games/"+$(this).data('game-id'))
  $('#new_match').click ->
    length = $('.matches').length
    $('.match_attribute')
    console.log("new match button click")
  $('#new_tournament').click ->
    console.log("new tournament click")

