#lang racket

(require "teachpacks/evren-teachpack.rkt")

( STRUCT v ( x y ) )

;; x : sayı - x koordinatı
;; y : sayı - y koordinatı
;; v+ - vektör toplama
;; v+ v v -> v

( ÖRNEK ( v+ ( v 5 3 ) ( v 5 4 ) ) ( v 10 7 ) )  

( ÖRNEK ( v+ ( v 2 6 ) ( v 8 9 ) ) ( v 10 15 ) ) 

( define ( v+ v1 v2 )
   ( v
     ( + ( v-x v1 ) ( v-x v2 ))
     ( + ( v-y v1 ) ( v-y v2 ) ) ) ) 

;; v- - vektör çıkartma

( ÖRNEK ( v- ( v 4 6 ) ( v 5 8 ) ) ( v -1 -2 ) )

( ÖRNEK ( v- ( v 3 7 ) ( v 6 2 ) ) ( v -3 5 ) )

( define ( v- v1 v2 )
   ( v
     ( - ( v-x v1 ) ( v-x v2 ) )
     ( - ( v-y v1 ) ( v-y v2 ) ) ) ) 

;; v* - vektör sayıyla çarpma
;; sayı v -> v 

( ÖRNEK ( v* 2 ( v 5 3 ) ) ( v 10 6 ) )

( ÖRNEK ( v* 3 ( v 4 6 ) ) ( v 12 18 ) )

( define ( v* s vk )
   ( v
     ( * s ( v-x vk ) )
     ( * s ( v-y vk ) ) ) ) 

;; v. - vektör dot çarpma
;; v. : vektör vektör -> sayı

( ÖRNEK ( v. ( v 5 3 ) ( v 8 6 ) ) 58 )

( ÖRNEK ( v. ( v 2 4 ) ( v 7 3 ) ) 26 )

( define ( v. v1 v2 )
   ( + ( * ( v-x v1 ) ( v-x v2 ) )
       ( * ( v-y v1 ) ( v-y v2 ) ) ) ) 

;; v-mag - vektör uzunluğu
;; v-mag vetör -> sayı

( ÖRNEK ( v-mag ( v 3 4 ) ) 5 )

( ÖRNEK ( v-mag ( v 5 12 ) ) 13 )

