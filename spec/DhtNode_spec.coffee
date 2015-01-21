DhtNode = require '../src/DhtNode'

describe 'DhtNode', ->

	beforeEach ->
		@node = new DhtNode()
		@node.map = {
			"lol": "herp"
			"damn": "derp"
		}

	describe "#search", ->
		it "should search for items", ->
			expect(@node.search "l").toEqual { "lol": "herp" }