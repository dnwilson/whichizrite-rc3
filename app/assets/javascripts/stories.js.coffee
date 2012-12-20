PrivatePub.subscribe "/posts", (data, channel) ->
	alert data.story.content