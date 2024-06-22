#lang racket
(displayln "Este programa imprime los números entre dos números ingresados por el usuario")
(printf "Ingrese un número: ")
(define n (read))
(printf "Ingrese otro número: ")
(define n2 (read))
(define (NumberList n n2 count)
         (if(< n n2)
            (begin
            (printf "~a," n)
            (NumberList (+ n 1)n2(+ count 1))
            )
            (if(= n n2)
            (begin
            (printf "~a." n )
            (printf "\nLa cantidad de dígitos es: ~a" (+ 1 count))
            )
            (void)))
)
(NumberList n n2 0)
            