Rebol [
    Title: "Gather-Take series builder"
    File: %gather-take.r
    Purpose: ""
    Author: "Barry Walsh (Draegtun)"
    Home: "Put github page"
    Date: 18-Apr-2013
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

;gather [print "hello" take [and take [take2 etake nothing here [take here]]] take]

a: gather [
    a: "test"
    take uppercase a
    for n 1 2 1 [
        take n
        for coll 10 15 1 [take coll + n]
    ]
    if true [take "END"]
]

probe a
