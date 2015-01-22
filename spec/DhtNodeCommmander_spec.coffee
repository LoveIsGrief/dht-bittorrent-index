DhtNode = require '../src/DhtNode'
DhtNodeCommander = require '../src/DhtNodeCommander'

describe "DhtNodeCommander" , ->

	describe "#parseCommand",  ->

		beforeEach ->
			@node = new DhtNode
			@node.map = {
				"infohashHerp" : "herp"
				"infohashLol" : "lol"
				"infohashLmao" : "lmao"
				"infohashMate" : "mate"
				"infohashRate" : "rate"
			}
			spyOn(@node, "search").and.callThrough()
			spyOn(@node, "getIndex").and.callThrough()

			holdResult = (result) =>
				@result = result

			@dhc = new DhtNodeCommander @node
			@dhc.init holdResult

		it "should search when commanded to" , ->
			@dhc.parseCommand "search h"
			expect(@node.search).toHaveBeenCalled()
			expect(@result).toEqual { "infohashHerp" : "herp" }

		it "should getIndex when commanded to" , ->
			@dhc.parseCommand "getIndex"
			expect(@node.getIndex).toHaveBeenCalled()
			expect(@result).toBe @node.map
