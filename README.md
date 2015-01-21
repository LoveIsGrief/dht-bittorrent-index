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
	"<torrent name1>": "<magnet link1>",
	"<torrent name2>": "<magnet link2>",
	// ...
	"<torrent nameN>": "<magnet linkN>",
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