require(['jquery', 'backbone', 'app/indexView'],
    ($, Backbone, IndexView) ->
        $(document).ready(() ->
            view = new IndexView()
            view.render()
        )
)