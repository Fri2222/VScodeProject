;Header and description

(define (domain trans)

;remove requirements that are not needed
(:requirements :strips :fluents :typing :conditional-effects :negative-preconditions :disjunctive-preconditions)

(:types 
    steel 
    truck
    location
)

; un-comment following line if constants are needed
;(:constants )

(:predicates 

    (world)
	(automata)
    (q1 ?s - steel)
    (q2 ?s - steel)
    (q3 ?s - steel)
    (q4 ?s - steel)

    (waiting-to-load ?s - steel)
    (being-transported ?s - steel)
    (order-completed ?s - steel)

    (steel-at ?s - steel ?t - truck)
    (steel-in ?s - steel ?l - location)
    (at-goal-location ?s - steel ?l - location)

    (truck-in ?t - truck ?l - location)
    (connected-by-way ?l1 - location ?l2 - location)
)


(:functions     
    (time-cost) - number
    (distance ?l1-location ?l2-location)
)

(:action load
    :parameters (?s - steel  ?t - truck ?l - location)
    :precondition (and 
        (world)
        (steel-in ?s ?l)
        (truck-in ?t ?l)
        (waiting-to-load ?s )
        )
    :effect (and
        (not (world))
        (automata)
        (not (steel-in ?s ?l))
        (steel-at ?s ?t)
        (not (waiting-to-load ?s))
        (being-transported ?s)
        (increase (time-cost) 10)
    )
)

(:action unload
    :parameters (?s - steel  ?t - truck ?l - location)
    :precondition (and 
        (world)
        (steel-at ?s ?t)
        (truck-in ?t ?l)
        (being-transported ?s)
        )
    :effect (and
        (not (world))
        (automata)
        (steel-in ?s ?l)
        (not (steel-at ?s ?t))
        (increase (time-cost) 10)
        (not (being-transported ?s))
        (waiting-to-load ?s)
        (when (at-goal-location ?s ?l)
           (and (not (waiting-to-load ?s))
                (order-completed ?s) )
        )
    )
)
(:action drive-way
    :parameters (?t - truck ?l1 - location ?l2 - location)
    :precondition (and 
        (world)
        (truck-in ?t ?l1)
        (connected-by-way ?l1 ?l2)
            )
    :effect (and 
        (not (world))
        (automata)
        (truck-in ?t ?l2)
        (not (truck-in ?t ?l1))
        (increase (time-cost) (distance ?l1 ?l2))
            )
)
(:action transition-1-to-2
    :parameters (?s - steel)
    :precondition (and 
        (q1 ?s)
        (being-transported ?s)
        (automata)
    )
    :effect (and 
        (not (automata))
        (world)
        (not (q1 ?s))
        (q2 ?s)
        )
)
(:action transition-1-to-3
    :parameters (?s - steel)
    :precondition (and 
        (q1 ?s)
        (waiting-to-load ?s)
        (automata)
    )
    :effect (and 
        (not (automata))
        (world)
        (not (q1 ?s))
        (q3 ?s)
        )
)
(:action stay-2
    :parameters (?s - steel)
    :precondition (and 
        (q2 ?s)
        (being-transported ?s)
        (not (waiting-to-load ?s))
        (not (order-completed ?s))
        (automata)
    )
    :effect (and 
        (not (automata))
        (world)
        (being-transported ?s)
        (q2 ?s)
        )
)
(:action transition-2-to-4
    :parameters (?s - steel)
    :precondition (and 
        (q2 ?s)  
        (waiting-to-load ?s) 
        (not (order-completed ?s))  
        (automata)
    )
    :effect (and 
        (not (automata))
        (world)
        (not (q2 ?s))  
        (q4 ?s)
        )
)
(:action transition-2-to-3
    :parameters (?s - steel)
    :precondition (and 
        (q2 ?s)  
        (waiting-to-load ?s) 
        (order-completed ?s)  
        (automata)
    )
    :effect (and 
        (not (automata))
        (world)
        (not (q2 ?s))  
        (q3 ?s)
    )
)

(:action transition-3-to-2
    :parameters (?s - steel)
    :precondition (and 
        (q3 ?s)  
        (not (waiting-to-load ?s)) 
        (or (order-completed ?s) (not (being-transported ?s)))  
        (automata)
    )
    :effect (and 
        (not (automata))
        (world)
        (not (q3 ?s))  
        (q2 ?s)
    )
)
(:action transition-3-to-4
    :parameters (?s - steel)
    :precondition (and 
        (q3 ?s)  
        (being-transported ?s) 
        (not (order-completed ?s))  
        (automata)
    )
    :effect (and 
        (not (automata))
        (world)
        (not (q3 ?s))  
        (q4 ?s)
    )
)
(:action stay-3
    :parameters (?s - steel)
    :precondition (and 
        (q3 ?s)  
        (waiting-to-load ?s) 
        (or (order-completed ?s) (not (being-transported ?s)))  
        (automata)
    )
    :effect (and 
        (not (automata))
        (world)
        (q3 ?s)
    )
)
(:action stay-4
    :parameters (?s - steel)
    :precondition (and 
        (q4 ?s)  
        (order-completed ?s)  
        (automata)
    )
    :effect (and 
        (not (automata))
        (world)
        (q4 ?s)
    )
)
)