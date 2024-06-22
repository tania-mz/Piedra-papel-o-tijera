#lang racket
(require graphics/graphics)
(open-graphics)
(define tablero (open-viewport "Ajedrez" 900 600))
(define string "TCADRACTPPPPPPPP00000000000000000000000000000000pppppppptcadract")
(define ministring "")
(define (ChangeChar string index char)
  (string-append (substring string 0 index)(~a char)(substring string (+ 1 index) 64))
)
((draw-solid-rectangle tablero)(make-posn 0 0) 900 600 "MistyRose")
((draw-solid-rectangle tablero)(make-posn 660 480) 170 35 "burlywood")
((draw-string tablero) (make-posn 700 500) "Terminar juego")
((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
;(((draw-pixmap-posn "decor.jpeg")tablero)(make-posn 650 15 ))

(define (BuscarReyNegro counter)
  (if (< counter 63)
      (if (char=? #\R (string-ref string counter))
       counter
      (BuscarReyNegro (+ 1 counter))
      )
      (void)
   )
)
(define (BuscarReyBlanco counter)
  (if (< counter 63)
      (if (char=? #\r (string-ref string counter))
       counter
      (BuscarReyBlanco (+ 1 counter))
      )
      (void)
   )
)
;----------------------------------------------------------------------------------------------------------------------
;IMPRIME EL TABLERO DE AJEDREZ

(define (ChessBoard counterfilas counter x y)
  (if (<= counterfilas 8)
      (if(= (remainder counterfilas 2) 1)
         (if(< counter 4)
            (begin
              ((draw-solid-rectangle tablero)(make-posn x y) 75 75 "maroon")
              ((draw-solid-rectangle tablero)(make-posn (- x 75) y) 75 75 "pink")
              (ChessBoard counterfilas (+ 1 counter) ( + 150 x) y)
            )
            (ChessBoard (+ counterfilas 1) 0 0 (+ y 75))
         )
         (if(< counter 4)
            (begin
              ((draw-solid-rectangle tablero)(make-posn x y) 75 75 "maroon")
              ((draw-solid-rectangle tablero)(make-posn (+ x 75) y) 75 75 "pink")
              (ChessBoard counterfilas (+ 1 counter) ( + 150 x) y)
            )
            (ChessBoard (+ counterfilas 1) 0 75 (+ y 75))
         )
      )
      (void)
  )
)

(ChessBoard 1 0 75 0)

;----------------------------------------------------------------------------------------------------------------------
;IMPRIME FICHAS (TABLERO INICIAL)

(define (Peon counter x y color)
  (if (string=? color "negro")
      (if(< counter 8)
        (begin
        (((draw-pixmap-posn "peonesnegros.png")tablero)(make-posn x (+ 75 y) ))
        (Peon (+ counter 1) (+ x 75) y "negro" )
        )
        ;else (if(< counter 8)
       (if(= counter 8 )
         (Peon 0 0 0 "blanco" )
         ;else
         (void)
        );end if (= counter 8 )
      );end(if(< counter 8)
  ;else (if (string=? color "negro")
     (if(string=? color "blanco")
        (if(< counter 8)
        (begin
        (((draw-pixmap-posn "peonesblancos.png")tablero)(make-posn (+ 15 x) (* 75 6) ))
        (Peon (+ counter 1) (+ x 75) y "blanco")
        )
        ;else (if(< counter 8)
        (void)
        );endif(< counter 8)
        ;else(string=? color "blanco")
       (void)
    );endif(if(string=? color "blanco")
  )
);end function(Peon counter x y color)

(define (Caballo counter x y color)
  (if (string=? color "negro")
      (if(< counter 2)
        (begin
        (((draw-pixmap-posn "caballosnegros.png")tablero)(make-posn (+ 15 x) 0) )
        (Caballo (+ counter 1) (* 6 x) y "negro" )
        )
        ;else (if(< counter 8)
       (if(= counter 2 )
          (Caballo 0 75 0 "blanco" )
         ;else
         (void)
        );end if (= counter 8 )
      );end(if(< counter 8)
  ;else (if (string=? color "negro")
     (if(string=? color "blanco")
        (if(< counter 2)
        (begin
        (((draw-pixmap-posn "caballoblanco.png")tablero)(make-posn (+ 15 x) (* 75 7) ))
        (Caballo (+ counter 1) (* x 6) y "blanco")
        )
        ;else (if(< counter 8)
        (void)
        );endif(< counter 8)
        ;else(string=? color "blanco")
       (void)
    );endif(if(string=? color "blanco")
  )
  );end function(Peon counter x y color)

(define (Alfil counter x y color)
  (if (string=? color "negro")
      (if(< counter 2)
        (begin
        (((draw-pixmap-posn "alfilesnegros.png")tablero)(make-posn (+ 15 x) 0) )
        (Alfil (+ counter 1) (* 2.5 x) y "negro" )
        )
        ;else (if(< counter 8)
       (if(= counter 2 )
          (Alfil 0 150 0 "blanco" )
         ;else
         (void)
        );end if (= counter 8 )
      );end(if(< counter 8)
  ;else (if (string=? color "negro")
     (if(string=? color "blanco")
        (if(< counter 2)
        (begin
        (((draw-pixmap-posn "alfilesblancos.png")tablero)(make-posn (+ 15 x) (* 75 7) ))
        (Alfil (+ counter 1) (* x 2.5) y "blanco")
        )
        ;else (if(< counter 8)
        (void)
        );endif(< counter 8)
        ;else(string=? color "blanco")
       (void)
    );endif(if(string=? color "blanco")
  )
  );end function(Peon counter x y color)

(define (Torre counter x y color)
  (if (string=? color "negro")
      (if(< counter 2)
        (begin
        (((draw-pixmap-posn "torresnegras.png")tablero)(make-posn (+ 15(- x 75)) 0) )
        (Torre (+ counter 1) (* 8 x) y "negro" )
        )
        ;else (if(< counter 8)
       (if(= counter 2 )
          (Torre 0 75 0 "blanco" )
         ;else
         (void)
        );end if (= counter 8 )
      );end(if(< counter 8)
  ;else (if (string=? color "negro")
     (if(string=? color "blanco")
        (if(< counter 2)
        (begin
        (((draw-pixmap-posn "torresblancas.png")tablero)(make-posn (+ 15(- x 75)) (* 75 7) ))
        (Torre (+ counter 1) (* x 8) y "blanco")
        )
        ;else (if(< counter 8)
        (void)
        );endif(< counter 8)
        ;else(string=? color "blanco")
       (void)
    );endif(if(string=? color "blanco")
  )
  );end function(Peon counter x y color)

(define (Rey counter x y color)
  (if (string=? color "negro")
      (if(< counter 1)
        (begin
        (((draw-pixmap-posn "reynegro.png")tablero)(make-posn (+ 15(* 75 4)) 0) )
        (Rey (+ counter 1) 0 0 "negro" )
        )
        ;else (if(< counter 8)
       (if(= counter 1 )
          (Rey 0 0 0 "blanco" )
         ;else
         (void)
        );end if (= counter 8 )
      );end(if(< counter 8)
  ;else (if (string=? color "negro")
     (if(string=? color "blanco")
        (if(< counter 1)
        (begin
        (((draw-pixmap-posn "reyblanco.png")tablero)(make-posn (+ 15(* 4 75)) (* 75 7) ))
        (Rey (+ counter 1) x  y "blanco")
        )
        ;else (if(< counter 8)
        (void)
        );endif(< counter 8)
        ;else(string=? color "blanco")
       (void)
    );endif(if(string=? color "blanco")
  )
  );end function(Peon counter x y color)

(define (Reina counter x y color)
  (if (string=? color "negro")
      (if(< counter 1)
        (begin
        (((draw-pixmap-posn "reinanegra.png")tablero)(make-posn (+ 15(* 75 3)) 0) )
        (Reina (+ counter 1) 0 0 "negro" )
        )
        ;else (if(< counter 8)
       (if(= counter 1 )
          (Reina 0 0 0 "blanco" )
         ;else
         (void)
        );end if (= counter 8 )
      );end(if(< counter 8)
  ;else (if (string=? color "negro")
     (if(string=? color "blanco")
        (if(< counter 1)
        (begin
        (((draw-pixmap-posn "reinablanca.png")tablero)(make-posn (+ 15(* 3 75)) (* 75 7) ))
        (Reina (+ counter 1) x  y "blanco")
        )
        ;else (if(< counter 8)
        (void)
        );endif(< counter 8)
        ;else(string=? color "blanco")
       (void)
    );endif(if(string=? color "blanco")
  )
  );end function(Peon counter x y color)

;---------------------------LLAMADO DE FUNCIONES PARA TABLERO INICIAL--------------------------------------------

(ChessBoard 1 0 75 0)
(Peon 0 0 0 "negro")
(Caballo 0 75 0 "negro")
(Alfil 0 150 0 "negro")
(Torre 0 75 0 "negro")
(Rey 0 0 0 "negro")
(Reina 0 0 0 "negro")

;----------------------------------------FUNCIONES DE JUEGO---------------------------------------------------------

;FUNCIÓN MANEJO DE CLICKS
(define (Click function str)
  (define posicion (get-mouse-click tablero))
  (define x (posn-x (mouse-click-posn posicion)))
  (define y (posn-y (mouse-click-posn posicion)))
  (if (= function 1)
       (values (+(* 8 (quotient y 75))(quotient x 75)) x y)
       x
  )
)

(define (Color? posicion)
  (if (= 0 (remainder (quotient posicion 8) 2))
      (if (= 1 (remainder posicion 2))
          #t
          #f)
      (if (= 0 (remainder posicion 2))
          #t
          #f)
  )
)

;FUNCIÓN COMPROBAR SI MOVIMIENTO DEL ALFIL ES POSIBLE
(define (MovAlfil fila pos1 pos2 str)
 (if(positive? (- pos1 pos2))
  (if (= (- fila 1) (quotient pos2 8))
      #t
      (if (< pos2 (- pos1(* 8 (- (quotient pos1 8) (quotient pos2 8)))))
            (if(char-numeric? (string-ref str (abs(- pos1 9))))
               (MovAlfil (- fila 1)(- pos1 9) pos2 str)
               #f
            )
            (if(char-numeric? (string-ref str (- pos1 7)))
               (MovAlfil (- fila 1)(- pos1 7) pos2 str)
               #f
            )
      )     
  )
 (if (= fila (quotient pos2 8))
      #t
      (if (< pos2 (+ pos1(* 8 (abs(- (quotient pos1 8) (quotient pos2 8))))))
            (if(char-numeric? (string-ref str (+ pos1 7)))
               (MovAlfil (+ fila 1)(+ pos1 7) pos2 str)
               #f
            )
            (if(char-numeric? (string-ref str (+ 9 pos1 )))
               (MovAlfil (+ fila 1)(+ pos1 9) pos2 str)
               #f
            )
      )     
  )))

;FUNCIÓN COMPROBAR SI MOVIMIENTO DE LA TORRE ES POSIBLE
(define (MovTorre fila pos1 pos2 str)
  (if(positive? (- pos1 pos2))
  (if (= fila (quotient pos2 8))
      (if (= (- (remainder pos1 8)1) (remainder pos2 8))
            #t
            (if(char-numeric? (string-ref str (- pos1 1)))
               (MovTorre fila (- pos1 1) pos2 str)
               #f
            )
      )
      (if (= (- (quotient pos1 8) 1) (quotient pos2 8))
            #t
            (if(char-numeric? (string-ref str (- pos1 8)))
               (MovTorre fila (- pos1 8) pos2 str)
               #f
            )
      ))
      
  (if (= fila (quotient pos2 8))
      (if (= (+ 1(remainder pos1 8)) (remainder pos2 8))
            #t
            (if(char-numeric? (string-ref str (+ pos1 1)))
               (MovTorre fila (+ pos1 1) pos2 str)
               #f
            )
      )
      (if (= (quotient pos1 8) (quotient pos2 8))
            #t
            (if(char-numeric? (string-ref str (+ pos1 8)))
               (MovTorre fila (+ pos1 8) pos2 str)
               #f
            )
      )))
  )

;FUNCIÓN COMPROBAR SI MOVIMIENTO DE LA REINA ES POSIBLE
(define (MovReina fila pos1 pos2 str)
     (if(or(=(quotient pos1 8)(quotient pos2 8))(=(remainder pos1 8)(remainder pos2 8)))
        (if(MovTorre (quotient pos1 8) pos1 pos2 str)
           #t
           #f
        )
        (if(MovAlfil (quotient pos1 8) pos1 pos2 str)
           #t
           #f
        )
      )
)

;FUNCIÓN JAQUE NEGRO
(define (JaqueNegro? counter county str)
  (if(< counter 63)
   (if(char-lower-case? (string-ref str counter))
     (if(and(char=? #\a (string-ref str counter))(MovAlfil (quotient counter 8) counter county str))
        #t
         (if(and(char=? #\c (string-ref str counter))(or (= county (+ counter 10))
                    (= county (+ counter 17))(= county (+ counter 15))(= county (+ counter 6))(= county (- counter 10))
                    (= county (- counter 17))(= county (- counter 15))(= county (- counter 6))))
                 #t
                 (if(and(char=? #\t (string-ref str counter))(MovTorre (quotient counter 8) counter county str))
                 #t
                 (if(and(char=? #\p (string-ref str counter)) (or(and(= county (+ counter 9))(char-lower-case? (string-ref str (+ counter 9))))
                             (and(= county (+ counter 7))(char-lower-case? (string-ref str (+ counter 7))))
                             (and(= county (+ counter 8))(char-numeric? (string-ref str (+ counter 8))))))
                 #t
                 (if(and(char=? #\d (string-ref str counter))(MovReina (quotient counter 8) counter county str))
                        #t
                        (if(and(char=? #\r (string-ref str counter))(or(= county (+ counter 1))(= county (+ counter 8))(= county (+ counter 9))(= county (+ counter 7))
                        (= county (- counter 1))(= county (- counter 8))(= county (- counter 9))(= county (- counter 7))))
                       #t
                        (JaqueNegro? (+ 1 counter) county str)
                        ))))))
  (JaqueNegro? (+ 1 counter) county str))
  #f
 ))

;FUNCIÓN JAQUE BLANCO
(define (JaqueBlanco? counter county str)
  (if(< counter 63)
   (if(char-upper-case? (string-ref str counter))
     (if(and(char=? #\A (string-ref str counter))(MovAlfil (quotient counter 8) counter county str))
        #t
         (if(and(char=? #\C (string-ref str counter))(or (= county (+ counter 10))
                    (= county (+ counter 17))(= county (+ counter 15))(= county (+ counter 6))(= county (- counter 10))
                    (= county (- counter 17))(= county (- counter 15))(= county (- counter 6))))
                 #t
                 (if(and(char=? #\T (string-ref str counter))(MovTorre (quotient counter 8) counter county str))
                 #t
                 (if(and(char=? #\P (string-ref str counter)) (or(and(= county (+ counter 9))(char-lower-case? (string-ref str (+ counter 9))))
                             (and(= county (+ counter 7))(char-upper-case? (string-ref str (+ counter 7))))
                             (and(= county (+ counter 8))(char-numeric? (string-ref str (+ counter 8))))))
                #t
                 (if(and(char=? #\D (string-ref str counter))(MovReina (quotient counter 8) counter county str))
                        #t
                        (if(and(char=? #\R (string-ref str counter))(or(= county (+ counter 1))(= county (+ counter 8))(= county (+ counter 9))(= county (+ counter 7))
                        (= county (- counter 1))(= county (- counter 8))(= county (- counter 9))(= county (- counter 7))))
                        #t
                        (JaqueNegro? (+ 1 counter) county str)
                        ))))))
  (JaqueBlanco? (+ 1 counter) county str))
  #f
 ))

;FUNCIÓN EVITAR JAQUE NEGRO
(define(SalvarJaqueNegro? counter county str salvadas)
  (if(= counter 64)
      salvadas
     (if(char-upper-case? (string-ref str counter))
        (if (char=? #\T (string-ref str counter))
            (if(< county 63)
               (if(MovTorre (quotient counter 8) counter county str)
                  (begin
                    (let ((string-jaque (ChangeChar (ChangeChar str counter #\0) county (string-ref str counter))))
                    (if (JaqueNegro? 0 (BuscarReyNegro 0) string-jaque)
                        (SalvarJaqueNegro? counter (+ 1 county) str salvadas)
                        (begin
                        (string-append ministring (~a (string-ref str counter)))
                        (SalvarJaqueNegro? (+ 1 counter) 0 str (+ 1 salvadas))
                        )
                    )))
                  (SalvarJaqueNegro? counter (+ 1 county) str salvadas)
            )
            (SalvarJaqueNegro? (+ 1 counter) 0 str salvadas))

            
         (if (char=? #\A (string-ref str counter))
            (if(< county 63)
               (if(MovAlfil (quotient counter 8) counter county str)
                  (begin
                    (let ((string-jaque (ChangeChar (ChangeChar str counter #\0) county (string-ref str counter))))
                    (if (JaqueNegro? 0 (BuscarReyNegro 0) string-jaque)
                        (SalvarJaqueNegro? counter (+ 1 county) str salvadas)
                        (begin
                        (string-append ministring (~a (string-ref str counter)))
                        (SalvarJaqueNegro? (+ 1 counter) 0 str (+ 1 salvadas))
                        )
                    )))
                  (SalvarJaqueNegro? counter (+ 1 county) str salvadas)
            )
            (SalvarJaqueNegro? (+ 1 counter) 0 str salvadas))

            
         (if (char=? #\R (string-ref str counter))
            (if(< county 63)
               (if(MovReina (quotient counter 8) counter county str)
                  (begin
                    (let ((string-jaque (ChangeChar (ChangeChar str counter #\0) county (string-ref str counter))))
                    (if (JaqueNegro? 0 (BuscarReyNegro 0) string-jaque)
                        (SalvarJaqueNegro? counter (+ 1 county) str salvadas)
                        (begin
                        (string-append ministring (~a (string-ref str counter)))
                        (SalvarJaqueNegro? (+ 1 counter) 0 str (+ 1 salvadas))
                        )
                    )))
                  (SalvarJaqueNegro? counter (+ 1 county) str salvadas)
            )
            (SalvarJaqueNegro? (+ 1 counter) 0 str salvadas))


         (if (char=? #\C (string-ref str counter))
            (if(< county 63)
               (if(or (= county (+ counter 10))
                    (= county (+ counter 17))(= county (+ counter 15))(= county (+ counter 6))(= county (- counter 10))
                    (= county (- counter 17))(= county (- counter 15))(= county (- counter 6)))
                  (begin
                    (let ((string-jaque (ChangeChar (ChangeChar str counter #\0) county (string-ref str counter))))
                    (if (JaqueNegro? 0 (BuscarReyNegro 0) string-jaque)
                        (SalvarJaqueNegro? counter (+ 1 county) str salvadas)
                        (begin
                        (string-append ministring (~a (string-ref str counter)))
                        (SalvarJaqueNegro? (+ 1 counter) 0 str (+ 1 salvadas))
                        )
                    )))
                  (SalvarJaqueNegro? counter (+ 1 county) str salvadas)
            )
            (SalvarJaqueNegro? (+ 1 counter) 0 str salvadas))


         (if (char=? #\P (string-ref str counter))
            (if(< county 63)
               (if(or(and(= county (+ counter 9))(char-lower-case? (string-ref str (+ counter 9))))
                             (and(= county (+ counter 7))(char-lower-case? (string-ref str (+ counter 7))))
                             (and(= county (+ counter 8))(char-numeric? (string-ref str (+ counter 8)))))
                  (begin
                    (let ((string-jaque (ChangeChar (ChangeChar str counter #\0) county (string-ref str counter))))
                    (if (JaqueNegro? 0 (BuscarReyNegro 0) string-jaque)
                        (SalvarJaqueNegro? counter (+ 1 county) str salvadas)
                        (begin
                        (string-append ministring (~a (string-ref str counter)))
                        (SalvarJaqueNegro? (+ 1 counter) 0 str (+ 1 salvadas))
                        )
                    )))
                  (SalvarJaqueNegro? counter (+ 1 county) str salvadas)
            )
            (SalvarJaqueNegro? (+ 1 counter) 0 str salvadas))
            (SalvarJaqueNegro? (+ 1 counter) 0 str salvadas))))))

        (SalvarJaqueNegro? (+ 1 counter) 0 str salvadas))))

;FUNCIÓN EVITAR JAQUE BLANCO
(define(SalvarJaqueBlanco? counter county str salvadas)
  (if(= counter 64)
      salvadas
     (if(char-lower-case? (string-ref str counter))
        (if (char=? #\t (string-ref str counter))
            (if(< county 63)
               (if(MovTorre (quotient counter 8) counter county str)
                  (begin
                    (let ((string-jaque (ChangeChar (ChangeChar str counter #\0) county (string-ref str counter))))
                    (if (JaqueBlanco? 0 (BuscarReyBlanco 0) string-jaque)
                        (SalvarJaqueBlanco? counter (+ 1 county) str salvadas)
                        (begin
                        (string-append ministring (~a (string-ref str counter)))
                        (SalvarJaqueBlanco? (+ 1 counter) 0 str (+ 1 salvadas))
                        )
                    )))
                  (SalvarJaqueBlanco? counter (+ 1 county) str salvadas)
            )
            (SalvarJaqueBlanco? (+ 1 counter) 0 str salvadas))

            
         (if (char=? #\a (string-ref str counter))
            (if(< county 63)
               (if(MovAlfil (quotient counter 8) counter county str)
                  (begin
                    (let ((string-jaque (ChangeChar (ChangeChar str counter #\0) county (string-ref str counter))))
                    (if (JaqueBlanco? 0 (BuscarReyBlanco 0) string-jaque)
                        (SalvarJaqueBlanco? counter (+ 1 county) str salvadas)
                        (begin
                        (string-append ministring (~a (string-ref str counter)))
                        (SalvarJaqueBlanco? (+ 1 counter) 0 str (+ 1 salvadas))
                        )
                    )))
                  (SalvarJaqueBlanco? counter (+ 1 county) str salvadas)
            )
            (SalvarJaqueBlanco? (+ 1 counter) 0 str salvadas))

            
         (if (char=? #\r (string-ref str counter))
            (if(< county 63)
               (if(MovReina (quotient counter 8) counter county str)
                  (begin
                    (let ((string-jaque (ChangeChar (ChangeChar str counter #\0) county (string-ref str counter))))
                    (if (JaqueBlanco? 0 (BuscarReyBlanco 0) string-jaque)
                        (SalvarJaqueBlanco? counter (+ 1 county) str salvadas)
                        (begin
                        (string-append ministring (~a (string-ref str counter)))
                        (SalvarJaqueBlanco? (+ 1 counter) 0 str (+ 1 salvadas))
                        )
                    )))
                  (SalvarJaqueBlanco? counter (+ 1 county) str salvadas)
            )
            (SalvarJaqueBlanco? (+ 1 counter) 0 str salvadas))


         (if (char=? #\c (string-ref str counter))
            (if(< county 63)
               (if(or (= county (+ counter 10))
                    (= county (+ counter 17))(= county (+ counter 15))(= county (+ counter 6))(= county (- counter 10))
                    (= county (- counter 17))(= county (- counter 15))(= county (- counter 6)))
                  (begin
                    (let ((string-jaque (ChangeChar (ChangeChar str counter #\0) county (string-ref str counter))))
                    (if (JaqueBlanco? 0 (BuscarReyBlanco 0) string-jaque)
                        (SalvarJaqueBlanco? counter (+ 1 county) str salvadas)
                        (begin
                        (string-append ministring (~a (string-ref str counter)))
                        (SalvarJaqueBlanco? (+ 1 counter) 0 str (+ 1 salvadas))
                        )
                    )))
                  (SalvarJaqueBlanco? counter (+ 1 county) str salvadas)
            )
            (SalvarJaqueBlanco? (+ 1 counter) 0 str salvadas))


         (if (char=? #\p (string-ref str counter))
            (if(< county 63)
               (if(or(and(= county (+ counter 9))(char-lower-case? (string-ref str (+ counter 9))))
                             (and(= county (+ counter 7))(char-lower-case? (string-ref str (+ counter 7))))
                             (and(= county (+ counter 8))(char-numeric? (string-ref str (+ counter 8)))))
                  (begin
                    (let ((string-jaque (ChangeChar (ChangeChar str counter #\0) county (string-ref str counter))))
                    (if (JaqueBlanco? 0 (BuscarReyBlanco 0) string-jaque)
                        (SalvarJaqueBlanco? counter (+ 1 county) str salvadas)
                        (begin
                        (string-append ministring (~a (string-ref str counter)))
                        (SalvarJaqueBlanco? (+ 1 counter) 0 str (+ 1 salvadas))
                        )
                    )))
                  (SalvarJaqueBlanco? counter (+ 1 county) str salvadas)
            )
            (SalvarJaqueBlanco? (+ 1 counter) 0 str salvadas))
            (SalvarJaqueBlanco? (+ 1 counter) 0 str salvadas))))))

        (SalvarJaqueBlanco? (+ 1 counter) 0 str salvadas))))


;FUNCIÓN PRINCIPAL FUNCIONAMIENTO DEL JUEGO        
(define (Juego turn str)   
;---------------------------------------------------------------------TURNO 1 (BLANCAS)----------------------------------------------------------------------------
  (if (= 1 turn)
      (begin
        ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
        ((draw-string tablero) (make-posn 680 420) "JUEGAN BLANCAS")
        (let-values (((pos1 x1 y1)(Click 1 str)))
          (if(char-lower-case? (string-ref str pos1))
          (begin
          (if (and(<= x1 600) (>= x1 0)(<= y1 600) (>= y1 0));Comprueba si el click está dentro del tablero de juego
             (begin
             (let-values (((pos2 x2 y2) (Click 1 str)))
               (if (and(<= x2 600) (>= x2 0)(<= y2 600) (>= y2 0))
            (begin
;______________________________________________________________________CABALLO BLANCO_____________________________________________
              (if (char=? #\c (string-ref str pos1))
                  (if (and(or(char-upper-case? (string-ref str pos2))(char-numeric? (string-ref str pos2)))
                          (or (= pos2 (+ pos1 10))
                          (= pos2 (+ pos1 17))(= pos2 (+ pos1 15))(= pos2 (+ pos1 6))(= pos2 (- pos1 10))
                          (= pos2 (- pos1 17)) (= pos2 (- pos1 15))(= pos2 (- pos1 6))))
                      (begin
                        ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                        (((draw-pixmap-posn "caballoblanco.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                        ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                        (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 (string-ref str pos1))))
                          (display new-str)
                          (newline)
                          (if(JaqueNegro? 0 (BuscarReyNegro 0) new-str)
                             (begin
                             ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                             ((draw-string tablero) (make-posn 680 420) "Rey negro en jaque")
                             (sleep 4)
                             (Juego 2 new-str))
                             (Juego 2 new-str)
                             )
                      ))
                      (begin
                        ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                        ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                        (sleep 1)
                        (Juego 1 str)
                      )
                 )
;_______________________________________________________________________TORRE BLANCA_____________________________________________
              (if (char=? #\t (string-ref str pos1))
                  (if (and(or(char-upper-case? (string-ref str pos2))(char-numeric? (string-ref str pos2)))
                          (or(=(remainder pos1 8)(remainder pos2 8))(=(quotient pos1 8)(quotient pos2 8))))
                      (if(MovTorre (quotient pos1 8) pos1 pos2 str)
                         (begin
                           ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                           (((draw-pixmap-posn "torresblancas.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                           ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                           (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 (string-ref str pos1))))
                           (display new-str)
                           (newline)
                           (if(JaqueNegro? 0 (BuscarReyNegro 0) new-str)
                             (begin
                             ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                             ((draw-string tablero) (make-posn 680 420) "Rey negro en jaque")
                             (sleep 4)
                             (Juego 2 new-str))
                             (Juego 2 new-str)
                             )
                         ))
                         (begin
                           ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                           ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                           (sleep 1)
                           (Juego 1 str)
                         )
                      )
                     (begin
                       ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                       ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                       (sleep 1)
                       (Juego 1 str)
                      )
                  )
;_______________________________________________________________________ALFIL BLANCO_________________________________________________
              (if (char=? #\a (string-ref str pos1))
                  (if (and(or(char-upper-case? (string-ref str pos2))(char-numeric? (string-ref str pos2)))
                          (= (abs(- (remainder pos1 8)(remainder pos2 8)))(abs(- (quotient pos1 8)(quotient pos2 8)))))
                      (if(MovAlfil (quotient pos1 8) pos1 pos2 str)
                        (begin
                          ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                          (((draw-pixmap-posn "alfilesblancos.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                          ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                          (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 (string-ref str pos1))))
                          (display new-str)
                          (newline)
                          (if(JaqueNegro? 0 (BuscarReyNegro 0) new-str)
                             (begin
                             ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                             ((draw-string tablero) (make-posn 680 420) "Rey negro en jaque")
                             (sleep 4)
                             (Juego 2 new-str))
                             (Juego 2 new-str)
                             ))
                        )
                        (begin
                          ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                          ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                          (sleep 1)
                          (Juego 1 str)
                        )
                      )
                      (begin
                        ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                        ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                        (sleep 1)
                        (Juego 1 str)
                       )
                  )
;_______________________________________________________________________PEON BLANCO____________________________________________________
               (if (char=? #\p (string-ref str pos1))
                   (if (= 6 (quotient pos1 8))
                       (if(or(and(= pos2 (- pos1 9))(char-upper-case? (string-ref str (- pos1 9))))
                             (and(= pos2 (- pos1 7))(char-upper-case? (string-ref str (- pos1 7))))
                             (and(= pos2 (- pos1 8))(char-numeric? (string-ref str (- pos1 8))))
                             (and(= pos2 (- pos1 16))(char-numeric? (string-ref str (- pos1 16)))))              
                          (begin
                            ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                            (((draw-pixmap-posn "peonesblancos.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                            ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                            (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 (string-ref str pos1))))
                            (display new-str)
                            (newline)
                            (if(JaqueNegro? 0 (BuscarReyNegro 0) new-str)
                             (begin
                             ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                             ((draw-string tablero) (make-posn 680 420) "Rey negro en jaque")
                             (sleep 4)
                             (Juego 2 new-str))
                             (Juego 2 new-str)
                             )
                          ))
                          (begin
                            ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                            ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                            (sleep 1)
                            (Juego 1 str)
                          )
                        )
                       (if(or(and(= pos2 (- pos1 9))(char-upper-case? (string-ref str (- pos1 9))))
                             (and(= pos2 (- pos1 7))(char-upper-case? (string-ref str (- pos1 7))))
                             (and(= pos2 (- pos1 8))(char-numeric? (string-ref str (- pos1 8)))))
                          
                           ;CORONACIÓN DE PEONES------------------------------------------------------------------------
                          (if(or( = pos2 0)( = pos2 1)( = pos2 2)( = pos2 3)( = pos2 4)( = pos2 5)( = pos2 6)( = pos2 7))
                             (begin
                               ((draw-solid-rectangle tablero)(make-posn 620 30) 150 50 "wheat")
                               ((draw-string tablero) (make-posn 660 60 ) "Reina")
                               ((draw-solid-rectangle tablero)(make-posn 620 90) 150 50 "wheat")
                               ((draw-string tablero) (make-posn 660 120) "Torre")
                               ((draw-solid-rectangle tablero)(make-posn 620 150) 150 50 "wheat")
                               ((draw-string tablero) (make-posn 660 180) "Caballo")
                               ((draw-solid-rectangle tablero)(make-posn 620 210) 150 50 "wheat")
                               ((draw-string tablero) (make-posn 660 240) "Alfil")
                               (let-values (((pos3 x2 y2) (Click 1 str)))
                               (if(and(<= x2 770) (>= x2 620)(<= y2 80) (>= y2 30));En caso de que el usuario elija coronar una reina
                                  (begin
                                    ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                                    (((draw-pixmap-posn "reinablanca.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                                    ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                                    (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 #\d)))
                                    (display new-str)
                                    (newline)
                                      (if(JaqueNegro? 0 (BuscarReyNegro 0) new-str)
                             (begin
                             ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                             ((draw-string tablero) (make-posn 680 420) "Rey negro en jaque")
                             (sleep 1)
                             (Juego 2 new-str))
                             (Juego 2 new-str)
                             )))
                               (if(and(<= x2 770) (>= x2 620)(<= y2 140) (>= y2 90));En caso de que el usuario elija coronar con una torre
                                  (begin
                                    ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                                    (((draw-pixmap-posn "torresblancas.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                                    ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                                    (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 #\t)))
                                    (display new-str)
                                    (newline)   
                                    (if(JaqueNegro? 0 (BuscarReyNegro 0) new-str)
                             (begin
                             ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                             ((draw-string tablero) (make-posn 680 420) "Rey negro en jaque")
                             (sleep 4)
                             (Juego 2 new-str))
                             (Juego 2 new-str)
                             ))
                                  )
                              (if(and(<= x2 770) (>= x2 620)(<= y2 200) (>= y2 150));En caso de que el usuario elija coronar con un caballo 
                                 (begin
                                   ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                                   (((draw-pixmap-posn "caballoblanco.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                                   ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                                   (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 #\c)))
                                   (display new-str)
                                   (newline)
                                   (if(JaqueNegro? 0 (BuscarReyNegro 0) new-str)
                             (begin
                             ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                             ((draw-string tablero) (make-posn 680 420) "Rey negro en jaque")
                             (sleep 4)
                             (Juego 2 new-str))
                             (Juego 2 new-str)
                             )
                                 ))
                              (if(and(<= x2 770) (>= x2 620)(<= y2 260) (>= y2 210));En caso de que el usuario elija coronar con un alfil
                                 (begin
                                   ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                                   (((draw-pixmap-posn "alfilesblancos.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                                   ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                                   (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 #\a)))
                                   (display new-str)
                                   (newline)
                                   (if(JaqueNegro? 0 (BuscarReyNegro 0) new-str)
                             (begin
                             ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                             ((draw-string tablero) (make-posn 680 420) "Rey negro en jaque")
                             (sleep 4)
                             (Juego 2 new-str))
                             (Juego 2 new-str)
                             )
                                 ))
                                 (void)
                              )
                              )))));Cierre de if's de la coronación de peones
                          (begin
                            ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                            (((draw-pixmap-posn "peonesblancos.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                            ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                            (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 (string-ref str pos1))))
                            (display new-str)
                            (newline)
                            (if(JaqueNegro? 0 (BuscarReyNegro 0) new-str)
                             (begin
                             ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                             ((draw-string tablero) (make-posn 680 420) "Rey negro en jaque")
                             (sleep 4)
                             (Juego 2 new-str))
                             (Juego 2 new-str)
                             ))
                          )
                         );FIN CORONACIÓN DE PEONES 
                      (begin
                        ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                        ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                        (sleep 1)
                        (Juego 1 str)
                      )
                     ))
;-------------------------------------------------------------REINA BLANCA-------------------------------------------
               (if (char=? #\d (string-ref str pos1))
                   (if (and(or(char-upper-case? (string-ref str pos2))(char-numeric? (string-ref str pos2)))
                           (or(= (abs(- (remainder pos1 8)(remainder pos2 8)))(abs(- (quotient pos1 8)(quotient pos2 8))))
                           (=(remainder pos1 8)(remainder pos2 8))(=(quotient pos1 8)(quotient pos2 8))))
                       (if(MovReina (quotient pos1 8) pos1 pos2 str)
                          (begin
                            ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                            (((draw-pixmap-posn "reinablanca.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                            ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                            (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 (string-ref str pos1))))
                            (display new-str)
                            (newline)
                            (if(and(JaqueNegro? 0 (BuscarReyNegro 0) new-str)(= 0 (SalvarJaqueNegro? 0 0 string 0)))
                             (begin
                             ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                             ((draw-string tablero) (make-posn 680 420) "Esta en jaque")
                             (sleep 3)
                             (void))
                             (if(JaqueNegro? 0 (BuscarReyNegro 0) new-str)
                                (begin
                             ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                             ((draw-string tablero) (make-posn 680 420) "Jaque Mate")
                             (sleep 2)
                             (void)
                             )
                             (Juego 2 new-str)
                             ))
                          ))
                       (begin
                         ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                         ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                         (sleep 1)
                         (Juego 1 str)
                        )
                       )
                      (begin
                        ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                        ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                        (sleep 1)
                        (Juego 1 str)
                      )
                   )
;--------------------------------------------------------REY BLANCO--------------------------------------------------
              (if (char=? #\r (string-ref str pos1))
                  (if (and(or(char-upper-case? (string-ref str pos2))(char-numeric? (string-ref str pos2)))
                          (or(= pos2 (+ pos1 1))(= pos2 (+ pos1 8))(= pos2 (+ pos1 9))(= pos2 (+ pos1 7))
                          (= pos2 (- pos1 1))(= pos2 (- pos1 8))(= pos2 (- pos1 9))(= pos2 (- pos1 7))))
                        (begin
                          ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                          (((draw-pixmap-posn "reyblanco.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                          ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                          (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 (string-ref str pos1))))
                          (display new-str)
                          (newline)
                          (if(JaqueNegro? 0 (BuscarReyNegro 0) new-str)
                             (begin
                             ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                             ((draw-string tablero) (make-posn 680 420) "Rey negro en jaque")
                             (sleep 4)
                             (Juego 2 new-str))
                             (Juego 2 new-str)
                             ))
                        )
                        (begin
                          ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                          ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                          (sleep 1)
                          (Juego 1 str)
                        )
                  )
                 (void)))))));Cierre de if's fichas blancas
          );Cierre begin que determina si el segundo click está en el tablero de juego
            
            (if(and (>= x2 660)(<= x2 830)(>= y2 480)(<= y2 515))
             (begin
               ((draw-solid-rectangle tablero)(make-posn 0 0) 900 600 "black")
               ((draw-string tablero) (make-posn 350 300) "FIN DEL JUEGO" "white")  
               (void)
              )
             (Juego 1 str)
            ))))
          (if(and (>= x1 660)(<= x1 830)(>= y1 480)(<= y1 515))
              (begin
               ((draw-solid-rectangle tablero)(make-posn 0 0) 900 600 "black")
               ((draw-string tablero) (make-posn 350 300) "FIN DEL JUEGO" "white")  
               (void)
              )
             (Juego 1 str)
           )))
       (begin
        ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
        ((draw-string tablero) (make-posn 680 420) "NO ES TU TURNO")
        (sleep 1)
        (Juego 1 str)
))))
;-----------------------------------------------------------------------TURNO 2 (NEGRAS)----------------------------------------------------------------------------------
      (begin
        ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
        ((draw-string tablero) (make-posn 680 420) "JUEGAN NEGRAS")
        (let-values (((pos1 x1 y1)(Click 1 str)))
          (if(and (>= x1 660)(<= x1 830)(>= y1 480)(<= y1 515))
             (begin
               ((draw-solid-rectangle tablero)(make-posn 0 0) 900 600 "black")
               ((draw-string tablero) (make-posn 350 300) "FIN DEL JUEGO" "white")  
               (void)
              )
          (if(char-upper-case? (string-ref str pos1))
          (begin
          (if (and(<= x1 600) (>= x1 0)(<= y1 600) (>= y1 0));Comprueba si el click está dentro del tablero de juego
             (begin
             (let-values (((pos2 x2 y2) (Click 1 str)))
               (if (and(<= x2 600) (>= x2 0)(<= y2 600) (>= y2 0))
            (begin
;______________________________________________________________________CABALLO NEGRO_____________________________________________
              (if (char=? #\C (string-ref str pos1))
                  (if (and(or(char-lower-case? (string-ref str pos2))(char-numeric? (string-ref str pos2)))
                          (or (= pos2 (+ pos1 10))
                          (= pos2 (+ pos1 17))(= pos2 (+ pos1 15))(= pos2 (+ pos1 6))(= pos2 (- pos1 10))
                          (= pos2 (- pos1 17)) (= pos2 (- pos1 15))(= pos2 (- pos1 6))))
                      (begin
                        ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                        (((draw-pixmap-posn "caballosnegros.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                        ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                        (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 (string-ref str pos1))))
                          (display new-str)
                          (newline)
                          (Juego 1 new-str))
                      )
                      (begin
                        ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                        ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                        (sleep 1)
                        (Juego 2 str)
                      )
                 )
;_______________________________________________________________________TORRE NEGRA_____________________________________________
              (if (char=? #\T (string-ref str pos1))
                  (if (and(or(char-lower-case? (string-ref str pos2))(char-numeric? (string-ref str pos2)))
                          (or(=(remainder pos1 8)(remainder pos2 8))(=(quotient pos1 8)(quotient pos2 8))))
                      (if(MovTorre (quotient pos1 8) pos1 pos2 str)
                         (begin
                           ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                           (((draw-pixmap-posn "torresnegras.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                           ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                           (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 (string-ref str pos1))))
                           (display new-str)
                           (newline)
                           (Juego 1 new-str))
                         )
                         (begin
                           ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                           ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                           (sleep 1)
                           (Juego 2 str)
                         )
                      )
                     (begin
                       ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                       ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                       (sleep 1)
                       (Juego 2 str)
                      )
                  )
;_______________________________________________________________________ALFIL NEGRO_________________________________________________
              (if (char=? #\A (string-ref str pos1))
                  (if (and(or(char-lower-case? (string-ref str pos2))(char-numeric? (string-ref str pos2)))
                          (= (abs(- (remainder pos1 8)(remainder pos2 8)))(abs(- (quotient pos1 8)(quotient pos2 8)))))
                      (if(MovAlfil (quotient pos1 8) pos1 pos2 str)
                        (begin
                          ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                          (((draw-pixmap-posn "alfilesnegros.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                          ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                          (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 (string-ref str pos1))))
                          (display new-str)
                          (newline)
                          (Juego 1 new-str))
                        )
                        (begin
                          ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                          ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                          (sleep 1)
                          (Juego 2 str)
                        )
                      )
                      (begin
                        ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                        ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                        (sleep 1)
                        (Juego 2 str)
                       )
                  )
;_______________________________________________________________________PEON NEGRO____________________________________________________
               (if (char=? #\P (string-ref str pos1))
                   (if (= 1 (quotient pos1 8))
                       (if(or(and(= pos2 (+ pos1 9))(char-lower-case? (string-ref str (+ pos1 9))))
                             (and(= pos2 (+ pos1 7))(char-lower-case? (string-ref str (+ pos1 7))))
                             (and(= pos2 (+ pos1 8))(char-numeric? (string-ref str (+ pos1 8))))
                             (and(= pos2 (+ pos1 16))(char-numeric? (string-ref str (+ pos1 16)))))              
                          (begin
                            ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                            (((draw-pixmap-posn "peonesnegros.png") tablero)(make-posn (* 75(remainder pos2 8)) (* 75(quotient pos2 8))))
                            ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                            (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 (string-ref str pos1))))
                            (display new-str)
                            (newline)
                            (Juego 1 new-str))
                          )
                          (begin
                            ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                            ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                            (sleep 1)
                            (Juego 2 str)
                          )
                        )
                       (if(or(and(= pos2 (+ pos1 9))(char-lower-case? (string-ref str (+ pos1 9))))
                             (and(= pos2 (+ pos1 7))(char-lower-case? (string-ref str (+ pos1 7))))
                             (and(= pos2 (+ pos1 8))(char-numeric? (string-ref str (+ pos1 8)))))
                          
                           ;CORONACIÓN DE PEONES------------------------------------------------------------------------
                          (if(or( = pos2 60)( = pos2 61)( = pos2 62)( = pos2 63)( = pos2 59)( = pos2 58)( = pos2 56)( = pos2 57))
                             (begin
                               ((draw-solid-rectangle tablero)(make-posn 620 30) 150 50 "wheat")
                               ((draw-string tablero) (make-posn 660 60 ) "Reina")
                               ((draw-solid-rectangle tablero)(make-posn 620 90) 150 50 "wheat")
                               ((draw-string tablero) (make-posn 660 120) "Torre")
                               ((draw-solid-rectangle tablero)(make-posn 620 150) 150 50 "wheat")
                               ((draw-string tablero) (make-posn 660 180) "Caballo")
                               ((draw-solid-rectangle tablero)(make-posn 620 210) 150 50 "wheat")
                               ((draw-string tablero) (make-posn 660 240) "Alfil")
                               (let-values (((pos3 x2 y2) (Click 1 str)))
                               (if(and(<= x2 770) (>= x2 620)(<= y2 80) (>= y2 30));En caso de que el usuario elija coronar una reina
                                  (begin
                                    ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                                    (((draw-pixmap-posn "reinanegra.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                                    ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                                    (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 #\D)))
                                    (display new-str)
                                    (newline)
                                    (Juego 1 new-str))
                                  )
                               (if(and(<= x2 770) (>= x2 620)(<= y2 140) (>= y2 90));En caso de que el usuario elija coronar con una torre
                                  (begin
                                    ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                                    (((draw-pixmap-posn "torresnegras.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                                    ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                                    (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 #\T)))
                                    (display new-str)
                                    (newline)   
                                    (Juego 1 new-str))
                                  )
                              (if(and(<= x2 770) (>= x2 620)(<= y2 200) (>= y2 150));En caso de que el usuario elija coronar con un caballo 
                                 (begin
                                   ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                                   (((draw-pixmap-posn "caballonegro.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                                   ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                                   (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 #\C)))
                                   (display new-str)
                                   (newline)
                                   (Juego 1 new-str))
                                 )
                              (if(and(<= x2 770) (>= x2 620)(<= y2 260) (>= y2 210));En caso de que el usuario elija coronar con un alfil
                                 (begin
                                   ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                                   (((draw-pixmap-posn "alfilesnegros.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                                   ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                                   (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 #\A)))
                                   (display new-str)
                                   (newline)
                                   (Juego 1 new-str))
                                 )
                                 (void)
                              )
                              )))));Cierre de if's de la coronación de peones
                          (begin
                            ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                            (((draw-pixmap-posn "peonesnegros.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                            ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                            (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 (string-ref str pos1))))
                            (display new-str)
                            (newline)
                            (Juego 1 new-str))
                          )
                         );FIN CORONACIÓN DE PEONES 
                      (begin
                        ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                        ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                        (sleep 1)
                        (Juego 1 str)
                      )
                     ))
;-------------------------------------------------------------REINA NEGRA-------------------------------------------
               (if (char=? #\D (string-ref str pos1))
                   (if (and(or(char-lower-case? (string-ref str pos2))(char-numeric? (string-ref str pos2)))
                           (or(= (abs(- (remainder pos1 8)(remainder pos2 8)))(abs(- (quotient pos1 8)(quotient pos2 8))))
                           (=(remainder pos1 8)(remainder pos2 8))(=(quotient pos1 8)(quotient pos2 8))))
                       (if(MovReina (quotient pos1 8) pos1 pos2 str)
                          (begin
                            ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                            (((draw-pixmap-posn "reinanegra.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                            ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                            (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 (string-ref str pos1))))
                            (display new-str)
                            (newline)
                            (if(and(JaqueBlanco? 0 (BuscarReyBlanco 0) new-str)(= 0 (SalvarJaqueBlanco? 0 0 string 0)))
                             (begin
                             ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                             ((draw-string tablero) (make-posn 680 420) "Está en jaque mate")
                             (sleep 3)
                             (void))
                             (if(JaqueBlanco? 0 (BuscarReyBlanco 0) new-str)
                                (begin
                             ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                             ((draw-string tablero) (make-posn 680 420) "Está en jaque")
                             (sleep 3)
                             (void))
                             (Juego 1 new-str)
                             ))
                          ))
                       (begin
                         ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                         ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                         (sleep 1)
                         (Juego 2 str)
                        )
                       )
                      (begin
                        ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                        ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                        (sleep 1)
                        (Juego 2 str)
                      )
                   )
;--------------------------------------------------------REY NEGRO--------------------------------------------------
              (if (char=? #\R (string-ref str pos1))
                  (if (and(or(char-lower-case? (string-ref str pos2))(char-numeric? (string-ref str pos2)))
                          (or(= pos2 (+ pos1 1))(= pos2 (+ pos1 8))(= pos2 (+ pos1 9))(= pos2 (+ pos1 7))
                          (= pos2 (- pos1 1))(= pos2 (- pos1 8))(= pos2 (- pos1 9))(= pos2 (- pos1 7))))
                        (begin
                          ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos2 8)) (* 75 (quotient pos2 8))) 75 75 (if (Color? pos2) "maroon" "pink"))
                          (((draw-pixmap-posn "reynegro.png") tablero)(make-posn (+ 15 (* 75(remainder pos2 8))) (* 75(quotient pos2 8))))
                          ((draw-solid-rectangle tablero)(make-posn (* 75 (remainder pos1 8)) (* 75 (quotient pos1 8))) 75 75 (if (Color? pos1) "maroon" "pink"))
                          (let ((new-str (ChangeChar (ChangeChar str pos1 #\0) pos2 (string-ref str pos1))))
                          (display new-str)
                          (newline)
                          (Juego 1 new-str))
                        )
                        (begin
                          ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
                          ((draw-string tablero) (make-posn 680 420) "JUGADA INVÁLIDA")
                          (sleep 1)
                          (Juego 2 str)
                        )
                  )
                 (void)))))));Cierre de if's fichas blancas
          );Cierre begin que determina si el segundo click está en el tablero de juego
            
            (if(and (>= x2 660)(<= x2 830)(>= y2 480)(<= y2 515))
             (begin
               ((draw-solid-rectangle tablero)(make-posn 0 0) 900 600 "black")
               ((draw-string tablero) (make-posn 350 300) "FIN DEL JUEGO" "white")  
               (void)
              )
             (Juego 2 str)
            ))))
          (if(and (>= x1 660)(<= x1 830)(>= y1 480)(<= y1 515))
              (begin
               ((draw-solid-rectangle tablero)(make-posn 0 0) 900 600 "black")
               ((draw-string tablero) (make-posn 350 300) "FIN DEL JUEGO" "white")  
               (void)
              )
             (Juego 2 str)
           )))
       (begin
        ((draw-solid-rectangle tablero)(make-posn 640 380) 200 75 "wheat")
        ((draw-string tablero) (make-posn 680 420) "NO ES TU TURNO")
        (sleep 1)
        (Juego 2 str)
)))))))
(Juego 1 string)















  
  


     







  