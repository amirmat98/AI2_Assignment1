(define (problem coffee-maker) (:domain coffee-maker-assistant)
(:objects 
    left_g
    right_g
    
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
    
    (GRIP left_g) (GRIP right_g)
    (CONTAINER water_jug) (CONTAINER beans_jar) (CONTAINER coffee_mug) 
    (KETTLE kettle)
    (PLACE cabinet) (PLACE table) (PLACE grinder) (PLACE stove) 
    (PLACE closet)
    (OPTION sugar)
    (MUG mug)

    ; robot 
    (is-free left_g)
    (is-free right_g)
    
    ;Places
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
    
    ; beans CONTAINER
    (has-beans beans_jar)
    (at cabinet beans_jar)
    (at cabinet coffee_mug)
    (is-empty coffee_mug)
    
    ;options
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
; You finish job, nothing in your grips, your environment is tidied up
; Main task was to prepare coffee with sugar.
(:goal (and 
            (has-coffee mug) (has-flavor mug sugar)
            
            (at cabinet coffee_mug)
            (at cabinet beans_jar)
            (at table water_jug)
            (at table sugar)
            
            (is-free right_g)
            (is-free left_g)
            
            (is-closed cabinet)
            (is-closed closet)
)
)
)