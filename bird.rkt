#lang racket/gui

(provide bird%)

(define bird%
  (class object%
    (init-field [bird-type 'player])
    
    (define bird-bitmap
      (read-bitmap
       "bird.png"
       #:backing-scale 10
       )
      )
    
    (define x-pos 0)
    (define y-pos 0)
    (define FALLING_SPEED 1)

   
    (define/public (change-direction direction)
      (case direction
       ['up (set! y-pos (- y-pos 15))]
      )
      )
      (define/public (falling)
      (set! y-pos (+ y-pos FALLING_SPEED)
      ))


     (define/public (change-bird-x-pos! bird-x-newpos)
      (set! x-pos bird-x-newpos)
             )
     
    (define/public (change-bird-y-pos! bird-y-newpos)
      (set! y-pos (- bird-y-newpos (/ (send bird-bitmap get-height) 2)))
      )

    (super-new)
     
    (define/public (draw dc)
      (send dc draw-bitmap bird-bitmap x-pos y-pos)
    )

    (define/public (get-left-x)
      x-pos
    )

    (define/public (get-right-x)
      (+ x-pos (send bird-bitmap get-width))
    )
    
  
    (define/public (get-top-y)
      y-pos
    )
  
    (define/public (get-bottom-y)
      (+ y-pos (send bird-bitmap get-height))
    )

)
)

  
