$(function() {
  $('.js-toggle-form-target').hide();
  $('.js-toggle-form-button').click(function() {
    $('.js-toggle-form-target').slideToggle(1000);
    if ($(this).text() === '検索') {
      $(this).text('閉じる');
    } else {
      $(this).text('検索');
    }
  });
});
