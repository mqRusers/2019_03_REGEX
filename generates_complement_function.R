# Function to replace the bases with their complements

############################################

generates_complement = function (string) {

	# split strings by char and creates vector
	string_cut = unlist(strsplit (string, ""))

	# replaces the bases with their complement
	# A to T
	# T to A
	# C to G
	# G to C

	# empty string
	complement = ""

	for (char in string_cut) {
		if (char == "A") {
			complement = append(complement,"T")
		#print(complement)
		} else if (char == "T") {
			complement = append(complement,"A")
		#print(complement)
		} else if (char == "G") {
			complement = append(complement,"C")
		#print(complement)
		} else { # if char == "C"
			complement = append(complement,"G")
		#print(complement)
		}
	}

	# removes initial empty string
	if (complement[1] == "") {
		complement = complement [-1]
	}
	
	# restores the string
	complement = paste(complement, collapse='')
	
	return (complement)

}

############################################