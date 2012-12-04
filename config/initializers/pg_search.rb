PgSearch.multisearch_options = {
	:using => {
		:tsearch => {
			:dictionary => "simple"
		},
		:trigram => {}
	},
	:ignoring => :accents
}