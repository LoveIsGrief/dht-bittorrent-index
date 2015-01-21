require "sugar"
_ = require "underscore"
functional = require "./functional"

class DhtNode
	constructor: ()->
		@map = {}

	###
	Searches the map keys for the given keys

	@returns Array of key-value pairs (KVPs) that match the query
	###
	search: (query) ->
		# pick keys that start with <query>
		_.pick @map,
			Object.keys(@map).filter functional.func "startsWith", query

	###
	@returns Object All KVPs this node has
	###
	getIndex: ->
		@map

module.exports = DhtNode