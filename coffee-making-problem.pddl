(define (problem moka_maker) (:domain moka_robo_barista_two)
(:objects 
    robot
    
    water_jug
    beans_jar
    coffee_mug
    
    pot
    
    drawer
    closet
    table
    grinder
    stove
    
    sugar
    
    mug
)

(:init
    
    (robot robot)
    (container water_jug) (container beans_jar) (container coffee_mug) 
    (pot pot)
    (location drawer) (location table) (location grinder) (location stove) 
    (LOCATION closet)
    (addonce sugar)
    (mug mug)


    ; robot 
    (is-free robot)
    
    ;Locations
    (is-drawer closet)
    (is-closed closet)
    (is-drawer drawer)
    (is-closed drawer)
    (is-table table)
    (is-grinder grinder)
    (is-stove stove)
    
    ; water jug
    (for-water water_jug)
    (at drawer water_jug)
    
    ; beans CONTAINER
    (has-beans beans_jar)
    (at drawer beans_jar)
    (at drawer coffee_mug)
    (is-empty coffee_mug)
    
    ;addons
    (at table sugar)

    ;mugs
    (is-empty mug)
    (at closet mug)

    
    ;pot
    (at drawer pot)
    (has-filter pot)
    (is-screwed pot)
    
    
)

(:goal (and 
            (has-coffee mug) (has-flavor mug sugar)
            
            (at drawer coffee_mug)
            (at drawer beans_jar)
            (at table water_jug)
            (at table sugar)
            (is-closed drawer)
            (is-closed closet)
            
            (is-free robot)
)
)
)