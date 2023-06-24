;Header and description

(define (domain stack)

;remove requirements that are not needed
(:requirements :typing  :fluents :negative-preconditions)
(:types 
    steel
    position
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
    (empty ?p - position)
    (steel-at ?s - steel ?p - position)
    (steel-in ?s - steel ?l - location)
    (truck-in ?t - truck ?l - location)
    (connected_by_way ?l1 - location ?l2 - location)
    
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




(:action move-steel-position
    :parameters (?s - steel ?p - position  ?t - truck ?l - location)
    :precondition (and 
        (clear ?s)
        (steel-in ?s ?l)
        (truck-in ?t ?l)
        (empty ?p)
        (not (bottom ?s))
        ;(<= (length-steel ?s ) (length-truck ?t))
        ;(<= (weight-steel ?s) (weight-turck ?t))
        )
    :effect (and 
        ;(assign (length-position ?p) (length-steel ?s))
        ;(assign (weight-position ?p) (weight-steel ?s))
        (steel-at ?s ?p)
        (bottom ?s)
        (not (steel-in ?s ?l))
        (not (empty ?p))
        )
)


(:action move-steel-steel
    :parameters (?l - location ?p -position ?steel - steel ?tosteel - steel ?t - truck)
    :precondition (and
        (clear ?steel)
        (clear ?tosteel)
        (steel-at ?tosteel ?p)
        (can-stack ?steel ?tosteel)
        (truck-in ?t ?l)
        (steel-in ?steel ?l)
        ;(<= (length-steel ?steel ) (length-position ?p))
        ;(<= (weight-steel ?steel) (weight-position ?p))
        (<= (priority ?steel) (priority ?tosteel))
     )
    :effect (and 
        (not (steel-in ?steel ?l))
        (steel-on ?steel ?tosteel)
        (steel-at ?steel ?p)
        (not (clear ?tosteel))
        (not (steel-on ?steel ?tosteel))
        )
)

(:action unload-steel-steel
    :parameters (?s_top - steel ?s_under - steel ?t - truck ?p - position ?l - location)
    :precondition (and 
        (clear ?s_top)
        (steel-on ?s_top ?s_under)
        (steel-at ?s_top ?p)
        (truck-in ?t ?l)
        )
    :effect (and 
        (steel-in ?s_top ?l)
        (clear ?s_under)
        (not (steel-at ?s_top ?p))
        )
)

(:action unload-steel-position
    :parameters (?s - steel ?t - truck ?p - position ?l - location)
    :precondition (and 
        (bottom ?s)
        (steel-at ?s ?p)
        (not (empty ?p))
        (truck-in ?t ?l)
        )
    :effect (and 
        (not (bottom ?s)) 
        (not (steel-at ?s ?p))
        (empty ?p)
        (steel-in ?s ?l)
            )
)

(:action drive-way
    :parameters (?t - truck ?l1 - location ?l2 - location)
    :precondition (and 
            (truck-in ?t ?l1)
            (connected_by_way ?l1 ?l2)
            )
    :effect (and 
            (truck-in ?t ?l2)
            (not (truck-in ?t ?l1))
            )
)

)