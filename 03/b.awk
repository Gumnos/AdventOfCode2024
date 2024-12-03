{
    s = $0
    while (mul_start = match(s, /mul\([0-9][0-9]*,[0-9][0-9]*\)/)) {
        # preserve RLENGTH because searching for do/don't tromps
        mul_len = RLENGTH
        before = substr(s, 1, mul_start - 1)
        while (match(before, /do(n't)?\(\)/)) {
            conditional = substr(before, RSTART, RLENGTH)
            disabled = conditional == "don't()"
            # print "state:", conditional, disabled
            before = substr(before, RSTART+RLENGTH)
        }

        # 4=length("mul(")
        # 5=length("mul(") + length(")")
        params = substr(s, mul_start+4 , mul_len-5)
        split(params, a,/,/)
        product = a[1] * a[2]
        # print params, product

        if (!disabled) total += product

        s = substr(s, mul_start+mul_len)
    }
}

END {
    print total
}
