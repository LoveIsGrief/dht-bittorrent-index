DhtNode = require '../src/DhtNode'
DhtNodeCommander = require '../src/DhtNodeCommander'

describe "DhtNodeCommander" , ->

	describe "#parseCommand",  ->

		beforeEach ->
			@node = new DhtNode
			@node.torrentMap = {
				"infohashHerp" : "herp"
				"infohashLol" : "lol"
				"infohashLmao" : "lmao"
				"infohashMate" : "mate"
				"infohashRate" : "rate"
			}
			spyOn(@node, "getTorrentIndex").and.callThrough()

			holdResult = (result) =>
				@result = result

			@dhc = new DhtNodeCommander @node
			@dhc.init holdResult

		it "should getTorrentIndex when commanded to" , ->
			@dhc.parseCommand "getTorrentIndex"
			expect(@node.getTorrentIndex).toHaveBeenCalled()
			expect(@result).toBe @node.torrentMap
