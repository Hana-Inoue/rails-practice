class TextCounter {
  constructor(targetId) {
    this.target = $(`#${targetId}`);
    this.maxTextCount = this.target.data('max-length');
    this.textCount = this.target.val().length;
    this.textCountArea = $(`#${targetId}-count-area`);
  }

  countText() {
    this.textCountArea.text(`${this.textCount}/${this.maxTextCount}`);
  }

  isValid() {
    return this.textCount <= this.maxTextCount;
  }

  stopWarning() {
    if (!this.isAlreadyWarned()) return
    this.textCountArea.removeClass('text-danger');
  }

  startWarning() {
    if (this.isAlreadyWarned()) return
    this.textCountArea.addClass('text-danger');
  }

  isAlreadyWarned() {
    return this.textCountArea.hasClass('text-danger');
  }
}

$(document).on('turbolinks:load', function() {
  $('.js-text-count-target').each(function() {
    new TextCounter($(this).attr('id')).countText();
  });

  $('.js-text-count-target').keyup(function() {
    let textCounter = new TextCounter($(this).attr('id'));
    textCounter.countText();
    textCounter.isValid() ? textCounter.stopWarning() : textCounter.startWarning();
  });
});
