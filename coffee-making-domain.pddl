;PDDL Domain Definition for Coffee Making Robot

; Define the domain
(define (domain coffee-maker-assistant)

; requirements for the domain are defined in the following order
(:requirements 
    :strips
    :typing
    :negative-preconditions
)

(:predicates
    (GRIP ?g) ;robot grip
    (PLACE ?p)   ;places (cabinets, tables etc)
    (CONTAINER ?c) ;container for coffee
    (KETTLE ?k)    ;kettle
    (MUG ?m) ; mug
    (OPTION ?o) ; additional stuff for your coffee

    
    ; Hand predicates
    (is-free ?g) ; if grip is free
    (has-spoon ?g) ;if one of the grips holds spoon
    (has-top-kettle-part ?g)   ;if grip holds the top part of the kettle

    ;Place predicates
    (is-cabinet ?p)  ;cabinet identifier
    (is-closed ?p)  ; if not true -> robot cannot take anything from cabinet
    (is-table ?p) ; table identifier
    (is-grinder ?p) ;grinder identifier
    (is-stove ?p)   ; stove id

    ; Container predicates
    (for-water ?c) ;container meant for storing water
    (has-water ?c) ;whether an object has water
    (has-beans ?c) ;whether a container has beans
    (is-empty ?c) ;if container is empty
    (is-open ?c)  ;if container is open
    (at ?p ?c) ; represents where the container is

    
    ;kettle predicates 
    (has-coffee ?k) ;whether object has coffee, both as a ground coffee or liquid
    (is-screwed ?k) ;whether kettle is screwed
    (has-filter ?k) ;if filter is inside the kettle
    (coffee-is-ready ?k)    ;whether coffee as liquid is in the kettle
    (coffee-is-distributed-evenly ?k)   ;Whether cofffee was placed evenly

    ;mug predicates
    (has-flavor ?m ?o)       ; if coffeee has specified option eg. sugar, milk -bleh
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
    :parameters (?g ?p ?c)
    :precondition (and (GRIP ?g) (is-free ?g)
                       (PLACE ?p) (is-cabinet ?p) (not (is-closed ?p))
                       (CONTAINER ?c) (at ?p ?c)
                       )
    :effect (and (not (is-free ?g)) (at ?g ?c) (not (at ?p ?c)))
)

(:action put-object-down-to-cabinet
    ; Robot's arm puts object to cabinet
    :parameters (?g ?p ?c)
    :precondition (and (GRIP ?g) (not (is-free ?g))
                       (PLACE ?p) (is-cabinet ?p) (not (is-closed ?p))
                       (CONTAINER ?c) (at ?g ?c) 
                       )
    :effect (and (is-free ?g) (not (at ?g ?c)) (at ?p ?c))
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
                       (KETTLE ?k) (at ?g ?k) 
                       )
    :effect (and (is-free ?g) (not (at ?g ?k)) (at ?p ?k))
)

(:action take-object-up-from
    ; Robot's arm takes object from place (not cabinet)
    :parameters (?g ?p ?c)
    :precondition (and (GRIP ?g) (is-free ?g)
                       (PLACE ?p) (not (is-cabinet ?p))
                       (CONTAINER ?c) (at ?p ?c)
                       )
    :effect (and (not (is-free ?g)) (at ?g ?c) (not (at ?p ?c)) )
)
    
(:action put-object-down-to
    ; Robot's arm puts object to place (not cabinet)
    :parameters (?g ?p ?c)
    :precondition (and (GRIP ?g) (not (is-free ?g))
                       (PLACE ?p) (not (is-cabinet ?p)) (not (is-stove ?p))
                       (CONTAINER ?c) (at ?g ?c)
                       )
    :effect (and (is-free ?g) (not (at ?g ?c)) (at ?p ?c))
)


(:action take-option-up-from
    ; Robot's arm takes object from place (not cabinet)
    :parameters (?g ?p ?c)
    :precondition (and (GRIP ?g) (is-free ?g)
                       (PLACE ?p) (not (is-cabinet ?p))
                       (OPTION ?c) (at ?p ?c)
                       )
    :effect (and (not (is-free ?g)) (at ?g ?c) (not (at ?p ?c)) )
)
    
(:action put-option-down-to
    ; Robot's arm puts object to place (not cabinet)
    :parameters (?g ?p ?c)
    :precondition (and (GRIP ?g) (not (is-free ?g))
                       (PLACE ?p) (not (is-cabinet ?p)) (not (is-stove ?p))
                       (OPTION ?c) (at ?g ?c)
                       )
    :effect (and (is-free ?g) (not (at ?g ?c)) (at ?p ?c))
)


(:action take-mug-up-from
    ; Robot's arm takes object from place (not cabinet)
    :parameters (?g ?p ?m)
    :precondition (and (GRIP ?g) (is-free ?g)
                       (PLACE ?p) (not (is-cabinet ?p))
                       (MUG ?m) (at ?p ?m)
                       )
    :effect (and (not (is-free ?g)) (at ?g ?m) (not (at ?p ?m)) )
)
    
