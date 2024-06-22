#lang racket
#|
- Fecha de publicación: 05/05/2024
- Hora: 19:24
- Versión de su código: 8.4
- Autor. Ing(c) Tania Marin Zamora
- Nombre del lenguaje utilizado: Racket
- Versión del lenguaje utilizado: 8.11
- Presentado a: Doctor Ricardo Moreno Laverde
- Universidad Tecnológica de Pereira
- Programa de Ingeniería de Sistemas y Computación

- Descripción: Este programa simula una resonancia magnética, cuenta con tres (3) funciones.
la primera función (PuntoSospechoso) recibe tres coordenadas (x, y, z) ingresadas por el usuario y determina si dicho punto es sospechoso.
La segunda función (LineasSospechosas) sevalúa una página (digitada por el usuario) y evalúa la cantidad de líneas sospechosas existentes en dicha página.
La tercera función (Reporte) hace un reporte general de la cantidad de puntos sospechosos y lineas sospechosas encontradas en cada página.
-Salvedades: No se garantizan resultados si los datos ingresados por el usuario no son números enteros positivos entre 2 y 99|#

(printf "ESTAS SON LAS FUNCIONES A LLAMAR:

(PuntoSospechoso)
(LineasSospechosas z) (z corresponde a la página que desea observar)
(GenerarReporte)\n\n")

(printf "Nota: En los valores que se le pedirán a continuación, no se evaluarán números menores o iguales a 1 ni mayores o iguales a 100.
El rango permitido es de 2 a 99\n")

(require graphics/graphics)
(open-graphics)
(define(Reading valor parámetro);Esta función evalúa los valores ingresados por el usuario para determinar si están en el rango a tomar
   (if (and(> valor 1)(< valor 100))
       (- valor 1)
       (begin
         (printf "Valor invalido para ~a, ingrese otro valor: " parámetro);CAMBIAR
         (Reading (read) parámetro)
       )
   )
)

(define(Range a)
  (random 0 255)
)

(define(Rango counter)
  ;(if(= ind 1)
     ;(random 20 41)
     ;(random 0 255)
       ( if  ( and ( <= counter (* 10000 52))(>= counter (* 10000 44))
            ( <= counter (+(* 10000 44)9000))(>= counter (+(* 10000 44)2000))
           ( >= ( remainder ( - counter ( * (  quotient counter 100 ) 100  )) 10000 ) 23)
               ( <= ( remainder ( - counter ( * (  quotient counter 100 ) 100  )) 10000 ) 33 )) 
         ( random 20 41)
         ( random 0 255)
         )
   )
 
(define (ExaminePunto x y z);Esta función examina la coordenada ingresada por el usuario y devuelve el vector-ref de la coordenada en el vector (str)
(vector-ref str (+  x (* y 100)(* z 10000)))
)

(define (Sospechoso? x y z); Esta función determina si un punto es o no es sospechoso
(if (and (and(>= (ExaminePunto x (- y 1) z) 20)(<= (ExaminePunto x (- y 1) z) 40))
         (and(>= (ExaminePunto x (+ y 1) z) 20)(<= (ExaminePunto x (+ y 1) z) 40))
         (and(>= (ExaminePunto (+ x 1) y z) 20)(<= (ExaminePunto (+ x 1) y z) 40))
         (and(>= (ExaminePunto (- x 1) y z) 20)(<= (ExaminePunto (- x 1) y z) 40))
         (and(>= (ExaminePunto (- x 1)(- y 1) z) 20)(<= (ExaminePunto (- x 1)(- y 1) z) 40))
         (and(>= (ExaminePunto (+ x 1)(- y 1) z) 20)(<= (ExaminePunto (+ x 1)(- y 1) z) 40))
         (and(>= (ExaminePunto (+ x 1)(+ y 1) z) 20)(<= (ExaminePunto (+ x 1)(+ y 1) z) 40))
         (and(>= (ExaminePunto (- x 1)(+ y 1) z) 20)(<= (ExaminePunto (- x 1)(+ y 1) z) 40))
         
         (and(>= (ExaminePunto x y (+ 1 z)) 20)(<= (ExaminePunto x y (+ 1 z)) 40))
         (and(>= (ExaminePunto x (- y 1)(+ 1 z)) 20)(<= (ExaminePunto x (- y 1)(+ 1 z)) 40))
         (and(>= (ExaminePunto x (+ y 1)(+ 1 z)) 20)(<= (ExaminePunto x (+ y 1)(+ 1 z)) 40))
         (and(>= (ExaminePunto (+ x 1) y(+ 1 z)) 20)(<= (ExaminePunto (+ x 1) y(+ 1 z)) 40))
         (and(>= (ExaminePunto (- x 1) y(+ 1 z)) 20)(<= (ExaminePunto (- x 1) y(+ 1 z)) 40))
         (and(>= (ExaminePunto (- x 1)(- y 1)(+ 1 z)) 20)(<= (ExaminePunto (- x 1)(- y 1) (+ 1 z)) 40))
         (and(>= (ExaminePunto (+ x 1)(- y 1)(+ 1 z)) 20)(<= (ExaminePunto (+ x 1)(- y 1) (+ 1 z)) 40))
         (and(>= (ExaminePunto (+ x 1)(+ y 1)(+ 1 z)) 20)(<= (ExaminePunto (+ x 1)(+ y 1) (+ 1 z)) 40))
         (and(>= (ExaminePunto (- x 1)(+ y 1)(+ 1 z)) 20)(<= (ExaminePunto (- x 1)(+ y 1) (+ 1 z)) 40))

         (and(>= (ExaminePunto x (- y 1)(- z 1)) 20)(<= (ExaminePunto x (- y 1)(- z 1)) 40))
         (and(>= (ExaminePunto x (+ y 1)(- z 1)) 20)(<= (ExaminePunto x (+ y 1)(- z 1)) 40))
         (and(>= (ExaminePunto (+ x 1) y(- z 1)) 20)(<= (ExaminePunto (+ x 1) y(- z 1)) 40))
         (and(>= (ExaminePunto (- x 1) y(- z 1)) 20)(<= (ExaminePunto (- x 1) y(- z 1)) 40))
         (and(>= (ExaminePunto (- x 1)(- y 1)(- z 1)) 20)(<= (ExaminePunto (- x 1)(- y 1)(- z 1)) 40))
         (and(>= (ExaminePunto (+ x 1)(- y 1)(- z 1)) 20)(<= (ExaminePunto (+ x 1)(- y 1)(- z 1)) 40))
         (and(>= (ExaminePunto (+ x 1)(+ y 1)(- z 1)) 20)(<= (ExaminePunto (+ x 1)(+ y 1)(- z 1)) 40))
         (and(>= (ExaminePunto (- x 1)(+ y 1)(- z 1)) 20)(<= (ExaminePunto (- x 1)(+ y 1)(- z 1)) 40))
         (and(>= (ExaminePunto x y (- z 1)) 20)(<= (ExaminePunto x y (- z 1)) 40)))
   #t
   #f
)
  )
;_____________________________________________________________________________________________________________________
;PUNTOS SOSPECHOSOS

(define (PuntoSospechoso); Esta es la primera función es la principal,(Primer punto del contrato) la que puede llamar el usuario en consola
(printf "\nIngrese la coordenada en x del punto: ")
(define x (Reading(read) "x"))
(printf "\nIngrese la coordenada en y del punto: ")
(define y (Reading(read) "y"))
(printf "\nIngrese la coordenada en z del punto: ")
(define z (Reading(read) "z"))
(define puntos (open-viewport "Puntos Sospechosos" 800 350));Abrir ventana de los puntos sospechosos
;------Parte gráfica de la ventana------------------------------
(((draw-pixmap-posn "cuadricula.png")puntos)(make-posn 80 80))
(((draw-pixmap-posn "flechax.png")puntos)(make-posn 80 40))
(((draw-pixmap-posn "flechay.png")puntos)(make-posn 40 80))
(((draw-pixmap-posn "cuadricula.png")puntos)(make-posn 320 80))
(((draw-pixmap-posn "flechax.png")puntos)(make-posn 320 40))
(((draw-pixmap-posn "flechay.png")puntos)(make-posn 280 80))
(((draw-pixmap-posn "cuadricula.png")puntos)(make-posn 550 80))
(((draw-pixmap-posn "flechax.png")puntos)(make-posn 550 40))
(((draw-pixmap-posn "flechay.png")puntos)(make-posn 505 80))
((draw-string puntos)(make-posn 40 250) "Plano en Z (Hoja) =")
((draw-string puntos)(make-posn 180 250) (~a z))
((draw-string puntos)(make-posn 40 265) "Plano Inferior")
((draw-string puntos)(make-posn 280 250) "Plano en Z (Hoja) =")
((draw-string puntos)(make-posn 420 250) (~a (+ 1 z)))
((draw-string puntos)(make-posn 505 250) "Plano en Z (Hoja) =")
((draw-string puntos)(make-posn 645 250) (~a(+ z 2)))
((draw-string puntos)(make-posn 505 265) "Plano Superior")
((draw-solid-ellipse puntos) (make-posn 365 125) 30 30 "maroon")

((draw-string puntos)(make-posn 370 70) (~a (+ 1 x)))
((draw-string puntos)(make-posn 330 70) (~a x ))
((draw-string puntos)(make-posn 410 70) (~a (+ 2 x)))
((draw-string puntos)(make-posn 300 145)(~a (+ 1 y)))
((draw-string puntos)(make-posn 300 105)(~a y ))
((draw-string puntos)(make-posn 300 185)(~a (+ y 2)))

((draw-string puntos)(make-posn 370 105) (~a(ExaminePunto x (- y 1) z)))
((draw-string puntos)(make-posn 330 105) (~a(ExaminePunto (- x 1) (- y 1) z)))
((draw-string puntos)(make-posn 410 105) (~a(ExaminePunto (+ 1 x)(- y 1)z)))
((draw-string puntos)(make-posn 330 145) (~a(ExaminePunto (- x 1) y z)))
((draw-string puntos)(make-posn 410 145) (~a(ExaminePunto (+ x 1) y z)))
((draw-string puntos)(make-posn 370 185) (~a(ExaminePunto x (+ y 1) z)))
((draw-string puntos)(make-posn 410 185) (~a(ExaminePunto (+ x 1) (+ y 1) z)))
((draw-string puntos)(make-posn 330 185) (~a(ExaminePunto (- x 1) (+ y 1) z)))

((draw-string puntos)(make-posn 610 70) "x")
((draw-string puntos)(make-posn 560 70) "x-1")
((draw-string puntos)(make-posn 640 70) "x+1")
((draw-string puntos)(make-posn 530 145)"y")
((draw-string puntos)(make-posn 525 105)"y-1") 
((draw-string puntos)(make-posn 525 185)"y+1") 

((draw-string puntos)(make-posn 600 105) (~a(ExaminePunto x (- y 1) (+ z 1))))
((draw-string puntos)(make-posn 560 105) (~a(ExaminePunto (- x 1) (- y 1) (+ z 1))))
((draw-string puntos)(make-posn 640 105) (~a(ExaminePunto (+ 1 x)(- y 1)(+ z 1))))
((draw-string puntos)(make-posn 560 145) (~a(ExaminePunto (- x 1) y (+ z 1))))
((draw-string puntos)(make-posn 640 145) (~a(ExaminePunto (+ x 1) y (+ z 1))))
((draw-string puntos)(make-posn 600 185) (~a(ExaminePunto x (+ y 1) (+ z 1))))
((draw-string puntos)(make-posn 640 185) (~a(ExaminePunto (+ x 1) (+ y 1) (+ z 1))))
((draw-string puntos)(make-posn 560 185) (~a(ExaminePunto (- x 1) (+ y 1) (+ z 1))))
((draw-string puntos)(make-posn 600 145) (~a(ExaminePunto x y (+ z 1))))
  
((draw-string puntos)(make-posn 140 70) "x")
((draw-string puntos)(make-posn 90 70) "x-1")
((draw-string puntos)(make-posn 170 70) "x+1")
((draw-string puntos)(make-posn 60 145)"y")
((draw-string puntos)(make-posn 55 105)"y-1") 
((draw-string puntos)(make-posn 55 185)"y+1") 

((draw-string puntos)(make-posn 130 105)(~a(ExaminePunto x (- y 1) (- z 1))))
((draw-string puntos)(make-posn 90 105) (~a(ExaminePunto (- x 1) (- y 1) (- z 1))))
((draw-string puntos)(make-posn 170 105)(~a(ExaminePunto (+ 1 x)(- y 1)(- z 1))))
((draw-string puntos)(make-posn 90 145) (~a(ExaminePunto (- x 1) y (- z 1))))
((draw-string puntos)(make-posn 170 145)(~a(ExaminePunto (+ x 1) y (- z 1))))
((draw-string puntos)(make-posn 130 185)(~a(ExaminePunto x (+ y 1) (- z 1))))
((draw-string puntos)(make-posn 170 185)(~a(ExaminePunto (+ x 1) (+ y 1) (- z 1))))
((draw-string puntos)(make-posn 90 185) (~a(ExaminePunto (- x 1) (+ y 1) (- z 1))))
((draw-string puntos)(make-posn 130 145)(~a(ExaminePunto x y (- z 1))))
;----------------------------------------------------------------------
(if(Sospechoso? x y z)
    ((draw-string puntos)(make-posn 40 305) "EL PUNTO ES SOSPECHOSO")
    ((draw-string puntos)(make-posn 40 305) "EL PUNTO NO ES SOSPECHOSO")
    )
)
;_________________________________________________________________________________________________________________________________  
;LINEAS SOSPECHOSAS

(define (MakeLineas1 x y counter);Con esta función se trazan las lineas horizontales de la cuadrícula
  (if (< counter 100)
      (begin
        ((draw-line lineas)(make-posn x y)(make-posn 612 y) "black")
        (MakeLineas1 x (+ y 6)(+ counter 1))
      )
      (void)
  )
)

(define (MakeLineas2 x y counter);Con esta función se trazan las lineas verticales de la cuadricula
  (if (< counter 100)
      (begin
        ((draw-line lineas)(make-posn x y)(make-posn x 612) "black")
        (MakeLineas2 (+ x 6) y (+ counter 1))
      )
      (void)
   )
)
  
(define (BackLine x2 y2 z2);Esta función evalúa las lineas sospechosas y las grafica
  (if ( = y2 99)
      (void)
      (if (= x2 97)
          (BackLine 1 (+ 1 y2) z2) 
          (if (and (Sospechoso? x2 y2  z2)(Sospechoso? (+ 1 x2) y2 z2)(Sospechoso? (+ 2 x2) y2 z2))
              (begin
                ((draw-solid-rectangle lineas) (make-posn (+ 12(* 6 x2))(+ 12 (* y2 6))) 18 6 "maroon")
                (BackLine (+ 1 x2) y2 z2)
              )
              (BackLine (+ x2 1) y2 z2)
          ) 
      )
  )
)
    
(define lineas (open-viewport "Lineas Sospechosas" 612 612));Abre la ventana de las lineas sospechosas pero se muestra cuando se llama desde la consola

(define (LineasSospechosas z2);Esta es la segunda función principal,(Segundo punto del contrato) la que puede llamar el usuario en consola
       (((draw-pixmap-posn "prueba.jpeg")lineas)(make-posn 0 0))
       (BackLine 1 1 (- z2 1))
       (MakeLineas1 12 12 0)
       (MakeLineas2 12 12 0)
  )

#|(define (Cantidad counter)
  (if (< counter 98)
  (begin
  (Lineas sospechosas counter)
  (void)
))
(Cantidad 2)|#

;__________________________________________________________________________________________________________________________
;REPORTE

(define (CantidadPuntos counter x y z);Esta función calcula la cantidad de puntos 
  (if ( = y 99)
      counter
      (if ( = x 99)
          (CantidadPuntos counter 1 (+ 1 y) z)
          (if (Sospechoso? x y z)
              (CantidadPuntos (+ 1 counter) (+ x 1) y z)
              (CantidadPuntos  counter (+ x 1) y z)
          )
      )
  )
)

(define(CantidadLineas counter finalcount x y z);Esta función cuenta la cantidad de lineas
  (if(= y 99)
     finalcount
     (if (= x 99)
         (CantidadLineas 0 finalcount 1 (+ 1 y) z)
         (if (and(Sospechoso? x y z)(= counter 2))
             (CantidadLineas (+ 1 counter) (+ 1 finalcount) x y z)
             (if (Sospechoso? x y z)
                 (CantidadLineas (+ 1 counter) finalcount (+ x 1) y z)
                 (CantidadLineas 0 finalcount (+ x 1) y z)
             )
         )
     )
  )
)
            
(define (Reporte z);Esta función escribe renglón por renglón cuántas lineas y puntos hay en cada página
  ;(define lineas (open-viewport "Lineas Sospechosas" 612 612))
   (((draw-pixmap-posn "prueba.jpeg")lineas)(make-posn 0 0))
       (MakeLineas1 12 12 0)
       (MakeLineas2 12 12 0)
  (if (< z 99)
      (begin
        (BackLine 1 1  1)
        (printf "Página: ~a           Cantidad de lineas: ~a         Cantidad de puntos: ~a\n" (+ z 1) (CantidadLineas 0 0 1 1 z) (CantidadPuntos 0 1 1 z))
        (Reporte (+ z 1))
      )
      (void)
  )
)
     
(define (GenerarReporte);Esta es la tercera función principal,(Tercer punto del contrato) la que puede llamar el usuario en consola
  (Reporte 1)
)
      
