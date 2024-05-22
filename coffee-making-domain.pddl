(define (domain coffee-maker-assistant)

(:requirements 
    :strips
    :negative-preconditions
 )

(:predicates
    (GRIP ?g) ;robot grip
    (PLACE ?p)   ;places (cabinets, tables etc)
    (HOLDER ?h) ;holder for objects
    (KETTLE ?k)    ;kettle
    (MUG ?m) ; mug
    (ENHANCER ?e) ; enhancer stuff for coffee

    
    ; GRIP predicates
    (is-free ?g) ; if grip is free
    (has-spoon ?g) ;if one of the grips holds spoon
    (has-top-kettle-part ?g)   ;if grip holds the top part of the kettle

    ;Place predicates
    (is-cabinet ?p)  ;cabinet identifier
    (is-closed ?p)  ; if not true -> robot cannot take anything from cabinet
    (is-table ?p) ; table identifier
    (is-grinder ?p) ;grinder identifier
    (is-stove ?p)   ; stove identifier

    ; HOLDER predicates
    (for-water ?h) ;HOLDER meant for storing water
    (has-water ?h) ;whether an object has water
    (has-beans ?h) ;whether a HOLDER has beans
    (is-empty ?h) ;if HOLDER is empty
    (is-open ?h)  ;if HOLDER is open
    (at ?p ?h) ; represents where the HOLDER is

    
    ;kettle predicates 
    (has-coffee ?k) ;whether object has coffee, both as a ground coffee or liquid
    (is-screwed ?k) ;whether kettle is screwed
    (has-filter ?k) ;if filter is inside the kettle
    (coffee-is-ready ?k)    ;whether coffee as liquid is in the kettle
    (coffee-is-distributed-evenly ?k)   ;Whether cofffee was placed evenly

    ;mug predicates
    (has-flavor ?m ?e)       ; if coffeee has specified addon eg. sugar, milk -bleh
)

; action for cabinets
(:action open-cabinet
    ;Robot arms opens cabinet
    :parameters (?p ?g)
    :precondition (and (PLACE ?p) (is-cabinet ?p) (is-closed ?p)
                       (GRIP ?g) (is-free ?g))
    :effect (and (not (is-closed ?p)))
)

(:action close-cabinet
    ;Robot closes  cabinet
    :parameters (?p ?g)
    :precondition (and (PLACE ?p) (is-cabinet ?p) (not (is-closed ?p))
                       (GRIP ?g) (is-free ?g))
    :effect (and (is-closed ?p))
)

; MOVING OBJECTS

(:action take-object-up-from-cabinet    
    ; Robot's arm takes object from cabinet
    :parameters (?g ?p ?h)
    :precondition (and (GRIP ?g) (is-free ?g)
                       (PLACE ?p) (is-cabinet ?p) (not (is-closed ?p))
                       (HOLDER ?h) (at ?p ?h)
                       )
    :effect (and (not (is-free ?g)) (at ?g ?h) (not (at ?p ?h)))
)

(:action put-object-down-to-cabinet
    ; Robot's arm puts object to cabinet
    :parameters (?g ?p ?h)
    :precondition (and (GRIP ?g) (not (is-free ?h))
                       (PLACE ?p) (is-cabinet ?p) (not (is-closed ?p))
                       (HOLDER ?h) (at ?p ?h) 
                       )
    :effect (and (is-free ?g) (not (at ?g ?h)) (at ?p ?h))
)


(:action take-mug-up-from-cabinet
    ; Robot's arm takes object from cabinet
    :parameters (?g ?p ?m)
    :precondition (and (GRIP ?g) (is-free ?g)
                       (PLACE ?p) (is-cabinet ?p) (not (is-closed ?p))
                       (MUG ?m) (at ?p ?m)
                       )
    :effect (and (not (is-free ?g)) (at ?g ?m) (not (at ?p ?m)))
)

(:action put-mug-down-to-cabinet
    ; Robot's arm puts object to cabinet
    :parameters (?g ?p ?m)
    :precondition (and (GRIP ?g) (not (is-free ?g))
                       (PLACE ?p) (is-cabinet ?p) (not (is-closed ?p))
                       (MUG ?m) (at ?g ?m) 
                       )
    :effect (and (is-free ?g) (not (at ?g ?m)) (at ?p ?m))
)


(:action take-kettle-up-from-cabinet
    ; Robot's arm takes kettle from cabinet
    :parameters (?g ?p ?k)
    :precondition (and (GRIP ?g) (is-free ?g)
                       (PLACE ?p) (is-cabinet ?p) (not (is-closed ?p))
                       (KETTLE ?k) (at ?p ?k)
                       )
    :effect (and (not (is-free ?g)) (at ?g ?k) (not (at ?p ?k)))
)

(:action put-kettle-down-to-cabinet
    ; Robot's arm takes kettle to cabinet
    :parameters (?g ?p ?k)
    :precondition (and (GRIP ?g) (not (is-free ?g))
                       (PLACE ?p) (is-cabinet ?p) (not (is-closed ?p))
                       (KETTLE ?p) (at ?g ?p) 
                       )
    :effect (and (is-free ?g) (not (at ?g ?k)) (at ?p ?k))
)

(:action take-object-up-from
    ; Robot's arm takes object from PLACE (not cabinet)
    :parameters (?g ?p ?h)
    :precondition (and (GRIP ?g) (is-free ?g)
                       (PLACE ?p) (not (is-cabinet ?p))
                       (HOLDER ?h) (at ?p ?h)
                       )
    :effect (and (not (is-free ?g)) (at ?g ?h) (not (at ?p ?h)))
)
    
(:action put-object-down-to
    ; Robot's arm puts object to PLACE (not cabinet)
    :parameters (?g ?p ?h)
    :precondition (and (GRIP ?g) (not (is-free ?g))
                       (PLACE ?p) (not (is-cabinet ?p)) (not (is-stove ?p))
                       (HOLDER ?h) (at ?g ?h)
                       )
    :effect (and (is-free ?g) (not (at ?g ?h)) (at ?p ?h))
)

(:action take-addon-up-from
    ; Robot's arm takes object from PLACE (not cabinet)
    :parameters (?g ?p ?h)
    :precondition (and (GRIP ?g) (is-free ?g)
                       (PLACE ?p) (not (is-cabinet ?p))
                       (ENHANCER ?h) (at ?p ?h)
                       )
    :effect (and (not (is-free ?g)) (at ?g ?h) (not (at ?p ?h)) )
)
    
(:action put-addon-down-to
    ; Robot's arm puts object to PLACE (not cabinet)
    :parameters (?g ?p ?h)
    :precondition (and (GRIP ?g) (not (is-free ?g))
                       (PLACE ?p) (not (is-cabinet ?p)) (not (is-stove ?p))
                       (ENHANCER ?h) (at ?g ?h)
                       )
    :effect (and (is-free ?g) (not (at ?g ?h)) (at ?p ?h))
)


(:action take-mug-up-from
    ; Robot's arm takes object from PLACE (not cabinet)
    :parameters (?g ?p ?m)
    :precondition (and (GRIP ?g) (is-free ?g)
                       (PLACE ?p) (not (is-cabinet ?p))
                       (MUG ?m) (at ?p ?m)
                       )
    :effect (and (not (is-free ?g)) (at ?g ?m) (not (at ?p ?m)) )
)
    
(:action put-mug-down-to
    ; Robot's arm puts object to PLACE (not cabinet)
    :parameters (?g ?p ?m)
    :precondition (and (GRIP ?g) (not (is-free ?g))
                       (PLACE ?p) (not (is-cabinet ?p)) (not (is-stove ?p))
                       (MUG ?m) (at ?g ?m)
                       )
    :effect (and (is-free ?g) (not (at ?g ?m)) (at ?p ?m))
)



(:action take-kettle-up-from
    ; Robot's arm takes object from PLACE (not cabinet)
    :parameters (?g ?p ?k)
    :precondition (and (GRIP ?g) (is-free ?g)
                       (PLACE ?p) (not (is-cabinet ?p))
                       (KETTLE ?k) (at ?p ?k)
                       )
    :effect (and (not (is-free ?g)) (at ?g ?k) (not (at ?p ?k)) )
)
    
(:action put-kettle-down-to
    ; Robot's arm puts object to PLACE (not cabinet)
    :parameters (?g ?p ?k)
    :precondition (and (GRIP ?g) (not (is-free ?g))
                       (PLACE ?p) (not (is-cabinet ?p))
                       (KETTLE ?k) (at ?g ?k)
                       )
    :effect (and (is-free ?g) (not (at ?g ?k)) (at ?p ?k))
)

(:action open-holder
    ; robot uses two GRIPs to open the HOLDER
    :parameters (?g1 ?g2 ?h)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (is-free ?g2)
                       (HOLDER ?h) (at ?g1 ?h) (not (is-open ?h))
    )
    :effect (and (is-open ?h))
)

