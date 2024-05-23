(define (domain coffee-maker-assistant)

(:requirements 
    :strips
    :negative-preconditions
 )
(:predicates
    (HAND ?h) ;robot hand
    (LOCATION ?l)   ;locations (drawers, tables etc)
    (CONTAINER ?c) ;container for coffee
    (POT ?p)    ;pot
    (CUP ?c) ; cup
    (ADDON ?a) ; additional stuff for your coffee

    
    ; Hand predicates
    (is-free ?h) ; if hand is free
    (has-spoon ?h) ;if one of the hands holds spoon
    (has-top-pot-part ?h)   ;if hand holds the top part of the pot

    ;Location predicates
    (is-drawer ?l)  ;drawer identifier
    (is-closed ?l)  ; if not true -> robot cannot take anything from drawer
    (is-table ?l) ; table identifier
    (is-grinder ?l) ;grinder identifier
    (is-stove ?l)   ; stove id

    ; Container predicates
    (for-water ?c) ;container meant for storing water
    (has-water ?c) ;whether an object has water
    (has-beans ?c) ;whether a container has beans
    (is-empty ?c) ;if container is empty
    (is-open ?c)  ;if container is open
    (at ?l ?c) ; represents where the container is

    
    ;pot predicates 
    (has-coffee ?p) ;whether object has coffee, both as a ground coffee or liquid
    (is-screwed ?p) ;whether pot is screwed
    (has-filter ?p) ;if filter is inside the pot
    (coffee-is-ready ?p)    ;whether coffee as liquid is in the pot
    (coffee-is-distributed-evenly ?p)   ;Whether cofffee was placed evenly

    ;cup predicates
    (has-flavor ?c ?a)       ; if coffeee has specified addon eg. sugar, milk -bleh
)

; action for drawers
(:action open-drawer
    ;Robot arms opens drawer
    :parameters (?l ?h)
    :precondition (and (LOCATION ?l) (is-drawer ?l) (is-closed ?l)
                       (HAND ?h) (is-free ?h))
    :effect (and (not (is-closed ?l)))
)

(:action close-drawer
    ;Robot closes  drawer
    :parameters (?l ?h)
    :precondition (and (LOCATION ?l) (is-drawer ?l) (not (is-closed ?l))
                       (HAND ?h) (is-free ?h))
    :effect (and (is-closed ?l))
)

; MOVING OBJECTS

(:action take-object-up-from-drawer
    ; Robot's arm takes object from drawer
    :parameters (?h ?l ?c)
    :precondition (and (HAND ?h) (is-free ?h)
                       (LOCATION ?l) (is-drawer ?l) (not (is-closed ?l))
                       (CONTAINER ?c) (at ?l ?c)
                       )
    :effect (and (not (is-free ?h)) (at ?h ?c) (not (at ?l ?c)))
)

(:action put-object-down-to-drawer
    ; Robot's arm puts object to drawer
    :parameters (?h ?l ?c)
    :precondition (and (HAND ?h) (not (is-free ?h))
                       (LOCATION ?l) (is-drawer ?l) (not (is-closed ?l))
                       (CONTAINER ?c) (at ?h ?c) 
                       )
    :effect (and (is-free ?h) (not (at ?h ?c)) (at ?l ?c))
)


(:action take-cup-up-from-drawer
    ; Robot's arm takes object from drawer
    :parameters (?h ?l ?c)
    :precondition (and (HAND ?h) (is-free ?h)
                       (LOCATION ?l) (is-drawer ?l) (not (is-closed ?l))
                       (CUP ?c) (at ?l ?c)
                       )
    :effect (and (not (is-free ?h)) (at ?h ?c) (not (at ?l ?c)))
)

(:action put-cup-down-to-drawer
    ; Robot's arm puts object to drawer
    :parameters (?h ?l ?c)
    :precondition (and (HAND ?h) (not (is-free ?h))
                       (LOCATION ?l) (is-drawer ?l) (not (is-closed ?l))
                       (CUP ?c) (at ?h ?c) 
                       )
    :effect (and (is-free ?h) (not (at ?h ?c)) (at ?l ?c))
)


(:action take-pot-up-from-drawer
    ; Robot's arm takes pot from drawer
    :parameters (?h ?l ?p)
    :precondition (and (HAND ?h) (is-free ?h)
                       (LOCATION ?l) (is-drawer ?l) (not (is-closed ?l))
                       (POT ?p) (at ?l ?p)
                       )
    :effect (and (not (is-free ?h)) (at ?h ?p) (not (at ?l ?p)))
)

(:action put-pot-down-to-drawer
    ; Robot's arm takes pot to drawer
    :parameters (?h ?l ?p)
    :precondition (and (HAND ?h) (not (is-free ?h))
                       (LOCATION ?l) (is-drawer ?l) (not (is-closed ?l))
                       (POT ?p) (at ?h ?p) 
                       )
    :effect (and (is-free ?h) (not (at ?h ?p)) (at ?l ?p))
)

(:action take-object-up-from
    ; Robot's arm takes object from location (not drawer)
    :parameters (?h ?l ?c)
    :precondition (and (HAND ?h) (is-free ?h)
                       (LOCATION ?l) (not (is-drawer ?l))
                       (CONTAINER ?c) (at ?l ?c)
                       )
    :effect (and (not (is-free ?h)) (at ?h ?c) (not (at ?l ?c)) )
)
    
(:action put-object-down-to
    ; Robot's arm puts object to location (not drawer)
    :parameters (?h ?l ?c)
    :precondition (and (HAND ?h) (not (is-free ?h))
                       (LOCATION ?l) (not (is-drawer ?l)) (not (is-stove ?l))
                       (CONTAINER ?c) (at ?h ?c)
                       )
    :effect (and (is-free ?h) (not (at ?h ?c)) (at ?l ?c))
)


(:action take-addon-up-from
    ; Robot's arm takes object from location (not drawer)
    :parameters (?h ?l ?c)
    :precondition (and (HAND ?h) (is-free ?h)
                       (LOCATION ?l) (not (is-drawer ?l))
                       (ADDON ?c) (at ?l ?c)
                       )
    :effect (and (not (is-free ?h)) (at ?h ?c) (not (at ?l ?c)) )
)
    
(:action put-addon-down-to
    ; Robot's arm puts object to location (not drawer)
    :parameters (?h ?l ?c)
    :precondition (and (HAND ?h) (not (is-free ?h))
                       (LOCATION ?l) (not (is-drawer ?l)) (not (is-stove ?l))
                       (ADDON ?c) (at ?h ?c)
                       )
    :effect (and (is-free ?h) (not (at ?h ?c)) (at ?l ?c))
)


(:action take-cup-up-from
    ; Robot's arm takes object from location (not drawer)
    :parameters (?h ?l ?c)
    :precondition (and (HAND ?h) (is-free ?h)
                       (LOCATION ?l) (not (is-drawer ?l))
                       (CUP ?c) (at ?l ?c)
                       )
    :effect (and (not (is-free ?h)) (at ?h ?c) (not (at ?l ?c)) )
)
    
(:action put-cup-down-to
    ; Robot's arm puts object to location (not drawer)
    :parameters (?h ?l ?c)
    :precondition (and (HAND ?h) (not (is-free ?h))
                       (LOCATION ?l) (not (is-drawer ?l)) (not (is-stove ?l))
                       (CUP ?c) (at ?h ?c)
                       )
    :effect (and (is-free ?h) (not (at ?h ?c)) (at ?l ?c))
)



(:action take-pot-up-from
    ; Robot's arm takes object from location (not drawer)
    :parameters (?h ?l ?c)
    :precondition (and (HAND ?h) (is-free ?h)
                       (LOCATION ?l) (not (is-drawer ?l))
                       (POT ?c) (at ?l ?c)
                       )
    :effect (and (not (is-free ?h)) (at ?h ?c) (not (at ?l ?c)) )
)
    
(:action put-pot-down-to
    ; Robot's arm puts object to location (not drawer)
    :parameters (?h ?l ?c)
    :precondition (and (HAND ?h) (not (is-free ?h))
                       (LOCATION ?l) (not (is-drawer ?l))
                       (POT ?c) (at ?h ?c)
                       )
    :effect (and (is-free ?h) (not (at ?h ?c)) (at ?l ?c))
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

(:action unscrew-pot
    ;robot removes the top part of the pot and puts it on the table
    :parameters (?h1 ?h2 ?p)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (is-free ?h2)
                       (POT ?p) (at ?h1 ?p) (is-screwed ?p)
                       )
    :effect (and (not (is-screwed ?p)) (not (is-free ?h2)) (has-top-pot-part ?h2))
)

(:action put-down-top-part
    ; Robot puts down the top part of the pot
    :parameters (?h)
    :precondition (and (HAND ?h) (not (is-free ?h)) (has-top-pot-part ?h))
    :effect (and (is-free ?h) (not (has-top-pot-part ?h)))
)

(:action take-up-top-part
    ; Robot puts down the top part of the pot
    :parameters (?h)
    :precondition (and (HAND ?h) (is-free ?h) (not (has-top-pot-part ?h)))
    :effect (and (not (is-free ?h)) (has-top-pot-part ?h))
)

(:action screw-pot
    ;robot removes the top part of the pot and puts it on the table
    :parameters (?h1 ?h2 ?p)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (not (is-free ?h2)) (has-top-pot-part ?h2)
                       (POT ?p) (at ?h1 ?p) (not (is-screwed ?p))
                       )
    :effect (and (is-screwed ?p) (is-free ?h2) (not (has-top-pot-part ?h2)))
)

