// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-datepicker
//= require_tree .
window.setTimeout(function() {
  document.getElementsByClassName("flash")[0].style.display="none";
  document.getElementsByClassName("flash")[1].style.display="none";
}, 3000);
$(function() {
  return $(document).on('click', '.delete-record', function() {
  href_split_arr = $('#delete-modal-link').attr('href').split("/");
  href_split_arr[href_split_arr.length - 1] = $(this).data('delete-id');
  href = href_split_arr.join("/");
  $('#delete-modal-link').attr('href',href);
});
});
