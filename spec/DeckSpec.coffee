assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      debugger;
      assert.strictEqual deck.last().cid, hand.hit().models[hand.models.length - 1].cid
      assert.strictEqual deck.length, 49
###
  beforeEach ->
    deck = new Deck()
  describe 'checkHand', ->
    it 'should check if a dealer\'s hand is under 13', ->
      assert.strictEqual hand
###