(:action close-holder
    ; robot uses two GRIPs to close the HOLDER
    :parameters (?g1 ?g2 ?h)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (is-free ?g2)
                       (HOLDER ?h) (at ?g1 ?h) (is-open ?h)
    )
    :effect (and (not (is-open ?h)))
)

(:action fill-water-jug
    ; Robot fills water jug to have filtered water (using two GRIPs)
    :parameters (?g1 ?g2 ?h)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (is-free ?g2)
                       (HOLDER ?h) (for-water ?h) (at ?g1 ?h) (is-open ?h) (not (has-water ?h))
    )
    :effect (and (has-water ?h))
)

(:action unscrew-kettle
    ;robot removes the top part of the kettle and puts it on the table
    :parameters (?g1 ?g2 ?k)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (is-free ?g2)
                       (KETTLE ?k) (at ?g1 ?k) (is-screwed ?k)
                       )
    :effect (and (not (is-screwed ?k)) (not (is-free ?g2)) (has-top-kettle-part ?g2))
)

(:action put-down-top-part
    ; Robot puts down the top part of the kettle
    :parameters (?g)
    :precondition (and (GRIP ?g) (not (is-free ?g)) (has-top-kettle-part ?g))
    :effect (and (is-free ?g) (not (has-top-kettle-part ?g)))
)

