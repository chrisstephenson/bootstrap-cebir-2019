#lang racket
(require "teachpacks/evren-teachpack.rkt")
;; STRUCT v - vektör
;; x : sayı - x koordinatı
;; y : sayı - y koordinatı

(STRUCT v (x y))

;; v+ - vektör toplama
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)
(define (v+ v1 v2)
  (v
   (+ (v-x v1) (v-x v2))
   (+ (v-y v1) (v-y v2))))
;; v- - vektör çıkartma
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)
(define (v- v1 v2)
  (v
   (- (v-x v1) (v-x v2))
   (- (v-y v1) (v-y v2))))
;; v* - vektör sayıyla çarpma
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)


;vektörle bir sayıyı çarpmak
(define (v* s vk)
  (v
   (* s (v-x vk))
   (* s (v-y vk))))

(ÖRNEK (v* 4 (v 2 -3)) (v 8 -12))

(ÖRNEK (v* 0 (v 7 13)) (v 0 0))

;; v. - vektör dot çarpma
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)

; (+ (* x1 x2) (* y1 y2))

(define (v. v1 v2)
   (+ (* (v-x v1) (v-x v2)) (* (v-y v1) (v-y v2))))

;; v-mag - vektör uzunluğu
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)

(define (v-mag v1) (+ (sqrt (sqr (v-x v1)) (sqr (v-y v1)))))

;STRUCT
;nesne
;imaj: görüntü
;yer: v
;hız: v
;ivme: v

(STRUCT nesne (imaj yer hız ivme))

;nesne-çiz nesne görüntü => görüntü

(ÖRNEK (nesne-çiz (nesne (circle 10 "solid" "red")
                         (v 50 50) (v 0 0) (v 0 0))
                  (square 100 "solid" "yellow"))
       (place-image/v (circle 10 "solid" "red") (v 50 50)
                      (square 100 "solid" "yellow")))

(define (nesne-çiz n ap)
 (place-image/v (nesne-imaj n)
  (nesne-yer n) ap))

;nesne-fizik-gücelle nesne => nesne

;nesneyi bir sonraki haline getirmeli yer, hız ve ivme kullanarak

(ÖRNEK (nesne-fizik-güncelle
        (nesne (circle 10 "solid" "red") (v 50 50) (v 2 3) (v 4 5)))
        (nesne (circle 10 "solid" "red") (v 52 53) (v 6 8) (v 4 5)))

(define (nesne-fizik-güncelle n)
  (nesne
   (nesne-imaj n)
   (v+ (nesne-yer n) (nesne-hız n))
   (v+ (nesne-hız n) (nesne-ivme n))
   (nesne-ivme n)))

;STRUCT
;evren
;bg:görüntü
;n1:nesne
;n2:nesne
;n3:nesne

(STRUCT evren (bg n1 n2 n3))

;evren-çiz evren => görüntü
;evreni çiziyor

(ÖRNEK (evren-çiz (evren BACKGROUND
        (nesne (circle 10 "solid" "red") (v 50 50) (v 0 0) (v 0 0))
        (nesne (square 20 "solid" "green") (v 100 150) (v 0 0) (v 0 0))
        (nesne (triangle 30 "solid" "yellow") (v 200 300) (v 0 0) (v 0 0))))
(nesne-çiz (nesne (circle 10 "solid" "red") (v 50 50) (v 0 0) (v 0 0))
           (nesne-çiz (nesne (square 20 "solid" "green") (v 100 150) (v 0 0) (v 0 0))
                      (nesne-çiz (nesne (triangle 30 "solid" "yellow") (v 200 300) (v 0 0) (v 0 0)) BACKGROUND))))

(define(evren-çiz e) (nesne-çiz (evren-n1 e)
                                (nesne-çiz (evren-n2 e)
                                           (nesne-çiz (evren-n3 e) (evren-bg e)))))
               
;evren-güncelle evren => evren
;amaç => evrenin bir frame sonraki değerini vermek

(ÖRNEK (evren-güncelle yaradılış)
       (evren BACKGROUND
              (nesne (circle 30 "solid" "red") (v 60 567) (v 30 -32) (v 0 1))
              (nesne (square 40 "solid" "green") (v 950 275) (v -20 -24) (v 0 1))
              (nesne (triangle 35 "solid" "yellow") (v 355 522) (v 5 -27) (v 0 1))))

(define (evren-güncelle e)
  (evren (evren-bg e)
         (nesne-fizik-güncelle (evren-n1 e))
         (nesne-fizik-güncelle (evren-n2 e))
         (nesne-fizik-güncelle (evren-n3 e))))

        
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


; STRUCT nesne
;; imaj : görüntü - nesneini imajı
;; yer : v - nesnenin ekrandaki yeri
;; hız : v - nesnenin hızı
;; ivme : v - nesnenin ivmesi



;; STRUCT evren
;; arkaplanı : görüntü - oyun arka planı
;;



(define (evren-tuş e t)
  e)

(define (evren-fare e x y m)
  e)


(define BACKGROUND (bitmap "imaj/kutuphane.jpg")) 

(define FRAME-RATE 12)


(define yaradılış
  (evren BACKGROUND
         (nesne (circle 30 "solid" "red") (v 30 600) (v 30 -33) (v 0 1))
         (nesne (square 40 "solid" "green") (v 970 300) (v -20 -25) (v 0 1))
         (nesne (triangle 35 "solid" "yellow") (v 350 550) (v 5 -28) (v 0 1))))

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

