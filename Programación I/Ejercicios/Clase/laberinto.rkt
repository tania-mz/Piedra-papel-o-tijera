#lang racket
( define laberinto (make-string 900 #\M ) )
( define (ChangeCharacter cadenaOri pos char)
  (string-append (substring cadenaOri 0 pos)
                 (string char)
                 (substring cadenaOri (+ 1 pos))
   )
)
(define n (random 1 29))
(define (Number counter end)
  (if(<= counter end)
     (begin
       (if(=(remainder counter 30)0)
          (begin
          (newline)
          (display ( + 1(quotient counter 30)))
          (printf "\t")
          )
       (void)
       )
      (printf "~a" (if(or(=(remainder(- counter 29)30)0)(=(remainder counter 30)0)(< counter 30)(and(> counter 869)(< counter 900))(=(random 4)3))
                    #\█
                    ;else
                    #\space); endif(=(random 4)0)
     );end printf
     (Number (+ counter 1)end)
     )
     (void)
  ))
  ;(define (Salida)
  ;(define fila (random 2 30)
  ;(define change (-(* fila 30) 1)
  ;)
  
(display "\t012345678901234567890123456789")
(Number 0 899)






#|INTENTO DE ROMPER PARED DERECHA



(define (Salida)
  (define fila (random 2 30))
  (define change (- (* fila 30) 1))
  (display change)
)
(Salida)

(define (Change x)
  (define y (= x #\█))
    (display y)
)

(Change (Salida))
( define laberinto (make-string 900 #\M ) )
( define (ChangeCharacter cadenaOri pos char)
  (string-append (substring cadenaOri 0 pos)
                 (string char)
                 (substring cadenaOri (+ 1 pos))
   )
  |#