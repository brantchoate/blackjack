class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    # on stand @model.get('dealerHand').hit()
    storage = ''
    @model.get 'playerHand'
      .on 'stand', ->
        @model.get 'dealerHand'
          .models[0]
          .flip()
          storage = @getHands()
        while @model.get 'dealerHand'
          .minScore() <= 15
            @model.get 'dealerHand'
            .hit()
            storage = @getHands()
        console.log storage
      ,@
    @render()

  getHands: ->
    player = @model
        .get 'playerHand'
        .minScore()
    dealer = @model
        .get 'dealerHand'
        .minScore()
    if player > 21
      "dealer wins"
    else if dealer > 21
      "player wins"
    else if dealer > player
      "dealer wins"
    else if player > dealer
      "player wins"
    else
      "tie game"

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

