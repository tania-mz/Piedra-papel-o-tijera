#lang racket
#|
- Fecha de publicación: 17/04/24
- Hora: 5:20
- Versión de su código 20.0
- Autor. Ing(c) : Tania Marin Zamora
- Nombre del lenguaje utilizado : Racket
- Versión del lenguaje utilizado : 8.10
- Presentado a: Doctor Ricardo Moreno Laverde
- Universidad Tecnológica de Pereira
- Programa de Ingeniería de Sistemas y Computación
- Este programa permite jugar ahorcado
|#

(require graphics/graphics)
(open-graphics)

(define ventana (open-viewport "Ahorcado" 770 620  ))
((draw-solid-rectangle ventana) (make-posn 0 0 ) 770 620 "black")

(define abecedario " ABCDEFGHIJKLMNÑOPQRSTUVWXYZ") ;Guarda string de letras para saber que letra se está jugando
(define base "mov0.png") ;Imagen del movimiento 0, donde se inicia el juego
(define cabeza "mov1.png") 
(define cuerpo "mov2.png") 
(define manoD "mov3.png")  
(define manoI "mov5.png")  
(define pieD "mov6.png") 
(define pieI "mov7.png") 
(define muerto "cara_muerta.png") ;Este identificador guarda la imagen de la cara del muñeco cuando muere

( ( (draw-pixmap-posn base ) ventana) (make-posn 250 0 ) ) ;Se muestra la imagen base para jugar
;((draw-string ventana) (make-posn 330 320) "████████" "black")
((draw-string ventana)(make-posn 20 20)"Reiniciar Juego" "white")


(define (ChangeChar str index new)
  (string-append
    (substring str 0 index)
    (string new)
    (substring str (+ index 1))));Funcion para cambiar string

(define (Word n)
  (if (= n 0 )
      "LAVERDE"
      (if (= n 1 )
          "CONTRATO"
          (if (= n 2 )
              "CELULAR"
              (if (= n 3 )
                  "UTP"
                (if (= n 4)
                  "PARCIAL"
                  (void)))))))
 ;Palabra aleatoria

(define palabra  (Word (random 0 5)))

(define (crearPalabraAJugar count palabraC )
  (if (= count (string-length palabra ))
      palabraC
      (crearPalabraAJugar (+ 1 count) (string-append palabraC "_   ") )
  )
) ; Crea rayitas

(define palabraJugadaDin (crearPalabraAJugar 0 "" ) ) ;Guarda lo que retorna crearPalabraAJugar

(define (probarLetra i letra n z vida errores palabraJugada);Probar si una letra hace parte de la palabra
  ( if (string-contains? palabra (~a letra) ) ; Si el string CONTIENE la letra que se quiere jugar
       ( if (= i (string-length palabra )) ;Recorre todos los caractes que tenga la palabra buscando donde y cuantas letras iguales a esa hay
            (begin
              (verificar z vida errores palabraJugada) ;luego llama a verificar
              )
            (if (equal?  (string-ref palabra i)  letra ) 
                (begin
                  (probarLetra (+ 1 i) letra n (add1 z) vida errores  (ChangeChar palabraJugada (* i 4) letra )) ;Pasa a con el siguiente caracter a probar
                 )
                (probarLetra (+ 1 i) letra n z vida errores palabraJugada); si no es igual, sigue a probar con la siguiente
             )
       )
       (begin;NO CONTIENTE
         (quitarVida z (add1 vida) letra errores palabraJugada) ; LLama a Quitarvida


  
)
       )
       )
 

