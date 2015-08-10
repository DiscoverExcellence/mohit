# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('document').ready ->
  $('.delete-record').click ->
    href_split_arr = $('#delete-modal-link').attr('href').split("/")
    href_split_arr[href_split_arr.length - 1] = $(this).data('delete-id')
    href = href_split_arr.join("/")
    $('#delete-modal-link').attr('href',href)