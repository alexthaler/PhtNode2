(function() {
  require(['jquery', 'backbone', 'app/indexView'], function($, Backbone, IndexView) {
    return $(document).ready(function() {
      var view;
      view = new IndexView();
      return view.render();
    });
  });

}).call(this);

//# sourceMappingURL=../../../public/js/app/home.js.map