(define (verificar nA vida errores palabraJugada);Verifica ganar
  (imprimirLetras palabraJugada) ;Imprimir string
  (if (= nA  (string-length palabra) ) ;Aciertos=length
      (begin ;((draw-string ventana) (make-posn 330 320) "████████" "black")) ; coloca un fondo
             ((draw-string ventana) (make-posn 330 325) "GANASTE" "WHITE")) ;para mostrar por pantalla un mensaje avisando que se ha ganado
      (juego nA vida errores palabraJugada ) ;ContinuaJuego
   )

)
(define (quitarVida nA vida letra errores palabraJugada)
  (if (= vida 1 )
      (begin ( ( (draw-pixmap-posn cabeza ) ventana) (make-posn 250 0 ) ) (juego nA vida (ChangeChar errores 0 letra ) palabraJugada)) ;ref1: dibuja la parte de cuepo y agrega a errores la letra con la que se ha fallado
      (if (= vida 2)
          (begin ( ( (draw-pixmap-posn cuerpo ) ventana) (make-posn 250 0 ) ) (juego nA vida (ChangeChar errores 0 letra ) palabraJugada)) ;ref1
          (if (= vida 3)
              (begin ( ( (draw-pixmap-posn manoD ) ventana) (make-posn 250 0 ) )  (juego nA vida (ChangeChar errores 0 letra ) palabraJugada));ref1
              (if (= vida 4)
                  (begin ( ( (draw-pixmap-posn manoI ) ventana) (make-posn 250 0 ) )  (juego nA vida (ChangeChar errores 0 letra ) palabraJugada)) ;ref1
                  (if (= vida 5)
                      (begin ( ( (draw-pixmap-posn pieD ) ventana) (make-posn 250 0 ) )
                             (juego nA vida (ChangeChar errores 0 letra ) palabraJugada))
                      
                      (begin ( ( (draw-pixmap-posn pieI ) ventana) (make-posn 250 0 ) )
                             ((draw-string ventana) (make-posn 325 320) "████████████" "black")
                             ((draw-string ventana) (make-posn 330 320) "AHORCADO" "white")
                             ((draw-string ventana) (make-posn 400 335) palabra "white")
                             ((draw-string ventana) (make-posn 300 335) "La palabra era: " "white"))
                      )))))

);esta funcion esta encargada de mostrar colocar una parte del cuerpo al muñeco dependiendo de cuantas vidas se ha gastado (vida)



(define (imprimirLetras palabraJugada )
   ;((draw-string ventana) (make-posn 330 320) "███████████████████████████" "black") ; borra donde se va escribir
     ((draw-string ventana) (make-posn 250 300) "███████████████████████████" "black") ; borra donde se va escribir
   ((draw-string ventana) (make-posn 300 300) palabraJugada "white") ; se escribe palabraJugada
) ;esta funcion imprime en pantalla la palabra oculta con las letras que se ha destapado


(define (casillaTocada d )
  
 (if (and (< (posn-y (mouse-click-posn d)) 20) (< (posn-x (mouse-click-posn d)) 125) )31
     
 (if (and (< (posn-y (mouse-click-posn d)) 605) (>= (posn-y (mouse-click-posn d)) 350) )
     (+
      (if (and (< (posn-x (mouse-click-posn d)) 85) (>= (posn-x (mouse-click-posn d)) 5) ) 1
          
          (if (and (< (posn-x (mouse-click-posn d)) 175) (>= (posn-x (mouse-click-posn d)) 90) ) 2
              
              (if (and (< (posn-x (mouse-click-posn d)) 260 ) (>= (posn-x (mouse-click-posn d)) 175) ) 3
                  
                  (if (and (< (posn-x (mouse-click-posn d)) 345) (>= (posn-x (mouse-click-posn d)) 260) ) 4
                      
                      (if (and (< (posn-x (mouse-click-posn d)) 430) (>= (posn-x (mouse-click-posn d)) 345) ) 5
                          
                          (if (and (< (posn-x (mouse-click-posn d)) 515) (>= (posn-x (mouse-click-posn d)) 430) ) 6
                              
                              (if (and (< (posn-x (mouse-click-posn d)) 600) (>= (posn-x (mouse-click-posn d)) 515) ) 7
                                  
                                  (if (and (< (posn-x (mouse-click-posn d)) 685) (>= (posn-x (mouse-click-posn d)) 600) ) 8
                                      
                                      (if (and (< (posn-x (mouse-click-posn d)) 770) (>= (posn-x (mouse-click-posn d)) 685) ) 9
                                          (void) ) ) ) ) ) ) ) ) ) 
      (*

       (if (and (< (posn-y (mouse-click-posn d)) 430) (>= (posn-y (mouse-click-posn d)) 350) ) 0
           (if (and (< (posn-y (mouse-click-posn d)) 510) (>= (posn-y (mouse-click-posn d)) 430) ) 1
               (if (and (< (posn-y (mouse-click-posn d)) 595) (>= (posn-y (mouse-click-posn d)) 510) ) 2
                   (void) ) ) )  9
                                 )
      )
     30
   )
 )

  


) 

