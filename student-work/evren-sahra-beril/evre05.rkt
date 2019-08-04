#lang racket
(require "teachpacks/evren-teachpack.rkt")
;; STRUCT v - vektör
;; x : sayı - x koordinatı
;; y : sayı - y koordinatı

( define OYUNCU-imaj ( scale 0.50( bitmap "imaj/ghostbustertrue.PNG")))
( define TEHLİKE-imaj( scale 0.60(bitmap "imaj/billyghost.PNG")))
( define SORU-imaj   ( bitmap "imaj/bubbletrue.PNG"))
( define TEHLİKE-2   ( scale 0.75( bitmap "imaj/aristotle-real.PNG")))
( define TEHLİKE-3   ( scale 0.75( bitmap "imaj/Berilhayalet.PNG")))
( define TEHLİKE-4   ( scale 0.75( bitmap "imaj/Sahrahayalet.PNG")))
( define TEHLİKE-5   ( scale 0.75( bitmap "imaj/ALINESIN-hayalet.PNG")))
( define ODA-1       ( bitmap "imaj/room4.JPG")) 
( define cevap-a1-imaj( scale 0.101( bitmap "imaj/adalovelaceşık.PNG")))
( define cevap-b1-imaj( scale 0.101( bitmap "imaj/billgatesşık.PNG")))
( define cevap-c1-imaj( scale 0.101( bitmap "imaj/aristotleşık.PNG")))

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


( define OYUNCU    ( nesne OYUNCU-imaj ( v -20 270 ) ( v 0 0 ) (v 0 0)))
( define TEHLİKE-1 ( nesne TEHLİKE-imaj ( v 600 200) ( v 0 0 ) ( v 0 0 )))
( define SORU      ( nesne SORU-imaj ( v 300 150 ) ( v 0 0 ) ( v 0 0 )))
( define Cevap-a1  ( nesne cevap-a1-imaj ( v 175 330 ) ( v 0 0 ) ( v 0 0 )))
( define Cevap-b1  ( nesne cevap-b1-imaj ( v 300 330 ) ( v 0 0 ) ( v 0 0 )))
( define Cevap-c1  ( nesne cevap-c1-imaj ( v 425 330 ) ( v 0 0 ) ( v 0 0 )))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; nesne-fizik-güncelle nesne-->nesne
;; nesneyi bir sonraki haline getirmeli, yer hız ve ivme kullanarak
;; (define ( nesne-fizik-güncelle n)
;;    (nesne
;;          .... ( nesne-imaj n)
;;          .... ( nesne-yer  n)
;;          .... ( nesne-hız  n)
;;          .... ( nesne-ivme n)
( ÖRNEK (nesne-fizik-güncelle (nesne ( circle 10 "solid" "red") ( v 50 50 ) ( v 2 0 ) ( v 0 0 ) ))
        (nesne ( circle 10 "solid" "red" ) ( v 52 50 ) ( v 2 0 ) ( v 0 0 ) ) ) 
(define ( nesne-fizik-güncelle n)
  (nesne ( nesne-imaj n )
         ( v+ (nesne-yer n) (nesne-hız  n))
         ( v+ (nesne-hız n) (nesne-ivme n))
         (nesne-ivme n)))
  
 
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
        




;; STRUCT evren
;; arkaplanı : görüntü - oyun arka planı
;;
(STRUCT evren (background oyuncu tehlike1 soru cevapa1 cevapb1 cevapc1 ) )
(ÖRNEK
 ( evren-çiz ( evren background
                     (nesne (circle 10 "solid" "red" )( v 50 50 ) ( v 0 0 ) ( v 0 0 ))
                     (nesne (square 20 "solid" "green") ( v 100 150 ) ( v 0 0 ) ( v 0 0))
                     (nesne (triangle 30 "solid" "yellow") ( v 200 300 ) ( v 0 0 ) ( v 0 0 ))))
             ( nesne-çiz( nesne (circle 10 "solid" "red" )( v 50 50 ) ( v 0 0 ) ( v 0 0 ))
                        ( nesne-çiz( nesne (square 20 "solid" "green") ( v 100 150 ) ( v 0 0 ) ( v 0 0))
                                   ( nesne-çiz(nesne (triangle 30 "solid" "yellow") ( v 200 300 ) ( v 0 0 ) ( v 0 0 )) background)) )) 
                        
            
(define (evren-çiz e)
 (place-text/v (v 300 150 ) "Ilk kodlama dilini kim yarattı?" 20 "black" ( nesne-çiz (evren-oyuncu e)
  ( nesne-çiz ( evren-tehlike1 e)
              ( nesne-çiz ( evren-soru e)
                          (nesne-çiz ( evren-cevapa1 e )
                                     (nesne-çiz  ( evren-cevapb1 e)
                                                 (nesne-çiz ( evren-cevapc1 e )
  (evren-background e)))) ))))) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

          
                                    
   
             


; evren-güncelle evren-->evren
; amaç : evrenin bir frame sonraki değerini vermek
(ÖRNEK
  (evren-güncelle yaradılış)
                  (evren background OYUNCU TEHLİKE-1 SORU Cevap-a1 Cevap-b1 Cevap-c1 ))
  (define (evren-güncelle e)
  (evren (evren-background e)
  ( nesne-fizik-güncelle (evren-oyuncu e))
  ( nesne-fizik-güncelle (evren-tehlike1 e)
  ( nesne-fizik-güncelle (evren-soru e))
  ( nesne-fizik-güncelle (evren-cevapa1 e))
  ( nesne-fizik-güncelle (evren-cevapb1 e))
  ( nesne-fizik-güncelle (evren-cevapc1 e)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  

(define (evren-tuş e t)
  e)

(define (evren-fare e x y m)
  e)


(define background ODA-1) 

(define FRAME-RATE 12)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                               
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define yaradılış
  (evren background OYUNCU TEHLİKE-1 SORU Cevap-a1 Cevap-b1 Cevap-c1)) 

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


                                           

         


