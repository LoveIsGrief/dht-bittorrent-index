require "sugar"
_ = require "underscore"
functional = require "./functional"

class DhtNode
	constructor: ()->
		@map = {}

	###
	Searches the map keys for the given keys

	###
	Searches the map keys for the given keys
	@returns {Object} with filtered keys that match the query
	###
	search: (query) =>
		# pick keys that start with <query>
		res = _.pick @map,
			Object.keys(@map).filter functional.func "startsWith", query
		return res

	###
	@returns {Object} All KVPs this node has
	###
	getIndex: =>
		@map

module.exports = DhtNode