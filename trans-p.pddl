(define (problem trans-p) (:domain trans)
(:objects 
    s - steel
    t - truck
    location1 location2 location3 - location
)

(:init
    (= (time-cost) 0)
    (waiting-to-load s)
    (steel-in s location1)
    (truck-in t location1)
    (q1 s)
    (world)
    (at-goal-location s location3)

    (connected-by-way location1 location2)
    (connected-by-way location2 location3)
    (= (distance location1 location2) 2)
    (= (distance location2 location3) 2)
)

(:goal (and
    (steel-in s location3)
    (world)
))

(:metric minimize (time-cost))
)
