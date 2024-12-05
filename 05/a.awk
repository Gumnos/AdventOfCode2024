BEGIN {
    FS="|"
}

/^$/ {
    FS=","
}

FS=="|" {
    # reading orderings
    must_have_seen_before[$2, ++must_have_seen_before[$2, 0]] = $1
}

/./ && FS=="," {
    # reading pages
    delete all
    delete seen
    for (page_num=1; page_num<=NF; page_num++) {
        all[$page_num]
    }
    okay = 1
    for (page_num=1; page_num<=NF && okay; page_num++) {
        page = $page_num
        if ((page SUBSEP 0) in must_have_seen_before) {
            for (i=must_have_seen_before[$page_num, 0]; i; i--){
                probe = must_have_seen_before[$page_num, i]
                if (probe in all && !(probe in seen)) {
                    #print "failed page", $page_num, probe
                    okay = 0
                    break
                }
            }
        }
        seen[$page_num]
    }
    if (okay) {
        middle = $(int(NF/2)+1)
        # print "Okay", $0, middle
        total += middle
    }
}
END {
    print total
}
