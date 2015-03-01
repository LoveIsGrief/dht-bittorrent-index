# DHT Bittorrent index

A distributed index of torrents.

# Possible ways this could work

## Read-only nodes

Each node would either:

 * respond to requests from other nodes to read certain information like:
   * map of infohashes to torrent names
   * list of nodes known to the node
 * send such requests to other nodes

This approach could reduce the load on single nodes. It would be up to a node
to build its index of torrents and nodes. Any searches would then be done on the local db.

## Distributed search power

Each node would respond to search requests and implement their own search algorithm
to return a list of results.

It can also cascade the requests to other nodes in order to find what was requested,
but that isn't necessary to be implemented on all nodes. It could be implemented on nodes
that have many search requests and belong to one network / owner e.g one website that cascades it's search
to its other nodes.

Otherwise it also responds to requests of node indexes.

# Dev

	npm install -g coffee-script jasmine

	# Run tests with
	jasmine


# Specs

Each node has a hashmap of
```json
{
	"<infohash1>": "<torrent name1>",
	"<infohash2>": "<torrent name2>",
	// ...
	"<infohashN>": "<torrent nameN>",
}
```

## Protocol

A node should implement a protocol that allows
others nodes to query for torrents, get that node's index of torrents
and index of known nodes.

Commands look simply like shell commands:

	<command> [args]

### search <query>

Attempts to find a torrent with a given name.
A query language should (maybe will) be chosen to best service clients.

### getNodeIndex <format=JSON>

Returns the node's index of torrents in a given format (JSON is the default).

### getNodesIndex <format=JSON>

Returns the node's index of nodes in a given format (JSON is the default).

This is the list index/list of nodes known to the node. It should be regularly checked for dead nodes,
either by the node returning the index of the node requesting it.

### ...

More commands to come
