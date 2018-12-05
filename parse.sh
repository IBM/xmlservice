#!/usr/bin/awk -f

# awk script to clean up RPG compiler output
# Only prints lines like this:
##   1396 D   NumQueues                   10I 0 const lkjwer                                                                   000058
## ======>                                            aaaaaa
## *RNF3308 20 a      000058  Keyword name is not valid; the keyword is ignored. 
# And transforms them in to this:
##   1396 D   NumQueues                   10I 0 const lkjwer                                                                   000058
##                                                    ^~~~~~
## RNF3308: Keyword name is not valid; the keyword is ignored.

BEGIN { 
    context = ""
    header_line_count = 0
    is_error_message = 0
}
/ [0-9]{4}WDS/ {
    # Found a spool file page header, ignore 3 lines
    header_line_count = 3
}
header_line_count > 0 {
    header_line_count -= 1
    next
}
/[=]{6}>/ {
    # Found an error marker (======>), print the context line and
    # altered error marker line
    
    # Convert "aa...." to "^~...."
    sub(/a/, "^")
    gsub(/a/, "~")
    # Remove error arrow
    gsub(/[=>]/, " ")
    
    print context
    print $0

    # Indicate that the next line is the error message, go to
    # processing it
    is_error_message = 1
    next
}
{
    # Save the context line until we find an error marker
    context = $0
}
is_error_message == 1 {
    # Last line was an error marker, print the error message
    is_error_message = 0

    out = substr($1,2)
    $1=$2=$3=$4=""
    print FILENAME ": " out " - " substr($0,5)
}