(:action remove-filter
    ;robot removes filter from the moka pot
    :parameters (?h1 ?h2 ?p)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (is-free ?h2)
                       (POT ?p) (at ?h1 ?p) (not (is-screwed ?p)) (has-filter ?p)
    )
    :effect (and (not (has-filter ?p)))
)

(:action put-filter-back
    ;robot puts filter to the moka pot
    :parameters (?h1 ?h2 ?p)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (is-free ?h2)
                       (POT ?p) (at ?h1 ?p) (not (is-screwed ?p)) (not (has-filter ?p))
    )
    :effect (and (has-filter ?p))
)

(:action pour-water-to-the-pot
    :parameters (?h1 ?h2 ?p ?c)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (not (is-free ?h2))
                       (POT ?p) (not (is-screwed ?p)) (not (has-filter ?p)) (at ?h1 ?p)
                       (CONTAINER ?c) (for-water ?c) (has-water ?c) (at ?h2 ?c) (not (is-open ?c))
    )
    :effect (and (has-water ?p))
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
    :parameters (?h1 ?h2 ?l ?c)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (not (is-free ?h2)) (has-spoon ?h2)
                       (LOCATION ?l) (is-grinder ?l) 
                       (CONTAINER ?c) (has-beans ?c) (at ?h1 ?c) (is-open ?c)
                       )
    :effect (and (has-beans ?l))
)

