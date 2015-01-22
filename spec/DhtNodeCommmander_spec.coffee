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
			spyOn(@node, "search").and.callThrough()
			spyOn(@node, "getIndex").and.callThrough()

			holdResult = (result) =>
				@result = result

			@dhc = new DhtNodeCommander @node, holdResult

		it "should search when commanded to" , ->
			@dhc.parseCommand "search h"
			expect(@node.search).toHaveBeenCalled()
			expect(@result).toEqual { "herp": "derp" }

		it "should getIndex when commanded to" , ->
			@dhc.parseCommand "getIndex"
			expect(@node.getIndex).toHaveBeenCalled()
			expect(@result).toBe @node.map
