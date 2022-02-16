$(document).on('turbolinks:load', function() {
  $('.js-toggle-form-target').hide();

  let buttonText = $('.js-toggle-form-button').text();

  $('.js-toggle-form-button').click(function() {
    $('.js-toggle-form-target').slideToggle(1000);
    let textToRender = $(this).text() === buttonText ? '閉じる' : buttonText;
    $(this).text(textToRender);
  });
});
