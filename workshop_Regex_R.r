#####		Regular expressions in R  	#####
###  		By Rodrigo Araujo e Castro	 ####
#####  	28 March 2019  			#####
##### roacastro87@yahoo.com.br  #####

# IN THE END OF THIS FILE YOU CAN CHECK SOME TIPS ON QUERIES IN A COLUMN 
# OR IN CERTAIN COLUMN NAMES WITH THE RELEVANT DATA AND a SUGGESTED SOLUTION

# Part 1 - Text processing

# Basic steps

# check current directory
getwd()

# set new directory if necessary
setwd(choose.dir())

# list files (both commands are similar)
dir()
list.files()

# remove all objects from memory
rm(list=ls())

# importing libraries

# Necessary packages: readr, stringr, stringi and tm

# readr package

# install and load package if not present, otherwise just load them
if (!require(readr)){ # if package is not installed
	install.packages("readr")  # install package
	require(readr) # load package
} else {
	require(readr) # load package
}

# stringr package

# install and load "stringr" package if not present, otherwise just load them
if (!require(stringr)){ # if package is not installed
	install.packages("stringr")  # install package
	require(stringr) # load package
} else {
	require(stringr) # load package
}

# stringi package

# install and load "stringi" package if not present, otherwise just load them
if (!require(stringi)){ # if package is not installed
	install.packages("stringi")  # install package
	require(stringi) # load package
} else {
	require(stringi) # load package
}

# tm package

# install and load "tm" package if not present, otherwise just load them
if (!require(tm)){ # if package is not installed
	install.packages("tm")  # install package
	require(tm) # load package
} else {
	require(tm) # load package
}


#########

# importing customized function from another .R file in the same directory

# runs another script in the background, loading new functions or some other code
source ("generates_complement_function.R")

# checking if the new function was loaded
ls()

###########################################

# working with some string examples

string1 = "she can not see why she is here"
string2 = "She can not see why she is here"

# segmenting string by space (separating each word)

# "simplify" argument turns list of character vectors into matrix
string1_split = str_split(string1, pattern = " ", simplify=TRUE) # matrix
string1_split = string1_split [1,] # vector
string1_split

# locating patterns with grep

grep("she", string1)
grep("she", string2)

######################################
# QUESTIONS

# What does the output mean?

# What can we do next?

######################################

# What if we wanted to see the matches, not just the positions?

grep("she", string1, value = T)
grep("she", string1, value = TRUE)

grep("she", string2, value = TRUE)

# REMINDER: T = TRUE

# replacing patterns with native functions sub and gsub

# showing strings before change
string1
string2

# sub - replaces only the first occurence

sub("she","he",string1)

sub("she","he",string2)


# gsub - replaces all occurrences

gsub("she","he",string1)

gsub("she","he",string2)



######################################
# QUESTIONS

# What is the difference between the output of the two functions?

# Why are they different?

######################################

# replacing patterns with functions sub and gsub from stringr library

# https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html

# str_replace

str_replace (string1, "she","he")
str_replace (string2, "she","he")

# str_replace_all 

str_replace_all (string1, "she","he")
str_replace_all (string2, "she","he")

######################################
# QUESTIONS

# What is the difference between sub (and gsub)and str_replace (str_replace_all)?

# The default order of the arguments is different: 
# 	- in grep, the argument order is string, pattern, replacement
# 	- in str_replace,  the argument order is pattern, replacement, string

# While the native functions sub and gsub return a list of character vectors or a matrix (with simplify argument), 
# the functions from the stringr package always return a character vector.

# When using one or another?

# It is possible that stringr functions have been optimized (though native ones are fast enough, since they built in C),
# but ultimately it depends on which gives you the output you need in an efficient way.

######################################


#### Using regular expressions (REGEX) #### 

# excerpt from wikipedia

colonial_expansion = read_lines ("colonial_expansion_excerpt.txt")
colonial_expansion


# grep with regular expression

regex1 = "\\d+" 
# \\d means digits
# + means 1 or more

regex2 = "[[:digit:]]"

grep(regex1,str_split(colonial_expansion," ",simplify=T))
grep(regex1,str_split(colonial_expansion," ",simplify=T),value=T)

grep(regex2,str_split(colonial_expansion," ",simplify=T))
grep(regex2,str_split(colonial_expansion," ",simplify=T),value=T)



