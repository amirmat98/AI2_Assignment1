(define (domain coffee-maker-assistant)

(:requirements 
    :strips
    :negative-preconditions
 )
(:predicates
    (HAND ?h) ;robot hand
    (PLACE ?p)   ;places (drawers, tables etc)
    (CONTAINER ?c) ;container for coffee
    (KETTLE ?k)    ;kettle
    (CUP ?c) ; cup
    (ADDON ?a) ; additional stuff for your coffee

    
    ; Hand predicates
    (is-free ?h) ; if hand is free
    (has-spoon ?h) ;if one of the hands holds spoon
    (has-top-kettle-part ?h)   ;if hand holds the top part of the kettle

    ;Place predicates
    (is-drawer ?p)  ;drawer identifier
    (is-closed ?p)  ; if not true -> robot cannot take anything from drawer
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

    ;cup predicates
    (has-flavor ?c ?a)       ; if coffeee has specified addon eg. sugar, milk -bleh
)

; action for drawers
(:action open-drawer
    ;Robot arms opens drawer
    :parameters (?p ?h)
    :precondition (and (PLACE ?p) (is-drawer ?p) (is-closed ?p)
                       (HAND ?h) (is-free ?h))
    :effect (and (not (is-closed ?p)))
)

(:action close-drawer
    ;Robot closes  drawer
    :parameters (?p ?h)
    :precondition (and (PLACE ?p) (is-drawer ?p) (not (is-closed ?p))
                       (HAND ?h) (is-free ?h))
    :effect (and (is-closed ?p))
)

; MOVING OBJECTS

(:action take-object-up-from-drawer
    ; Robot's arm takes object from drawer
    :parameters (?h ?p ?c)
    :precondition (and (HAND ?h) (is-free ?h)
                       (PLACE ?p) (is-drawer ?p) (not (is-closed ?p))
                       (CONTAINER ?c) (at ?p ?c)
                       )
    :effect (and (not (is-free ?h)) (at ?h ?c) (not (at ?p ?c)))
)

(:action put-object-down-to-drawer
    ; Robot's arm puts object to drawer
    :parameters (?h ?p ?c)
    :precondition (and (HAND ?h) (not (is-free ?h))
                       (PLACE ?p) (is-drawer ?p) (not (is-closed ?p))
                       (CONTAINER ?c) (at ?h ?c) 
                       )
    :effect (and (is-free ?h) (not (at ?h ?c)) (at ?p ?c))
)


(:action take-cup-up-from-drawer
    ; Robot's arm takes object from drawer
    :parameters (?h ?p ?c)
    :precondition (and (HAND ?h) (is-free ?h)
                       (PLACE ?p) (is-drawer ?p) (not (is-closed ?p))
                       (CUP ?c) (at ?p ?c)
                       )
    :effect (and (not (is-free ?h)) (at ?h ?c) (not (at ?p ?c)))
)

(:action put-cup-down-to-drawer
    ; Robot's arm puts object to drawer
    :parameters (?h ?p ?c)
    :precondition (and (HAND ?h) (not (is-free ?h))
                       (PLACE ?p) (is-drawer ?p) (not (is-closed ?p))
                       (CUP ?c) (at ?h ?c) 
                       )
    :effect (and (is-free ?h) (not (at ?h ?c)) (at ?p ?c))
)


(:action take-kettle-up-from-drawer
    ; Robot's arm takes kettle from drawer
    :parameters (?h ?p ?k)
    :precondition (and (HAND ?h) (is-free ?h)
                       (PLACE ?p) (is-drawer ?p) (not (is-closed ?p))
                       (KETTLE ?k) (at ?p ?k)
                       )
    :effect (and (not (is-free ?h)) (at ?h ?k) (not (at ?p ?k)))
)

(:action put-kettle-down-to-drawer
    ; Robot's arm takes kettle to drawer
    :parameters (?h ?p ?k)
    :precondition (and (HAND ?h) (not (is-free ?h))
                       (PLACE ?p) (is-drawer ?p) (not (is-closed ?p))
                       (KETTLE ?k) (at ?h ?k) 
                       )
    :effect (and (is-free ?h) (not (at ?h ?k)) (at ?p ?k))
)

(:action take-object-up-from
    ; Robot's arm takes object from place (not drawer)
    :parameters (?h ?p ?c)
    :precondition (and (HAND ?h) (is-free ?h)
                       (PLACE ?p) (not (is-drawer ?p))
                       (CONTAINER ?c) (at ?p ?c)
                       )
    :effect (and (not (is-free ?h)) (at ?h ?c) (not (at ?p ?c)) )
)
    
(:action put-object-down-to
    ; Robot's arm puts object to place (not drawer)
    :parameters (?h ?p ?c)
    :precondition (and (HAND ?h) (not (is-free ?h))
                       (PLACE ?p) (not (is-drawer ?p)) (not (is-stove ?p))
                       (CONTAINER ?c) (at ?h ?c)
                       )
    :effect (and (is-free ?h) (not (at ?h ?c)) (at ?p ?c))
)


(:action take-addon-up-from
    ; Robot's arm takes object from place (not drawer)
    :parameters (?h ?p ?c)
    :precondition (and (HAND ?h) (is-free ?h)
                       (PLACE ?p) (not (is-drawer ?p))
                       (ADDON ?c) (at ?p ?c)
                       )
    :effect (and (not (is-free ?h)) (at ?h ?c) (not (at ?p ?c)) )
)
    
(:action put-addon-down-to
    ; Robot's arm puts object to place (not drawer)
    :parameters (?h ?p ?c)
    :precondition (and (HAND ?h) (not (is-free ?h))
                       (PLACE ?p) (not (is-drawer ?p)) (not (is-stove ?p))
                       (ADDON ?c) (at ?h ?c)
                       )
    :effect (and (is-free ?h) (not (at ?h ?c)) (at ?p ?c))
)


(:action take-cup-up-from
    ; Robot's arm takes object from place (not drawer)
    :parameters (?h ?p ?c)
    :precondition (and (HAND ?h) (is-free ?h)
                       (PLACE ?p) (not (is-drawer ?p))
                       (CUP ?c) (at ?p ?c)
                       )
    :effect (and (not (is-free ?h)) (at ?h ?c) (not (at ?p ?c)) )
)
    
(:action put-cup-down-to
    ; Robot's arm puts object to place (not drawer)
    :parameters (?h ?p ?c)
    :precondition (and (HAND ?h) (not (is-free ?h))
                       (PLACE ?p) (not (is-drawer ?p)) (not (is-stove ?p))
                       (CUP ?c) (at ?h ?c)
                       )
    :effect (and (is-free ?h) (not (at ?h ?c)) (at ?p ?c))
)



(:action take-kettle-up-from
    ; Robot's arm takes object from place (not drawer)
    :parameters (?h ?p ?c)
    :precondition (and (HAND ?h) (is-free ?h)
                       (PLACE ?p) (not (is-drawer ?p))
                       (KETTLE ?c) (at ?p ?c)
                       )
    :effect (and (not (is-free ?h)) (at ?h ?c) (not (at ?p ?c)) )
)
    
(:action put-kettle-down-to
    ; Robot's arm puts object to place (not drawer)
    :parameters (?h ?p ?c)
    :precondition (and (HAND ?h) (not (is-free ?h))
                       (PLACE ?p) (not (is-drawer ?p))
                       (KETTLE ?c) (at ?h ?c)
                       )
    :effect (and (is-free ?h) (not (at ?h ?c)) (at ?p ?c))
)

(:action open-container
    ; robot uses two hands to open the container
    :parameters (?h1 ?h2 ?c)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (is-free ?h2)
                       (CONTAINER ?c) (at ?h1 ?c) (not (is-open ?c))
    )
    :effect (and (is-open ?c))
)

