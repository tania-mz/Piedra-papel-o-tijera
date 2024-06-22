#lang racket
#|
- Fecha de publicación:
- Hora
- Versión de su código
- Autor. Ing(c) Tania Marin Zamora
- Nombre del lenguaje utilizado: Racket
- Versión del lenguaje utilizado: 8.11
- Presentado a: Doctor Ricardo Moreno Laverde
- Universidad Tecnológica de Pereira
- Programa de Ingeniería de Sistemas y Computación
- El programa es una graficadora, el usuario ingresa un polinomio en formato de string,
 el dominio de la función y el intérvalo de incrememento, el programa muestra la tabulación con los valores del dominio, y la gráfica
correspondiente
|#
(require graphics/graphics)
(open-graphics)
(define coeficientes (vector 0))
(define exponentes (vector 0))
(define resultados (vector 0))
(define ecuacion "")
(define datos (open-viewport "Datos a ingresar" 600 200))


(define (Number str counter y)
 (define tecla(key-value(get-key-press datos)))
  (if(equal? tecla 'release)
     (Number str counter y)
     (if (equal? 'rshift tecla)
         (Number str counter y)
     (if (equal? #\return tecla)
         (string->number str)
         (begin
          ((draw-string datos) (make-posn (+ 250 (* 8 counter)) y) (~a tecla))
          (Number (string-append str (~a tecla)) (+ 1 counter) y)
         )
     )
  )
))

(define (Cadena ecuacion counter)
 (define tecla(key-value(get-key-press datos)))
  (if(equal? tecla 'release)
     (Cadena ecuacion counter)
     (if (equal? 'rshift tecla)
         (Cadena ecuacion counter)
     (if (equal? #\return tecla)
         ecuacion
         (begin
          ((draw-string datos) (make-posn (+ 300 (* 8 counter)) 50) (~a tecla))
          (Cadena (string-append ecuacion (~a tecla)) (+ 1 counter))
         )
     )
  )
))

((draw-string datos) (make-posn 50 50) "Ingrese la función que desea graficar: ")
(define funcion (Cadena ecuacion 0))
(( draw-string datos ) ( make-posn 50 70 ) "Ingrese el inicio del dominio: " )
(define min (Number "" 0 70))
(( draw-string datos ) ( make-posn 50 90 ) "Ingrese el final del dominio: " )
(define max (Number "" 0 90))
(( draw-string datos ) ( make-posn 50 110 ) "Ingrese el incremento en x: " )
(define incremento (Number "" 0 110))

#|Esta función devuelve si hay o no X en un str que se le ingresa como parámetro
es muy útil ya que de esta manera, en la función operación reviso si se trata de un término independiente o no y por otro lado
en la función Descomponer me sirve para sacar la posición de la X y de esa manera multiplicar por el coeficiente y elevar al exponente|#
(define (X str counter)
    (if (= counter (string-length str))
        #f
        (if(or(char=? #\X (string-ref str counter))(char=? #\x (string-ref str counter)))
           counter
           (X str (+ 1 counter))
        )
    )
)

;Esta función recibe el string completo que ingresa el usuario y devuelve un vector con todos los coeficientes
(define (Coeficientes vector str counter)
  (define limite (string-length str))
  (if (= counter (string-length str))
      vector
     (if(char=? #\( (string-ref str counter))
        (Coeficientes vector str (+ 2 counter));Le suma dos al contador para que haga caso omiso al paréntesis y al signo dentro de este
        (if ( = counter (- limite 1));Cuando llega a el limite - 1 es pq ya queda solo un término en la cadena 
            (if(equal? #f (X str 0));Pregunto si es término independiente
               (Coeficientes (vector-append vector (make-vector 1 (string->number str))) str (+ 1 counter))
               (if(or(char=? #\x (string-ref str 0))(char=? #\X (string-ref str 0)))
                  (Coeficientes (vector-append vector (make-vector 1 1)) str (+ 1 counter))
                  (if(and(char=? #\- (string-ref str 0))(or(char=? #\x (string-ref str 1))(char=? #\X (string-ref str 1))))
                     (Coeficientes (vector-append vector (make-vector 1 -1)) str (+ 1 counter))
                     (Coeficientes (vector-append vector (make-vector 1 (string->number(substring str 0 (X str 0)))))                                                                       
                                   (if(char=? #\- (string-ref str counter))(substring str counter limite)(substring str (+ counter 1) limite)) 0
                     ) ;Cierre del llamado de coeficientes  
                  )
                )
            )
           (if (or(char=? #\+ (string-ref str counter))(char=? #\- (string-ref str counter))
                  (char=? #\/ (string-ref str counter))(char=? #\* (string-ref str counter)))
                  (if(= 0 counter)
                     (Coeficientes vector str (+ 1 counter))
                     (if (char=? #\x (string-ref str 0))
                         (Coeficientes (vector-append vector (make-vector 1 1)) (if(char=? #\- (string-ref str counter))(substring str counter limite)(substring str (+ counter 1) limite)) 0)
                         (if(and(char=? #\- (string-ref str 0))(or(char=? #\x (string-ref str 1))(char=? #\X (string-ref str 1))))
                            (Coeficientes (vector-append vector (make-vector 1 -1)) (if(char=? #\- (string-ref str counter))(substring str counter limite)(substring str (+ counter 1) limite)) 0)
                            (Coeficientes (vector-append vector (make-vector 1 (string->number(substring str 0 (if (equal? #f (X (substring str 0 counter) 0))
                                                                                                              counter
                                                                                                             (X (substring str 0 counter) 0))))))                                                                
                                          (if(char=? #\- (string-ref str counter))(substring str counter limite)(substring str (+ counter 1) limite)) 0
                            );Cierre del llamado de Coeficientes
                          )
                      ))
                  (Coeficientes vector str (+ 1 counter))
           )
        )   
     )
  )
)

;Esta función recibe el string que ingresa el usuario de la ecuación y devuelve un vector con todos los exponentes
(define (Exponentes vector str counter)
  (define limite (string-length str))
  (if (= counter (string-length str))
      vector
     (if(char=? #\( (string-ref str counter))
        (Exponentes vector str (+ 2 counter));Le suma dos al contador para que haga caso omiso al paréntesis y al signo dentro de este
        (if ( = counter (- limite 1));Cuando llega a el limite - 1 es pq ya queda solo un término en la cadena 
            (if(equal? #f (X str 0));Pregunto si es término independiente
               (Exponentes (vector-append vector (make-vector 1 0)) str (+ 1 counter))
               (if(or(char=? #\x (string-ref str counter))(char=? #\x (string-ref str counter)))
                  (Exponentes (vector-append vector (make-vector 1 1)) str (+ 1 counter))
                  (if (char=? #\) (string-ref str counter))
                      (Exponentes (vector-append vector (make-vector 1 (string->number(substring (substring str (+ 1 (X str 0)) limite) 1 (- limite 2))))) str (+ 1 counter))
                  (Exponentes (vector-append vector (make-vector 1 (string->number(substring str (+ 1(X str 0))limite)))) str (+ 1 counter)))                                                                      
             ))  
            (if (or(char=? #\+ (string-ref str counter))(char=? #\- (string-ref str counter))
                  (char=? #\/ (string-ref str counter))(char=? #\* (string-ref str counter)))
                  (if(= 0 counter)
                     (Exponentes vector str (+ 1 counter))
                     (if(or(char=? #\x (string-ref str (- counter 1)))(char=? #\X (string-ref str (- counter 1))))
                        (Exponentes (vector-append vector (make-vector 1 1))(if(char=? #\- (string-ref str counter))(substring str counter limite)(substring str (+ counter 1) limite)) 0) 
                     (if(equal? #f (X (substring str 0 counter) 0))
                        (Exponentes (vector-append vector (make-vector 1 0))(if(char=? #\- (string-ref str counter))(substring str counter limite)(substring str (+ counter 1) limite))0)
                        (Exponentes (vector-append vector (make-vector 1 (string->number (if (char=?(string-ref (substring str (+ 1(X (substring str 0 counter) 0)) counter)0)#\()
                                                                                             (substring str (+ 2(X (substring str 0 counter) 0)) (- counter 1))
                                                                                             (substring str (+ 1(X (substring str 0 counter) 0)) counter)))))
                                   (if(char=? #\- (string-ref str counter))(substring str counter limite)(substring str (+ counter 1) limite)) 0
                        );Cierre del llamado de Exponentes
                     )
                  ))
                  (Exponentes vector str (+ 1 counter))
            )
         )
      )
   )
)  
  
;Esta función se le entrega un str y una x, devuelve el resultado de este mismo ya con el coeficiente multiplicado y elevado al exp.
(define (Descomponer str x)
  (define limite (string-length str))
  (if (equal? #f (X str 0))
      (string->number str)
      (if (equal? 0 (X str 0))
            (if(char=?(string-ref str (+ 1(X str 0)))#\()
                (if(= x 0)
                -3.14
                (expt x (string->number (substring str (+ 2 (X str 0)) (- limite 1) ))))
              (expt (* 1 x)(string->number (substring str (+ 1 (X str 0)) limite ))))
          (if (equal? (- limite 1) (X str 0))
              (expt (* (string->number (substring str 0 (X str 0))) x) 1)
              (*(expt x (string->number (if(char=? #\( (string-ref (substring str (+ 1 (X str 0)) limite ) 0))
                                       (substring (substring str (+ 1 (X str 0)) limite ) 1 (-(string-length (substring str (+ 1 (X str 0)) limite ))1))
                                       (substring str (+ 1 (X str 0)) limite )
                                       )
                    )) (string->number (substring str 0 (X str 0)))
                    
              )
          )
      )
  )
)

#| Esta funcion hace uso de las dos anteriores, recibe el string de la ecuación como tal y devuelve el
resultado con una x determinada |#
(define (Operacion str counter counter1 counter2 x);counter1 y 2 es para saber donde está el primer y segundo signo
  (define limite (string-length str))
  (if (= counter (- limite 1));Esta condicion es para cuando ya hay solo un signo en la ecuacion, por ende cuando se recorre y no se encuentran más signos,se soluciona la ecuacion que queda
      (if (char=? #\+ (string-ref str counter1))
          (+ (Descomponer (substring str 0 counter1) x)(Descomponer (substring str ( + counter1 1) limite) x))
          (if (char=? #\- (string-ref str counter1))
              (if (char=? #\( (string-ref str (- counter1 1)))
                  (Descomponer str x)
              (- (Descomponer (substring str 0 counter1) x)(Descomponer (substring str ( + counter1 1) limite) x)))
              (if (char=? #\* (string-ref str counter1))
                  (* (Descomponer (substring str 0 counter1) x)(Descomponer (substring str ( + counter1 1) limite) x))
                  (if (char=? #\/ (string-ref str counter1))
                      (/ (Descomponer (substring str 0 counter1) x)(Descomponer (substring str ( + counter1 1) limite) x))
                      (Descomponer str x)))))
  (if (< counter limite)
      (if (or(char=? #\+ (string-ref str counter))(char=? #\- (string-ref str counter))
             (char=? #\/ (string-ref str counter))(char=? #\* (string-ref str counter)))
          (if(= counter1 0);No se había encontrado un signo antes pero ya se enconntró y su posición se guarda en counter1
             (Operacion str (+ 1 counter) counter counter2 x)
             (if (= counter2 0);Se encuentra un segundo signo pero no se guarda en counter2 sino q counter2 es como la condicion que permite el flujo
                 (if (char=? (string-ref str counter1) #\+)
                     (begin
                     (+ (Descomponer (substring str 0 counter1) x)(Descomponer (substring str ( + counter1 1) counter) x))
                     (Operacion (string-append (~a(+ (Descomponer (substring str 0 counter1) x) (Descomponer (substring str ( + counter1 1) counter)x)))
                                               (substring str counter limite)) 0 0 0 x)
                     )
                 (if (char=? (string-ref str counter1) #\-)
                     (begin
                     (- (Descomponer (substring str 0 counter1) x)(Descomponer (substring str ( + counter1 1) counter )x))
                     (Operacion (string-append (~a(- (Descomponer (substring str 0 counter1) x) (Descomponer (substring str ( + counter1 1) counter)x)))
                                               (substring str counter limite)) 0 0 0 x)
                     )
                 (if (char=? (string-ref str counter1) #\*)
                     (begin
                     (* (Descomponer (substring str 0 counter1) x)(Descomponer (substring str ( + counter1 1) counter)x))
                     (Operacion (string-append (~a(* (Descomponer (substring str 0 counter1) x) (Descomponer (substring str ( + counter1 1) counter)x)))
                                               (substring str counter limite)) 0 0 0 x)
                     )
                 (if (char=? (string-ref str counter1) #\/)
                     (begin
                     (/ (Descomponer (substring str 0 counter1) x)(Descomponer (substring str ( + counter1 1) counter)x))
                     (Operacion (string-append (~a(/ (Descomponer (substring str 0 counter1) x) (Descomponer (substring str ( + counter1 1) counter) x)))
                                               (substring str counter limite)) 0 0 0 x)
                     )
                     (void)
                 ))))(void)))
       (Operacion str (+ 1 counter) counter1 counter2 x))
      (string->number str)
  )
  )
)

(define (Cantidad min max intervalo counter)
    (if (< min max)
        (Cantidad (+ min intervalo) max intervalo counter)
        counter
    )
)
   
(define (Resultados vector min max incremento str)
  (define x (Operacion funcion 0 0 0 min))
  (if (<= min max)
          (Resultados (vector-append vector (make-vector 1 x)) (+ incremento min) max incremento str)
           vector
  )
)
  
(define (MakeTabla y ventana counter ref)
  ((draw-line ventana) (make-posn 50 25) (make-posn 50 (+ 50 (* 25 y))))
  ((draw-line ventana) (make-posn 200 25) (make-posn 200 (+(* 25 y)50)))
  ((draw-line ventana) (make-posn 350 25) (make-posn 350 (+(* 25 y)50)))
  ((draw-line ventana) (make-posn 50 25) (make-posn 350 25))
  ((draw-line ventana) (make-posn 50 50) (make-posn 350 50))
  ((draw-string ventana)(make-posn 60 40) "COEFICIENTES" "Purple")
  ((draw-string ventana)(make-posn 210 40) "EXPONENTES" "Purple")
  (if (< counter y)
      (begin
      ((draw-line ventana) (make-posn 50 (+ 75(* 25 counter)))(make-posn 350 (+ 75(* 25 counter))))
      ((draw-string ventana)(make-posn 60 (+ 20(+ 50(* 25 counter)))) (~a (vector-ref coe ref)) "black")
      ((draw-string ventana)(make-posn 210 (+ 20(+ 50(* 25 counter)))) (~a (vector-ref exp ref))"black")
      (MakeTabla y ventana (+ 1 counter) (+ 1 ref))
      )
      (sleep 5)
   )
)

(define (Mayor vector counter mayoractual)
  (define actual (vector-ref vector counter))
  (if(= counter (- (vector-length vector)1))
     mayoractual
   (if(equal? mayoractual #f)
      (Mayor vector (+ 1 counter) actual)
  (if(> actual mayoractual)
     (Mayor vector (+ 1 counter) actual)
     (Mayor vector (+ 1 counter) mayoractual)
  )
)))


(define (Menor vector counter menoractual)
  (define actual (vector-ref vector counter))
  (if(= counter (-(vector-length vector)1))
     menoractual
     (if (= actual -3.14)
          (Menor vector (+ 1 counter) menoractual)
  (if(< actual menoractual)
     (Menor vector (+ 1 counter) actual)
     (Menor vector (+ 1 counter) menoractual)
  )
)))

(define exp (Exponentes exponentes funcion 0))
(define coe (Coeficientes coeficientes funcion 0))
(define res (Resultados resultados min max incremento funcion))
(define cantidadcoe (- (vector-length coe)1))
(define tabla (open-viewport "TABLA DE VALORES" 400 (+ 25(* cantidadcoe 50))))
(MakeTabla cantidadcoe tabla 0 1 )

(define inicioy (Menor (vector-append res (make-vector 1 0)) 1 (vector-ref res 2)))
;inicioy
(define finaly  (Mayor (vector-append res(make-vector 1 0)) 1 (vector-ref resultados 0)))
;finaly

(define(CerodeX number)
   (define longitud ( abs ( - inicioy finaly )))
   (define pos0 ( - number inicioy))
   (/ pos0 longitud)
)

(define(CerodeY number)
   (define longitud(abs( - min max )))
   (define pos0 ( - number min))
   (/ pos0 longitud)
)

(define grafica (open-viewport "Gráfica" 650 650))

(define(numY proporcion num counter coo)
   (define increment ( / 600 ( / ( abs ( - min max ))incremento )))
   (define x ( - ( * increment coo ) 10 ))
   (define index ( - 650 proporcion ))
   (if ( >= counter 7 )
        ( void )
        ( begin
           (( draw-string grafica ) ( make-posn x index ) ( number->string num ))
           (numY ( + 100 proporcion ) ( + num ( * ( abs ( - inicioy finaly )) 1/6 )) ( + 1 counter ) coo )))
   ) #| fin funcion NumbersY
proporcion: es la proporcion en la cual se hace el numero y se le va sumando cada vez 100
number: es el numero que se va a graficar
counter: cuenta los numeros ya hechos para establecer un limite
coordenada: es la coordenada en "x" en la cual se van a hacer los numeros |#

( define(numX num counter coo i)
   ( define y ( - 650 ( * coo 100 )))
   ( define increment ( / 600 ( / ( abs ( - min max )) incremento )))
   ( if ( >= counter ( + 1 ( / ( abs ( - min max )) incremento )))
        ( void )
        ( begin
           (( draw-string grafica ) ( make-posn i y ) ( number->string num ))
           ( numX ( + incremento num ) ( + 1 counter ) coo ( + increment i )))))

( define (Lineas counter x1 x2 y1 y2 )
   ((draw-line grafica ) ( make-posn 0 ( - 625 ( * 600 ( CerodeX 0 )))) ( make-posn 650 ( - 625 ( * 600 ( CerodeX 0 )))))
   ((draw-line grafica ) ( make-posn (+ 25( * 600 ( CerodeY 0 ))) 0 ) ( make-posn(+ 25( * 600 ( CerodeY 0 ))) 650 ))
   ( define increment ( / 600 ( / ( abs ( - min max )) incremento )))
   ( if ( >= counter ( + ( / ( abs ( - min max )) incremento ) 10 ))
        (void)
   ( if ( = counter 8 )
        (Lineas( + 1 counter ) 25 25 0 650 )
        ( if ( < counter 8 )
             (begin
               (( draw-line grafica ) ( make-posn x1 y1 ) ( make-posn x2 y2 ) "PaleTurquoise" )
               ( Lineas ( + 1 counter ) x1 x2 ( + 100 y1 ) ( + 100 y2 )))
               ( begin
               (( draw-line grafica ) ( make-posn x1 y1 ) ( make-posn x2 y2 ) "PaleTurquoise" )
               ( Lineas ( + 1 counter ) ( + increment x1 ) ( + increment x2 ) y1 y2 )))))
)


(define(PuntoX counter)
   ( define increment ( / 600 ( / ( abs ( - min max )) incremento )))
   ( define x ( + 20 ( * (- counter 1) increment )))
  x
 )

(define(PuntoY counter)
  (define y (vector-ref res counter))
  (define y2 ( - 630 ( * 600 ( CerodeX y ))))
  y2  
)

(define (ConectarX x counter min max finaly inicioy)
  (if (<= x max)   
      (if (= 3.14 x)
          (ConectarX (+ x (* 1 incremento)) (+ 1 counter) min max finaly inicioy)
          (if (= counter (- (vector-length res) 1))
              (begin
                ((draw-string grafica) (make-posn (PuntoX counter) (PuntoY counter)) "X")
                (sleep 4)
              )
              (begin
                ((draw-string grafica) (make-posn (- (PuntoX counter)3) (- (PuntoY counter) 5)) "X")
                ((draw-line grafica)(make-posn (PuntoX counter) (PuntoY counter))(make-posn (PuntoX (+ 1 counter)) (PuntoY (+ 1 counter)))"Purple")
                (ConectarX (+ x incremento) (+ 1 counter) min max finaly inicioy)
              )
           )
          )
      (void)
      )
 )
     
    
(define (Grafica)
   ((draw-line grafica)(make-posn 0 25) (make-posn 600 25) "PaleTurquoise" )
   ((draw-line grafica)(make-posn 0 125) (make-posn 600 125)"PaleTurquoise")
   ((draw-line grafica)(make-posn 0 225) (make-posn 600 225)"PaleTurquoise")
   ((draw-line grafica)(make-posn 0 325) (make-posn 600 325)"PaleTurquoise")
   ((draw-line grafica)(make-posn 0 425) (make-posn 600 425)"PaleTurquoise")
   ((draw-line grafica)(make-posn 0 525) (make-posn 600 525)"PaleTurquoise")
   ((draw-line grafica)(make-posn 0 625) (make-posn 600 625)"PaleTurquoise")
   ((draw-line grafica)(make-posn 0 ( - 625 ( * 600 ( CerodeX 0 ))))( make-posn 650 ( - 625 ( * 600 (CerodeX 0 )))))
   (( draw-line grafica)( make-posn (+ 25 ( * 600 ( CerodeY 0 )))0)( make-posn (+ 25( * 600 ( CerodeY 0 ))) 650 ))
   (Lineas 0 0 650 25 25 )
   (numX min 0 ( * ( CerodeX 0 ) 6 ) 10 )
   (numY 30 inicioy 0 ( * ( / ( abs ( - min max )) incremento ) ( CerodeY 0 )))
   (ConectarX min 1 min max finaly inicioy)
   
)

(Grafica)
  


