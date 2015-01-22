DhtNode = require '../src/DhtNode'

describe 'DhtNode', ->

	beforeEach ->
		@node = new DhtNode()
		@node.map = {
			"infohashHerp": "herp"
			"infohashHerpaDerp": "herpderpa"
			"infohashDerp": "derp"
			"infohashLol": "lol"
		}

	describe "#search", ->
		it "should search for items", ->
			expect(@node.search "l").toEqual { "infohashLol": "lol" }
