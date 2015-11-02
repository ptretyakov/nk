var indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

define(function(require) {
  'use strict';
  var Marionette, Scrollfade;
  Marionette = require('marionette');
  require('jquery-ui');
  Scrollfade = Marionette.Behavior.extend({
    defaults: {
      animation: {
        effect: 'bounce',
        duration: 'right',
        time: 500,
        type: 'show'
      }
    },
    ui: {
      'FadeTargets': '.js-scrollfade'
    },
    events: {
      "click @ui.FadeTargets": 'showTestMessage'
    },
    showTestMessage: function(e) {
      return this.play(e.currentTarget);
    },

    /**
    		 * Метод отрабатывает при появляении страницы, можно сказать старт
    		 * @return Void
     */
    onShow: function() {
      this.prepareElements();
      return this.listenEvents();
    },

    /**
    		 * Метод устанвливает прослушку на необходимые события
    		 * @return Void
    		 * @param Function action - параметр указывает обработчик при срабатывания события
     */
    listenEvents: function() {
      var _this;
      _this = this;
      return $(window).scroll(function() {
        var setBottomScrollEvent;
        setBottomScrollEvent = function(element) {
          var bottom_of_object, bottom_of_window;
          bottom_of_object = $(element).position().top + $(element).outerHeight();
          bottom_of_window = $(window).scrollTop() + $(window).height();
          if (bottom_of_window > bottom_of_object) {
            return _this.play(element);
          }
        };
        return _this.handleElements(setBottomScrollEvent);
      });
    },

    /**
    		 * Метод делает анимацию элемента необходимым способом
    		 * @return Void
     */
    play: function(element) {
      var data;
      data = this.getOptions(element);
      switch (data.type) {
        case 'hide':
          return $(element).hide(data.effect, data, data.time);
        case 'show':
          return $(element).show(data.effect, data, data.time);
      }
    },

    /**
    		 * Получаем параметры  data-scrollfade-* из тега
    		 * @return Object data -> объект с параметрами элемента
     */
    getOptions: function(element) {
      var data, tmp;
      data = {};
      tmp = element.dataset;
      data.effect = tmp.scrollfadeEffect != null ? tmp.scrollfadeEffect : this.defaults.animation.effect;
      data.duration = tmp.scrollfadeDuration != null ? tmp.scrollfadeDuration : this.defaults.animation.duration;
      data.time = tmp.scrollfadeTime != null ? tmp.scrollfadeTime : this.defaults.animation.time;
      data.type = tmp.scrollfadeType != null ? tmp.scrollfadeType : this.defaults.animation.type;
      return data;
    },
    handleElements: function(callbacks) {
      var HandleDebug, i, j, n, ref, results;
      HandleDebug = true;
      if (this.ui.FadeTargets.length > 0) {
        results = [];
        for (i = j = 0, ref = this.ui.FadeTargets.length; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
          if (isFunction(callbacks)) {
            if (HandleDebug) {
              console.log('behaviors/scrollfade.handleDebug(): This is [FUNCTION] callback');
            }
            results.push(callbacks(this.ui.FadeTargets[i]));
          } else if (isArray(callbacks)) {
            if (HandleDebug) {
              console.log('behaviors/scrollfade.handleDebug(): This is [ARRAY] callbacks');
            }
            results.push((function() {
              var results1;
              results1 = [];
              for (n in callbacks) {
                if (!callbacks.hasOwnProperty(i)) {
                  continue;
                }
                results1.push(callbacks[n](this.ui.FadeTargets[i]));
              }
              return results1;
            }).call(this));
          } else if (isString(callbacks) && (callbacks != null) && indexOf.call(this, callbacks) >= 0) {
            if (HandleDebug) {
              console.log('behaviors/scrollfade.handleDebug(): This is [STRING] callback');
            }
            results.push(console.log('test'));
          } else {
            results.push(void 0);
          }
        }
        return results;
      }
    },

    /**
    		 * Метод подготавливает элементы перед навешиванием событий
     */
    prepareElements: function() {
      var action;
      return action = function(element) {
        var elements;
        return elements = [];
      };
    }
  });
  return Scrollfade;
});