(:action grind-coffee
    ; robot clicks on container to grind coffee, coffeee goes directly to the container which is at the grinder
    :parameters (?h ?l ?c)
    :precondition (and (HAND ?h) (is-free ?h)
                       (LOCATION ?l) (is-grinder ?l) (has-beans ?l)
                       (CONTAINER ?c) (at ?l ?c) (is-empty ?c)
    )
    :effect (and (has-coffee ?c))
)

(:action pour-coffee-to-the-pot
    ; put ground coffee to the pot
    :parameters (?h1 ?h2 ?c ?l ?p)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (has-spoon ?h2)
                       (CONTAINER ?c) (has-coffee ?c) (is-open ?c) (at ?h1 ?c)
                       (LOCATION ?l) (is-table ?l)
                       (POT ?p) (not (is-screwed ?p)) (has-filter ?p) (at ?l ?p)
    )
    :effect (and (has-coffee ?p) (not (has-coffee ?c)) (is-empty ?c))
)

(:action distribute-coffee-evenly
    ; level the coffee as in description
    :parameters (?h1 ?h2 ?p)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (has-spoon ?h2)
                       (POT ?p) (not (is-screwed ?p)) (has-filter ?p) (at ?h1 ?p) (has-coffee ?p)
                       )
    :effect (and (coffee-is-distributed-evenly ?p)  )
)


(:action ignite-heat
    ; fire-up the stove
    :parameters (?h ?p ?l)
    :precondition (and (HAND ?h) (is-free ?h)
                       (LOCATION ?l) (is-stove ?l)
                       (POT ?p) (has-water ?p) (coffee-is-distributed-evenly ?p) (is-screwed ?p) (at ?l ?p)
    )
    :effect (and (coffee-is-ready ?p))
)

(:action pour-fresh-specialty-to-a-cup
    ; pour the liquid into a cup
    :parameters (?h ?p ?l ?c)
    :precondition (and (HAND ?h) (not (is-free ?h))
                       (POT ?p) (coffee-is-ready ?p) (is-screwed ?p) (at ?h ?p)
                       (LOCATION ?l) (is-table ?l)
                       (CUP ?c) (at ?l ?c) (is-empty ?c)
    )
    :effect (and (has-coffee ?c))
)

(:action add-flavor-to-your-coffee
    ; add sugar/milk to your coffee
    :parameters (?h1 ?h2 ?l ?a ?c)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (has-spoon ?h2)
                       (LOCATION ?l) (is-table ?l)
                       (ADDON ?a) (at ?h1 ?a)
                       (CUP ?c) (has-coffee ?c) (at ?l ?c)
                       )
    :effect (and (has-flavor ?c ?a))
)

)