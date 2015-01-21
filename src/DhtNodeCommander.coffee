argv = require 'node-argv'

class DhtNodeCommander
	constructor: (@dhtNode) ->
		@program = require 'commander'
		#
		@program
		.command("search <query>")
		.action @dhtNode.search

		#
		@program
		.command("getIndex")
		.action @dhtNode.getIndex


	parseCommand: (input) =>
		# expects argv so we simulate it
		@program.parse [1,2].concat argv(input).input

module.exports = DhtNodeCommander