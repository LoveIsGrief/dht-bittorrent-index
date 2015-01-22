# DHT Bittorrent index

A distributed index of torrents.

## Dev

	npm install -g coffee-script jasmine

	# Run tests with
	jasmine



## Specs

Each node has a hashmap of
```json
{
	"<infohash1>": "<torrent name1>",
	"<infohash2>": "<torrent name2>",
	// ...
	"<infohashN>": "<torrent nameN>",
}


### Protocol

A node should implement a protocol that allows
others nodes to query for torrents, get that node's index
and delegate a query to a certain depth.

Commands look simply like shell commands:

	<command> [args]

#### search <query>

Attempts to find a torrent with a given name.
A query language should (maybe will) be chosen to best service clients.

#### getIndex <format=JSON>

Returns the node's index in a given format (JSON is the default).

#### ...

More commands to come