(:action put-mug-down-to
    ; Robot's arm puts object to place (not cabinet)
    :parameters (?g ?p ?m)
    :precondition (and (GRIP ?g) (not (is-free ?g))
                       (PLACE ?p) (not (is-cabinet ?p)) (not (is-stove ?p))
                       (MUG ?m) (at ?g ?m)
                       )
    :effect (and (is-free ?g) (not (at ?g ?m)) (at ?p ?m))
)



(:action take-kettle-up-from
    ; Robot's arm takes object from place (not cabinet)
    :parameters (?g ?p ?c)
    :precondition (and (GRIP ?g) (is-free ?g)
                       (PLACE ?p) (not (is-cabinet ?p))
                       (KETTLE ?c) (at ?p ?c)
                       )
    :effect (and (not (is-free ?g)) (at ?g ?c) (not (at ?p ?c)) )
)
    
(:action put-kettle-down-to
    ; Robot's arm puts object to place (not cabinet)
    :parameters (?g ?p ?c)
    :precondition (and (GRIP ?g) (not (is-free ?g))
                       (PLACE ?p) (not (is-cabinet ?p))
                       (KETTLE ?c) (at ?g ?c)
                       )
    :effect (and (is-free ?g) (not (at ?g ?c)) (at ?p ?c))
)

(:action open-container
    ; robot uses two grips to open the container
    :parameters (?g1 ?g2 ?c)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (is-free ?g2)
                       (CONTAINER ?c) (at ?g1 ?c) (not (is-open ?c))
    )
    :effect (and (is-open ?c))
)

(:action close-container
    ; robot uses two grips to close the container
    :parameters (?g1 ?g2 ?c)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (is-free ?g2)
                       (CONTAINER ?c) (at ?g1 ?c) (is-open ?c)
    )
    :effect (and (not (is-open ?c)))
)

(:action fill-water-jug
    ; Robot fills water jug to have filtered water (using two grips)
    :parameters (?g1 ?g2 ?c)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (is-free ?g2)
                       (CONTAINER ?c) (for-water ?c) (at ?g1 ?c) (is-open ?c) (not (has-water ?c))
    )
    :effect (and (has-water ?c))
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
    :parameters (?g1 ?g2 ?k ?c)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (not (is-free ?g2))
                       (KETTLE ?k) (not (is-screwed ?k)) (not (has-filter ?k)) (at ?g1 ?k)
                       (CONTAINER ?c) (for-water ?c) (has-water ?c) (at ?g2 ?c) (not (is-open ?c))
    )
    :effect (and (has-water ?k))
)

; SPOON Actions
(:action take-spoon
    ; one grip takes spoon
    :parameters (?g)
    :precondition (and (GRIP ?g) (is-free ?g) (not (has-spoon ?g)))
    :effect (and (not (is-free ?g)) (has-spoon ?g))
)

(:action put-down-spoon
    ; one grip puts spoon down
    :parameters (?g)
    :precondition (and (GRIP ?g) (not (is-free ?g)) (has-spoon ?g))
    :effect (and (not (has-spoon ?g)) (is-free ?g))
)


; COFFEE GRINDING
(:action pour-beans-to-grinder
    ; pours coffee beans to the grinder, which is always open
    :parameters (?g1 ?g2 ?p ?c)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (not (is-free ?g2)) (has-spoon ?g2)
                       (PLACE ?p) (is-grinder ?p) 
                       (CONTAINER ?c) (has-beans ?c) (at ?g1 ?c) (is-open ?c)
                       )
    :effect (and (has-beans ?p))
)

(:action grind-coffee
    ; robot clicks on container to grind coffee, coffeee goes directly to the container which is at the grinder
    :parameters (?g ?p ?c)
    :precondition (and (GRIP ?g) (is-free ?g)
                       (PLACE ?p) (is-grinder ?p) (has-beans ?p)
                       (CONTAINER ?c) (at ?p ?c) (is-empty ?c)
    )
    :effect (and (has-coffee ?c))
)

(:action pour-coffee-to-the-kettle
    ; put ground coffee to the kettle
    :parameters (?g1 ?g2 ?c ?p ?k)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (has-spoon ?g2)
                       (CONTAINER ?c) (has-coffee ?c) (is-open ?c) (at ?g1 ?c)
                       (PLACE ?p) (is-table ?p)
                       (KETTLE ?k) (not (is-screwed ?k)) (has-filter ?k) (at ?p ?k)
    )
    :effect (and (has-coffee ?k) (not (has-coffee ?c)) (is-empty ?c))
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
    :parameters (?g ?k ?p)
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
    :parameters (?g1 ?g2 ?p ?o ?m)
    :precondition (and (GRIP ?g1) (not (is-free ?g1))
                       (GRIP ?g2) (has-spoon ?g2)
                       (PLACE ?p) (is-table ?p)
                       (OPTION ?o) (at ?g1 ?o)
                       (MUG ?m) (has-coffee ?m) (at ?p ?m)
                       )
    :effect (and (has-flavor ?m ?o))
)

)