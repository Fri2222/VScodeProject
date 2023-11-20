;Header and description

(define (domain ltl)

;remove requirements that are not needed
(:requirements :typing :fluents :negative-preconditions :equality :disjunctive-preconditions :conditional-effects)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
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
    (cannot-stack ?s1 - steel ?s2 - steel)

    (steel-on ?s1 - steel ?s2 - steel)
    (steel-at ?s - steel ?c - container)
    (steel-in ?s - steel ?l - location)

    (truck-in ?t - truck ?l - location)
    (with ?c - container ?t - truck )

    (empty ?c - container)

    (connected-by-way ?l1 - location ?l2 - location)
)


(:functions 
    (time-cost) - number
    (money-cost)- number

    (priority ?steel)

    (capacity ?truck)

    (distance ?l1 - location ?l2 - location)

    (fuel-truck ?t - truck)
    (fuel-consumption-coefficient ?t -truck)

)
;define actions here
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
            (increase (time-cost) 10)
            (increase (capacity ?t) 1)
        )
)
(:action move-steel-steel
    :parameters (?l - location ?c -container ?steel - steel ?tosteel - steel ?t - truck)
    :precondition (and
        (not (empty ?c))
        (clear ?steel)
        (clear ?tosteel)
        (steel-at ?tosteel ?c)
        (truck-in ?t ?l)
        (steel-in ?steel ?l)
        (>= (priority ?steel) (priority ?tosteel))
        (with ?c ?t)
     )
    :effect (and 
        (steel-on ?steel ?tosteel)
        (steel-at ?steel ?c)
        (not (clear ?tosteel))
        (not (steel-in ?steel ?l))
            (increase (time-cost)  10)
            (decrease (capacity ?t) 1)            
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
        )
    :effect (and 
        (steel-in ?s-top ?l)
        (clear ?s-under)
        (not (steel-at ?s-top ?c))
        (not (steel-on ?s-top ?s-under))
            (increase (time-cost)  10)
            (decrease (capacity ?t) 1)
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
            (increase (time-cost) 10)
            (decrease (capacity ?t) 1 )
            )
)

(:action drive-way
    :parameters (?t - truck ?l1 - location ?l2 - location ?d - driver)
    :precondition (and 
            (truck-in ?t ?l1)
            (connected-by-way ?l1 ?l2)
 
            (>= (fuel-truck ?t) (distance ?l1 ?l2))
            )
    :effect (and 
            (truck-in ?t ?l2)
            (not (truck-in ?t ?l1))
            (increase
                (time-cost) (distance ?l1 ?l2 ))
            (decrease
                (fuel-truck ?t)
                (* (distance ?l1 ?l2) (fuel-consumption-coefficient ?t)))
            )
)

)