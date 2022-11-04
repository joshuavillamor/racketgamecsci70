#lang racket/gui
(require "bird.rkt")
(require "pillar.rkt")
(require "pillar2.rkt")

(define FRAME_HEIGHT 400)
(define FRAME_WIDTH (* FRAME_HEIGHT 2))
(define FLAPPY_ORIGIN (/ FRAME_HEIGHT 2))

(define main-frame
  (new frame%
       [label "Floppy Birds"]
       [width FRAME_WIDTH]
       [height FRAME_HEIGHT]
       )
  )

(define game-canvas%
  (class canvas%

    (define/override (on-char event)
      (case (send event get-key-release-code)
        ['up (send player change-direction 'up)]
        ['down (send player change-direction 'down)]
        ['#\return
         (case game-state
           ['paused (set! game-state 'active)(send game-timer start 10)]
           ['ended (reset-game-state)(set! game-state 'active)(send game-timer start 10)]
           ['active (set! game-state 'paused)(send game-timer stop)]
           )
         ; cannot refresh as a loop renders the game unplayable
         ;(send this refresh-now)
         ]
         )
      )
    
    (define/private (custom-paint-callback canvas dc)
      
      (for ([pillar pillar-list])
         (send pillar draw dc)
        )
      (send player draw dc)

      (when (or(equal? game-state 'paused) (equal? game-state 'ended))
        (send dc set-brush (make-color 0 0 0 0.5) 'solid)
        (send dc set-pen (make-color 0 0 0 0.5) 0 'solid)
        (send dc draw-rectangle 0 0 FRAME_WIDTH FRAME_HEIGHT)
        )
      )
    (super-new
     (paint-callback (lambda (canvas dc) (custom-paint-callback canvas dc)))
     )
    (send this set-canvas-background (make-color 175 225 175))
    )
  )

(define main-canvas
    (new game-canvas% [parent main-frame])
  )

(define game-state 'paused)

(define game-timer
  (new timer%
       [notify-callback
        (lambda()
          ;COLLISION CHECKER
          (when (did-collide pillar player)
            (display "COLLIDE")
            )
          
          ;COLLISION LOOP
           (for ([pillar pillar-list])
              (when (did-collide pillar player)
                (send game-timer stop)
                (set! game-state 'ended)
                )
             )
          
          (for ([pillar pillar-list])
            (send pillar move-pillar)
             (when (< (get-field x-pos pillar) -40)
               (send pillar move-to-side FRAME_WIDTH)
               )
             )
          
          (send player falling)

  
            
          (send main-canvas refresh-now)
          )
       ]
  )
 )

(define player (new bird% [bird-type 'player]))
(send player change-bird-x-pos! 20)
(send player change-bird-y-pos! FLAPPY_ORIGIN)

(define pillar (new pillar2% [spawn-location 'down]))
(send pillar set-x-pos! 200)
(send pillar set-y-pos! 0)

(define pillar2 (new pillar% [spawn-location 'down]))
(send pillar2 set-x-pos! 200)
(send pillar2 set-y-pos! 300)

(define pillar3 (new pillar2% [spawn-location 'down]))
(send pillar3 set-x-pos! 400)
(send pillar3 set-y-pos! -75)

(define pillar4 (new pillar% [spawn-location 'down]))
(send pillar4 set-x-pos! 400)
(send pillar4 set-y-pos! 225)

(define pillar5 (new pillar2% [spawn-location 'down]))
(send pillar5 set-x-pos! 600)
(send pillar5 set-y-pos! -100)

(define pillar6 (new pillar% [spawn-location 'down]))
(send pillar6 set-x-pos! 600)
(send pillar6 set-y-pos! 200)

(define pillar7 (new pillar2% [spawn-location 'down]))
(send pillar7 set-x-pos! 800)
(send pillar7 set-y-pos! -25)

(define pillar8 (new pillar% [spawn-location 'down]))
(send pillar8 set-x-pos! 800)
(send pillar8 set-y-pos! 275)

(define pillar9 (new pillar2% [spawn-location 'down]))
(send pillar9 set-x-pos! 1000)
(send pillar9 set-y-pos! -50)

(define pillar10 (new pillar% [spawn-location 'down]))
(send pillar10 set-x-pos! 1000)
(send pillar10 set-y-pos! 250)

(define pillar-list (vector pillar pillar2 pillar3 pillar4 pillar5 pillar6 pillar7 pillar8 pillar9 pillar10
                                    ))

;PILLAR VALUES
;0 -25 -50 -75 -100
;300 275 250 225 200

;FUNCTION WONT COLLIDE WITH PILLAR2
(define (did-collide pillar bird)
  (define pillar-left-x   (send pillar get-left-x))
  (define pillar-right-x  (send pillar get-right-x))
  (define pillar-top-y    (send pillar get-top-y))
  (define pillar-bottom-y (send pillar get-bottom-y))

  (define bird-left-x   (send bird get-left-x))
  (define bird-right-x  (send bird get-right-x))
  (define bird-top-y    (send bird get-top-y))
  (define bird-bottom-y (send bird get-bottom-y))
  
  (and
   (< pillar-left-x bird-right-x)
   (> pillar-right-x bird-left-x)
   (< pillar-top-y bird-bottom-y)
   (> pillar-bottom-y bird-top-y)
  )
)

(define (reset-game-state)
  (send player change-bird-y-pos! FLAPPY_ORIGIN)

  (send pillar set-x-pos! 200)
  (send pillar set-y-pos! 0)

  (send pillar2 set-x-pos! 200)
  (send pillar2 set-y-pos! 300)

  (send pillar3 set-x-pos! 400)
  (send pillar3 set-y-pos! -75)

  (send pillar4 set-x-pos! 400)
  (send pillar4 set-y-pos! 225)

  (send pillar5 set-x-pos! 600)
  (send pillar5 set-y-pos! -100)
    
  (send pillar6 set-x-pos! 600)
  (send pillar6 set-y-pos! 200)

  (send pillar7 set-x-pos! 800)
  (send pillar7 set-y-pos! -25)

  (send pillar8 set-x-pos! 800)
  (send pillar8 set-y-pos! 275)
    
  (send pillar9 set-x-pos! 1000)
  (send pillar9 set-y-pos! -50)
    
  (send pillar10 set-x-pos! 1000)
  (send pillar10 set-y-pos! 250)
)
  
  
(send main-frame show #t)

