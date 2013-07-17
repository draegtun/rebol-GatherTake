Rebol [
    Title: "Gather-Take series builder"
    Name: gather-take
    File: %gather-take.r
    Purpose: "flexible/lazy way to build series"
    Author: "Barry Walsh (Draegtun)"
    src: https://github.com/draegtun/rebol-GatherTake
    Date: 8-June-2013
    Version: 0.1.2
    Type: module
    Exports: [gather]
]

gather: func [
    "Lazy(ish) series builder - GATHER series by TAKE(ing) things"
    block [block!] "code block that performs the GATHER"
    /with take-name [word!] "TAKE with different WORD" 
    /local coll gather-take change-all-takes
  ][
    coll: copy []
    if not with [take-name: 'take]  ; default is TAKE unless /with refinement used
    gather-take: func [x] [append coll x]

    ; :block <- change all 'take to our gather-take func 
    ; (recurse down thru all nested blocks)
    change-all-takes: func [series] [
        replace/all series take-name 'gather-take
        if not find series block! [return series]
        foreach word series [
            if block? word [change-all-takes word]
        ]
    ]

    ; lets make change to :block
    change-all-takes block

    ;probe block
    do block
    coll
]

; examples
comment {

    ; simple
    even-nums:  gather [for n 1 100 1 [if even? n [take n]]]

    ; bit more practical
    series: gather [foreach this from-series [if some-cond? this [take this + 1]]]
}

    
