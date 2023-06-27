(define (problem stack-text-p) (:domain stack-text)
(:objects 
    steel-plate pipe angle-steel round-steel wire-rod - steel
    container0101 container0102 container2 container3 container4 container5 - container
    heavy-truck1 heavy-truck2 medium-truck light-truck mini-truck - truck
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
    (truck-in heavy-truck1 location-gas)
    (truck-in heavy-truck2 location-gas)
    (truck-in medium-truck location1)
    (truck-in light-truck location1)
    (truck-in mini-truck location2)

;the initial position of each steel
    (steel-in steel-plate location1)
    (steel-in pipe location1)
    (steel-in angle-steel location1)
    (steel-in round-steel location1)
    (steel-in wire-rod location1)


;define heavy-truck1,medium-truck,light-truck,minitruck
;define the speed,container,fuel,max-fuel,license-require of each truck
    
    ;basic information of heavy-truck
    (= (speed heavy-truck1) 20)
    (= (fuel heavy-truck1) 0)
    (= (max-fuel heavy-truck1) 100)
    (= (license-require heavy-truck1) 15)
    (can-exchange heavy-truck1)

    (with container0101 heavy-truck1)
    (empty container0101)
    (= (length-container container0101) 20)
    (= (breadth-container container0101) 15)
    (= (max-weigth container0101) 50)
    

    (= (speed heavy-truck2) 20)
    (= (fuel heavy-truck2) 0)
    (= (max-fuel heavy-truck2) 100)
    (= (license-require heavy-truck2) 15)
    (can-exchange heavy-truck2)

    (with container0102 heavy-truck2)
    (empty container0102)
    (= (length-container container0102) 20)
    (= (breadth-container container0102) 15)
    (= (max-weigth container0102) 50)

    
    ;basic information of medium-truck
    (= (speed medium-truck) 30)
    (= (fuel medium-truck) 10)
    (= (max-fuel medium-truck) 80)
    (= (license-require medium-truck) 15)

    (with container2 medium-truck)
    (empty container2)
    (= (length-container container2) 18)
    (= (breadth-container container2) 12)
    (= (max-weigth container2) 50)


    ;basic information of light-truck
    (= (speed light-truck) 20)
    (= (fuel light-truck) 0)
    (= (max-fuel light-truck) 60)
    (= (license-require light-truck) 14)

    (with container3 light-truck)
    (empty container3)
    (= (length-container container3) 14)
    (= (breadth-container container3) 10)
    (= (max-weigth container3) 50)


    ;basic information of mini-truck
    (= (speed mini-truck) 20)
    (= (fuel mini-truck) 10)
    (= (max-fuel mini-truck) 40)
    (= (license-require  mini-truck) 13)

    (with container5 mini-truck)
    (empty container4)
    (= (length-container container4) 10)
    (= (breadth-container container4) 8)
    (= (max-weigth container4) 50)



    ;whether the truck could through the location
    (available-through heavy-truck1 location1)
    (available-through heavy-truck1 location2)
    (available-through heavy-truck1 location-gas)

    (available-through heavy-truck2 location1)
    (available-through heavy-truck2 location2)
    (available-through heavy-truck2 location-gas)

    (available-through medium-truck location1)
    (available-through medium-truck  location2)
    (available-through medium-truck  location-gas)

    (available-through light-truck location1)
    (available-through light-truck location2)
    (available-through light-truck location-gas)

    (available-through mini-truck location1)
    (available-through mini-truck location2)
    (available-through mini-truck location-gas)

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
    (not (has-caculated steel-plate))
    (plate steel-plate)
    (= (priority steel-plate) 1)
    (= (length-steel steel-plate ) 2)
    (= (breadth-steel steel-plate ) 2)
    (= (heigth-steel steel-plate) 5)
    (= (quantity steel-plate) 1)

    (not (has-caculated pipe))
    (pipe pipe)
    (= (priority pipe) 4)
    (= (length-steel pipe ) 1)
    (= (breadth-steel pipe ) 4)
    (= (heigth-steel pipe) 3)
    (= (quantity pipe) 3)

    (not (has-caculated angle-steel))
    (section angle-steel)
    (= (priority angle-steel) 2)
    (= (length-steel angle-steel ) 8)
    (= (breadth-steel angle-steel ) 4)
    (= (diameter-steel angle-steel) 3)
    (= (quantity angle-steel) 3)

    (not (has-caculated round-steel))
    (section round-steel)
    (= (priority round-steel) 3)
    (= (length-steel round-steel ) 5)
    (= (breadth-steel round-steel ) 2)
    (= (diameter-steel round-steel) 3)
    (= (quantity round-steel) 3)

    (not (has-caculated wire-rod))
    (section wire-rod)
    (= (priority wire-rod) 5)
    (= (length-steel wire-rod ) 6)
    (= (breadth-steel wire-rod ) 2)
    (= (diameter-steel wire-rod) 3)
    (= (quantity wire-rod) 3)

    ;whether the steel in the initial state can be moved
    (clear steel-plate)
    (clear round-steel)
    (clear angle-steel)
    (clear pipe)
    (clear wire-rod)


    ;stackabke condition of steel 
    (can-stack steel-plate pipe)
    (can-stack steel-plate angle-steel)
    (can-stack steel-plate round-steel)
    (can-stack steel-plate wire-rod)
    (can-stack pipe steel-plate)
    (can-stack pipe angle-steel)
    (can-stack pipe round-steel)
    (can-stack pipe wire-rod)
    (can-stack angle-steel steel-plate)
    (can-stack angle-steel pipe)
    (can-stack angle-steel round-steel)
    (can-stack angle-steel wire-rod)
    (can-stack round-steel steel-plate)
    (can-stack round-steel pipe)
    (can-stack round-steel angle-steel)
    (can-stack round-steel wire-rod)
    (can-stack wire-rod steel-plate)
    (can-stack wire-rod pipe)
    (can-stack wire-rod angle-steel)
    (can-stack wire-rod round-steel)


)

(:goal (and
(steel-in steel-plate location2)
(steel-in wire-rod location2)
(steel-in round-steel location2)
(driver-in driver1 location2)
;(= (fuel heavy-truck1) (max-fuel heavy-truck1))
;(has-caculated wire-rod)

))


;(:metric minimize (+(time-cost) (money-cost)))
)

