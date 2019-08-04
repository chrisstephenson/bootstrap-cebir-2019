#lang racket
(require "teachpacks/evren-teachpack.rkt")
;; STRUCT v - vektör
;; x : sayı - x koordinatı
;; y : sayı - y koordinatı

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;STRUCT
;; v->vektör
;; x-> sayı
;; y-> sayı 
(STRUCT v ( x y ) )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; v+ - vektör toplama
;; v: vektör vektör --> vektör
;; ( define ( v+ vt vk )
;;    ( v
;;        ... v-x vt)(v-x vk)
;;        ... v-y vt)(v-y vk))))
(ÖRNEK   ( v+ (v 2 -3) (v 7 9))
         ( v 9 6  ))
(ÖRNEK   ( v+ (v -7 0) (v 4 5))
         ( v -3 5 ))
( define ( v+ vt vk )
    ( v
         ( + (v-x vk) (v-x vt))
         ( + (v-y vk) (v-y vt))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; v* - vektör çıkartma
;; v: vektör vektör--> vektör
;; ( define ( v- vt vk )
;;    ( v
;;        ... v-x vt) (v-x vk)
;;        ... v-y vt) (v-y vk)))))
(ÖRNEK ( v- (v 2 -3 ) (v 12 4))
       ( v -10 -7))
(ÖRNEK ( v- (v 7 9 ) (v 0 10))
       ( v 7 -1 ))
 ( define ( v- vt vk )
    ( v
        (- (v-x vt) (v-x vk))
        (- (v-y vt) (v-y vk))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; v* - vektör sayıyla çarpma
;; v: sayı vektör --> vektör
;; ( define ( v * S vk )
;;    ( v
;;        ... v-x vk)
;;        ... v-y vk)))))
(ÖRNEK ( v*  (v 2 -3 ) 4)
       ( v 8 -12))

(ÖRNEK ( v*  (v 7 9 ) 0)
       ( v 0 0 ))
 ( define ( v* vk S )
    ( v (* (v-x vk) S )
        (* (v-y vk) S )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; v. - vektör dot çarpma
;; v: vektör vektör --> sayı
(ÖRNEK ( v. ( v 7 9) ( v 5 6))
            89)
(ÖRNEK ( v. ( v 0 0) ( v 0 0))
            0)
(define ( v. vk vt )
  ( + (* (v-x vk) (v-x vt))
      (* (v-y vk) (v-y vt))))
      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; v-mag - vektör uzunluğu
;; v: 
(ÖRNEK (v-mag ( v 3 4 )) 5)
(define(v-mag vk)
  ( sqrt (+ ( sqr (v-x vk))
         ( sqr (v-y vk)))))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; STRUCT nesne
;; imaj : görüntü - nesneini imajı
;; yer : v - nesnenin ekrandaki yeri
;; hız : v - nesnenin hızı
;; ivme : v - nesnenin ivmesi
(STRUCT nesne ( imaj yer hız ivme))
;;nesne-çiz nesne görüntü --> görüntü
;;nesneyi verilen arkaplanıma çizmek
;;(define ( nesne-çiz n ap)
;;     .... ( nesne-imaj n)
;;      .... ( nesne-yer  n)
(ÖRNEK ( nesne-çiz ( nesne (circle 10 "solid" "red")
                           (v 50 50)
                           (v 0 0)
                           (v 0 0))
                   ( square 100 "solid" "yellow" ) )
       (place-image/v ( circle 10 "solid" "red" ) ( v 50 50 )
                      (square 100 "solid" "yellow")))
(define ( nesne-çiz n ap)
  (place-image/v
   (nesne-imaj n)
   (nesne-yer  n)
   ap))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; nesne-fizik-güncelle nesne-->nesne
;; nesneyi bir sonraki haline getirmeli, yer hız ve ivme kullanarak
;; (define ( nesne-fizik-güncelle n)
;;    (nesne
;;          .... ( nesne-imaj n)
;;          .... ( nesne-yer  n)
;;          .... ( nesne-hız  n)
;;          .... ( nesne-ivme n)
( ÖRNEK (nesne-fizik-güncelle (nesne ( circle 10 "solid" "red") ( v 50 50 ) ( v 2 3 ) ( v 4 5 ) ))
        (nesne ( circle 10 "solid" "red" ) ( v 52 53 ) ( v 6 8 ) ( v 4 5 ) ) ) 
(define ( nesne-fizik-güncelle n)
  (nesne ( nesne-imaj n )
         ( v+ (nesne-yer n) (nesne-hız  n))
         ( v+ (nesne-hız n) (nesne-ivme n))
         (nesne-ivme n)))
  
 
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
        




;; STRUCT evren
;; arkaplanı : görüntü - oyun arka planı
;;
(STRUCT evren (background n1 n2 n3) )
(ÖRNEK
 ( evren-çiz ( evren background
                     (nesne (circle 10 "solid" "red" )( v 50 50 ) ( v 0 0 ) ( v 0 0 ))
                     (nesne (square 20 "solid" "green") ( v 100 150 ) ( v 0 0 ) ( v 0 0))
                     (nesne (triangle 30 "solid" "yellow") ( v 200 300 ) ( v 0 0 ) ( v 0 0 ))))
             ( nesne-çiz( nesne (circle 10 "solid" "red" )( v 50 50 ) ( v 0 0 ) ( v 0 0 ))
                        ( nesne-çiz( nesne (square 20 "solid" "green") ( v 100 150 ) ( v 0 0 ) ( v 0 0))
                                   ( nesne-çiz(nesne (triangle 30 "solid" "yellow") ( v 200 300 ) ( v 0 0 ) ( v 0 0 )) background)) )) 
                        
            
(define (evren-çiz e)
  ( nesne-çiz (evren-n1 e)
              ( nesne-çiz ( evren-n2 e)
                          ( nesne-çiz ( evren-n3 e)
                                      (evren-background e))))) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; evren-güncelle evren-->evren
; amaç : evrenin bir frame sonraki değerini vermek
( ÖRNEK
  (evren-güncelle yaradılış)
                  (evren background
                         (nesne ( circle 30 "solid" "red" ) ( v 60 27 ) ( v 30 32 ) ( v 0 1 ))
                                (nesne  (square 20 "solid" "green") ( v 900 225 ) ( v -70 -74 ) ( v 0 1 ))
                                        (nesne (triangle 30 "solid" "yellow") ( v 355 532 ) ( v 5 -17 ) ( v 0 1 ))))
(define (evren-güncelle e)
  (evren (evren-background e )
  ( nesne-fizik-güncelle (evren-n1 e))
  ( nesne-fizik-güncelle (evren-n2 e))
  ( nesne-fizik-güncelle (evren-n3 e))))                     

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (evren-tuş e t)
  e)

(define (evren-fare e x y m)
  e)


(define background (bitmap "imaj/kutuphane.jpg")) 

(define FRAME-RATE 12)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define yaradılış
  (evren background
  (nesne ( circle 30 "solid" "red")(v 30 60 ) ( v 30 -33 )( v 0 1))
  (nesne ( square 40 "solid" "green") (v 970 300) ( v -70 -75) ( v 0 1 ))
  (nesne ( triangle 35 "solid" "yellow") (v 350 550) ( v 5 -18 ) (v 0 1 ))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   

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

