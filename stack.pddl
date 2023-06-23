;Header and description

(define (domain stack)

;remove requirements that are not needed
(:requirements :typing  :fluents)
(:types 
    steel
    position
    truck 
)

; un-comment following line if constants are needed
;(:constants )

(:predicates 
    (has-empty-area ?t - truck)
    (clear ?s - steel)
    (can-stack ?s1 - steel ?s2 - steel)
    (on ?s1 - steel ?s2 - steel)
    (empty ?p - position)
    (at ?s - steel ?t - truck)
    
)


(:functions 
    (priority ?steel)
    (length-truck ?truck)
    (weight-turck ?truck)
    (length-steel ?steel )
    (weight-steel ?steel)
    (length-position ?position)
    (weight-position ?position)
)

(:action divid-truck-positon
    :parameters(?t - truck ?p - position)
    :precondition (and 
    (has-empty-area ?t)
    )
    :effect (and )
)


(:action move-steel-position
    :parameters (?s - steel ?p - position  ?t - truck)
    :precondition (and 
        (has-empty-area ?t)
        (clear ?s)
        (<= (length-steel ?s ) (length-truck ?t))
        (<= (weight-steel ?s) (weight-turck ?t))
        )
    :effect (and 
        (assign (length-position ?p) (length-steel ?s))
        (assign (weight-position ?p) (weight-steel ?s))
        (at ?s ?t)
        (not (empty ?p))
        )
)


(:action move-steel-steel
    :parameters (?p -position ?steel - steel ?tosteel - steel ?t - truck)
    :precondition (and
        (clear ?steel)
        (clear ?tosteel)
        (at ?tosteel ?t)
        (can-stack ?steel ?tosteel)
        (<= (length-steel ?steel ) (length-position ?p))
        (<= (weight-steel ?steel) (weight-position ?p))
        (<= (priority ?steel) (priority ?tosteel))
     )
    :effect (and 
        (on ?steel ?tosteel)
        (at ?steel ?t)
        (not (clear ?tosteel))
        (not (on ?steel ?tosteel))
        )
)

)