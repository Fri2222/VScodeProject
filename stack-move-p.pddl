(define (problem stack_problem) (:domain stack-text )
(:objects 
    steel-plate pipe angle_steel round-steel wire-rod - steel
    container1 container2 container3 container4 container5 - container
    heavy-truck medium-truck light-truck mini-truck - truck
    location1 location2 - location
)

(:init

    (= (time-cost) 0)

    (truck-in heavy-truck location1)
    (= (speed heavy-truck) 20)
    (with container1 heavy-truck)
    (empty container1)
        (= (length-container container1) 20)
    (= (breadth-container container1) 15)
    

    (truck-in medium-truck location1)
    (= (speed medium-truck) 30)
    (with container2 medium-truck)
    (empty container2)
     (= (length-container container2) 18)
    (= (breadth-container container2) 12)
    

    (truck-in light-truck location1)
    (= (speed light-truck) 20)
    (with container3 light-truck)
    (empty container3)
     (= (length-container container3) 14)
    (= (breadth-container container3) 10)
    




    (truck-in mini-truck location1)
    (= (speed mini-truck) 20)
    (with container4 mini-truck)
    (empty container4)
      (= (length-container container4) 10)
    (= (breadth-container container4) 8)
   


    (connected-by-way location1 location2)
    (= (distance location1 location2) 10)
    (connected-by-way location2 location1)
    (= (distance location2 location1) 10)


    (steel-in steel-plate location1)
    (steel-in pipe location1)
    (steel-in angle_steel location1)
    (steel-in round-steel location1)
    (steel-in wire-rod location1)

    (= (priority steel-plate) 1)
    (= (length-steel steel-plate ) 2)
    (= (breadth-steel steel-plate ) 2)
    (= (weight-steel steel-plate) 5)


    (= (priority pipe) 4)
    (= (length-steel pipe ) 1)
    (= (breadth-steel pipe ) 4)
    (= (weight-steel pipe) 3)

    (= (priority angle_steel) 2)
    (= (length-steel angle_steel ) 8)
    (= (breadth-steel angle_steel ) 4)
    (= (weight-steel angle_steel) 3)

    (= (priority round-steel) 3)
    (= (length-steel round-steel ) 5)
    (= (breadth-steel round-steel ) 2)
    (= (weight-steel round-steel) 3)

    (= (priority wire-rod) 5)
    (= (length-steel wire-rod ) 6)
    (= (breadth-steel wire-rod ) 2)
    (= (weight-steel wire-rod) 3)

    (clear steel-plate)
    (clear round-steel)
    (clear angle_steel)
    (clear pipe)
    (clear wire-rod)





    (can-stack steel-plate pipe)
    (can-stack steel-plate angle_steel)
    (can-stack steel-plate round-steel)
    (can-stack steel-plate wire-rod)
    (can-stack pipe steel-plate)
    (can-stack pipe angle_steel)
    (can-stack pipe round-steel)
    (can-stack pipe wire-rod)
    (can-stack angle_steel steel-plate)
    (can-stack angle_steel pipe)
    (can-stack angle_steel round-steel)
    (can-stack angle_steel wire-rod)
    (can-stack round-steel steel-plate)
    (can-stack round-steel pipe)
    (can-stack round-steel angle_steel)
    (can-stack round-steel wire-rod)
    (can-stack wire-rod steel-plate)
    (can-stack wire-rod pipe)
    (can-stack wire-rod angle_steel)
    (can-stack wire-rod round-steel)


    ;todo: put the initial state's facts and numeric values here
)

(:goal (and
(steel-in steel-plate location2)
(steel-in wire-rod location2)
(steel-in round-steel location2)
(steel-on round-steel steel-plate)

))


(:metric minimize (time-cost))
)