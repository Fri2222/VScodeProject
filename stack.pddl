;Header and description

(define (domain stack)

;remove requirements that are not needed
(:requirements :typing  :fluents :negative-preconditions)
(:types 
    steel
    container
    truck 
    location
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
    (steel-in ?s - steel ?l - location)
    (truck-in ?t - truck ?l - location)
    (connected-by-way ?l1 - location ?l2 - location)
    (connected-by-expressway ?l1 - location ?l2 - location)
    (with ?c - container ?t - truck )
    
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
        ;(<= (length-steel ?s ) (length-truck ?t))
        ;(<= (breadth-steel ?s) (breadth-turck ?t))
        )
    :effect (and 
        ;(assign (length-container ?c) (length-steel ?s))
        ;(assign (breadth-container ?c) (breadth-steel ?s))
        (steel-at ?s ?c)
        (bottom ?s)
        (not (steel-in ?s ?l))
        (not (empty ?c))
            (increase (time-cost) (weight-steel ?s))
        )
)


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

(:action unload-steel-steel
    :parameters (?s_top - steel ?s_under - steel ?t - truck ?c - container ?l - location)
    :precondition (and 
        (clear ?s_top)
        (steel-on ?s_top ?s_under)
        (steel-at ?s_top ?c)
        (truck-in ?t ?l)
        (with ?c ?t)
        )
    :effect (and 
        (steel-in ?s_top ?l)
        (clear ?s_under)
        (not (steel-at ?s_top ?c))
            (increase (time-cost) (weight-steel ?s_top))
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
        )
    :effect (and 
        (not (bottom ?s)) 
        (not (steel-at ?s ?c))
        (empty ?c)
        (steel-in ?s ?l)
            (increase (time-cost) (weight-steel ?s))
            )
)

(:action drive-way
    :parameters (?t - truck ?l1 - location ?l2 - location)
    :precondition (and 
            (truck-in ?t ?l1)
            (connected-by-way ?l1 ?l2)
            )
    :effect (and 
            (truck-in ?t ?l2)
            (not (truck-in ?t ?l1))
                (increase (time-cost) (/ (distance ?l1 ?l2) (speed ?t)))
            )
)

(:action drive-expressway
    :parameters (?t - truck ?l1 - location ?l2 - location)
    :precondition (and 
            (truck-in ?t ?l1)
            (connected-by-expressway ?l1 ?l2)
            )
    :effect (and 
            (truck-in ?t ?l2)
            (not (truck-in ?t ?l1))
                (increase (time-cost) (/ (distance ?l1 ?l2) (speed ?t)))
            )
)

)