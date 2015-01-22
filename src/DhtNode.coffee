require "sugar"
_ = require "underscore"
functional = require "./functional"

###
A P2P node that can listen to a port on an interface and react to commands given to it by clients.
###
class DhtNode
	constructor: ()->
		@map = {}
		@server = null

	###
	Starts the server on the given interface and port
	@param interface
	@param port
	###
	start: (@interface,@port)->

	###
	Searches the map keys for the given keys
	@returns {Object} with filtered keys that match the query
	###
	search: (query) =>
		# pick keys that have values starting with <query>
		res = _.pick @map,
			Object.keys(@map).filter (key)=>
				@map[key].startsWith query
		return res

	###
	@returns {Object} All KVPs this node has
	###
	getIndex: =>
		@map

module.exports = DhtNode