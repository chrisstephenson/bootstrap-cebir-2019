#lang racket
(require "teachpacks/evren-teachpack.rkt")

(STRUCT v (x y))
(STRUCT nesne (imaj yer hız ivme))
; evren imaj imaj nesne nesne nesne nesne sayı sayı görüntü görüntü görüntü
; arkaplanı --> bir imajdır arkaplanı verir
; dünya --> dünya imajını gösterir
; oyuncu --> oyuncu nesnesi
; t1 --> tehlike 1
;t2 --> tehlike 2
; amaç --> alınması gereken nesne
(STRUCT evren( arkaplanı dünya oyuncu  t1 t2 amaç timer-benzin genel-zaman can1 can2 can3 ))

; place-image/v görüntü vektör görüntü
(define (place-image/v im v1 sahne)
  (place-image/align im (v-x v1) (v-y v1) "center" "center"  sahne))

(define BACKGROUND (place-image/v (scale 1.5 (bitmap "imaj/earth1.png")) ( v 495  785 ) (bitmap "imaj/uazy2.jpeg"))) 
(define DÜNYA (bitmap "imaj/earth1.png"))
(define TEHLİKE1 (scale 0.1(bitmap "imaj/meteor1.png")))
(define TEHLİKE2 (scale 0.1(bitmap "imaj/uydu.png")))
(define OYUNCU (scale 0.1 (bitmap "imaj/game-rocket-image.png")))
(define AMAÇ (square 15 "solid" "green"))
(define BENZİN-TİMER 10)
(define GENEL-ZAMAN 20)
(define CAN1 (bitmap "imaj/kalp.png"))
(define CAN2 (bitmap "imaj/kalp.png"))
(define CAN3 (bitmap "imaj/kalp.png"))



;; STRUCT v - vektör
;; x : sayı - x koordinatı
;; y : sayı - y koordinatı

(define(v- vs vk)
  (v
   (- (v-x vs) (v-x vk))
   (- (v-y vs) (v-y vk))))

;; v+ - vektör toplama
(define(v+ vs vk)
  (v
   (+ (v-x vs) (v-x vk))
   (+ (v-y vs) (v-y vk))))

; v* - vektör çarpma  
; sayı vektör --> vektör
(ÖRNEK( v* 3 (v 7 8)) (v 21 24) ) 
(define(v* s vk)
  (v
   (* s (v-x vk))
   (* s (v-y vk)))) 

;; v. - vektör dot çarpma

(define(v. vk vy)
  (+ (* (v-x vk) (v-x vy)) (* (v-y vk) (v-y vy))))

;; v-mag - vektör uzunluğu

(define (v-mag vk)
   (sqrt (+ (sqr (v-x vk)) (sqr(v-y vk)))))


(define test-circle (circle 10 "solid" "purple"))
(define test-square (square 100 "solid" "green"))
;
(ÖRNEK (place-image/v  test-circle (v 5 5) test-square)
       (place-image/align test-circle 5 5 "center" "center" test-square))
(ÖRNEK (place-image/v test-circle (v 3 8) test-square)
       (place-image/align test-circle 3 8 "center" "center" test-square))
(ÖRNEK (place-image/v test-circle (v 1 2) test-square)
       (place-image/align test-circle 1 2 "center" "center" test-square))
(ÖRNEK (place-image/v test-circle (v 2 8) test-square)
       (place-image/align test-circle 2 8 "center" "center" test-square))



;nesne-çiz nesne görüntü --> görüntü
;nesneyi verilen arkaplana çizmek

(define nesneÖrnek (nesne(circle 15 "solid" "red") (v 50 50) (v 0 0) (v 0 0)))
(ÖRNEK(nesne-çiz(nesne(circle 15 "solid" "red") (v 50 50) (v 0 0) (v 0 0)) (square 15 "solid" "green"))
                 (place-image/v (circle 10 "solid" "red") (v 50 50) (square 15 "solid" "green")))

(define(nesne-çiz n ap)
  (place-image/v
   (nesne-imaj n) (nesne-yer n) ap))

;(nesne-çiz (nesne(circle 15 "solid" "red") (v 50 50) (v 0 0) (v 0 0)) (square 15 "solid" "yellow"))

   
;nesne-fizik-güncelle
;nesneyi bir sonraki haline getirmek , yer, hız ve ivme kullanarak
(ÖRNEK (nesne-fizik-güncelle (nesne (circle 10 "solid" "red") (v 50 50) (v 2 3) (v 4 5)))
              (nesne (circle 10 "solid" "red") (v 52 53) (v 6 8) (v 4 5)))

(define( nesne-fizik-güncelle n)
  (nesne
   (nesne-imaj n)
   (v+ (nesne-hız n) (nesne-yer n))
   (v+ (nesne-ivme n) (nesne-hız n))
   (nesne-ivme n)))


