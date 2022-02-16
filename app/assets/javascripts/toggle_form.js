$(document).on('turbolinks:load', function() {
  $('.js-toggle-form-target').hide();

  let buttonText = $('.js-toggle-form-button').text();

  $('.js-toggle-form-button').click(function() {
    $('.js-toggle-form-target').slideToggle(1000);
    if ($(this).text() === buttonText) return $(this).text('閉じる');
    $(this).text(buttonText);
  });
});
