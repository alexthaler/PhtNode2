(function() {
  define(['jquery', 'underscore', 'backbone'], function($, _, Backbone) {
    var indexView;
    indexView = Backbone.View.extend({
      el: '.create',
      events: {
        "click .submit": "submit_game"
      },
      render: function() {
        console.log('yay rendering!');
        return console.log(this.$el);
      },
      submit_game: function(e) {
        var game_drinks, game_name;
        game_name = this.$('.name').val();
        game_drinks = this.$('.drinks').val();
        return $.ajax({
          type: "POST",
          url: '/game/' + game_name + '/' + game_drinks,
          dataType: 'json',
          success: function(data, textStats, jqXHR) {
            return $('.gamelist').append("<option>" + data.name + "</option>");
          }
        });
      }
    });
    return indexView;
  });

}).call(this);

//# sourceMappingURL=../../../public/js/app/index.js.map