(:action close-container
    ; robot uses two hands to close the container
    :parameters (?h1 ?h2 ?c)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (is-free ?h2)
                       (CONTAINER ?c) (at ?h1 ?c) (is-open ?c)
    )
    :effect (and (not (is-open ?c)))
)

(:action fill-water-jug
    ; Robot fills water jug to have filtered water (using two hands)
    :parameters (?h1 ?h2 ?c)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (is-free ?h2)
                       (CONTAINER ?c) (for-water ?c) (at ?h1 ?c) (is-open ?c) (not (has-water ?c))
    )
    :effect (and (has-water ?c))
)

(:action unscrew-kettle
    ;robot removes the top part of the kettle and puts it on the table
    :parameters (?h1 ?h2 ?k)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (is-free ?h2)
                       (KETTLE ?k) (at ?h1 ?k) (is-screwed ?k)
                       )
    :effect (and (not (is-screwed ?k)) (not (is-free ?h2)) (has-top-kettle-part ?h2))
)

(:action put-down-top-part
    ; Robot puts down the top part of the kettle
    :parameters (?h)
    :precondition (and (HAND ?h) (not (is-free ?h)) (has-top-kettle-part ?h))
    :effect (and (is-free ?h) (not (has-top-kettle-part ?h)))
)

(:action take-up-top-part
    ; Robot puts down the top part of the kettle
    :parameters (?h)
    :precondition (and (HAND ?h) (is-free ?h) (not (has-top-kettle-part ?h)))
    :effect (and (not (is-free ?h)) (has-top-kettle-part ?h))
)

(:action screw-kettle
    ;robot removes the top part of the kettle and puts it on the table
    :parameters (?h1 ?h2 ?k)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (not (is-free ?h2)) (has-top-kettle-part ?h2)
                       (KETTLE ?k) (at ?h1 ?k) (not (is-screwed ?k))
                       )
    :effect (and (is-screwed ?k) (is-free ?h2) (not (has-top-kettle-part ?h2)))
)

