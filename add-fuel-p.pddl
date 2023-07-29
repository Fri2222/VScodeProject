(define (problem add-fuel-p) (:domain add-fuel)
(:objects 
    steel-plate1 steel-plate2 steel-plate3 steel-plate4 
    pipe angle-steel round-steel wire-rod - steel
    container-heavy1 container-heavy2 container-medium container-light container-mini - container
    heavy-truck1 heavy-truck2 medium-truck light-truck mini-truck - truck
    location1 location2 location3 location4 location5 location6
    location7 location8 location9 location10 - location
    gas-station1 gas-station2 - location
    driver1 - driver
)

(:init

    (gas gas-station1)
    (gas gas-station2)
;license has divided into 16 ranks from A1 to P
    ;rank 15 for driving licence A2
    (= (license driver1) 15)

;the initial state of time-cost and money-cost
    (= (time-cost) 0)
    (= (money-cost) 0)

;the initial position of the driver
    (driver-in driver1 location1)

;the initial position of the truck
    (truck-in heavy-truck1 location1)
    (truck-in heavy-truck2 location1)
    (truck-in medium-truck location1)
    (truck-in light-truck location1)
    (truck-in mini-truck location2)

;the initial position of each steel
    (steel-in steel-plate1 location1)
    (steel-in pipe location1)
    (steel-in angle-steel location1)
    (steel-in round-steel location1)
    (steel-in wire-rod location1)

;define heavy-truck1,medium-truck,light-truck,minitruck
;define the speed,container,fuel-truck-truck,max-fuel-truck,license-require of each truck
    
    (= (speed heavy-truck1) 20)
    (= (fuel-truck heavy-truck1) 0.5)
    (= (max-fuel-truck heavy-truck1) 300)
    (= (license-require heavy-truck1) 15)
    (can-exchange heavy-truck1)

    (with container-heavy1 heavy-truck1)
    (empty container-heavy1)
    (= (length-container container-heavy1) 20)
    (= (breadth-container container-heavy1) 15)
    (= (current-weight container-heavy1) 0)
    (= (max-weigth container-heavy1) 50)
    

    (= (speed heavy-truck2) 20)
    (= (fuel-truck heavy-truck2) 0)
    (= (max-fuel-truck heavy-truck2) 100)
    (= (license-require heavy-truck2) 15)
    (can-exchange heavy-truck2)

    (with container-heavy2 heavy-truck2)
    (empty container-heavy2)
    (= (length-container container-heavy2) 20)
    (= (breadth-container container-heavy2) 15)
    (= (current-weight container-heavy2) 0)
    (= (max-weigth container-heavy2) 50)

    
    ;basic information of medium-truck
    (= (speed medium-truck) 30)
    (= (fuel-truck medium-truck) 0)
    (= (max-fuel-truck medium-truck) 80)
    (= (license-require medium-truck) 15)

    (with container-medium medium-truck)
    (empty container-medium)
    (= (length-container container-medium) 18)
    (= (breadth-container container-medium) 12)
    (= (current-weight container-medium) 50)
    (= (max-weigth container-medium) 50)


    ;basic information of light-truck
    (= (speed light-truck) 20)
    (= (fuel-truck light-truck) 0)
    (= (max-fuel-truck light-truck) 60)
    (= (license-require light-truck) 14)

    (with container-light light-truck)
    (empty container-light)
    (= (length-container container-light) 14)
    (= (breadth-container container-light) 10)
    (= (current-weight container-light) 50)
    (= (max-weigth container-light) 50)


    ;basic information of mini-truck
    (= (speed mini-truck) 20)
    (= (fuel-truck mini-truck) 0)
    (= (max-fuel-truck mini-truck) 40)
    (= (license-require  mini-truck) 13)

    (with container-mini mini-truck)
    (empty container-mini)
    (= (length-container container-mini) 10)
    (= (breadth-container container-mini) 8)
    (= (current-weight container-mini) 50)
    (= (max-weigth container-mini) 50)




;road network

    ;road connecting location1
    (connected-by-way location1 location2)
    (= (distance location1 location2) 10)
    (connected-by-way location2 location1)
    (= (distance location2 location1) 10)

    (connected-by-way location1 gas-station1)
    (= (distance location1 gas-station1) 5)
    (connected-by-way gas-station1 location1)
    (= (distance location1 gas-station1) 5)

    ;road connecting location2
    (connected-by-way location2 gas-station1)
    (= (distance location2 gas-station1) 100)
    (connected-by-way gas-station1 location2)
    (= (distance gas-station1 location1) 100)

    ;road connecting location3
    (connected-by-way location3 gas-station1)
    (= (distance location3 gas-station1) 10)
    (connected-by-way gas-station1 location3)
    (= (distance gas-station1 location3) 10)

    (connected-by-way location3 location2)
    (= (distance location3 location2) 10)
    (connected-by-way location2 location3)
    (= (distance location2 location3) 10)

    ;road connecting location4
    (connected-by-way location4 gas-station1)
    (= (distance location4 gas-station1) 10)
    (connected-by-way gas-station1 location4)
    (= (distance gas-station1 location4) 10)

    (connected-by-way location3 location4)
    (= (distance location3 location4) 10)
    (connected-by-way location4 location3)
    (= (distance location4 location3) 10)

    ;road connecting location5
    (connected-by-way location4 gas-station2)
    (= (distance location4 gas-station2) 10)
    (connected-by-way gas-station2 location4)
    (= (distance gas-station2 location4) 10)

    (connected-by-way location5 location4)
    (= (distance location5 location4) 10)
    (connected-by-way location5 location3)
    (= (distance location5 location3) 10)

    (connected-by-way location5 location1)
    (= (distance location5 location1) 10)
    (connected-by-way location5 location1)
    (= (distance location5 location1) 10)

    ;road connecting location6
    (connected-by-way location6 gas-station2)
    (= (distance location6 gas-station2) 10)
    (connected-by-way gas-station2 location6)
    (= (distance gas-station2 location6) 10)

    (connected-by-way location6 location4)
    (= (distance location6 location4) 10)
    (connected-by-way location5 location3)
    (= (distance location5 location3) 10)

    (connected-by-way location6 location1)
    (= (distance location6 location1) 10)
    (connected-by-way location6 location1)
    (= (distance location6 location1) 10)

    (connected-by-expressway location6 location3)
    (= (distance location6 location3) 10)
    (connected-by-expressway location6 location3)
    (= (distance location6 location3) 10)





    ;the priority,length,breadth,weight of each steel
    (not (has-caculated steel-plate1))
    (plate steel-plate1)
    (= (priority steel-plate1) 1)
    (= (length-steel steel-plate1 ) 2)
    (= (breadth-steel steel-plate1 ) 2)
    (= (heigth-steel steel-plate1) 5)
    (= (quantity steel-plate1) 1)

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
    (clear steel-plate1)
    (clear round-steel)
    (clear angle-steel)
    (clear pipe)
    (clear wire-rod)


    ;stackabke condition of steel 
    (can-stack steel-plate1 pipe)
    (can-stack steel-plate1 angle-steel)
    (can-stack steel-plate1 round-steel)
    (can-stack steel-plate1 wire-rod)
    (can-stack pipe steel-plate1)
    (can-stack pipe angle-steel)
    (can-stack pipe round-steel)
    (can-stack pipe wire-rod)
    (can-stack angle-steel steel-plate1)
    (can-stack angle-steel pipe)
    (can-stack angle-steel round-steel)
    (can-stack angle-steel wire-rod)
    (can-stack round-steel steel-plate1)
    (can-stack round-steel pipe)
    (can-stack round-steel angle-steel)
    (can-stack round-steel wire-rod)
    (can-stack wire-rod steel-plate1)
    (can-stack wire-rod pipe)
    (can-stack wire-rod angle-steel)
    (can-stack wire-rod round-steel)


)

(:goal (and
(steel-in steel-plate1 location2)
(steel-in wire-rod location2)
(steel-in round-steel location2)


))


(:metric minimize (+ (time-cost) (money-cost)))
)