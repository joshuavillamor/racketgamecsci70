#lang racket/gui

(provide pillar%)

(define pillar%
  (class object%
    (init-field [spawn-location 'down])

    (field [x-pos 0])
    (field [y-pos 0])
    (define SPEED 1)

      (define pillar-bitmap
      (read-bitmap
       "pillar.png"
       #:backing-scale 5
       )
      )
      (super-new)
     
    (define/public (draw dc)
      (send dc draw-bitmap pillar-bitmap x-pos y-pos)
      )

    (define/public (set-x-pos! x-newpos)
      (set! x-pos (- x-newpos (/ (send pillar-bitmap get-width) 2)))
             )
     
    (define/public (set-y-pos! y-newpos)
      (set! y-pos y-newpos)
      )
    

     (define/public (move-pillar)
       (set! x-pos (- x-pos SPEED))
    )
    
    (define/public (move-to-side FRAME_WIDTH)
      (set! x-pos (+ (send pillar-bitmap get-width) FRAME_WIDTH))
      )

    (define/public (get-left-x)
      x-pos
       )

    (define/public (get-right-x)
      (+ x-pos (/ (send pillar-bitmap get-width)1))
       )
    
  
    (define/public (get-top-y)
      y-pos
      )
  
    (define/public (get-bottom-y)
      (+ y-pos (send pillar-bitmap get-height))
      )
   )
  )

  