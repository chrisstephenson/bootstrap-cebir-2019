#lang racket
(require "teachpacks/evren-teachpack.rkt")
( STRUCT v  ( x y ))
; x : sayı - x koordinatı

; y : sayı - y koordinatı



;; v+ - vektör toplama
;;v+ : v v -> v 
(ÖRNEK ( v+ (v 5 3 )(v 5 4)) ( v 10 7 ))
(ÖRNEK ( v+ (v 2 6 )(v 8 9))( v 10 15 ))
( define ( v+  v1 v2)
              (v
               ( + (v-x v1)( v-x v2 ))
               ( +  (v-y v1)( v-y v2 ))))
               
;; v- - vektör çıkartma
;; 
;;
(ÖRNEK ( v- ( v 4 6 )(v 5 8))( v -1 -2))
(ÖRNEK( v- ( v 3 7 )(v 6 2 ))( v -3 5 ))
(define (v- v1 v2 )
  ( v
    ( - (v-x v1 )( v-x v2))
    ( - (v-y v1 )(v-y v2))))

;; v* - vektör sayıyla çarpma
;;v* : sayı -> vektör
(ÖRNEK ( v* 2 ( v 5 3 ))( v 10 6 ))
(ÖRNEK ( v* 3 (v 4 6 ))( v 12 18 ))
(define (v* s vk )
  (v
   (* s (v-x vk))
   (* s  (v-y vk))))

;; v. - vektör dot çarpma
;; v. : vektör vektör -> sayı
;;
(ÖRNEK ( v. ( v 3 5 )(v 8 6 )) 54 )
(ÖRNEK ( v. ( v 2 4 )(v 7 3 )) 26 )
( define ( v. v1 v2 )
                     ( + (* (v-x v1)( v-x v2 ))
                      ( *  (v-y v1)( v-y v2 ))))
                      
       

;; v-mag - vektör uzunluğu
;; v-mag vektör -> sayı

(ÖRNEK (v-mag ( v 3 4 )) 5)
(ÖRNEK (v-mag ( v 5 12 ))13 )
( define (v-mag v1 )(sqrt (+ (sqr(v-x v1))(sqr(v-y v1)))))

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
(define test-square (square 100 "solid" "green"))
(define BACKGROUND (bitmap "imaj/kutuphane.jpg")) 
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


;STRUCT nesne
; imaj : görüntü - nesneini imajı
; yer : v - nesnenin ekrandaki yeri
; hız : v - nesnenin hızı
; ivme : v - nesnenin ivmesi
( STRUCT nesne (imaj yer hız ivme ))

(ÖRNEK (nesne-çiz (nesne (circle  10 "solid" "red" )
                         (v 50 50 ) ( v 0 0 )( v 0 0 ))
                         (square 100 "solid" "yellow" ))
                   (place-image/v  ( circle 10 "solid" "red")( v 50 50 )
                                   (square 100 "solid" "yellow")))

( define ( nesne-çiz n ap )
 (place-image/v ( nesne-imaj n)( nesne-yer n) ap))

 ;STRUCT evren
; arkaplanı : görüntü - oyun arka planı



;evren-çiz
( STRUCT evren ( bg n1 n2 n3 ))

(ÖRNEK  (evren-çiz (evren BACKGROUND 
                    ( nesne ( circle 10 "solid" "red" )( v 40 60 )( v 0 0)( v 0 0 ))
                   (nesne (square 20 "solid" "blue")(v 80 90)(v 0  0)( v 0 0 ))
                   ( nesne (triangle 30 "solid" "green" )(v 250 200 )( v 0 0)( v 0 0)))) 
             (nesne-çiz ( nesne ( circle 10 "solid" "red" )( v 40 60)( v 0 0 )( v 0 0 ))
             (nesne-çiz (nesne (square 20 "solid" "blue")(v 80 90)(v 0  0)( v 0 0))
             (nesne-çiz ( nesne (triangle 30 "solid" "green" )(v 250 200 )( v 0 0 )(v 0 0)) BACKGROUND))))
 
