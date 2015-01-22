argv = require 'node-argv'
_ = require "underscore"

class DhtNodeCommander

	###
	Sets up the commands a node will handle,
	which `node.method` will be called and which method the result will be passed to
	###
	constructor: (@dhtNode) ->

		# method = console.log if !method

		@program = require 'commander'

	init: (method)->
		@program
		.command("search <query>")
		.action _.compose(method, @dhtNode.search)

		#
		@program
		.command("getIndex")
		.action _.compose(method, @dhtNode.getIndex)


	parseCommand: (input) =>
		# expects argv so we simulate it
		@program.parse [1,2].concat argv(input).input

module.exports = DhtNodeCommander