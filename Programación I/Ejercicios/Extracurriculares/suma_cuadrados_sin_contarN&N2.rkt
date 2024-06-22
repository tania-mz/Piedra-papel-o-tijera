#lang racket
(define (Global)
(displayln "Este programa imprime la suma de los cuadrados entre 2 números que el usuario ingrese")
(printf "Ingrese un número: ")
(define n (read))
(printf "Ingrese otro número: ")
(define n2 (read))
(define (Sum n n2 sum)
  (if(< n n2)
   (begin
    (printf "~a+" (sqr n))
    (Sum (+ n 1) n2 (+ (sqr n)sum))
   )
   (if(= n n2)
    (printf "~a=~a" (sqr n) (+ (sqr n) sum))
    (void)
   ); endif(= n n2)
  );endif(< n n2)
);endFunctionSum
(Sum (+ n 1) (- n2 1) 0)
);endFunctionGlobal
(Global)
 
      