( define ( v-mag v1 ) ( sqrt ( + ( sqr ( v-x v1 ) ) ( sqr ( v-y v1 ) ) ) ) ) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hediye vektör çizim fonksiyonları
;; Vektör STRUCT tanıttıktan sonra bu fonkisyonları uncomment edebilirsiniz
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;place-image/v
; resim v sahne -> sahne
; bir sahneye vectöre göre bir imaj yerleştir
; template :
; (define (place-image/v im v1 sahne)
;  (... im ... (v-x v1) ... (v-y v1) ...)

(define test-circle (circle 10 "solid" "purple"))

(define test-square ( square 100 "solid" "grey"))

(define BACKGROUND ( bitmap "imaj/asıl_saha.jpg"))

(define oyuncu1 ( scale 0.2 ( bitmap "imaj/mavi.png")) )

(define oyuncu2 ( scale 0.2  ( bitmap "imaj/kırmızı.png")) )

(define top ( scale 0.05 ( bitmap "imaj/topp.png")) )

(ÖRNEK (place-image/v  test-circle (v 5 5) test-square)
       (place-image/align test-circle 5 5 "center" "center" test-square))

(ÖRNEK (place-image/v test-circle (v 3 8) test-square)
       (place-image/align test-circle 3 8 "center" "center" test-square))

(ÖRNEK (place-image/v test-circle (v 1 2) test-square)
       (place-image/align test-circle 1 2 "center" "center" test-square))

(ÖRNEK (place-image/v test-circle (v 2 8) test-square)
       (place-image/align test-circle 2 8 "center" "center" test-square))

(define (place-image/v im v1 sahne)
  (place-image/align im (v-x v1) (v-y v1) "center" "center"  sahne))

; place-line/v v v color görüntü -> görüntü
; v1'den v2'e giden bir çizgi arka imajına yerleştir

(ÖRNEK (place-line/v (v 2 3) (v 5 1) "red" test-square)
       (add-line test-square 2 3 5 1 "red"))

;.....................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................

(define (place-line/v v1 v2 renk arka)
  (add-line arka (v-x v1) (v-y v1) (v-x v2) (v-y v2) renk)) 

; place-text/v v metin sayı color görüntü -> görüntü
; v pozisyonda  verilen metni arka imajına yerleştir
(ÖRNEK (place-text/v (v 20 30) "Hello" 15 "red" test-square)
       (place-image/v (text "Hello" 15 "red") (v 20 30) test-square))
(define (place-text/v v metin size col arka)
  (place-image/v (text metin size col) v arka))

( define background-height ( image-height BACKGROUND ) )



; STRUCT nesne
; imaj : görüntü - nesneini imajı
; yer : v - nesnenin ekrandaki yeri
; hız : v - nesnenin hızı
; ivme : v - nesnenin ivmesi
; nesne-çiz nesne görüntü -> görüntü 
; nesneyi verilen arkaplana çizmek
( STRUCT nesne ( imaj yer hız ivme ) ) 
( ÖRNEK ( nesne-çiz ( nesne ( circle 10 "solid" "red" ) ( v 50 50 )
                            ( v 0 0 )
                            ( v 0 0 ) )
                    ( square 100 "solid" "yellow" ) )
        ( place-image/v ( circle 10 "solid" "red" ) ( v 50 50 )
                        ( square 100 "solid" "yellow" ) ) )
( define ( nesne-çiz n ap ) ( place-image/v ( nesne-imaj n )
                                            ( nesne-yer n ) ap ) )  

; STRUCT evren
; evren-çiz evren -> görüntü
; evren çiziyor
; bg -> background , n1 -> oyuncu1 , n2 -> oyuncu2 , n3 -> top , skor1 -> sol skor , skor2 -> sağ skor0
(STRUCT evren ( bg oyuncu1 oyuncu2 top skor1 skor2 ) )
(ÖRNEK ( evren-çiz ( evren BACKGROUND ( nesne oyuncu1 ( v 100 50 )
                                              ( v 0 0 )
                                              ( v 0 0 ) )    
                           ( nesne oyuncu2 ( v 200 100 )
                                   ( v 0 0 )
                                   ( v 0 0 ) )  
                           ( nesne top ( v 50 25 )
                                   ( v 0 0 )
                                   ( v 0 0 ) ) 0 3 ) )
       ( place-text/v ( v 70 30 ) ( string-append "Skor: " ( number->string 0 ) "-" ( number->string 3 ) ) 20 "white"  
                      ( nesne-çiz ( nesne oyuncu1 ( v 100 50 )
                                          ( v 0 0 )
                                          ( v 0 0 ) )
                                  ( nesne-çiz ( nesne oyuncu2 ( v 200 100 )
                                                      ( v 0 0 )
                                                      ( v 0 0 ) )  
                                              ( nesne-çiz ( nesne top ( v 50 25 )
                                                                  ( v 5 5 )
                                                                  ( v 2 2  ) ) BACKGROUND ) ) )))

( define ( evren-çiz e )
   ( place-text/v ( v 70 30 ) ( string-append "Skor: " ( number->string ( evren-skor1 e  ) ) "-" ( number->string ( evren-skor2 e  ) ) ) 20 "white"  
                  ( nesne-çiz ( evren-oyuncu1 e )  
                              ( nesne-çiz ( evren-oyuncu2 e ) 
                                          ( nesne-çiz ( evren-top e )( evren-bg e ) ) ) ) ))   

; nesne-fizik-güncelle nesne -> nesne
; nesneyi bir sonraki haline getirmek , yer, hız ve ivme kullanarak
                            
(define ( nesne-fizik-güncelle n )
  ( nesne
    ( nesne-imaj n )
    ( v+ ( nesne-hız n ) ( nesne-yer n ) )
    ( v+ ( nesne-ivme n ) ( nesne-hız n ) )
    ( nesne-ivme n ) ) )

; evren-güncelle evren -> evren
; amaç -> evrenin bir frame sonraki değerini vermek
( ÖRNEK ( evren-güncelle yaradılış ) ( evren BACKGROUND ( nesne oyuncu1 ( v 30 300 )
                                                                ( v 0 0 )
                                                                ( v 0 0 ) )
                                             ( nesne oyuncu2 ( v 970 300 )
                                                     ( v 0 0 )
                                                     ( v 0 0 ) )
                                             ( nesne top ( v 355 555 )
                                                     ( v 7 5  )
                                                     ( v 0 0 ) ) 0 0 ) ) 
        
( define ( evren-güncelle e ) ( çarpışma (gol-gör ( evren ( evren-bg e ) 
                                      ( evren-oyuncu1 e ) 
                                      ( evren-oyuncu2 e )  
                                      ( nesne-sek ( nesne-fizik-güncelle ( evren-top e ) ) ( evren-bg e ) y1 y2 ) 
                                      (evren-skor1 e) (evren-skor2 e) ) ) ) )
                                                    
; gol-gör evren -> evren
; bir gol olmuşsa skor arttırmak, topu ortaya getirmek
( ÖRNEK ( gol-gör ( evren BACKGROUND
                          ( nesne oyuncu1 ( v 100 50 )
                                  ( v 0 0 )
                                  ( v 0 0 ) )
                          ( nesne oyuncu2 ( v 200 100 )
                                  ( v 0 0 )
                                  ( v 0 0 ) )
                          ( nesne top ( v 1 200 )
                                  ( v  0 0 )
                                  ( v 0 0 ) )
                          0 0  ))
        (  evren BACKGROUND
                 ( nesne oyuncu1 ( v 100 50 )
                         ( v 0 0 )
                         ( v 0 0 ) )
                 ( nesne oyuncu2 ( v 200 100 )
                         ( v 0 0 )
                         ( v 0 0 ) )
                 ( nesne top ( v 480 318) 
                         ( v  0 0 )
                         ( v 0 0 ) )
                 0 1 ))
                


( define ( gol-gör e ) ( cond
                          [( sol-gol e )
                           (evren ( evren-bg e ) ( evren-oyuncu1 e ) ( evren-oyuncu2 e )
                                  (nesne (nesne-imaj ( evren-top e ) ) ( v ( / ( image-width ( evren-bg e )) 2 ) ( / ( image-height ( evren-bg e )) 2 ))  ( nesne-hız ( evren-top e ) )  ( v 0 0 ) )       
                                  (evren-skor1 e ) (+ (evren-skor2 e) 1))]
                          
                          [( sağ-gol e )
                           (evren ( evren-bg e ) ( evren-oyuncu1 e ) ( evren-oyuncu2 e )
                                  (nesne  (nesne-imaj (evren-top e )) ( v ( / ( image-width ( evren-bg e )) 2 ) ( / ( image-height ( evren-bg e )) 2 )) ( nesne-hız (evren-top e) )  ( v 0 0 ) )
                                  (+ ( evren-skor1 e ) 1) (evren-skor2 e) ) ]
                          [ else e ]))

( define x-sol1 0 )

( define x-sol2 10 )

( define x-sağ1 950 )

( define x-sağ2 960 )

( define y1 175 )

( define y2 325 )

( define ( sol-gol e ) ( v-in ( nesne-yer ( evren-top e ) ) x-sol1 x-sol2 y1 y2 ) )

( define ( sağ-gol e ) ( v-in ( nesne-yer ( evren-top e ) ) x-sağ1 x-sağ2 y1 y2 ) )

; v-in: v sayı sayı sayı sayı -> mantık
( define ( v-in v x1 x2 y1 y2 ) ( and ( > ( v-x v) x1 ) 
                                      ( < ( v-x v ) x2 ) 
                                      ( > ( v-y v ) y1 ) 
                                      ( < ( v-y v ) y2 ) ) ) 
                                                                              
(define (evren-tuş e t)
  ( evren ( evren-bg e )
          ( oyuncu1-güncelle (evren-oyuncu1 e) t )
          ( oyuncu2-güncelle ( evren-oyuncu2 e ) t )
          ( evren-top e )
          ( evren-skor1 e )
          ( evren-skor2 e ) ) ) 
    

(define (evren-fare e x y m)
  e)

(define FRAME-RATE 12)

( define yaradılış ( evren BACKGROUND ( nesne oyuncu1 ( v 30 300 )
                                              ( v 0 0  )
                                              ( v 0 0 ) )
                           ( nesne oyuncu2  ( v 970 300 )
                                   ( v 0 0 )
                                   ( v 0 0 ) ) 
                           ( nesne top ( v 350 550 )
                                   ( v -7 -5 )
                                   ( v 0 0 ) ) 0  0) ) 

;nesne-sek-gol-yoksa
;gol mesafesine bakmadan kenarlarda sek

( define ( nesne-sek-gol-yoksa n bg) ( let* ( ( nyer ( nesne-yer n ) )
                                              ( nhız ( nesne-hız n ) )
                                              ( nim ( nesne-imaj n ) )
                                              ( x ( v-x nyer ) )
                                              ( x-hız ( v-x nhız ) )
                                              ( y ( v-y nyer ) )
                                              ( y-hız ( v-y nhız ) )
                                              ( nimh/2 ( / ( image-height nim ) 2 ) ) 
                                              ( nimw/2 ( / ( image-width nim ) 2 ) )
                                              ( x-sol nimw/2 )
                                              ( x-sağ ( - ( image-width bg ) nimw/2 ) )
                                              ( y-üst nimh/2 )
                                              ( y-alt ( - ( image-height bg ) nimh/2 ) ) )
                                        ( cond
                                           ( ( or ( and ( < x x-sol )
                                                        ( < x-hız 0 ) )
                                                  ( and ( > x x-sağ )
                                                        ( > x-hız 0 ) ) ) 
                                             ( nesne-hız-set n ( v ( - x-hız ) y-hız ) ) )
                                           ( ( or ( and ( < y y-üst )
                                                        ( < y-hız 0 ) )
                                                  ( and ( > y y-alt )
                                                        ( > y-hız 0 ) ) )
                                             ( nesne-hız-set n ( v x-hız ( - y-hız ) ) ) )
                                           (else n ) ) ))

; nesne-sek nesne imaj sayı sayı -> nesne
; nesne gol seviyesinde değilse, kenarlardan sek

( define ( nesne-sek n bg gol-y-üst gol-y-alt )
   ( cond
      ( ( gol-y? ( v-y ( nesne-yer n ) ) gol-y-üst gol-y-alt ) n )
      ( else ( nesne-sek-gol-yoksa n bg ) ) ) )

; oyuncu1-güncelle nesne string -> nesne

( define oyuncu-adım 5 ) 

( define ( oyuncu1-güncelle n t ) 
   ( alt-güvende-mi ( + background-height ( /( image-height (nesne-imaj n ) ) 2 )  )n )
                    (üst-güvende-mi ( - background-height ( / ( image-height ( nesne-imaj n ) ) 2 ) )n )
                                    ( nesne ( nesne-imaj n )
                                            ( cond
                                               [ ( string=? t "a")  ( v ( - ( v-x ( nesne-yer n) ) oyuncu-adım ) ( v-y ( nesne-yer n ) ) )]
                                               [ ( string=? t "d" ) ( v ( + ( v-x ( nesne-yer n) ) oyuncu-adım ) ( v-y ( nesne-yer n ) ) )]                              
                                               [ ( string=? t "w" ) ( v ( v-x ( nesne-yer n ) ) ( - ( v-y ( nesne-yer n )) oyuncu-adım ) ) ]
                                               [ ( string=? t "s" ) ( v ( v-x ( nesne-yer n ) ) ( + ( v-y ( nesne-yer n )) oyuncu-adım ) )]
                                               [else (nesne-yer n)])
                                            ( nesne-hız n )
                                            ( nesne-ivme n )))   

; oyuncu2-güncelle nesne string -> nesne

( define ( oyuncu2-güncelle  n t )
   ( alt-güvende-mi ( + background-height ( / ( image-height ( nesne-imaj n ) ) 2 ) ) n )
                    (üst-güvende-mi ( - background-height ( / ( image-height ( nesne-imaj n ) )  2 ) )n )
                                    ( nesne ( nesne-imaj n )
                                            ( cond
                                               [ ( string=? t "left" ) ( v ( - ( v-x ( nesne-yer n ) ) oyuncu-adım ) ( v-y ( nesne-yer n ) ) ) ]
                                               [ ( string=? t "right" ) ( v ( + ( v-x ( nesne-yer n ) ) oyuncu-adım ) ( v-y ( nesne-yer n ) ) ) ]
                                               [ ( string=? t "up" ) ( v ( v-x ( nesne-yer n ) ) ( - ( v-y ( nesne-yer n ) ) oyuncu-adım ) ) ]
                                               [ ( string=? t "down" ) ( v ( v-x ( nesne-yer n ) ) ( + ( v-y ( nesne-yer n ) ) oyuncu-adım ) ) ]
                                               [ else ( nesne-yer n ) ] )
                                            ( nesne-hız n )
                                            ( nesne-ivme n ) ) )
 
; gol-y? sayı sayı sayı -> boolean
; y gol önünde mi ?

( define ( gol-y? y gol-y-üst gol-y-alt ) ( and ( > y gol-y-üst )
                                                ( < y gol-y-alt ) ) )

; nesne-hız-set nesne v -> nesne
; set nesnenin hızı

( define ( nesne-hız-set n hız ) ( nesne ( nesne-imaj n )
                                         ( nesne-yer n ) hız
                                         ( nesne-ivme n ) ) )

; STRUCT player-track
; t1
; t2
; t3
; t4

( STRUCT player-track ( t1 t2 t3 t4 ) )
( define ( update-player-track pt pos )
   ( player-track
     pos
     ( player-track-t1 pt )
     ( player-track-t2 pt )
     ( player-track-t3 pt ) ) )

( define ( player-hız pt ) ( v* 0.25 ( v- ( player-track-t1 pt )
                                          ( player-track-t4 pt ) ) ) )

; üst-güvende-mi sayı nesne -> nesne
( define ( üst-güvende-mi y-limit n)
   ( cond
     ( ( > ( - 0 ( v-y ( nesne-yer n ) )) y-limit )
       (nesne
        (nesne-imaj n)
        (v (v-x(nesne-yer n)) y-limit)
        (nesne-hız n)
        (nesne-ivme n)))
     (else n)))

;alt-güvende-mi sayı nesne -> nesne
( define ( alt-güvende-mi y-limit n )
   ( cond
      ( ( < ( - ( v-y ( nesne-yer n ) ) ) y-limit )
        ( nesne
          ( nesne-imaj n )
          ( v ( v-x ( nesne-yer n ) ) y-limit )
          ( nesne-hız n )
          ( nesne-ivme n ) ) )
      ( else n) ) ) 
       
; çarpışma evren -> evren
( define ( çarpışma e )(evren (evren-bg e ) ( evren-oyuncu1 e) ( evren-oyuncu2 e ) (nesne ( nesne-imaj ( evren-top  e) )
                                                                                          ( nesne-yer ( evren-top e )  ) 
     ( cond
      ((< (v-mag ( v- (nesne-yer (evren-oyuncu1 e )) (nesne-yer (evren-top e )) ) ) 50)( v* -1 ( nesne-hız ( evren-top e) )))
      ((< (v-mag ( v- (nesne-yer (evren-oyuncu2 e )) (nesne-yer (evren-top e )) ) ) 50)( v* -1 ( nesne-hız ( evren-top e) )))
      ( else ( nesne-hız ( evren-top e ) ) ) )
     ( nesne-ivme ( evren-top e ) ) )
                              ( evren-skor1 e ) ( evren-skor2 e ) ) ) 
      
            
               
       
      





;SES herhangbirşey ses-dosyası-metin -> herhangibirşey
; birinci paramatresini aynen dönsürüyor, sesi çalarak

(test)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Sabit kod bundan sonra                               ;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(yut (big-bang yaradılış
       (on-tick evren-güncelle (/ 1.0 FRAME-RATE))
       (on-draw evren-çiz)
       (on-key evren-tuş)
       (on-mouse evren-fare)))

