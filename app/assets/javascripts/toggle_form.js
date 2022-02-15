$(document).on('turbolinks:load', function() {
  $('.js-toggle-form-target').hide();
  var buttonText = $('.js-toggle-form-button').text();
  $('.js-toggle-form-button').click(function() {
    $('.js-toggle-form-target').slideToggle(1000);
    if ($(this).text() === buttonText) {
      $(this).text('閉じる');
    } else {
      $(this).text(buttonText);
    }
  });
});
