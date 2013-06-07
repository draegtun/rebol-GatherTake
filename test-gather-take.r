Rebol []

do %gather-take.r

;; test 1 - simple usage pattern
e1: ["START" 1 11 12 13 14 15 16 2 12 13 14 15 16 17 "END"]
t1: gather [
    a: "start"
    take uppercase a
    for n 1 2 1 [
        take n
        for coll 10 15 1 [take coll + n]
    ]
    if true [take "END"]
]


;; tests 2-4 - nested gather/takes
e2: [12 13 14 15 16 17]
e3: [15 14 13 12 11 10 9 8 7 6 5 4 3 2 1]
e4: ["start" 1 2 "end"]
t2: t3: none
t4: gather [
    a: "START"
    take lowercase a
    for n 1 2 1 [
        take n
        t2: gather [for coll 10 15 1 [
            take coll + n
            if all [n = 1 coll = 15] [t3: gather [
                for x coll n -1 [take x]
            ]]
        ]]
    ]
    if true [take "end"]
]


;; test 5 TBD - check /only (appending lists)
;; test 6 - check calling function with gather causes no probs

;; do tests
tests: reduce [
    e1 = t1
    e2 = t2
    e3 = t3
    e4 = t4
]

failed-tests: map-each n tests [n = false]

either any failed-tests [
    print "Tests failed :("
    probe tests
][
    print "All tests passed"
]

