{
    s = $0
    while (match(s, /mul\([0-9][0-9]*,[0-9][0-9]*\)/)) {
        # 4=length("mul(")
        # 5=length("mul(") + length(")")
        m = substr(s, RSTART+4 , RLENGTH-5)
        split(m, a,/,/)
        product = a[1] * a[2]
        # print m, product
        total += product
        s = substr(s, RSTART+RLENGTH)
    }
}
END {
    print total
}
