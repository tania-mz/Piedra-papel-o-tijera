#lang racket
(displayln "Este programa imprime los números entre dos números ingresados por el usuario")
(printf "Ingrese un número: ")
(define n (read))
(printf "Ingrese otro número: ")
(define n2 (read))
(define (Average n n2 count sum)
         (if(< n n2)
            (begin
            (printf "~a+" n)
            (Average (+ n 1)n2(+ count 1)(+ n sum))
            )
            (if(= n n2)
            (begin
            (printf "~a/~a\n" n (+ 1 count))
            (printf "\nEl promedio es: ~a" (/ (+ n sum)(+ 1.0 count)))
            )
            (void))
          )
)
(Average n n2 0 0)
            