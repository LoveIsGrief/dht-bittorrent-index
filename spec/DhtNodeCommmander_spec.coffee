DhtNode = require '../src/DhtNode'
DhtNodeCommander = require '../src/DhtNodeCommander'

describe "DhtNodeCommander" , ->

	describe "#parseCommand",  ->

		describe "getTorrentIndex" , ->

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

		describe "getNodeIndex", ->

			beforeEach ->
				@node = new DhtNode
				@node.nodeMap = {
					"localhost": 9999
					"torrentz.eu": 9999
					"thepiratebay.org": 9999
					"isohunt.com": 9999
				}
				spyOn(@node, "getNodeIndex").and.callThrough()

				holdResult = (result) =>
					@result = result

				@dhc = new DhtNodeCommander @node
				@dhc.init holdResult

			it "should respond to the call", ->
				expect(@node.getNodeIndex).toBeDefined()