######################################
# QUESTIONS

# What is the problem with the output of this text?

# The text must be segmented by space and punctuation must be removed to get a precise result 

######################################

# We will move forward, using the stringr functions and regmatches
# More regular expressions, using 

# The most DANGEROUS and GENERAL regex: . (dot)
# . (dot) matches everything
# * matches any number of times
# .* matches everything, without limitation; that is, matches nothing in particular, unless limited by "?"

sentence = "2 eyes are better than 1, of course!"

regex = ".*"

regmatches (sentence,gregexpr(regex, sentence))

# this part 'gregexpr(regex, sentence)' gives information on the string
gregexpr(regex, sentence)

# AVOID using ".", especially in this combination.

# check this:

# Example 1

regex = "e.*"

regmatches (sentence,gregexpr(regex, sentence))

# Example 2

regex = "2.*1"

regmatches (sentence,gregexpr(regex, sentence))

# More will be shown about this topic when treating parentheses


# Quantifier * MUST be limited with ? , otherwise, the answer will not be correct.

#### More on quantifiers: 
# ? = 0 or 1 time
# + = 1 or more times
# * = any number of times
# {a,b} = matches a to b (1 to 3 numbers, for instance, if a = 1 and b = 3) 

# ? is also a limiter for the * quantifier if it follows *, so you can match what you desire, not too much

numbers = "a123456"

# matches 0 or 1 numbers
regex = "\\d?"

regmatches (numbers,gregexpr(regex,numbers))

# matches 1 or more numbers
regex = "\\d+"

regmatches (numbers,gregexpr(regex,numbers))

# matches any quantity of numbers
regex = "\\d*"

regmatches (numbers,gregexpr(regex,numbers))

# matches 1 to 3 digits
regex = "\\d{1,3}"

regmatches (numbers,gregexpr(regex,numbers))


################################################

# Some of the recommended regex


# new strings

string3 = "She can not see why he is here"
string4 = "she can not see why he is here"

regex = "s?he"
# ? makes characters optional


regex2 = "\\bs?he\\b"
# ? makes characters optional
# \\b marks word limit (by spaces)

# Briefly contrasting grep and regmatches 

grep(regex, string3,value=T)

# matching only the first match with regexpr
regmatches (string3,regexpr(regex,string3))
regmatches (string4,regexpr(regex,string4))

# matching all ocorrences with gregexpr
regmatches (string3,gregexpr(regex2,string3))
regmatches (string4,gregexpr(regex2,string4))

# invert result

regmatches (string4,gregexpr(regex2,string4), invert=TRUE)


# terms between parentheses

# Special charactes like . (dot), parenthesis, quotes and more, must be escaped with \\ (in R) or \ (in other computer languages) to be recognized literaly
# Sometimes, function arguments or options from softwares can make this explicit as well


# new example

kangaroo = "The eastern grey kangaroo (Macropus giganteus) is less well-known than the red (outside Australia)"

regex = "\\(.*\\)"
regex2 = "\\(.*?\\)"

regmatches (kangaroo, gregexpr(regex, kangaroo))
regmatches (kangaroo, gregexpr(regex2, kangaroo))


string5 = "Some of the earliest human remains found in the Americas, Luzia Woman, were found in the area of Pedro Leopoldo, Minas Gerais and provide evidence of human habitation going back at least 11,000 years"

# needed if used grep
#string5_split = strsplit(string5," ")[[1]]

regex = "[[:punct:]]"
# punctuation

#grep(regex,string5_split,value=T)
regmatches (string5,gregexpr(regex,string5))


# CHECK THIS LATER - FIX IT

# matching only the first match with regexpr
regmatches (string4,regexpr("she",string4))

# Lets compare this result with the next regex query

# matching all hits with gregexpr
regex = "s?(he)"
regmatches (string4,gregexpr("s?(he)",string4))
regmatches (string4,gregexpr(regex,string4))

# What was the problem with these results?
# Tip: track in the sentence each match


# Fixing that result delimiting the word boundary with \\b and or \\< and \\>

#regex = "\\bs?(he)\\b" # same as the one below
regex = "\\<s?(he)\\>"

regmatches (string4, gregexpr(regex, string4)) # he or she

# characters

