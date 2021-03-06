require "sugar"
_ = require "underscore"
config = require '../config/config'
DhtNodeCommander = require "./DhtNodeCommander"
functional = require "./functional"
log4js = require "log4js"
net = require "net"
Q = require "q"

logger = log4js.getLogger("DhtNode")
logger.setLevel config.logLevel

###
A P2P node that can listen to a port on an interface and react to commands given to it by clients.
###
class DhtNode
	constructor: ()->
		@torrentMap = {}
		@nodeMap = {}
		@server = null
		@commander = null

	###
	Promises to start the server on the given interface and port

	Configures it to attempt to execute commands and
	return their results in JSON format

	@param interface {String} Which interface to listen on
	@param port {Integer} Which port to listen on
	###
	start: (@interface,@port)->

		deferred = Q.defer()
		@commander = new DhtNodeCommander @
		logger.debug "Going to create a server #{@interface}:#{@port}"
		@server = net.createServer (socket)=>

			socketString = "#{socket.remoteAddress}:#{socket.remotePort}"
			logger.debug "Connection from #{socketString}"

			# Handle successfully parsed data
			@commander.init (result)=>
				ret = JSON.stringify result
				logger.debug "Sending back data (to:#{socketString})", ret
				socket.write ret

			# Parse incoming data
			socket.on "data", (buffer)=>
				input = buffer.toString()
				logger.debug "[#{socketString}]Got input data: ", input
				@commander.parseCommand input

		# Promise.catch on error
		@server.on "error", deferred.reject

		# Actually creates the server
		@server.listen @port, @interface, ->
			logger.debug "Created server"
			deferred.resolve()

		deferred.promise


	###
	Promises to end the server.
	###
	end: ->
		deferred = Q.defer()
		if @server and @server.address()
			serverString = @server.address()
			serverString = "#{serverString.address}:#{serverString.port}"
			@server.on "close", =>
				delete @server
				logger.debug "Closed server: ", serverString
				deferred.resolve()
			@server.close()
			logger.debug "Waiting for server to close..."

		else
			setTimeout ->
				deferred.reject "Server doesn't exist"
			, 1

		deferred.promise

	###
	Searches the map keys for the given keys
	@returns {Object} with filtered keys that match the query
	###
	search: (query) =>
		# pick keys that have values starting with <query>
		res = _.pick @torrentMap,
			Object.keys(@torrentMap).filter (key)=>
				@torrentMap[key].startsWith query
		return res

	###
	@returns {Object} All torrent KVPs this node has
	###
	getTorrentIndex: =>
		@torrentMap

	###
	@returns {Object} All node KVPs this node has
	###
	getNodeIndex: =>
		@nodeMap



module.exports = DhtNode