;;place-image/v
;; resim v sahne -> sahne
;; bir sahneye vectöre göre bir imaj yerleştir
;; template :
;; (define (place-image/v im v1 sahne)
;;  (... im ... (v-x v1) ... (v-y v1) ...)


; place-line/v v v color görüntü -> görüntü
; v1'den v2'e giden bir çizgi arka imajına yerleştir
(ÖRNEK (place-line/v (v 2 3) (v 5 1) "red" test-square)
       (add-line test-square 2 3 5 1 "red")) 

(define (place-line/v v1 v2 renk arka)
  (add-line arka (v-x v1) (v-y v1) (v-x v2) (v-y v2) renk)) 

;; place-text/v v metin sayı color görüntü -> görüntü
;; v pozisyonda  verilen metni arka imajına yerleştir

(ÖRNEK (place-text/v (v 20 30) "Hello" 15 "red" test-square)
       (place-image/v (text "Hello" 15 "red") (v 20 30) test-square))

(define (place-text/v v metin size col arka)
  (place-image/v (text metin size col) v arka))


; STRUCT nesne
;; imaj : görüntü - nesneini imajı
;; yer : v - nesnenin ekrandaki yeri
;; hız : v - nesnenin hızı
;; ivme : v - nesnenin ivmesi



;; STRUCT evren
;; arkaplanı : görüntü - oyun arka planı
;;
; evren-çiz evren --> görüntü
; evreni çiziyor
; Struct
; evren
; bg: görüntü evren arkaplanı
; n1 nesne
;n2 nesne
;n3 nesne

(ÖRNEK (evren-çiz
        (evren BACKGROUND
        (nesne (circle 10 "solid" "red") (v 50 50) (v 0 0) (v 0 0))
         (nesne (circle 20 "solid" "green") (v 50 50) (v 0 0) (v 0 0))
         (nesne (circle 30 "solid" "yellow") (v 50 50) (v 0 0) (v 0 0))))
     (nesne-çiz (nesne (circle 10 "solid" "red") (v 50 50) (v 0 0) (v 0 0) ) 
     (nesne-çiz (nesne (circle 20 "solid" "green") (v 50 50) (v 0 0) (v 0 0))
     (nesne-çiz (nesne (circle 30 "solid" "yellow") (v 50 50) (v 0 0) (v 0 0)) BACKGROUND))))

;evren-çiz evren --> görüntü

;(define(evren-çiz e)
 ; (nesne-çiz (evren-n1 e)
  ;           (nesne-çiz (evren-n2 e)
   ;                     (nesne-çiz (evren-n3 e) BACKGROUND))))

(define(evren-çiz e)
  (place-image/v (evren-can3 e) (v 205 65) (place-image/v (evren-can2 e) (v 120 65) (place-image/v (evren-can1 e) (v 35 65) (place-text/v (v 915 65) "Timer" 50 "white" (nesne-çiz (evren-oyuncu e)
             (nesne-çiz (evren-t1 e)
                        (nesne-çiz (evren-t2 e)
                                   (nesne-çiz (evren-amaç e)  BACKGROUND)))))))))


(define yaradılış
  (evren BACKGROUND
         DÜNYA
         (nesne (rotate -90 OYUNCU) (v (/ (image-width BACKGROUND) 2) (/ (image-height BACKGROUND) 2)) (v 0 0) (v 0 0))
         (nesne TEHLİKE1 (v 920 540) (v -17 -18) (v 0 1))
         (nesne TEHLİKE2 (v 920 500) (v -17 -18) (v 0 1))
         (nesne AMAÇ (v 950 520) (v -17 -18) (v 0 1))
         10 20 CAN1 CAN2 CAN3))

; evren-güncelle evren --> evren
; amaç --> evrenin bir frame sonraki durumunu vermek
;(ÖRNEK (evren-güncelle yaradılış)

       ;(evren BACKGROUND
        ;      (nesne(circle 30 "solid" "red") (v (/ (image-width BACKGROUND) 2) 167) (v 30 -6) (v 0 1))
         ;     (nesne(square 40 "solid" "green") (v 950 275) (v -20 -24) (v 0 1))
          ;    (nesne(triangle 35 "solid" "yellow") (v 355 532) (v 5 -17) (v 0 1))))


;(define (evren-dur e)
 ; (cond
  ;  ((> (v-y (nesne-yer (evren-n1 e))) (- EKRANYÜKSEKLİĞİ 50)) (evren (evren-arkaplanı e)
   ;                                               (nesne (nesne-imaj (evren-n1 e))
    ;                                                     (nesne-yer (evren-n1 e)) 
     ;                                                    (v 0 -24)
      ;                                                   (v 0 0))
       ;                                           (nesne-fizik-güncelle  (evren-n2 e))
        ;                                          (nesne-fizik-güncelle  (evren-n3 e))))
    
   ; (else (evren (evren-arkaplanı e)
    ;             (nesne-fizik-güncelle  (evren-n1 e))                           
     ;            (nesne-fizik-güncelle  (evren-n2 e))
      ;           (nesne-fizik-güncelle  (evren-n3 e))))))


(define (evren-güncelle e)
  (evren (evren-arkaplanı e)
         (evren-dünya e)
  (evren-oyuncu e)
  (nesne-fizik-güncelle  (evren-t1 e))                           
  (nesne-fizik-güncelle  (evren-t2 e))
  (nesne-fizik-güncelle  (evren-amaç e)) BENZİN-TİMER GENEL-ZAMAN CAN1 CAN2 CAN3))

(define (evren-tuş e t)
  (evren (evren-arkaplanı e)
         (evren-dünya e)
  (oyuncu-güncelle (evren-oyuncu e) t)
  (nesne-fizik-güncelle  (evren-t1 e))                           
  (nesne-fizik-güncelle  (evren-t2 e))
  (nesne-fizik-güncelle  (evren-amaç e)) BENZİN-TİMER GENEL-ZAMAN CAN1 CAN2 CAN3))

(define (evren-fare e x y m)
  e)

(define (oyuncu-güncelle n yön)
  (nesne (nesne-imaj n)
         (v ( v-x (nesne-yer n))
            (cond
    [ (string=? yön "up" ) (- (v-y (nesne-yer n )) 10)]
    [ (string=? yön "down") (+ (v-y (nesne-yer n )) )]
    (else (v-y (nesne-yer n )))))
         (nesne-hız n)
         (nesne-ivme n)))


         

             

(define FRAME-RATE 12)



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

