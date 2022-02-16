$(document).on('turbolinks:load', function() {
  let maxTextCount = 30;
  let textCount = $('.js-text-count-target').val().length;
  $('.js-text-count').text(textCount);
  $('.js-max-text-count').text(maxTextCount);

  $('.js-text-count-target').keyup(function() {
    let textCount = $(this).val().length;
    $('.js-text-count').text(textCount);
    if (maxTextCount < textCount && !$('.js-text-count-area').hasClass('text-danger')) {
      $('.js-text-count-area').addClass('text-danger');
    } else if (maxTextCount >= textCount && $('.js-text-count-area').hasClass('text-danger')) {
      $('.js-text-count-area').removeClass('text-danger');
    }
  });
});
