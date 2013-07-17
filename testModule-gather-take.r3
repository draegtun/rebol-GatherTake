Rebol []

import %gather-take.r
; import 'gather-take  - doesn't seem to work?

; lets perform a simple test
expected: [10 20 30]
got: gather [for n 1 3 1 [take n * 10]]

either expected != got [
    print "Tests failed :("
][
    print "All tests passed"
]
