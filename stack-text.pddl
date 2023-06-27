;Header and description

(define (domain stack-text)

;remove requirements that are not needed
(:requirements :typing  :fluents :negative-preconditions)
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

    (truck-in ?t - truck ?l - location)

    (driver-in ?d - driver ?l - location)
    (driver-at ?d - driver ?t - truck)

    (connected-by-way ?l1 - location ?l2 - location)
    (connected-by-expressway ?l1 - location ?l2 - location)

    (with ?c - container ?t - truck )
    (gas ?l - location)
    (empty ?c - container)

)


(:functions 
    (priority ?steel)
    (length-steel ?steel )
    (breadth-steel ?steel)
    (weight-steel ?steel)
    (length-container ?container)
    (breadth-container ?container)
    (distance ?l1 - location ?l2 - location)
    (speed ?t - truck)
    (time-cost) - number
    (money-cost) - number
    (fuel ?t - truck)
    (max-fuel ?t -truck)
    (license ?d - driver)
    (license-require ?t - truck)

)



;move steel from location to the bottom of container
(:action move-steel-container
    :parameters (?s - steel ?c - container  ?t - truck ?l - location)
    :precondition (and 
        (clear ?s)
        (steel-in ?s ?l)
        (truck-in ?t ?l)
        (empty ?c)
        (not (bottom ?s))
        (with ?c ?t)
        (>= (fuel ?t) 0)
        (<= (length-steel ?s ) (length-container ?c))
        (<= (breadth-steel ?s) (breadth-container ?c))
        )
    :effect (and
        (steel-at ?s ?c)
        (bottom ?s)
        (not (steel-in ?s ?l))
        (not (empty ?c))
            (increase (time-cost) (weight-steel ?s))
        )
)

;load more steel and stack them
(:action move-steel-steel
    :parameters (?l - location ?c -container ?steel - steel ?tosteel - steel ?t - truck)
    :precondition (and
        (clear ?steel)
        (clear ?tosteel)
        (steel-at ?tosteel ?c)
        (can-stack ?steel ?tosteel)
        (truck-in ?t ?l)
        (steel-in ?steel ?l)
        (with ?c ?t)
        (>= (fuel ?t) 0)
        (<= (length-steel ?steel ) (length-container ?c))
        (<= (breadth-steel ?steel) (breadth-container ?c))
        (<= (priority ?steel) (priority ?tosteel))
     )
    :effect (and 
        (not (steel-in ?steel ?l))
        (steel-on ?steel ?tosteel)
        (steel-at ?steel ?c)
        (not (clear ?tosteel))
        (not (steel-on ?steel ?tosteel))
            (increase (time-cost) (weight-steel ?steel))
        )
)

;unlond steel expect the bottom ones
(:action unload-steel-steel
    :parameters (?s_top - steel ?s_under - steel ?t - truck ?c - container ?l - location)
    :precondition (and 
        (clear ?s_top)
        (steel-on ?s_top ?s_under)
        (steel-at ?s_top ?c)
        (truck-in ?t ?l)
        (with ?c ?t)
        (>= (fuel ?t) 0)
        )
    :effect (and 
        (steel-in ?s_top ?l)
        (clear ?s_under)
        (not (steel-at ?s_top ?c))
            (increase (time-cost) (weight-steel ?s_top))
        )
)

;unload the bottum steel
(:action unload-steel-container
    :parameters (?s - steel ?t - truck ?c - container ?l - location)
    :precondition (and 
        (bottom ?s)
        (steel-at ?s ?c)
        (not (empty ?c))
        (truck-in ?t ?l)
        (with ?c ?t)
        (>= (fuel ?t) 0)
        )
    :effect (and 
        (not (bottom ?s)) 
        (not (steel-at ?s ?c))
        (empty ?c)
        (steel-in ?s ?l)
            (increase (time-cost) (weight-steel ?s))
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
            )
)


;drive truck in way
(:action drive-way
    :parameters (?t - truck ?l1 - location 
                ?l2 - location ?d - driver)
    :precondition (and 
            (truck-in ?t ?l1)
            (connected-by-way ?l1 ?l2)
            (driver-at ?d ?t)
                (> (fuel ?t) (distance ?l1 ?l2))
                (> (fuel ?t) 0)
            )
    :effect (and 
            (truck-in ?t ?l2)
            (not (truck-in ?t ?l1))
                (increase (time-cost) (/ (distance ?l1 ?l2) (speed ?t)))
                (decrease (fuel ?t) (distance ?l1 ?l2))
            )
)

;drive truck in expressway
(:action drive-expressway
    :parameters (?t - truck ?l1 - location 
                ?l2 - location ?d - driver)
    :precondition (and 
            (truck-in ?t ?l1)
            (connected-by-expressway ?l1 ?l2)
            (driver-at ?d ?t)
                (>= (license ?d) (license-require ?t))
                (> (fuel ?t) (distance ?l1 ?l2))
                (> (fuel ?t) 0)
            )
    :effect (and 
            (truck-in ?t ?l2)
            (not (truck-in ?t ?l1))
                (increase (time-cost) (/ (distance ?l1 ?l2) (speed ?t)))
                (decrease (fuel ?t) (distance ?l1 ?l2))  

            )
)

;refuel truck
(:action refuel
    :parameters (?t - truck ?l - location)
    :precondition (and 
            (truck-in ?t ?l)
            (gas ?l)
                (<= (fuel ?t) (max-fuel ?t))
    )
    :effect (and 
            (increase (time-cost) (*(- (max-fuel ?t) (fuel ?t)) 0.2))
            (increase (money-cost) (fuel ?t))
            (assign (fuel ?t) (max-fuel ?t))
            )
)

)