(:action take-up-top-part
    ; Robot puts down the top part of the kettle
    :parameters (?g)
    :precondition (and (GRIP ?g) (is-free ?g) (not (has-top-kettle-part ?g)))
    :effect (and (not (is-free ?g)) (has-top-kettle-part ?g))
)

(:action screw-kettle
    ;robot removes the top part of the kettle and puts it on the table
    :parameters (?g1 ?g2 ?k)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (not (is-free ?g2)) (has-top-kettle-part ?g2)
                       (KETTLE ?k) (at ?g1 ?k) (not (is-screwed ?k))
                       )
    :effect (and (is-screwed ?k) (is-free ?g2) (not (has-top-kettle-part ?g2)))
)

(:action remove-filter
    ;robot removes filter from the moka kettle
    :parameters (?g1 ?g2 ?k)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (is-free ?g2)
                       (KETTLE ?k) (at ?g1 ?k) (not (is-screwed ?k)) (has-filter ?k)
    )
    :effect (and (not (has-filter ?k)))
)

(:action put-filter-back
    ;robot puts filter to the moka kettle
    :parameters (?g1 ?g2 ?k)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (is-free ?g2)
                       (KETTLE ?k) (at ?g1 ?k) (not (is-screwed ?k)) (not (has-filter ?k))
    )
    :effect (and (has-filter ?k))
)

