#lang racket
(require graphics/graphics)
(open-graphics)
(define ahorcado(open-viewport "Ahorcado" 600 400))
((draw-solid-rectangle ahorcado)(make-posn 0 0) 600 400)
((draw-line ahorcado) (make-posn 380 50)( make-posn 380 410))
(((draw-pixmap-posn "fondo.png")ahorcado)(make-posn 0 0))
(((draw-pixmap-posn "mov0.png")ahorcado)(make-posn 20 20))
(define table "AÁBCDEÉFGHIÍJKLMNÑOÓPQRSTUÚÜVWXYZ")
(display (string-length table))

(define string "")
;PALABRA ALEATORIA
(define number (random  1 6))
(define str (if(= number 5)"CELULAR"
            (if(= number 4)"ABEJA"
            (if(= number 3)"LAVERDE"
            (if(= number 2)"UTP"
            (if(= number 1)"PARCIAL"
            (void))))))) str

;FUNCION PARA LAS RAYAS
(define (CalculateLength str amount x y)
  (define length (string-length str))
  (if(< amount length)
     (begin
     ((draw-line ahorcado) (make-posn x y)( make-posn (+ x 30) y)"white")
     (CalculateLength str (+ 1 amount) (+ 40 x)y)
     )
     (void)))

(CalculateLength str 0 20 380)

;IMPRIMIR LETRAS CON RECURSIVIDAD
(define (RandomLetter counter)
  (if (= counter 1)"adef.png" (if (= counter 2)"ádef.png" (if (= counter 3)"bdef.png" (if (= counter 4)"cdef.png"
  (if (= counter 5)"ddef.png" (if (= counter 6)"edef.png" (if (= counter 7)"édef.png" (if (= counter 8)"fdef.png"
  (if (= counter 9)"gdef.png" (if (= counter 10)"hdef.png" (if (= counter 11)"idef.png" (if (= counter 12)"ídef.png"
  (if (= counter 13)"jdef.png" (if (= counter 14)"kdef.png" (if (= counter 15)"ldef.png" (if (= counter 16)"mdef.png"
  (if (= counter 17)"ndef.png" (if (= counter 18)"ñdef.png" (if (= counter 19)"odef.png" (if (= counter 20)"ódef.png"
  (if (= counter 21)"pdef.png" (if (= counter 22)"qdef.png" (if (= counter 23)"rdef.png" (if (= counter 24)"sdef.png"
  (if (= counter 25)"tdef.png" (if (= counter 26)"udef.png" (if (= counter 27)"údef.png" (if (= counter 28)"uu.png"
  (if (= counter 29)"vdef.png" (if (= counter 30)"wdef.png" (if (= counter 31)"xdef.png" (if (= counter 32)"ydef.png"
  (if (= counter 33)"zdef.png" (void)))))))))))))))))))))))))))))))))))

                                                              
(define (PrintLetter counter county cont x y)
  (if (= county 31)
      (begin
      (((draw-pixmap-posn "xdef.png")ahorcado)(make-posn 370 320))
      (PrintLetter counter (+ county 1) cont x y))
    (if (= county 32)
        (begin
      (((draw-pixmap-posn "ydef.png")ahorcado)(make-posn 420 320))
      (PrintLetter counter (+ county 1) cont x y))
     (if (= county 33)
         (begin
      (((draw-pixmap-posn "zdef.png")ahorcado)(make-posn 470 320))
      (PrintLetter counter (+ county 1) cont x y))
  (if(= cont 4)
     (begin
     (((draw-pixmap-posn (RandomLetter county))ahorcado)(make-posn (+ 320 x) y))
      (PrintLetter (+ 1 counter)(+ county 1) 0 0 (+ y 50))
      )
  (if(< counter 30)
     (begin
     (((draw-pixmap-posn (RandomLetter county))ahorcado)(make-posn (+ 320 x) y))
     (PrintLetter (+ 1 counter)(+ county 1)(+ 1 cont)(+ x 50) y)
     )
     (void)))))))
  
