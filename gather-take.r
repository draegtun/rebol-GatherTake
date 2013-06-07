Rebol [
    Title: "Gather-Take series builder"
    File: %gather-take.r
    Purpose: ""
    Author: "Barry Walsh (Draegtun)"
    Home: "Put github page"
    Date: 2-May-2013
    Version: 0.1.0
    Type: 'module
    Exports: [gather]
]

gather: func [block /local coll gather-take gather-count change-all-takes] [
    coll: copy []
    gather-take: func [x] [append coll x]
    gather-count: 0

    ; :block <- change all 'take to our gather-take func 
    ; (recurse down thru all nested blocks)
    change-all-takes: func [series] [
        replace/all series 'take 'gather-take
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

