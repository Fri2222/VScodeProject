(define (problem stack-text-p) (:domain stack-text)
(:objects 
    steel-plate pipe angle_steel round-steel wire-rod - steel
    container1 container2 container3 container4 container5 - container
    heavy-truck medium-truck light-truck mini-truck - truck
    location1 location2 location-gas - location
    driver1 - driver
)

(:init
    ;license has divided into 16 ranks from A1 to P
    ;rank 15 for driving licence A2
    (= (license driver1) 15)

    ;the initial state of time-cost and money-cost
    (= (time-cost) 0)
    (= (money-cost) 0)

    ;the initial position of the driver
    (driver-in driver1 location1)

    ;the initial position of the truck
    (truck-in heavy-truck location-gas)
    (truck-in medium-truck location1)
    (truck-in light-truck location1)
    (truck-in mini-truck location2)

    ;the initial position of each steel
    (steel-in steel-plate location1)
    (steel-in pipe location1)
    (steel-in angle_steel location1)
    (steel-in round-steel location1)
    (steel-in wire-rod location1)


    ;define heavy-truck,medium-truck,light-truck,minitruck
    ;define the speed,container,fuel,max-fuel,license-require of each truck
    (= (speed heavy-truck) 20)
    (with container1 heavy-truck)
    (empty container1)
    (= (length-container container1) 20)
    (= (breadth-container container1) 15)
    (= (fuel heavy-truck) 0)
    (= (max-fuel heavy-truck) 100)
    (= (license-require heavy-truck) 15)

    (= (speed medium-truck) 30)
    (with container2 medium-truck)
    (empty container2)
    (= (length-container container2) 18)
    (= (breadth-container container2) 12)
    (= (fuel medium-truck) 10)
    (= (max-fuel medium-truck) 80)
    (= (license-require medium-truck) 15)

    (= (speed light-truck) 20)
    (with container3 light-truck)
    (empty container3)
    (= (length-container container3) 14)
    (= (breadth-container container3) 10)
    (= (fuel light-truck) 0)
    (= (max-fuel light-truck) 60)
    (= (license-require light-truck) 14)

    (= (speed mini-truck) 20)
    (with container5 mini-truck)
    (empty container4)
    (= (length-container container4) 10)
    (= (breadth-container container4) 8)
     (= (fuel mini-truck) 10)
    (= (max-fuel mini-truck) 40)
    (= (license-require  mini-truck) 13)

    ;road network
    (connected-by-way location1 location2)
    (= (distance location1 location2) 10)
    (connected-by-way location2 location1)
    (= (distance location2 location1) 10)

    (connected-by-way location1 location-gas)
    (= (distance location1 location-gas) 10)
    (connected-by-way location2 location-gas)
    (= (distance location2 location-gas) 10)

    (connected-by-way location-gas location1)
    (= (distance location1 location-gas) 10)
    (connected-by-way location-gas location2)
    (= (distance location-gas location1) 10)

    ;define gas-station
    (gas location-gas)


    ;the priority,length,breadth,weight of each steel
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

    ;whether the steel in the initial state can be moved
    (clear steel-plate)
    (clear round-steel)
    (clear angle_steel)
    (clear pipe)
    (clear wire-rod)


    ;stackabke condition of steel 
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


)

(:goal (and
;(steel-in steel-plate location2)
;(steel-in wire-rod location2)
(steel-in round-steel location2)
(driver-in driver1 location2)
;(= (fuel heavy-truck) (max-fuel heavy-truck))

))


(:metric minimize (+(time-cost) (money-cost)))
)
