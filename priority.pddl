;Header and description

(define (domain priority-goods)

;remove requirements that are not needed
(:requirements :strips :fluents :typing :conditional-effects :negative-preconditions :equality)

(:types 
    car 
    goods
    site


;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
)

; un-comment following line if constants are needed
;(:constants )

(:predicates 
    (goods_in ?g - goods ?s - site)
    (goods_at ?g - goods ?c - car)
    (in_place ?c - car ?s - site)
    (connected_by_way ?s1 - site ?s2 - site)
   
        

;todo: define predicates here
)


(:functions 
    (priority ?g - goods)
    (state ?c - car)

)


(:action car_load
    :parameters (?c - car ?g - goods ?s - site)
    :precondition (and 
        (goods_in ?g ?s)
        (in_place ?c ?s)
        (<= (state ?c) (priority ?g))

                
                )
    :effect (and 
            (goods_at ?g ?c)
            (not(goods_in ?g ?s))  
            (in_place ?c ?s)
            (assign (state ?c) (priority ?g))                   
                )
)   

(:action car_unload
    :parameters (?c - car ?g - goods ?sit - site)
    :precondition (and 
            (goods_at ?g ?c)
            (in_place ?c ?sit)
                
                )
    :effect (and 
            (not(goods_at ?g ?c))
            (goods_in ?g ?sit)    
            (in_place ?c ?sit)                    
                )
)

(:action drive-way
    :parameters (?c - car ?s1 - site ?s2 - site)
    :precondition (and 
            (in_place ?c ?s1)
            (connected_by_way ?s1 ?s2)
            
            )
    :effect (and 
            (in_place ?c ?s2)
            (not (in_place ?c ?s2))

            )
)


)