(define (problem ltltext-p) (:domain ltltext)
(:objects 
    steel-text - steel
    container-heavy1 container-medium - container
    Six-Axle-Truck Four-Axle-Truck - truck
    location_load1 location_load2 location_load3 - location 
    location_unload4 location_unload5 location_unload6 - location
    location_unload7 - location

)

(:init
    (= (time-cost) 0)
    (= (money-cost) 0)

    (=(priority steel-text)1)
    (clear steel-text)
;the initial position of the truck
    (truck-in Six-Axle-Truck location_load1)
    (truck-in Four-Axle-Truck location_load1)
;the initial position of each steel
    (steel-in steel-text location_load1)

    (= (fuel-truck Six-Axle-Truck) 3)
    (= (max-fuel-truck Six-Axle-Truck) 6)
    (= (fuel-consumption-coefficient Six-Axle-Truck) 0.031);燃油缩放100倍距离缩放10倍，单位每31升/每100公里->单位燃油0.031 单位距离1

    ;油耗22升每百公里
    ;basic information of Four-Axle-Truck
    (= (fuel-truck Four-Axle-Truck) 0)
    (= (max-fuel-truck Four-Axle-Truck) 6)
    (= (fuel-consumption-coefficient Four-Axle-Truck) 0.022)

    (connected-by-way location_load1 location_load2)
    (= (distance location_load1 location_load2) 0.05)
    (connected-by-way location_load2 location_load1)
    (= (distance location_load2 location_load1) 0.05)

    (connected-by-way location_load1 location_load3)
    (= (distance location_load1 location_load3) 0.67)
    (connected-by-way location_load3 location_load1)
    (= (distance location_load3 location_load1) 0.67)

    (connected-by-way location_load1 location_unload4)
    (= (distance location_load1 location_unload4) 6.3)
    (connected-by-way location_unload4 location_load1)
    (= (distance location_unload4 location_load1) 6.3)

    (connected-by-way location_load1 location_unload5)
    (= (distance location_load1 location_unload5) 5.8)
    (connected-by-way location_unload5 location_load1)
    (= (distance location_unload5 location_load1) 5.8)

    (connected-by-way location_load1 location_unload6)
    (= (distance location_load1 location_unload6) 6.15)
    (connected-by-way location_unload6 location_load1)
    (= (distance location_unload6 location_load1) 6.15)

    (connected-by-way location_load1 location_unload7)
    (= (distance location_load1 location_unload7) 6.28)
    (connected-by-way location_unload7 location_load1)
    (= (distance location_unload7 location_load1) 6.28)



    (connected-by-way location_load2 location_load3)
    (= (distance location_load2 location_load3) 0.67)
    (connected-by-way location_load3 location_load2)
    (= (distance location_load3 location_load2) 0.67)

    (connected-by-way location_load2 location_unload4)
    (= (distance location_load2 location_unload4) 6.3)
    (connected-by-way location_unload4 location_load2)
    (= (distance location_unload4 location_load2) 6.3)

    (connected-by-way location_load2 location_unload5)
    (= (distance location_load2 location_unload5) 5.8)
    (connected-by-way location_unload5 location_load2)
    (= (distance location_unload5 location_load2) 5.8)

    (connected-by-way location_load2 location_unload6)
    (= (distance location_load2 location_unload6) 6.15)
    (connected-by-way location_unload6 location_load2)
    (= (distance location_unload6 location_load2) 6.15)

    (connected-by-way location_load2 location_unload7)
    (= (distance location_load2 location_unload7) 6.28)
    (connected-by-way location_unload7 location_load2)
    (= (distance location_unload7 location_load2) 6.28)



    ;road connecting location_load3

    (connected-by-way location_load3 location_unload4)
    (= (distance location_load3 location_unload4) 6.2)
    (connected-by-way location_unload4 location_load3)
    (= (distance location_unload4 location_load3) 6.2)

    (connected-by-way location_load3 location_unload5)
    (= (distance location_load3 location_unload5) 5.7)
    (connected-by-way location_unload5 location_load3)
    (= (distance location_unload5 location_load3) 5.7)

    (connected-by-way location_load3 location_unload6)
    (= (distance location_load3 location_unload6) 6.06)
    (connected-by-way location_unload6 location_load3)
    (= (distance location_unload6 location_load3) 6.06)

    (connected-by-way location_load3 location_unload7)
    (= (distance location_load3 location_unload7) 6.18)
    (connected-by-way location_unload7 location_load3)
    (= (distance location_unload7 location_load3) 6.18)



    ;road connecting location_unload4
    (connected-by-way location_unload4 location_unload5)
    (= (distance location_unload4 location_unload5) 0.5)
    (connected-by-way location_unload5 location_unload4)
    (= (distance location_unload5 location_unload4) 0.5)

    (connected-by-way location_unload4 location_unload6)
    (= (distance location_unload4 location_unload6) 0.45)
    (connected-by-way location_unload6 location_unload4)
    (= (distance location_unload6 location_unload4) 0.45)

    (connected-by-way location_unload4 location_unload7)
    (= (distance location_unload4 location_unload7) 0.58)
    (connected-by-way location_unload7 location_unload4)
    (= (distance location_unload7 location_unload4) 0.58)



    ;road connecting location_unload5
    (connected-by-way location_unload5 location_unload6)
    (= (distance location_unload5 location_unload6) 0.35)
    (connected-by-way location_unload6 location_unload5)
    (= (distance location_unload6 location_unload5) 0.35)

    (connected-by-way location_unload5 location_unload7)
    (= (distance location_unload5 location_unload7) 0.48)
    (connected-by-way location_unload7 location_unload5)
    (= (distance location_unload7 location_unload5) 0.48)





    ;road connecting location_unload6

    (connected-by-way location_unload6 location_unload7)
    (= (distance location_unload6 location_unload7) 0.43)
    (connected-by-way location_unload7 location_unload6)
    (= (distance location_unload7 location_unload6) 0.43)

)
   
(:goal (and
        (steel-in steel-text location_load2)
    )
)
;un-comment the following line if metric is needed
(:metric minimize (+ (time-cost) (money-cost)))
)




