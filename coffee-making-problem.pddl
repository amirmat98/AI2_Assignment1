(define (problem coffee_maker) (:domain coffee-maker-assistant)
(:objects 
    left_h
    right_h
    
    water_jug
    beans_jar
    coffee_mug
    
    kettle
    
    cabinet
    closet
    table
    grinder
    stove
    
    sugar
    
    mug
)

(:init
    
    (GRIP left_h) (GRIP right_h)
    (HOLDER water_jug) (HOLDER beans_jar) (HOLDER coffee_mug) 
    (KETTLE kettle)
    (PLACE cabinet) (PLACE table) (PLACE grinder) (PLACE stove) 
    (PLACE closet)
    (ENHANCER sugar)
    (MUG mug)

    ; robot 
    (is-free left_h)
    (is-free right_h)
    
    ;PLACEs
    (is-cabinet closet)
    (is-closed closet)
    (is-cabinet cabinet)
    (is-closed cabinet)
    (is-table table)
    (is-grinder grinder)
    (is-stove stove)
    
    ; water jug
    (for-water water_jug)
    (at cabinet water_jug)
    
    ; beans HOLDER
    (has-beans beans_jar)
    (at cabinet beans_jar)
    (at cabinet coffee_mug)
    (is-empty coffee_mug)
    
    ;addons
    (at table sugar)

    ;mugs
    (is-empty mug)
    (at closet mug)

    ;kettle
    (at cabinet kettle)
    (has-filter kettle)
    (is-screwed kettle)    
)

; Idea behind thid goal is to have kind-of-master-chef way of doing that.
; You finish job, nothing in your GRIPs, your environment is tidied up
; Main task was to prepare coffee with sugar.
(:goal (and 
            (has-coffee mug) (has-flavor mug sugar)
            
            (at cabinet coffee_mug)
            (at cabinet beans_jar)
            (at table water_jug)
            (at table sugar)
            
            (is-free right_h)
            (is-free left_h)
            
            (is-closed cabinet)
            (is-closed closet)
)
)
)