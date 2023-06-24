(define (problem stack_problem) (:domain stack)
(:objects 
    steel1 steel2 steel3 steel4 steel5 - steel
    position1 - position
    truck - truck
    location1 location2 - location
)

(:init
    (clear steel1)
    (clear steel4)
    (clear steel3)
    (clear steel2)
    (clear steel5)

    (truck-in truck location1)

    (connected_by_way location1 location2)
    (connected_by_way location2 location1)


    (steel-in steel1 location1)
    (steel-in steel2 location1)
    (steel-in steel3 location1)
    (steel-in steel4 location1)
    (steel-in steel5 location1)

    (= (priority steel1) 1)
    (= (priority steel2) 2)
    (= (priority steel3) 3)
    (= (priority steel4) 4)
    (= (priority steel5) 5)

    (= (length-steel steel1 ) 2)
    (= (length-steel steel2 ) 1)
    (= (length-steel steel3 ) 8)
    (= (length-steel steel4 ) 5)
    (= (length-steel steel5 ) 6)
    (= (weight-steel steel1 ) 2)
    (= (weight-steel steel1 ) 4)
    (= (weight-steel steel1 ) 2)
    (= (weight-steel steel1 ) 9)
    (= (weight-steel steel1 ) 2)

    (= (length-truck truck) 15)
    (= (weight-turck truck) 10)


    (empty position1)

    (can-stack steel1 steel2)
    (can-stack steel1 steel3)
    (can-stack steel1 steel4)
    (can-stack steel1 steel5)
    (can-stack steel2 steel1)
    (can-stack steel2 steel3)
    (can-stack steel2 steel4)
    (can-stack steel2 steel5)
    (can-stack steel3 steel1)
    (can-stack steel3 steel2)
    (can-stack steel3 steel4)
    (can-stack steel3 steel5)
    (can-stack steel4 steel1)
    (can-stack steel4 steel2)
    (can-stack steel4 steel3)
    (can-stack steel4 steel5)
    (can-stack steel5 steel1)
    (can-stack steel5 steel2)
    (can-stack steel5 steel3)
    (can-stack steel5 steel4)


    ;todo: put the initial state's facts and numeric values here
)

(:goal (and
(steel-in steel1 location2)
(steel-in steel5 location2)
(steel-in steel4 location2)
(truck-in truck location2)

))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)