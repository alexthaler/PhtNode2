(function() {
  require(['jquery', 'backbone', 'app/gameView'], function($, Backbone, GameView) {
    return $(document).ready(function() {
      var view;
      view = new GameView();
      return view.render();
    });
  });

}).call(this);

//# sourceMappingURL=../../../public/js/app/game.js.map
