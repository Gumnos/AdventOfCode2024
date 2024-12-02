{
    left[NR] = $1 +0
    ++right[$2]
}

END {
    for (i in left)
        s += left[i] * right[left[i]]
    print s
}
