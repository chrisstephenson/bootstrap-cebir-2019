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
(define oyuncu1 ( bitmap "imaj/peter.png"))
(define oyuncu2 ( bitmap "imaj/dumbo.png"))
(define top ( bitmap "imaj/top.jpg"))

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

(define (place-line/v v1 v2 renk arka)
  (add-line arka (v-x v1) (v-y v1) (v-x v2) (v-y v2) renk)) 

; place-text/v v metin sayı color görüntü -> görüntü
; v pozisyonda  verilen metni arka imajına yerleştir
(ÖRNEK (place-text/v (v 20 30) "Hello" 15 "red" test-square)
       (place-image/v (text "Hello" 15 "red") (v 20 30) test-square))
(define (place-text/v v metin size col arka)
  (place-image/v (text metin size col) v arka))


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
(STRUCT evren ( bg n1 n2 n3 skor1 skor2 ) )
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
                               ( v 0 0 )
                               ( v 0 0 ) ) BACKGROUND ) ) )))

( define ( evren-çiz e )
         ( place-text/v ( v 70 30 ) ( string-append "Skor: " ( number->string ( evren-skor1 e  ) ) "-" ( number->string ( evren-skor2 e  ) ) ) 20 "white"  
         ( nesne-çiz ( evren-n1 e )  
         ( nesne-çiz ( evren-n2 e ) 
         ( nesne-çiz ( evren-n3 e )( evren-bg e ) ) ) ) ))   

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
( ÖRNEK ( evren-güncelle yaradılış ) ( evren BACKGROUND ( nesne oyuncu1 ( v 30 600 )
                                                                        ( v 0 0 )
                                                                        ( v 0 0 ) )
                                                        ( nesne oyuncu2 ( v 970 300 )
                                                                        ( v 0 0 )
                                                                        ( v 0 0 ) )
                                                        ( nesne top ( v 350 550 )
                                                                    ( v 0 0  )
                                                                    ( v 0 0 ) ) 0 0 ) ) 
        
( define ( evren-güncelle e ) ( evren ( evren-bg e ) ( nesne-fizik-güncelle ( evren-n1 e ) )
                                                     ( nesne-fizik-güncelle ( evren-n2 e ) )
                                                     ( nesne-fizik-güncelle ( evren-n3 e ) ) 0 0 ) )
                                                    
; gol-gör evren -> evren
; bir gol olmuşsa skor arttırmak, topu ortaya getirmek
( ÖRNEK ( gol-gör ( evren BACKGROUND
                          ( nesne oyuncu1 ( v 100 50 )
                                  ( v 0 0 )
                                  ( v 0 0 ) )
                          ( nesne oyuncu2 ( v 200 100 )
                                  ( v 0 0 )
                                  ( v 0 0 ) )
                          ( nesne top ( v 0 200 )
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
                           (evren ( evren-bg e ) ( evren-n1 e ) ( evren-n2 e )
                                  (nesne (nesne-imaj ( evren-n3 e ) ) ( v ( / ( image-width ( evren-bg e )) 2 ) ( / ( image-height ( evren-bg e )) 2 ))  ( v 0 0 )  ( v 0 0 ) )       
                                  (evren-skor1 e ) (+ (evren-skor2 e) 1))]
                          
                          [( sağ-gol e )
                           (evren ( evren-bg e ) ( evren-n1 e ) ( evren-n2 e )
                                  (nesne  (nesne-imaj (evren-n3 e )) ( v ( / ( image-width ( evren-bg e )) 2 ) ( / ( image-height ( evren-bg e )) 2 )) ( v 0 0 )  ( v 0 0 ) )
                                  (+ ( evren-skor1 e ) 1) (evren-skor2 e) ) ]
                          [ else e ]))

( define x-sol1 0 )

( define x-sol2 10 )

( define x-sağ1 630 )

( define x-sağ2 640 )

( define y1 325 )

( define y2 175 )

( define ( sol-gol e ) ( v-in ( nesne-yer ( evren-n3 e ) ) x-sol1 x-sol2 y1 y2 ) )

( define ( sağ-gol e ) ( v-in ( nesne-yer ( evren-n3 e ) ) x-sağ1 x-sağ2 y1 y2 ) )

; v-in: v sayı sayı sayı sayı -> mantık
( define ( v-in v x1 x2 y1 y2 ) ( and ( > ( v-x v) x1 ) 
                                            ( < ( v-x v ) x2 ) 
                                                                           
                                                                           
                                            ( > ( v-y v ) y1 ) 
                                            ( < ( v-y v ) y2 ) ) ) 
                                                                              
                                                                
                      
                       

                                      
 

(define (evren-tuş e t)
  e)

(define (evren-fare e x y m)
  e)



(define FRAME-RATE 12)

( define yaradılış ( evren BACKGROUND ( nesne oyuncu1 ( v 30 600 )
                                                      ( v 0 0  )
                                                      ( v 0 0 ) )
                                      ( nesne oyuncu2  ( v 970 300 )
                                                       ( v 0 0 )
                                                       ( v 0 0 ) ) 
                                      ( nesne top ( v 350 550 )
                                                  ( v 0 0 )
                                                  ( v 0 0 ) ) 0  0) ) 

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

