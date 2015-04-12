class window.AppView extends Backbone.View
  template: _.template '
    <div class="outcome"></div>
    <div class="wins">WINNER:</div>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': ->
      console.log('hit')
      @model.get('playerHand').hit()
    'click .stand-button': ->
      console.log('stand', @model.get('playerHand'), 'standDealer', @model.get('dealerHand'))
      @model.get('playerHand').stand()

  initialize: ->
    # on stand @model.get('dealerHand').hit()
    storage = ''
    @model.get 'playerHand'
      .on 'stand', ->
        console.log("stand");
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
        $('.outcome').html(storage);
        setTimeout (->
          #debugger
          @model.initialize()
          @render()
          return
        ).bind(this), 5000
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
      "dealer"
    else if dealer > 21
      "player"
    else if dealer > player
      "dealer"
    else if player > dealer
      "player"
    else
      "tie game"


  render: ->
    @$el.children().detach()
    @$el.html(@template())
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
