class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2><h3 class="outcome"></h3>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  checkHand: ->
    if @.collection.minScore() > 21
      "You lost"

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]
    @$('.outcome').text @checkHand()

