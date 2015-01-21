DhtNode = require '../src/DhtNode'
DhtNodeCommander = require '../src/DhtNodeCommander'

describe "DhtNodeCommander" , ->

	describe "#parseCommand",  ->

		beforeEach ->
			@node = new DhtNode
			@node.map = {
				"herp": "derp"
				"lol": "whatever"
				"lmao": "wtf!?!?!"
				"mate": "g'day"
				"rate": "8/8"
			}
			spyOn @node, "search"
			@dhc = new DhtNodeCommander @node

		it "should search when commanded to" , ->
			@dhc.parseCommand "search h"
			expect(@node.search).toHaveBeenCalled()
