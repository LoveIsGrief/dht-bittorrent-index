argv = require 'node-argv'
_ = require "underscore"
Commander = require('commander').Command

class DhtNodeCommander

	constructor: (@dhtNode) ->
		@program = new Commander

	###
	Sets up the commands a node will handle,
	which `node.method` will be called and which method the result will be passed to
	###
	init: (method = console.log)->

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