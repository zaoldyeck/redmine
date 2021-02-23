function jsZenEdit(textArea, options) {
  if (!document.createElement) { return; }

  if (!textArea) { return; }

  if ((typeof(document["selection"]) == "undefined")
  && (typeof(textArea["setSelectionRange"]) == "undefined")) {
    return;
  }

  this.options = options || {};
  this.title = this.options['title'] || 'Zen';
  this.$textArea = $(textArea);
  this.$textArea.attr('placeholder', this.options['placeholder']);

  var $jstEditor = this.$textArea.parent('.jstEditor');
  this.$jstEditor = $jstEditor;

  var $jstBlock = $jstEditor.parent();
  this.$toolBar = $jstBlock.find('.jstElements');

  var that = this;

  // Add the theme button
  var $themeButton = $('<button type="button" tabindex="200" class="jstb_zenedit theme"></button>');
  $themeButton.attr('title', this.title);
  $jstEditor.append($themeButton);
  $themeButton.on('click', function () {
    try {
      $jstEditor.toggleClass('dark-theme');
      that.$textArea.focus();
    } catch (e) {}
    return false;
  });

  this.addZenButton();

  // Add listener for "escape" key
  document.onkeydown = function (evt) {
    evt = evt || window.event;
    if (evt.keyCode == 27) {
      var $jstElements = $('.jstElements.zen').removeClass('zen');
      $jstElements.removeAttr("style");

      var $jstEditor = $('.jstEditor.zen');
      $jstEditor.removeClass('zen');

      var $textArea = $jstEditor.find('textarea');
      $textArea.removeAttr("style");
      $textArea.focus();

      $('html.zen').removeClass('zen');
      $('#zenPreview').remove();
    }
  };
}

jsZenEdit.prototype = {
  addZenButton: function () {
    var that = this;

    that.$zenButton = $('<button type="button" tabindex="200" class="jstb_zenedit"></button>');
    that.$zenButton.attr('title', this.title);
    that.$jstEditor.append(that.$zenButton);

    that.$zenButton.on('click', function () {
      try {
        that.$jstEditor.toggleClass('zen');
        that.$toolBar.toggleClass('zen');
        that.$toolBar.removeAttr("style");
        that.$textArea.removeAttr("style");
        $('#zenPreview').remove();
        $('html').toggleClass('zen');
        that.$textArea.focus();
      } catch (e) {}
      return false;
    });

    // Toggle together with $textArea
    if ('MutationObserver' in window) {
      var observer = new MutationObserver(function(mutationList, observer) { that.visibilityByTextArea(that.$zenButton) });
      observer.observe(that.$textArea[0], { 'attributes': true, 'attributeFilter': ['class'] });
    } else {
      $(document).on('click', function (event) { that.visibilityByTextArea(that.$zenButton) });
      $(document).on('keydown', function (event) {
        if (event.which == 13 || event.keyCode == 13) { // Enter
          that.visibilityByTextArea(that.$zenButton)
        }
      });
    }
  },

  visibilityByTextArea: function($target) {
    $target.toggle(!this.$textArea.is(':hidden'))
  },
};
