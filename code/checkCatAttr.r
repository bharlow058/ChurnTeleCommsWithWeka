for(i in 191:229) {
	print(i)
	values <- names(table(orange.train[[i]]))
	for(j in 1:length(values)) {
		if(values[j] == '') {
			next
		}
		for(k in (i+1):229) {

			if(isTRUE(any(orange.train[[k]] == values[j]))) {
				cat(values[j], ",", k, " - ", any(orange.train[[k]] == values[j]), "\n")
			}
		}
	}
}