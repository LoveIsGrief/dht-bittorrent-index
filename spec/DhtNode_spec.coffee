net = require "net"
log4js = require "log4js"
Q = require "q"
DhtNode = require "../src/DhtNode"
config = require "../config/config"

logger = log4js.getLogger "DhtNode_spec"
logger.setLevel config.logLevel

# https://jasmine.github.io/2.0/custom_matcher.html
customMatchers =

	toBeInstanceOf: (util, customEqualityTesters)->
		compare: (actual, expected)->
			pass: (actual instanceof expected)

	toBePromise: (util, customEqualityTesters)->
		compare: (actual, expected)->
			pass: (Q.isPromise actual)

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

	beforeEach ->
		jasmine.addMatchers customMatchers

	describe "network" , ->

		describe "forever alone" , ->

			# Connect client and server
			beforeEach (done)->
				@ip = "localhost"
				@port = 9000
				@node = createNode()
				@node.start(@ip, @port)
				.then =>
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

	describe "promises" , ->

		describe "when starting", ->

			beforeEach ->
				@node = new DhtNode

			it "should return a promise", ->
				promise = @node.start()
				expect(promise).toBePromise()

			it "should successfully create a server and resolve promise", (done)->
				@node.start("localhost", 9999)
				.then done

			it "should successfully create a server and reject promise", (done)->
				# Port 80 is a priliged port
				@node.start("localhost", 80)
				.catch done

		describe "when ending" , ->

			beforeEach ->
				@node = new DhtNode

			it "should return a promise", ->
				expect(@node.end()).toBePromise()

			it "should promise failure when no server exists", (done)->
				@node.end().catch done