(define (imprimirTeclas i x y)
  (if (= i 28)
      (void)
      (if (= (remainder i 9) 0) ;Ya se imprimieron 8 
          (begin
            ((draw-solid-rectangle ventana) (make-posn x y ) 80 80  "Pink")
            ((draw-string ventana) (make-posn (+ x 39) (+ y 39)) ( ~a (string-ref abecedario i)) "maroon") 
            (imprimirTeclas (add1 i) 5 (+ y 85)) 
           )
           (begin
             ((draw-solid-rectangle ventana) (make-posn x y ) 80 80  "Pink") 
             ((draw-string ventana) (make-posn (+ x 39) (+ y 39)) ( ~a (string-ref abecedario i)) "maroon") 
             (imprimirTeclas (add1 i) (+ x 85) y) 
           )
       )
   )
  
) 

(define (colocarFicha i obj x y color )
  (if (= i obj)
      (begin  ((draw-solid-rectangle ventana) (make-posn x y ) 80 80  color) ((draw-string ventana) (make-posn (+ x 39) (+ y 39)) ( ~a (string-ref abecedario i)) "black") )
      (if (and (= (remainder i 9) 0) ( not (= i 0)))
          (colocarFicha (+ 1 i) obj 5 (+ y 10000000) color )
          (colocarFicha (+ 1 i) obj (+ x 85) y  color )
       )
   ) 
  
)

(define (intermediario d n vida errores palabraJugada);Antes de enviar a funciones la limita
  (if (= d 31)
      (begin
        ( ( (draw-pixmap-posn base ) ventana) (make-posn 250 0 ) )
      (imprimirLetras palabraJugadaDin) ; Imprime letras
      (imprimirTeclas 1 5 350) ;imprime teclas
      (juego 0 0 "0xxxxxx" palabraJugadaDin)
      )
  (if (= d 30) ;si d 30 quiere decir que casillaTocada devolvio 30 (ya se mencionó porque 30)
      (juego n vida errores palabraJugada ) ; por ende llamo a juego si alterar nada
      (if (or (string-contains? palabraJugada (~a (string-ref abecedario d)) ) (string-contains? errores (~a (string-ref abecedario d)) )) ;si la casilla ya fue jugada
      (begin  ((draw-string ventana) (make-posn 320 330) "YA JUGASTE ESTA LETRA" "white") (juego n vida errores palabraJugada )) ; se le indica que ya fue jugada pero no se pierde vida
      (begin ((draw-string ventana) (make-posn 300 330) "████████████████████████████" "black")
             (probarLetra 0 (string-ref abecedario d) d n vida errores palabraJugada))))) 
         
)

(define (juego n vida errores palabraJugada );Hace el juego
  
  (intermediario (casillaTocada (get-mouse-click ventana)) n vida errores palabraJugada) ; solicita al jugador que clickee una casilla 
  
)

(imprimirLetras palabraJugadaDin) ; Imprime letras
(imprimirTeclas 1 5 350) ;imprime teclas
(juego 0 0 "0xxxxxx" palabraJugadaDin)