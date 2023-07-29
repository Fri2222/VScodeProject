
(define (domain add-fuel)

;remove requirements that are not needed
(:requirements :typing  :fluents :negative-preconditions :equality)
(:types 
    steel
    container
    truck 
    location
    driver
)

; un-comment following line if constants are needed
;(:constants )

(:predicates 
    (clear ?s - steel)
    (bottom ?s - steel)
    (can-stack ?s1 - steel ?s2 - steel)

    (steel-on ?s1 - steel ?s2 - steel)
    (steel-at ?s - steel ?c - container)
    (steel-in ?s - steel ?l - location)
    (has-caculated ?steel)

    (plate ?s - steel)
    (pipe ?s - steel)
    (section ?s - steel)

    (truck-in ?t - truck ?l - location)
    (with ?c - container ?t - truck )
    (can-exchange ?t - truck)

    (empty ?c - container)
    (container-in ?c - container ?l - location)

    (connected-by-way ?l1 - location ?l2 - location)
    (connected-by-expressway ?l1 - location ?l2 - location)

    (driver-in ?d - driver ?l - location)
    (driver-at ?d - driver ?t - truck)

    (gas ?l - location)
    
)


(:functions 
    (time-cost) - number
    (money-cost)- number

    (priority ?steel)
    (quantity ?steel)
    (length-steel ?steel )
    (breadth-steel ?steel)
    (heigth-steel ?steel)
    (diameter-steel ?steel)
    (weight-steel ?steel)

    (length-container ?container)
    (breadth-container ?container)
    (max-weigth ?container)
    (current-weight ?container)

    (distance ?l1 - location ?l2 - location)

    (speed ?t - truck)
    (fuel-truck ?t - truck)
    (max-fuel-truck ?t -truck)

    (license ?d - driver)
    (license-require ?t - truck)
)


(:action refuel
    :parameters (?t - truck ?l - location)
    :precondition (and 
            (truck-in ?t ?l)
            (gas ?l)
                (<= (fuel-truck ?t) (max-fuel-truck ?t))
    )
    :effect (and 
            (increase (time-cost) (* (- (max-fuel-truck ?t) (fuel-truck ?t)) 0.2))
            (increase (money-cost) (- (max-fuel-truck ?t) (fuel-truck ?t)))
            (increase (fuel-truck ?t) (- (max-fuel-truck ?t ) (fuel-truck ?t)))
            )
)

(:action move-steel-container
    :parameters (?s - steel ?c - container  ?t - truck ?l - location)
    :precondition (and 
        (clear ?s)
        (steel-in ?s ?l)
        (truck-in ?t ?l)
        (empty ?c)
        (not (bottom ?s))
        (with ?c ?t)
        )
    :effect (and 
        (steel-at ?s ?c)
        (bottom ?s)
        (not (steel-in ?s ?l))
        (not (empty ?c))
            (increase (time-cost) (/ (weight-steel ?s) 10))
            (assign (current-weight ?c) 
                    (* (weight-steel ?s) (quantity ?s)))
        )
)


(:action move-steel-steel
    :parameters (?l - location ?c -container ?steel - steel ?tosteel - steel ?t - truck)
    :precondition (and
        (with ?c ?t)
        (not (empty ?c))
        (clear ?steel)
        (clear ?tosteel)
        (steel-at ?tosteel ?c)
        (can-stack ?steel ?tosteel)
        (truck-in ?t ?l)
        (steel-in ?steel ?l)
        (<= (length-steel ?steel ) (length-container ?c))
        (<= (breadth-steel ?steel) (breadth-container ?c))
        (>= (priority ?steel) (priority ?tosteel))
        (<= (+ (* (weight-steel ?steel) (quantity ?steel)) 
                (current-weight ?c))   
                    (max-weigth ?c))
     )
    :effect (and 
        (steel-on ?steel ?tosteel)
        (steel-at ?steel ?c)
        (not (clear ?tosteel))
        (not (steel-in ?steel ?l))
            (increase (time-cost) (/ (weight-steel ?steel) 10))
            (increase (current-weight ?c) 
                    (* (weight-steel ?steel) (quantity ?steel)))
        )
)

(:action unload-steel-steel
    :parameters (?s-top - steel ?s-under - steel ?t - truck ?c - container ?l - location)
    :precondition (and 
        (truck-in ?t ?l)
        (with ?c ?t)
        (not (empty ?c))
        (steel-at ?s-top ?c)
        (not (clear ?s-under))
        (steel-on ?s-top ?s-under)
        (not (steel-in ?s-top ?l))
;Do not delete this line of code((has-caculated ?s-top)),or the program will
;go through all the loading and unloading actions
        (has-caculated ?s-top)
        )
    :effect (and 
        (steel-in ?s-top ?l)
        (clear ?s-under)
        (not (steel-at ?s-top ?c))
        (not (steel-on ?s-top ?s-under))
            (increase (time-cost) (/ (weight-steel ?s-top) 10))
            (decrease (current-weight ?c) 
                (+ (current-weight ?c) 
                    (* (weight-steel ?s-top) (quantity ?s-top))))
        )
)

(:action unload-steel-container
    :parameters (?s - steel ?t - truck ?c - container ?l - location)
    :precondition (and 
        (bottom ?s)
        (steel-at ?s ?c)
        (not (empty ?c))
        (truck-in ?t ?l)
        (with ?c ?t)
        (not (steel-in ?s ?l))
;Do not delete this line of code(has-caculated ?s),or the program will
;go through all the loading and unloading actions
        (has-caculated ?s)
        )
    :effect (and 
        (not (bottom ?s)) 
        (not (steel-at ?s ?c))
        (empty ?c)
        (steel-in ?s ?l)
            (increase (time-cost) (/ (weight-steel ?s) 10))
            (decrease (current-weight ?c) 
                (+ (current-weight ?c) 
                    (* (weight-steel ?s) (quantity ?s))))
            )
)
;driver get in truck
(:action get-in
    :parameters (?d - driver ?t - truck ?l - location)
    :precondition (and 
        (driver-in ?d ?l)
        (truck-in ?t ?l)
        (>= (license ?d) (license-require ?t)) 
        )

    :effect (and 
        (driver-at ?d ?t)
        (not (driver-in ?d ?l))
            (increase (time-cost) 0.2)
        )
)

;driver get out truck
(:action get-out
    :parameters (?d - driver ?t - truck ?l - location)
    :precondition (and 
            (driver-at ?d ?t)
            (truck-in ?t ?l)
            )
    :effect (and 
            (driver-in ?d ?l)
            (not (driver-at ?d ?t))
                (increase (time-cost) 0.2)
            )
)

(:action drive-way
    :parameters (?t - truck ?l1 - location ?l2 - location ?d - driver)
    :precondition (and 
            (truck-in ?t ?l1)
            (connected-by-way ?l1 ?l2)
            (driver-at ?d ?t)
            (>= (license ?d) (license-require ?t)) 
            (>= (fuel-truck ?t) (/ (distance ?l1 ?l2) 10))
            )
    :effect (and 
            (truck-in ?t ?l2)
            (not (truck-in ?t ?l1))
                (increase (time-cost) (/ (distance ?l1 ?l2) (speed ?t)))
                (decrease (fuel-truck ?t) (/ (distance ?l1 ?l2) 10))
            )
)

(:action drive-expressway
    :parameters (?t - truck ?l1 - location ?l2 - location ?d - driver)
    :precondition (and 
            (truck-in ?t ?l1)
            (connected-by-expressway ?l1 ?l2)
            (driver-at ?d ?t)
            (>= (license ?d) (license-require ?t)) 
            (>= (fuel-truck ?t) (/ (distance ?l1 ?l2) 10))
            )
    :effect (and 
            (truck-in ?t ?l2)
            (not (truck-in ?t ?l1))
                (increase (time-cost) (/ (distance ?l1 ?l2) (speed ?t)))
                (decrease (fuel-truck ?t) (/ (distance ?l1 ?l2) 10))
            )
)

;trailar exhange the container
(:action loss-container
    :parameters (?t - truck ?c - container ?l - location)
    :precondition (and 
            (truck-in ?t ?l)
            (with ?c ?t )
            (can-exchange ?t)
        )
    :effect (and 
            (container-in ?c ?l)
            (not (with ?c ?t ))
            )
)


(:action acquire-container
    :parameters (?t - truck ?c1 - container ?l - location ?c2 - container)
    :precondition (and 
            (truck-in ?t ?l)
            (container-in ?c1 ?l)
            (not (with ?c2 ?t ))
            (can-exchange ?t)
            (not (= ?c1 ?c2))
            )
    :effect (and 
            (with ?c1 ?t )
            (not (container-in ?c1 ?l))
            )
)

;caculate the weight of steel(weight=height*length*bredth*coefficient)
(:action caculate-weight
    :parameters (?s - steel)
    :precondition (and 
        (or (plate ?s) (pipe ?s) (section ?s))
        (not (has-caculated ?s))
    )
    :effect (and 
        (has-caculated ?s)
        (when (plate ?s)
            (assign (weight-steel ?s) 
                (* (length-steel ?s) 
                    (* (breadth-steel ?s) 
                        (* (heigth-steel ?s) 
                            (* (quantity ?s) 7.5)
                        )
                    )
                )
            )
        )
        (when (pipe ?s)
            (assign (weight-steel ?s) 
                (* (length-steel ?s)
                    (* (breadth-steel ?s)
                        (* (diameter-steel ?s) 
                            (* (quantity ?s) 0.02466)
                        )
                    )
                )
            )
        )
        (when (section ?s)
            (assign (weight-steel ?s) 
                (* (diameter-steel ?s)
                    (* (diameter-steel ?s)
                        (* (length-steel ?s) 
                            (* (quantity ?s) 0.00617)
                        )
                    )
                )
            )
        )
    )
)


)