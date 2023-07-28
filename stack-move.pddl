;Header and description

(define (domain stack)

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
    (empty ?c - container)
    (steel-at ?s - steel ?c - container)
    (container-in ?c - container ?l - location)
    (steel-in ?s - steel ?l - location)

    (truck-in ?t - truck ?l - location)
    (connected-by-way ?l1 - location ?l2 - location)
    (connected-by-expressway ?l1 - location ?l2 - location)
    (with ?c - container ?t - truck )
    
    (can-exchange ?t - truck)

    (driver-in ?d - driver ?l - location)
    (driver-at ?d - driver ?t - truck)
    
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
    (license ?d - driver)
    (license-require ?t - truck)
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
     )
    :effect (and 
        (steel-on ?steel ?tosteel)
        (steel-at ?steel ?c)
        (not (clear ?tosteel))
        (not (steel-in ?steel ?l))
            (increase (time-cost) (/ (weight-steel ?steel) 10))
        )
)

(:action unload-steel-steel
    :parameters (?s_top - steel ?s_under - steel ?t - truck ?c - container ?l - location)
    :precondition (and 
        (clear ?s_top)
        (steel-on ?s_top ?s_under)
        (steel-at ?s_top ?c)
        (truck-in ?t ?l)
        (with ?c ?t)
        (not (steel-in ?s_top ?l))
        )
    :effect (and 
        (steel-in ?s_top ?l)
        (clear ?s_under)
        (not (steel-at ?s_top ?c))
            (increase (time-cost) (/ (weight-steel ?s_top) 10))
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
        )
    :effect (and 
        (not (bottom ?s)) 
        (not (steel-at ?s ?c))
        (empty ?c)
        (steel-in ?s ?l)
            (increase (time-cost) (/ (weight-steel ?s) 10))
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
            )
    :effect (and 
            (truck-in ?t ?l2)
            (not (truck-in ?t ?l1))
                (increase (time-cost) (/ (distance ?l1 ?l2) (speed ?t)))
            )
)

(:action drive-expressway
    :parameters (?t - truck ?l1 - location ?l2 - location ?d - driver)
    :precondition (and 
            (truck-in ?t ?l1)
            (connected-by-expressway ?l1 ?l2)
            (driver-at ?d ?t)
            (>= (license ?d) (license-require ?t)) 
            )
    :effect (and 
            (truck-in ?t ?l2)
            (not (truck-in ?t ?l1))
                (increase (time-cost) (/ (distance ?l1 ?l2) (speed ?t)))
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
            (not (can-exchange ?t))
            (not (with ?c ?t ))
            )
)


(:action acquire-container
    :parameters (?t - truck ?c1 - container ?l - location ?c2 - container)
    :precondition (and 
            (truck-in ?t ?l)
            (container-in ?c1 ?l)
            (not (with ?c2 ?t ))
            (not (can-exchange ?t))
            (not (= ?c1 ?c2))
            )
    :effect (and 
            (with ?c1 ?t )
            (can-exchange ?t)
            (not (container-in ?c1 ?l))
            )
)


)