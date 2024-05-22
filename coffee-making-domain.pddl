;Header and description

(define (domain cafe-robot)

(:requirements 
  :strips
  :typing  
  :negative-preconditions
)

;;;;;;;;;;;;;;;Types;;;;;;;;;;;;;;;;;;;;

(:types
  robot vessel substance tool - object
  water_holder beans_holder sugar_holder coffee_container - vessel  
  cabinet closet table grinder stove - place ; locations
  coffee water enhancer - substance
  sugar milk - enhancer  
  pot mug spoon - tools
  grip - robot ; Robot's hand  
)

;;;;;;;;;;;;;;;;Predicates;;;;;;;;;;;;;;;;;;

(:predicates
; predicates
(vessel ?v - object)
(substance ?s - object)
(tool ?t - object)
(robot ?r - object)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; robot predicates
(grip ?g - robot)
(is-free ?g - robot) ; grib is free
(has-spoon ?g - robot) ; grip has spoon
(has-top-part ?g - robot) ; grip has top part of the pot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; vessel predicates
(water_holder ?wh - vessel) ; water holder
(beans_holder ?bh - vessel) ; beans holder
(sugar_holder ?sh - vessel) ; sugar holder
(coffee_container ?cc - vessel) ; coffee container
(is-empty ?v - vessel) ; container is empty
(has-water ?v - vessel) ; container has water
(has-beans ?v - vessel) ; container has coffee beans
(has-sugar ?v - vessel) ; container has sugar
(has-milk ?v - vessel) ; container has milk
(is-open ?v - vessel) ; container is open
(at ?p ?v) ; vessel is at place
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; place predicates
(cabinet ?ca - place) ; cabinet
(closet ?cl - place) ; closet
(table ?ta - place) ; table
(grinder ?gr - place) ; grinder
(stove ?st - place) ; stove
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; substance predicates
(coffee ?c - substance) ; coffee
(water ?w - substance) ; water
(enhancer ?e - substance) ; enhancer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; coffee predicates
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; enhancer predicates
(sugar ?s - enhancer) ; sugar
(milk ?m - enhancer) ; milk
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; tool predicates
(pot ?p - tool) ; pot
(mug ?m - tool) ; mug
(spoon ?sp - tool) ; spoon
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; pot predicates
(has-coffee ?p - tool) ; pot has coffee
(has-filter ?p - tool) ; pot has filter
(is-screwed ?p - tool) ; pot is screwd
(is-ready ?p - tool) ; coffer is ready to serve when the water is in the pot
(is-distributed ?p - tool) ; coffee is distributed
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mug predicates
(has-flavor ?m - tool) ; mug has flavor
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
    :parameters (?r ?p)
    :precondition (and (robot ?r) (not (is-free ?r))
                       (pot ?p) (at ?r ?p) (not (is-screwed ?p)) (has-filter ?p)
    )
    :effect (and (not (has-filter ?p)))
)

(:action put-filter-back
    ;robot puts filter to the moka pot
    :parameters (?r ?p)
    :precondition (and (robot ?r) (not (is-free ?r))
                       (pot ?p) (at ?r ?p) (not (is-screwed ?p)) (not (has-filter ?p))
    )
    :effect (and (has-filter ?p))
)

(:action pour-water-to-the-pot
    :parameters (?r ?p ?c)
    :precondition (and (robot ?r) (not (is-free ?r))
                       (pot ?p) (not (is-screwed ?p)) (not (has-filter ?p)) (at ?r ?p)
                       (container ?c) (for-water ?c) (has-water ?c) (at ?r ?c) (not (is-open ?c))
    )
    :effect (and (full-water ?p))
)

(:action take-spoon
    ; one hand takes spoon
    :parameters (?r)
    :precondition (and (robot ?r) (is-free ?r) (not (has-spoon ?r)))
    :effect (and (not (is-free ?r)) (has-spoon ?r))
)

(:action put-down-spoon
    ; one hand puts spoon down
    :parameters (?r)
    :precondition (and (robot ?r) (not (is-free ?r)) (has-spoon ?r))
    :effect (and (not (has-spoon ?r)) (is-free ?r))
)


; COFFEE GRINDING
(:action pour-beans-to-grinder
    ; pours coffee beans to the grinder, which is always open
    :parameters (?r ?l ?c)
    :precondition (and (robot ?r) (not (is-free ?r)) (has-spoon ?r)
                       (location ?l) (is-grinder ?l) 
                       (container ?c) (has-beans ?c) (at ?r ?c) (is-open ?c)
                       )
    :effect (and (has-beans ?l))
)

(:action grind-coffee
    ; robot clicks on container to grind coffee
    :parameters (?r ?l ?c)
    :precondition (and (robot ?r) (is-free ?r)
                       (location ?l) (is-grinder ?l) (has-beans ?l)
                       (container ?c) (at ?l ?c) (is-empty ?c)
    )
    :effect (and (has-coffee ?c))
)

(:action pour-coffee-to-the-pot
    :parameters (?r ?c ?l ?p)
    :precondition (and (robot ?r) (not (is-free ?r))
                       (robot ?r) (has-spoon ?r)
                       (container ?c) (has-coffee ?c) (is-open ?c) (at ?r ?c)
                       (location ?l) (is-table ?l)
                       (pot ?p) (not (is-screwed ?p)) (has-filter ?p) (at ?l ?p)
    )
    :effect (and (has-coffee ?p) (not (has-coffee ?c)) (is-empty ?c))
)

(:action distribute-coffee-evenly
    :parameters (?r ?p)
    :precondition (and (robot ?r) (not (is-free ?r)) (has-spoon ?r)
                       (pot ?p) (not (is-screwed ?p)) (has-filter ?p) (at ?r ?p) (has-coffee ?p)
                       )
    :effect (and (is-distributed ?p))
)


(:action ignite-heat
    :parameters (?r ?p ?l)
    :precondition (and (robot ?r) (is-free ?r)
                       (location ?l) (is-stove ?l)
                       (pot ?p) (has-water ?p) (is-distributed ?p) (is-screwed ?p) (at ?l ?p)
    )
    :effect (and (is-ready ?p))
)

(:action pour-fresh-specialty-to-a-mug
    :parameters (?r ?p ?l ?m)
    :precondition (and (robot ?r) (not (is-free ?r))
                       (pot ?p) (is-ready ?p) (is-screwed ?p) (at ?r ?p)
                       (location ?l) (is-table ?l)
                       (mug ?m) (at ?l ?m) (is-empty ?m)
    )
    :effect (and (has-coffee ?m))
)

(:action add-flavor-to-your-coffee
    :parameters (?r ?l ?a ?m)
    :precondition (and (robot ?r) (not (is-free ?r)) (has-spoon ?r)
                       (location ?l) (is-table ?l)
                       (addonce ?a) (at ?r ?a)
                       (mug ?m) (has-coffee ?m) (at ?l ?m)
                       )
    :effect (and (has-flavor ?m ?a))
)

)