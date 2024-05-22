;Header and description

(define (domain coffe-robot)

(:requirements 
  :strips
  :negative-preconditions
)

;;;;;;;;;;;;;;;Types;;;;;;;;;;;;;;;;;;;;

(:types
  robot - robot
  container ingredients tools - object
  drawer table grinder stove - location
  coffee water addonce - ingredients
  pot mug spoon - tools
)

;;;;;;;;;;;;;;;;Predicates;;;;;;;;;;;;;;;;;;

(:predicates
  ; predicates
  (robot ?r) ; represents a robot
  (container ?c) ; represents a container
  (addonce ?a) ; represents an addonce
  (location ?l) ; represents a location
  (tools ?t) ; represents a tool
  (pot ?p) ; represents a pot
  (mug ?m) ; represents a mug
  (spoon ?sp) ; represents a spoon
  (drawer ?d) ; represents a drawer
  (table ?t) ; represents a table
  (grinder ?g) ; represents a grinder
  (stove ?s) ; represents a stove
  (coffee ?co) ; represents a coffee
  (water ?w) ; represents water

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; robot predicates
  (is-free ?r) ; robot is free
  (has-spoon ?r) ; robot has spoon
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; container predicates
  (is-empty ?c) ; container is empty
  (for-water ?c) ; container is for water
  (has-water ?c) ; container has water
  (has-beans ?c) ; container has coffee beans
  (has-sugar ?c) ; container has sugar
  (has-milk ?c) ; container has milk
  (is-open ?c) ; container is open
  (at ?l ?c) ; container is at location
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; location predicates
  (is-drawer ?l) ; location is drawer
  (is-table ?l) ; location is table
  (is-grinder ?l) ; location is grinder
  (is-stove ?l) ; location is stove
  (is-closed ?l) ; location is closed
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; coffee predicates
  (has-flavor ?co ?a) ; coffee has flavor
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; pot predicates
  ;(is-empty ?p) ; pot is empty
  (has-coffee ?p) ; pot has coffee
  (has-filter ?p) ; pot has filter
  (full-water ?p) ; pot has water
  (is-screwed ?p) ; pot is screwd
  (is-ready ?p) ; coffer is ready to serve
  (is-distributed ?p) ; coffee is distributed

)

;;;;;;;;;;;;;Actions;;;;;;;;;;;;;;;
; action for drawers
(:action open-drawer
    ;Robot arms opens drawer
    :parameters (?l ?r)
    :precondition (and (location ?l) (is-drawer ?l) (is-closed ?l)
                       (robot ?r) (is-free ?r))
    :effect (and (not (is-closed ?l)))
)

(:action close-drawer
    ;Robot closes  drawer
    :parameters (?l ?r)
    :precondition (and (location ?l) (is-drawer ?l) (not (is-closed ?l))
                       (robot ?r) (is-free ?r))
    :effect (and (is-closed ?l))
)

; MOVING OBJECTS

(:action take-object-up-from-drawer
    ; Robot's arm takes object from drawer
    :parameters (?r ?l ?c)
    :precondition (and (robot ?r) (is-free ?r)
                       (location ?l) (is-drawer ?l) (not (is-closed ?l))
                       (container ?c) (at ?l ?c)
                       )
    :effect (and (not (is-free ?r)) (at ?r ?c) (not (at ?l ?c)))
)

(:action put-object-down-to-drawer
    ; Robot's arm puts object to drawer
    :parameters (?r ?l ?c)
    :precondition (and (robot ?r) (not (is-free ?r))
                       (location ?l) (is-drawer ?l) (not (is-closed ?l))
                       (container ?c) (at ?r ?c) 
                       )
    :effect (and (is-free ?r) (not (at ?r ?c)) (at ?l ?c))
)


(:action take-mug-up-from-drawer
    ; Robot's arm takes object from drawer
    :parameters (?r ?l ?m)
    :precondition (and (robot ?r) (is-free ?r)
                       (location ?l) (is-drawer ?l) (not (is-closed ?l))
                       (mug ?m) (at ?l ?m)
                       )
    :effect (and (not (is-free ?r)) (at ?r ?m) (not (at ?l ?m)))
)

(:action put-mug-down-to-drawer
    ; Robot's arm puts object to drawer
    :parameters (?r ?l ?m)
    :precondition (and (robot ?r) (not (is-free ?r))
                       (location ?l) (is-drawer ?l) (not (is-closed ?l))
                       (mug ?m) (at ?r ?m) 
                       )
    :effect (and (is-free ?r) (not (at ?r ?m)) (at ?l ?m))
)


(:action take-pot-up-from-drawer
    ; Robot's arm takes pot from drawer
    :parameters (?r ?l ?p)
    :precondition (and (robot ?r) (is-free ?r)
                       (location ?l) (is-drawer ?l) (not (is-closed ?l))
                       (pot ?p) (at ?l ?p)
                       )
    :effect (and (not (is-free ?r)) (at ?r ?p) (not (at ?l ?p)))
)

(:action put-pot-down-to-drawer
    ; Robot's arm takes pot to drawer
    :parameters (?r ?l ?p)
    :precondition (and (robot ?r) (not (is-free ?r))
                       (location ?l) (is-drawer ?l) (not (is-closed ?l))
                       (pot ?p) (at ?r ?p) 
                       )
    :effect (and (is-free ?r) (not (at ?r ?p)) (at ?l ?p))
)

(:action take-object-up-from
    ; Robot's arm takes object from location (not drawer)
    :parameters (?r ?l ?c)
    :precondition (and (robot ?r) (is-free ?r)
                       (location ?l) (not (is-drawer ?l))
                       (container ?c) (at ?l ?c)
                       )
    :effect (and (not (is-free ?r)) (at ?r ?c) (not (at ?l ?c)) )
)
    
(:action put-object-down-to
    ; Robot's arm puts object to location (not drawer)
    :parameters (?r ?l ?c)
    :precondition (and (robot ?r) (not (is-free ?r))
                       (location ?l) (not (is-drawer ?l)) (not (is-stove ?l))
                       (container ?c) (at ?r ?c)
                       )
    :effect (and (is-free ?r) (not (at ?r ?c)) (at ?l ?c))
)


(:action take-addon-up-from
    ; Robot's arm takes object from location (not drawer)
    :parameters (?r ?l ?c)
    :precondition (and (robot ?r) (is-free ?r)
                       (location ?l) (not (is-drawer ?l))
                       (addonce ?c) (at ?l ?c)
                       )
    :effect (and (not (is-free ?r)) (at ?r ?c) (not (at ?l ?c)) )
)
    
(:action put-addon-down-to
    ; Robot's arm puts object to location (not drawer)
    :parameters (?r ?l ?c)
    :precondition (and (robot ?r) (not (is-free ?r))
                       (location ?l) (not (is-drawer ?l)) (not (is-stove ?l))
                       (addonce ?c) (at ?r ?c)
                       )
    :effect (and (is-free ?r) (not (at ?r ?c)) (at ?l ?c))
)


(:action take-mug-up-from
    ; Robot's arm takes object from location (not drawer)
    :parameters (?r ?l ?m)
    :precondition (and (robot ?r) (is-free ?r)
                       (location ?l) (not (is-drawer ?l))
                       (mug ?m) (at ?l ?m)
                       )
    :effect (and (not (is-free ?r)) (at ?r ?m) (not (at ?l ?m)) )
)
    
(:action put-mug-down-to
    ; Robot's arm puts object to location (not drawer)
    :parameters (?r ?l ?m)
    :precondition (and (robot ?r) (not (is-free ?r))
                       (location ?l) (not (is-drawer ?l)) (not (is-stove ?l))
                       (mug ?m) (at ?r ?m)
                       )
    :effect (and (is-free ?r) (not (at ?r ?m)) (at ?l ?m))
)



(:action take-pot-up-from
    ; Robot's arm takes object from location (not drawer)
    :parameters (?r ?l ?p)
    :precondition (and (robot ?r) (is-free ?r)
                       (location ?l) (not (is-drawer ?l))
                       (pot ?p) (at ?l ?p)
                       )
    :effect (and (not (is-free ?r)) (at ?r ?p) (not (at ?l ?p)) )
)
    
(:action put-pot-down-to
    ; Robot's arm puts object to location (not drawer)
    :parameters (?r ?l ?p)
    :precondition (and (robot ?r) (not (is-free ?r))
                       (location ?l) (not (is-drawer ?l))
                       (pot ?p) (at ?r ?p)
                       )
    :effect (and (is-free ?r) (not (at ?r ?p)) (at ?l ?p))
)

(:action open-container
    ; robot uses two hands to open the container
    :parameters (?r ?c)
    :precondition (and (robot ?r) (not (is-free ?r))
                       (container ?c) (at ?r ?c) (not (is-open ?c))
    )
    :effect (and (is-open ?c))
)


(:action close-container
    ; robot uses two hands to close the container
    :parameters (?r ?c)
    :precondition (and (robot ?r) (not (is-free ?r))
                       (container ?c) (at ?r ?c) (is-open ?c)
    )
    :effect (and (not (is-open ?c)))
)

(:action fill-water-reservoir
    ; Robot fills water reservoir to have filtered water (using two hands)
    :parameters (?r ?c)
    :precondition (and (robot ?r) (not (is-free ?r))
                       (container ?c) (for-water ?c) (at ?r ?c) (is-open ?c) (not (has-water ?c))
    )
    :effect (and (has-water ?c))
)

(:action unscrew-pot
    ;robot removes the top part of the pot and puts it on the table
    :parameters (?r ?p)
    :precondition (and (robot ?r) (not (is-free ?r))
                       (pot ?p) (at ?r ?p) (is-screwed ?p)
                       )
    :effect (and (not (is-screwed ?p)))
)

(:action screw-pot
    ;robot removes the top part of the pot and puts it on the table
    :parameters (?r ?p)
    :precondition (and (robot ?r) (not (is-free ?r))
                       (pot ?p) (at ?r ?p) (not (is-screwed ?p))
                       )
    :effect (and (is-screwed ?p))
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
    ; robot clicks on container to grind coffee
    :parameters (?h ?l ?c)
    :precondition (and (HAND ?h) (is-free ?h)
                       (LOCATION ?l) (is-grinder ?l) (has-beans ?l)
                       (CONTAINER ?c) (at ?l ?c) (is-empty ?c)
    )
    :effect (and (has-coffee ?c))
)

(:action pour-coffee-to-the-pot
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
    :parameters (?h1 ?h2 ?p)
    :precondition (and (HAND ?h1) (not (is-free ?h1))
                       (HAND ?h2) (has-spoon ?h2)
                       (POT ?p) (not (is-screwed ?p)) (has-filter ?p) (at ?h1 ?p) (has-coffee ?p)
                       )
    :effect (and (coffee-is-distributed-evenly ?p)  )
)


(:action ignite-heat
    :parameters (?h ?p ?l)
    :precondition (and (HAND ?h) (is-free ?h)
                       (LOCATION ?l) (is-stove ?l)
                       (POT ?p) (has-water ?p) (coffee-is-distributed-evenly ?p) (is-screwed ?p) (at ?l ?p)
    )
    :effect (and (coffee-is-ready ?p))
)

(:action pour-fresh-specialty-to-a-cup
    :parameters (?h ?p ?l ?c)
    :precondition (and (HAND ?h) (not (is-free ?h))
                       (POT ?p) (coffee-is-ready ?p) (is-screwed ?p) (at ?h ?p)
                       (LOCATION ?l) (is-table ?l)
                       (CUP ?c) (at ?l ?c) (is-empty ?c)
    )
    :effect (and (has-coffee ?c))
)

(:action add-flavor-to-your-coffee
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