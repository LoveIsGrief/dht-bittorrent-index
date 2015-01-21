###
Sets up a predicate function that will call a function of
the specific name and with the specific args, of a given object

@example
	startsWithSomething = func("startsWith", "something")
	startsWithSomething( "nope" ) # will return false
@returns Function predicate function
###
exports.func = (name, args...)->
	(object)->
		object[name](args)