string6 = "Beethoven composed two symphonies during the eight years he lived in the Pasqualati House"
string7 = "Beethoven composed 2 symphonies during the 8 years he lived in the Pasqualati House"

regex = "[a-zA-Z]+"

regmatches (string6, gregexpr(regex, string6))
regmatches (string7, gregexpr(regex, string7))


### Using a library to clean text with regex

removeNumbers(colonial_expansion)
removePunctuation(colonial_expansion)

# And so on

# EXERCISES


new_string = "More information can be sent to my emails redkoala@gmail.com.br or blueWombat@gmail.com until midnight."

# Create a regex to match both email addresses at the same time.

regex_email = "YOUR CODE HERE"

# Test the regex running the following command:

regmatches (new_string,gregexpr(regex_email,new_string))

# ANY SUGGESTIONS OF EXERCISES?

string_test = "YOUR STRING HERE"

regex = "YOUR REGEX HERE"

regmatches (string_test,gregexpr(regex,string_test))


################################################
################################################
################################################
################################################

# basic steps

# Part 2 - Bioinformatics

# list files with genome
dir()

# reading genome from file
bact_genome_files = dir(file.path(getwd(),"bacteria genomes"))
bact_genome_files

genome = read_lines ("Vibrio_cholerae.txt")

str(genome)

# number of characters - number of C,G,T,A
str_length(genome)

# spliting the string by character 
genome_split = str_split(string = genome, pattern = "",simplify = TRUE)

str(genome_split)

# bases counting - bottleneck of the script, since it takes some time
counting = table(genome_split)
counting

# bases proportion
proportion = 100* counting /sum(counting)
proportion

# counting cut points of DNA used to reduplicate DNA

cutpoint1 = "ATGATCAAG"
cutpoint2 = "CTTGATCAT" # reverse complement

###########################
# how to obtain cutpoint2 from cutpoint1

# reverse
# https://stackoverflow.com/questions/13612967/how-to-reverse-a-string-in-r

# stri_reverse from stringi
cutpoint2a = stri_reverse (cutpoint1)

# replace bases with the customized function "generates_complement"

# Check the function code on the "generates_complement_function.R" file

# runs another script in the background, loading new functions or some other code
#source ("generates_complement_function.R")

cutpoint2a = generates_complement (cutpoint2a)
cutpoint2a
###########################

# sample to test

# cutting the string using substr
sample = substr(genome,0,500)
sample 


sample = unlist(genome_split[1:20])

sample


# start and end position of all matches
gregexpr(cutpoint1, genome)

# all matches
regmatches (genome, gregexpr(cutpoint1, genome))



# EXERCISES

# Exercise A

# WOULD YOU LIKE TO TRY ANOTHER REGEX OR MORE COMBINATIONS? 
# FEEL FREE TO CHANGE THE REGEX BELOW AND CHECK THE RESULT
# WITH genome OR sample AS THE DATABASE


# Try different sequences here
regex = "ATGCTACT"

# querying all matches

matches = regmatches (genome, gregexpr(regex, genome))

# converting list into vector
matches = unlist(matches) 
matches

length(matches)

str(genome)



# IF YOU ARE CURIOUS, MORE ON THE NEXT SECTION

##################################################
### EASTER EGG
##################################################

############
# ATTENTION:
# THIS PART SHOULD BE RUN FROM THE SCRATCH SINCE THE FIRST COMMAND
# DELETES ALL OBJECTS CREATED PREVIOUSLY

# IF THIS IS NOT YOUR INTENTION (RUNNING FROM SCRATCH), 
# IGNORE THE FIRST COMMAND
############

# Basic steps

# clean memory to avoid errors
rm(list=ls())

# check directory
getwd()

# list files
dir()


# importing libraries (if necessary)
require(readr)
require(stringr)

genome = read_lines ("Vibrio_cholerae.txt")
genome_cut = substr(genome,1,10000)
str(genome_cut)
str_length(genome_cut)


# Regex with genome_cut and subsequent filtering

# cutting DNA into subsets of 3 bases each

str(genome_cut)
str_length(genome_cut)

# matches 0 or 1 numbers
regex = "[GTAC]{3}"


# preparing data to represent graphically
triples = regmatches (genome_cut,gregexpr(regex,genome_cut))
triples

# counting and ordering the triples by frequency
table_triples = table(triples)
table_triples = table_triples[order(table_triples, decreasing=T)]
table_triples

