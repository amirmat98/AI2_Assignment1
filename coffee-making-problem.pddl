(define (problem coffee-maker) (:domain coffee-maker-assistant)
(:objects 
    left_h
    right_h
    
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
    
    cup
)

(:init
    
    (HAND left_h) (HAND right_h)
    (CONTAINER water_jug) (CONTAINER beans_jar) (CONTAINER coffee_mug) 
    (POT pot)
    (LOCATION drawer) (LOCATION table) (LOCATION grinder) (LOCATION stove) 
    (LOCATION closet)
    (ADDON sugar)
    (CUP cup)

    ; robot 
    (is-free left_h)
    (is-free right_h)
    
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

    ;cups
    (is-empty cup)
    (at closet cup)

    ;pot
    (at drawer pot)
    (has-filter pot)
    (is-screwed pot)    
)

; Idea behind thid goal is to have kind-of-master-chef way of doing that.
; You finish job, nothing in your hands, your environment is tidied up
; Main task was to prepare coffee with sugar.
(:goal (and 
            (has-coffee cup) (has-flavor cup sugar)
            
            (at drawer coffee_mug)
            (at drawer beans_jar)
            (at table water_jug)
            (at table sugar)
            
            (is-free right_h)
            (is-free left_h)
            
            (is-closed drawer)
            (is-closed closet)
)
)
)