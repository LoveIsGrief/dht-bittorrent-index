net = require "net"
DhtNode = require '../src/DhtNode'

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
				@socket.on "end", ->
					done()
				@node.end()

			it "should respond to getIndex", (done) ->
				index = JSON.stringify @node.map

				@socket.on "data", (buffer)=>
					data = buffer.toString()
					expect(data).toEqual index
					done()

				@socket.write "getIndex"

			it "should respond to search", (done) ->
				expected = JSON.stringify {
						"infohashHerp": "herp"
						"infohashHerpaDerp": "herpderpa"
					}

				@socket.on "data", (buffer)=>

					received = buffer.toString()
					expect(reveiced).toEqual expected
					done()

				@socket.write "search h"