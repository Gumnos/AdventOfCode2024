BEGIN {
    FS=""
    EMPTY = "."
}

function dump(label, data,        i) {
    printf("%s:", label)
    for (i=0; i<length(data); i++) printf("%s ", data[i])
    print ""
}

{
    delete data
    print (NF+1)/2, "files"
    fileno = 0
    for (offset=1; offset<=NF; offset++) {
        blocks = $offset + 0
        is_data = offset % 2 == 1
        for (i=0; i<blocks; i++) {
            data[block_counter++] = is_data ? fileno : EMPTY
        }
        if (is_data) ++fileno
    }
    #dump("before", data)
    empty_start = $1
    end = length(data) - 1
    while (i < end) {
        # find next empty
        #print "seeking", i, end
        for (i=empty_start; i < end && data[i] != EMPTY; i++) {
            #print "filedata" data[i]
        }
        while (i < end && data[i] == EMPTY) {
            while (data[end] == EMPTY) --end
            data[i++] = data[end]
            data[end--] = EMPTY
        }
    }
    ++end
    #dump(" after", data)
    for (i=0; i<end; i++) total += i * data[i]
    print total
}