(:action pour-water-to-the-kettle
    :parameters (?g1 ?g2 ?k ?h)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (not (is-free ?g2))
                       (KETTLE ?k) (not (is-screwed ?k)) (not (has-filter ?k)) (at ?g1 ?k)
                       (HOLDER ?h) (for-water ?h) (has-water ?h) (at ?g2 ?h) (not (is-open ?h))
    )
    :effect (and (has-water ?k))
)

; SPOON Actions
(:action take-spoon
    ; one GRIP takes spoon
    :parameters (?g)
    :precondition (and (GRIP ?g) (is-free ?g) (not (has-spoon ?g)))
    :effect (and (not (is-free ?g)) (has-spoon ?g))
)

(:action put-down-spoon
    ; one GRIP puts spoon down
    :parameters (?g)
    :precondition (and (GRIP ?g) (not (is-free ?g)) (has-spoon ?g))
    :effect (and (not (has-spoon ?g)) (is-free ?g))
)


; COFFEE GRINDING
(:action pour-beans-to-grinder
    ; pours coffee beans to the grinder, which is always open
    :parameters (?g1 ?g2 ?p ?h)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (not (is-free ?g2)) (has-spoon ?g2)
                       (PLACE ?p) (is-grinder ?p) 
                       (HOLDER ?h) (has-beans ?h) (at ?g1 ?h) (is-open ?h)
                       )
    :effect (and (has-beans ?p))
)

(:action grind-coffee
    ; robot clicks on HOLDER to grind coffee, coffeee goes directly to the HOLDER which is at the grinder
    :parameters (?g ?p ?h)
    :precondition (and (GRIP ?g) (is-free ?g)
                       (PLACE ?p) (is-grinder ?p) (has-beans ?p)
                       (HOLDER ?h) (at ?p ?h) (is-empty ?h)
    )
    :effect (and (has-coffee ?h))
)

(:action pour-coffee-to-the-kettle
    ; put ground coffee to the kettle
    :parameters (?g1 ?g2 ?h ?p ?k)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (has-spoon ?g2)
                       (HOLDER ?h) (has-coffee ?h) (is-open ?h) (at ?g1 ?h)
                       (PLACE ?p) (is-table ?p)
                       (KETTLE ?k) (not (is-screwed ?k)) (has-filter ?k) (at ?p ?k)
    )
    :effect (and (has-coffee ?k) (not (has-coffee ?h)) (is-empty ?h))
)

(:action distribute-coffee-evenly
    ; level the coffee as in description
    :parameters (?g1 ?g2 ?k)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (has-spoon ?g2)
                       (KETTLE ?k) (not (is-screwed ?k)) (has-filter ?k) (at ?g1 ?k) (has-coffee ?k)
                       )
    :effect (and (coffee-is-distributed-evenly ?k)  )
)


(:action ignite-heat
    ; fire-up the stove
    :parameters (?g ?p ?k)
    :precondition (and (GRIP ?g) (is-free ?g)
                       (PLACE ?p) (is-stove ?p)
                       (KETTLE ?k) (has-water ?k) (coffee-is-distributed-evenly ?k) (is-screwed ?k) (at ?p ?k)
    )
    :effect (and (coffee-is-ready ?k))
)

(:action pour-fresh-specialty-to-a-mug
    ; pour the liquid into a mug
    :parameters (?g ?k ?p ?m)
    :precondition (and (GRIP ?g) (not (is-free ?g))
                       (KETTLE ?k) (coffee-is-ready ?k) (is-screwed ?k) (at ?g ?k)
                       (PLACE ?p) (is-table ?p)
                       (MUG ?m) (at ?p ?m) (is-empty ?m)
    )
    :effect (and (has-coffee ?m))
)

(:action add-flavor-to-your-coffee
    ; add sugar/milk to your coffee
    :parameters (?g1 ?g2 ?p ?e ?m)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (has-spoon ?g2)
                       (PLACE ?p) (is-table ?p)
                       (ENHANCER ?e) (at ?g1 ?e)
                       (MUG ?m) (has-coffee ?m) (at ?p ?m)
                       )
    :effect (and (has-flavor ?m ?a))
)

)