(:action remove-filter
    ;robot removes filter from the moka kettle
    :parameters (?h1 ?h2 ?k)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (is-free ?h2)
                       (KETTLE ?k) (at ?h1 ?k) (not (is-screwed ?k)) (has-filter ?k)
    )
    :effect (and (not (has-filter ?k)))
)

(:action put-filter-back
    ;robot puts filter to the moka kettle
    :parameters (?h1 ?h2 ?k)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (is-free ?h2)
                       (KETTLE ?k) (at ?h1 ?k) (not (is-screwed ?k)) (not (has-filter ?k))
    )
    :effect (and (has-filter ?k))
)

(:action pour-water-to-the-kettle
    :parameters (?h1 ?h2 ?k ?c)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (not (is-free ?h2))
                       (KETTLE ?k) (not (is-screwed ?k)) (not (has-filter ?k)) (at ?h1 ?k)
                       (CONTAINER ?c) (for-water ?c) (has-water ?c) (at ?h2 ?c) (not (is-open ?c))
    )
    :effect (and (has-water ?k))
)

; SPOON Actions
(:action take-spoon
    ; one hand takes spoon
    :parameters (?h)
    :precondition (and (HAND ?h) (is-free ?h) (not (has-spoon ?h)))
    :effect (and (not (is-free ?h)) (has-spoon ?h))
)

(:action put-down-spoon
    ; one hand puts spoon down
    :parameters (?h)
    :precondition (and (HAND ?h) (not (is-free ?h)) (has-spoon ?h))
    :effect (and (not (has-spoon ?h)) (is-free ?h))
)


; COFFEE GRINDING
(:action pour-beans-to-grinder
    ; pours coffee beans to the grinder, which is always open
    :parameters (?h1 ?h2 ?p ?c)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (not (is-free ?h2)) (has-spoon ?h2)
                       (PLACE ?p) (is-grinder ?p) 
                       (CONTAINER ?c) (has-beans ?c) (at ?h1 ?c) (is-open ?c)
                       )
    :effect (and (has-beans ?p))
)

(:action grind-coffee
    ; robot clicks on container to grind coffee, coffeee goes directly to the container which is at the grinder
    :parameters (?h ?p ?c)
    :precondition (and (HAND ?h) (is-free ?h)
                       (PLACE ?p) (is-grinder ?p) (has-beans ?p)
                       (CONTAINER ?c) (at ?p ?c) (is-empty ?c)
    )
    :effect (and (has-coffee ?c))
)

(:action pour-coffee-to-the-kettle
    ; put ground coffee to the kettle
    :parameters (?h1 ?h2 ?c ?p ?k)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (has-spoon ?h2)
                       (CONTAINER ?c) (has-coffee ?c) (is-open ?c) (at ?h1 ?c)
                       (PLACE ?p) (is-table ?p)
                       (KETTLE ?k) (not (is-screwed ?k)) (has-filter ?k) (at ?p ?k)
    )
    :effect (and (has-coffee ?k) (not (has-coffee ?c)) (is-empty ?c))
)

(:action distribute-coffee-evenly
    ; level the coffee as in description
    :parameters (?h1 ?h2 ?k)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (has-spoon ?h2)
                       (KETTLE ?k) (not (is-screwed ?k)) (has-filter ?k) (at ?h1 ?k) (has-coffee ?k)
                       )
    :effect (and (coffee-is-distributed-evenly ?k)  )
)


(:action ignite-heat
    ; fire-up the stove
    :parameters (?h ?k ?p)
    :precondition (and (HAND ?h) (is-free ?h)
                       (PLACE ?p) (is-stove ?p)
                       (KETTLE ?k) (has-water ?k) (coffee-is-distributed-evenly ?k) (is-screwed ?k) (at ?p ?k)
    )
    :effect (and (coffee-is-ready ?k))
)

(:action pour-fresh-specialty-to-a-cup
    ; pour the liquid into a cup
    :parameters (?h ?k ?p ?c)
    :precondition (and (HAND ?h) (not (is-free ?h))
                       (KETTLE ?k) (coffee-is-ready ?k) (is-screwed ?k) (at ?h ?k)
                       (PLACE ?p) (is-table ?p)
                       (CUP ?c) (at ?p ?c) (is-empty ?c)
    )
    :effect (and (has-coffee ?c))
)

(:action add-flavor-to-your-coffee
    ; add sugar/milk to your coffee
    :parameters (?h1 ?h2 ?p ?a ?c)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (has-spoon ?h2)
                       (PLACE ?p) (is-table ?p)
                       (ADDON ?a) (at ?h1 ?a)
                       (CUP ?c) (has-coffee ?c) (at ?p ?c)
                       )
    :effect (and (has-flavor ?c ?a))
)

)