(PrintLetter 0 1 0 0 20)

  
;CASILLA
(define (Casilla x y )
 ;(define ubicacion (get-mouse-click ahorcado))
 ;(define x (posn-x (mouse-click-posn ubicacion)))
 ;(define y (posn-y (mouse-click-posn ubicacion)))
  ;(printf "Hola")
  
   (if(and(and(>= x 320)(< x 360)(and(>= y 20)(< y 60))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 320 20))
      1
      )
   (if(and(and(>= x 370)(< x 410)(and(>= y 20)(< y 60))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 370 20))
      2
      )
   (if(and(and(>= x 420)(< x 460)(and(>= y 20)(< y 60))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 420 20))
      3
      )
   (if(and(and(>= x 470)(< x 510)(and(>= y 20)(< y 60))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 470 20))
      4
      )
   (if(and(and(>= x 520)(< x 560)(and(>= y 20)(< y 60))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 520 20))
      5
      )
   (if(and(and(>= x 320)(< x 360)(and(>= y 70)(< y 110))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 320 70))
      6
      )
   (if(and(and(>= x 370)(< x 410)(and(>= y 70)(< y 110))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 370 70))
      7
      )
   (if(and(and(>= x 420)(< x 460)(and(>= y 70)(< y 110))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 420 70))
      8
      )
   (if(and(and(>= x 470)(< x 510)(and(>= y 70)(< y 110))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 470 70))
      9
      )
   (if(and(and(>= x 520)(< x 560)(and(>= y 70)(< y 110))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 520 70))
      10
      )
   (if(and(and(>= x 320)(< x 360)(and(>= y 120)(< y 160))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 320 120))
      11
      )
   (if(and(and(>= x 370)(< x 410)(and(>= y 120)(< y 160))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 370 120))
      12
      )
   (if(and(and(>= x 420)(< x 460)(and(>= y 120)(< y 160))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 420 120))
      13
      )
   (if(and(and(>= x 470)(< x 510)(and(>= y 120)(< y 160))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 470 120))
      14
      )
   (if(and(and(>= x 520)(< x 560)(and(>= y 120)(< y 160))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 520 120))
      15
      )
   (if(and(and(>= x 320)(< x 360)(and(>= y 170)(< y 210))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 320 170))
      16
      )
   (if(and(and(>= x 370)(< x 410)(and(>= y 170)(< y 210))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 370 170))
      17
      )
   (if(and(and(>= x 420)(< x 460)(and(>= y 170)(< y 210))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 420 170))
      18
      )
   (if(and(and(>= x 470)(< x 510)(and(>= y 170)(< y 210))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 470 170))
      19
      )
   (if(and(and(>= x 520)(< x 560)(and(>= y 170)(< y 210))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 520 170))
      20
      )
   (if(and(and(>= x 320)(< x 360)(and(>= y 220)(< y 260))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 320 220))
      21
      )
   (if(and(and(>= x 370)(< x 410)(and(>= y 220)(< y 260))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 370 220))
      22
      )
   (if(and(and(>= x 420)(< x 460)(and(>= y 220)(< y 260))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 420 220))
      23
      )
   (if(and(and(>= x 470)(< x 510)(and(>= y 220)(< y 260))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 470 220))
      24
      )
   (if(and(and(>= x 520)(< x 560)(and(>= y 220)(< y 260))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 520 220))
      25
      )
   (if(and(and(>= x 320)(< x 360)(and(>= y 270)(< y 310))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 320 270))
      26
      )
   (if(and(and(>= x 370)(< x 410)(and(>= y 270)(< y 310))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 370 270))
      27
      )
   (if(and(and(>= x 420)(< x 460)(and(>= y 270)(< y 310))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 420 270))
      28
      )
   (if(and(and(>= x 470)(< x 510)(and(>= y 270)(< y 310))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 470 270))
      29
      )
   (if(and(and(>= x 520)(< x 560)(and(>= y 270)(< y 310))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 520 270))
      30
      )
   (if(and(and(>= x 370)(< x 410)(and(>= y 320)(< y 360))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 370 320))
      31
      )
   (if(and(and(>= x 420)(< x 460)(and(>= y 320)(< y 360))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 420 320))
      32
      )
   (if(and(and(>= x 470)(< x 510)(and(>= y 320)(< y 360))))
     (begin
      (((draw-pixmap-posn "fondo2.png")ahorcado)(make-posn 470 320))
      33
      )
    (Click 0 0)))))))))))))))))))))))))))))))))) )
;---------------------------------------------------------------------------------------------------------------

(define (RandomMov counter)
  (if (= counter 1)"mov1.png"(if (= counter 2)"mov2.png" (if (= counter 3)"mov3.png" (if (= counter 4)"mov4.png" (if (= counter 5)"mov5.png"
  (if (= counter 6)"mov6.png" (if (= counter 7)"mov7.png" #|(if (= counter 7)"mov7.png"|#(void)))))))))

;JUEGO

(define (ChangeChar str number)
  (define limit (string-length str))
  (string-append  (substring str 0 (- number 1)) (~a 0) (substring str  number ( - limit 1)))
  )

(define (Game str counter counter2 mov x y)
(define limit (string-length str))
(if (< counter limit)
    (if(char=?(string-ref table(-(Casilla x y)1))(string-ref str counter))
     (begin
     (((draw-pixmap-posn (RandomLetter (Casilla x y)))ahorcado)(make-posn (+ 15(* counter 40)) 330))
     (Game str (+ counter 1)(+ counter2 1) mov x y)
     )
     (Game str (+ counter 1) counter2 mov x y)
     )
     (if(< counter2 1)
     (begin
     (((draw-pixmap-posn (RandomMov mov)) ahorcado)(make-posn 20 20))
     (viewport-flush-input ahorcado)
     (Click 0 (+ 1 mov))
     )
     (if(=(Game str 0 0 mov x y)7)
        
             (begin
             (((draw-pixmap-posn "fondo.png")ahorcado)(make-posn 0 0))
             ((draw-string ahorcado) (make-posn 300 200) "PERDISTE")
             )
             (void)
      )
     (begin
     (((draw-pixmap-posn (RandomMov mov)) ahorcado)(make-posn 20 20))
     (viewport-flush-input ahorcado)
     (Click 0 (+ 1 mov))
     )
     (void)
     )
     )
    mov
  )


(define (Click count mov)
  (define limit (string-length str))
  (define ubicacion (get-mouse-click ahorcado))
  (define x (posn-x (mouse-click-posn ubicacion)))
  (define y (posn-y (mouse-click-posn ubicacion)))
      (if (>= count 0)
          (begin
          (printf "hola")
          (Game str 0 0  mov x y)
           (if(= count limit)
             (begin
             (((draw-pixmap-posn "fondo.png")ahorcado)(make-posn 0 0))
             ((draw-string ahorcado) (make-posn 300 200) "GANASTE")
             )
          (begin
          (viewport-flush-input ahorcado)
          (Click (+ count 1)(+ 1 mov))
          )
          )
           )
          )
          (void)   
  )
  )


(Click 0 0)
                                                                          

;contar la cantidad de letras que se van evaluando
;counter2 contar la cantidad de veces que al menos dió un acierto
;mov cantidad de veces que se equivoca para pasar las imágenes
;coordenada en x del click
;coordenada en y del click


                 

