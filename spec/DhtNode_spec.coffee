net = require "net"
log4js = require "log4js"
DhtNode = require "../src/DhtNode"
config = require "../config/config"

logger = log4js.getLogger "DhtNode_spec"
logger.setLevel config.logLevel

describe "DhtNode", ->

	createNode= ->
		node = new DhtNode()
		node.map = {
			"infohashHerp": "herp"
			"infohashHerpaDerp": "herpderpa"
			"infohashDerp": "derp"
			"infohashLol": "lol"
		}
		return node

	describe "#search", ->

		beforeEach ->
			@node = createNode()

		it "should search for items", ->
			expect(@node.search "l").toEqual { "infohashLol": "lol" }

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

			it "should respond to getIndex", (done) ->
				expectedIndex = JSON.stringify @node.map
				@socket.on "data", (buffer)=>
					data = buffer.toString()
					expect(data).toEqual expectedIndex
					done()

				@socket.write "getIndex"

			it "should respond to search", (done) ->
				expected = JSON.stringify {
						"infohashHerp": "herp"
						"infohashHerpaDerp": "herpderpa"
					}

				@socket.on "data", (buffer)=>

					received = buffer.toString()
					expect(received).toEqual expected
					done()

				@socket.write "search h"