str(table_triples)

head(table_triples)
tail(table_triples)

# Barplot with heat colors indicating frequency of triples

graph = barplot(
	table_triples,
	horiz=T,
	main = "Frequency of the most common triples\n in the DNA of Vibrio cholerae",
	xlab = "Frequency",
	ylab = "Triples",
	cex.names = 0.75,
	xlim = c(0,120),
	col = heat.colors(64)
) 

#########

# Example of regex query

regex = "GTA[ACTG]+?T"

matches1 = regmatches (genome_cut, gregexpr(regex, genome_cut))
matches = unlist(matches1)
str(matches)

# nchar counts the number of character in a string
# to compute the lenght of each match

length_matches = unlist(lapply(matches,nchar))
str(length_matches)

# filtering matches by size (length) to obtain the longest matches

match_distr = data.frame(matches = matches, size = length_matches)
head(match_distr)

summary(match_distr)

# filtering data to obtain the highest sizes
highest = subset (match_distr, size > 10)
highest

# ordering dataframe by size
sorted_highest = highest[order (highest$size,decreasing = TRUE),]
sorted_highest

# finding the most frequent matches
# to compute the frequency of each

freq_matches = sort(unlist(table(matches)),decreasing=TRUE)

str(freq_matches)

head(freq_matches,10)

# filtering matches by frequency to obtain the most frequent matches

match_distr2 = data.frame(freq_matches)

head(match_distr2)

str(match_distr2)

# filtering to obtain the highest frequencies
highest = subset (match_distr2, Freq > 5)
highest

################################################

# TIPS

# 1- IF YOU WANT TO QUERY FOR COLUMN NAMES FOLLOWING A CERTAIN PATTERN

# Make a query as usual, but instead of the data, use the column names,
# as in "colnames (data)". Use the cheatsheet or research online if necessary.


# Example 1

# read_csv from readr library, much faster than read.csv, native from R

require(readr)

prokaryotes_sample = read_csv2 ("prokaryotes_sample.csv")
str(prokaryotes_sample)

# converting from tibble to dataframe (unnecessary, but it can be done anytime)
#prokaryotes_sample = data.frame(prokaryotes_sample)
#str(prokaryotes_sample)


# Regex for coccus bacteria

# regex means: Organism or organism, followed by underline(_) or space 
# and any text (no numbers)

regex = "[Oo]rganism[_ ][a-zA-Z]+"
column_names = colnames(prokaryotes_sample)
str(column_names)

organism_columns = regmatches (column_names, gregexpr(regex, column_names))
organism_columns = unlist(organism_columns)
organism_columns

# subseting columns of interest
subset (prokaryotes_sample, select = organism_columns)


# 2 - IF YOU WANT TO QUERY FOR DATA FOLLOWING CERTAIN PATTERNS IN A COLUMN

# First create a subset of the data selecting that column (with the subset function, for instance),
# then query with the regex. Use the cheatsheet or research online if necessary.

# Example 2

# read_csv from readr library, much faster than read.csv, native from R

require(readr)

prokaryotes_sample = read_csv2 ("prokaryotes_sample.csv")
str(prokaryotes_sample)

# converting from tibble to dataframe (unnecessary, but it can be done anytime)
#prokaryotes_sample = data.frame(prokaryotes_sample)
#str(prokaryotes_sample)


# Regex for coccus bacteria
regex = "[a-zA-Z]+coccus [a-zA-Z]+"
organisms = prokaryotes_sample$Organism_Name
str(organisms)

# positions in which regex matches
positions = grep (regex, organisms)
positions 

# subset that matches
coccus = prokaryotes_sample[positions,]
coccus 
str(coccus)
coccus [,1]

# all bacteria names

bact_names = regmatches (data, gregexpr(regex, data))
bact_names = unlist(matches)
bact_names
matches [matches != ""]



################################################


# THANKS A LOT FOR ATTENDING THIS WORKSHOP! 
# I HOPE YOU HAVE ENJOYED IT AND LEARNED A BIT ABOUT REGULAR EXPRESSIONS
# AND ONE OF ITS APPLICATIONS (IN BIOINFORMATICS)

# ANY DOUBTS YOU CAN SEND ME AN EMAIL TO roacastro87@yahoo.com.br


################################################