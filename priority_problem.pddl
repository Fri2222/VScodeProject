(define (problem priority_goods) (:domain priority-goods)

(:objects 
    car - car
    site1 site2 site3 site4 site5 - site
    goods1 goods2 - goods
)

(:init
    (= (priority goods1) 5)
    (= (priority goods2) 3)
    (= (state car) 0)
    (goods_in goods1 site1)
    (goods_in goods2 site1)
    (in_place car site1)

    (connected_by_way site1 site2)
    (connected_by_way site2 site1)
    (connected_by_way site2 site5)
    (connected_by_way site2 site3)
    (connected_by_way site3 site4)
    (connected_by_way site5 site4)
    ;todo: put the initial state's facts and numeric values here
)

(:goal (and
    (goods_in goods1 site4 )
    (goods_in goods2 site5)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
