#lang racket
(define (Global)
(define (SqrCubic n count)
  (if(< count 10)
     (begin
     (printf "\nEl cuadrado del número es: ~a\n"(sqr n))
     (printf "El cubo del número es: ~a\n"(expt n 3))
     (printf "\nIngrese el número: ")
     (SqrCubic (read) (+ 1 count))
     )
     (begin
     (printf "\nEl cuadrado del número es: ~a\n"(sqr n))
     (printf "El cubo del número es: ~a\n"(expt n 3))
     (printf "Fin")
     )
  )
)
(printf "Ingrese el primer número: ")
(SqrCubic (read) 1)
)
(Global)
      