( define ( evren-çiz e)
        (nesne-çiz ( evren-n1 e)
        (nesne-çiz (evren-n2 e) 
        (nesne-çiz  ( evren-n3 e ) (evren-bg e)))))
                     
   

; nesne-fizik-güncelle

( ÖRNEK( nesne-fizik-güncelle  ( nesne ( circle 10 "solid" "red" )( v 50 50 )( v 2 3 )(v 4 5 )))
        ( nesne ( circle 10 "solid" "red")(v 52 53)( v 6 8)( v 4 5))) 

(define ( nesne-fizik-güncelle n )
  ( nesne
    ( nesne-imaj n )
    ( v+ (nesne-hız n) ( nesne-yer n  ))
    ( v+ (nesne-ivme n) ( nesne-hız n ))
    ( nesne-ivme n))) 

                                            
                                           


; evren-güncelle : evren ->evren
(ÖRNEK (evren-güncelle yaradılış-iki )
       ( evren BACKGROUND
       ( nesne ( circle 10 "solid" "red") ( v 360 165) (v  30 -31 )(v 0 1))
       ( nesne ( square 20 "solid" "blue")( v 110 451)( v -20 -23 )(v 0 1 ))
       ( nesne ( triangle 30 "solid" " green" )( v  745  245)(v 50 -26)(v 0 1))))
( define ( evren-güncelle e )
   ( evren BACKGROUND
   ( nesne-fizik-güncelle (evren-n1 e ))
   ( nesne-fizik-güncelle (evren-n2 e))
   ( nesne-fizik-güncelle (evren-n3 e ))))
   
          
               



(define (evren-tuş e t)
  e)

(define (evren-fare e x y m)
  e)




(define FRAME-RATE 12)

( define yaradılış
          ( evren BACKGROUND 
                  ( nesne ( circle 10 "solid" "red" )( v 20 600)( v 30 -33)( v 0 1 ))
                  (nesne (square 20 "solid" "blue")(v 900 640 )( v -20 -25)( v 0 1 ))
                  ( nesne (triangle 30 "solid" "green" )(v 25 400 )( v 5 -28)( v 0 1))))
( define yaradılış-iki 
          ( evren BACKGROUND 
                  ( nesne ( circle 10 "solid" "red" )( v 330 197 )( v 30 -32)( v 0 1 ))
                  (nesne (square 20 "solid" "blue")(v 130 475)( v -20 -24)( v 0 1 ))
                  ( nesne (triangle 30 "solid" "green" )(v 695 272 )( v 50 -27)( v 0 1))))





;(STRUCT anim ( resimler zaman değişim-sıklığı  devamlı ))
; anim: animasyon -> görüntü
;( ÖRNEK ( anim-çiz ( anim (list (square 10 "solid" "red")
;(square 15 "solid" "red" )
;(square 20 "solid" "red")
;(square 25 "solid" "red")) 13 3 true))
                                          
;(square 10 "solid" "red"))

;(define ( anim-çiz a )
;(list-ref
;(anim-resimler a)
;( modulo(quotient (anim-zaman a )
;(anim-değişim-sıklığı a )))( length ( anim-resimler a))))



;; SES herhangbirşey ses-dosyası-metin -> herhangibirşey
;; birinci paramatresini aynen dönsürüyor, sesi çalarak
(ÖRNEK (SES 0 "ses/bark.wav") 0)

(test)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sabit kod bundan sonra                               ;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(yut (big-bang yaradılış
  (on-tick evren-güncelle (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)
  (on-mouse evren-fare)))



(ÖRNEK ( sahne-2-çiz ( sahne-2-bg-iki
                       sahne-2-elma 
                       sahne-2-sepet
                       sahne-2-skor-e ))
       (sahne-2-bg-iki
        (nesne-çiz sahne-2-elma  )
        (nesne-çiz sahne-2-sepet)
        sahne-2-skor-e))
        
( define (sahne-2-çiz s) 
        (nesne-çiz (sahne-2-elma s )
        (nesne-çiz (sahne-2-sepet s )
         (sahne-2-bg-iki s))))
(
   

