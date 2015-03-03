net = require "net"
log4js = require "log4js"
DhtNode = require "../src/DhtNode"
config = require "../config/config"

logger = log4js.getLogger "DhtNode_spec"
logger.setLevel config.logLevel

describe "DhtNode", ->

	createNode= ->
		node = new DhtNode()
		node.torrentMap = {
			"infohashHerp": "herp"
			"infohashHerpaDerp": "herpderpa"
			"infohashDerp": "derp"
			"infohashLol": "lol"
		}
		node.nodeMap = {
			"localhost": 9999
			"torrentz.eu": 9999
			"thepiratebay.org": 9999
			"isohunt.com": 9999
		}
		return node

	describe "network" , ->

		describe "forever alone" , ->

			# Connect client and server
			beforeEach (done)->
				@ip = "localhost"
				@port = 9000
				@node = createNode()
				@node.start @ip, @port, =>
					@socket = net.connect { port: @port}, =>
						done()


			# Disconnect client and server
			afterEach (done)->
				port = @socket.localPort
				@socket.on "end", ->
					logger.debug "closed socket: #{port}"
					done()
				@socket.end()
				@node.end()

			it "should respond to getTorrentIndex", (done) ->
				expectedIndex = JSON.stringify @node.torrentMap
				@socket.on "data", (buffer)=>
					data = buffer.toString()
					expect(data).toEqual expectedIndex
					done()

				@socket.write "getTorrentIndex"

			it "should respond to getNodeIndex", (done) ->
				expectedIndex = JSON.stringify @node.nodeMap
				@socket.on "data", (buffer)=>
					data = buffer.toString()
					expect(data).toEqual expectedIndex
					done()

				@socket.write "getNodeIndex"
