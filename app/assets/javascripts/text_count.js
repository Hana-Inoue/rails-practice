$(document).on('turbolinks:load', function() {
  function countText(targetId) {
    let target = $(`#${targetId}`);
    let maxTextCount = target.data('max-length');
    let textCount = target.val().length;
    let textCounter = $(`#${targetId}-counter`);
    textCounter.text(`${textCount}/${maxTextCount}`);
    return { maxTextCount: maxTextCount, textCount: textCount, textCounter: textCounter }
  }

  function changeTextCounterColor(textCounter) {
    textCounter.toggleClass('text-danger');
  }

  $('.js-text-counter-target').each(function() {
    countText($(this).attr('id'));
  });
  $('.js-text-counter-target').keyup(function() {
    let { maxTextCount, textCount, textCounter } = countText($(this).attr('id'));
    if ((maxTextCount < textCount && !textCounter.hasClass('text-danger')) ||
        (maxTextCount >= textCount && textCounter.hasClass('text-danger'))) {
      changeTextCounterColor(textCounter);
    }
  });
});
