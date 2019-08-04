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

;; v- - vektör çıkartma
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)

;; v* - vektör sayıyla çarpma
;; 
;;
(ÖRNEK (v* (v 2 -3) 4) (v 8 -12))
(ÖRNEK (v* (v 7 13) 0) (v 0 0))

(define (v* vk s)
  (v
      (* s (v-x vk))
      (* s (v-y vk))))
         
;; v. - vektör dot çarpma
;; 
;; vektor dot çarpma: v v ---> sayı 

(ÖRNEK (v. (v 3 4) (v 3 4)) (+ (* 3 3) (* 4 4)))
(ÖRNEK (v. (v 4 5) (v 4 5)) (+ (* 4 4) (* 5 5)))

(define (v. v1 v2) (+ (* (v-x v1) (v-x v2)) (* (v-y v1) (v-y v2))))

;; v-mag - vektör uzunluğu
;; 
;;
(ÖRNEK (v-mag (v 6 8)) (sqrt (+ (sqr 6) (sqr 8))))
(ÖRNEK (v-mag (v 3 4)) (sqrt (+ (sqr 3) (sqr 4))))

(define (v-mag v1) (sqrt (+ (sqr (v-x v1)) (sqr (v-y v1)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hediye vektör çizim fonksiyonları
;; Vektör STRUCT tanıttıktan sonra bu fonkisyonları uncomment edebilirsiniz
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;place-image/v
;; resim v sahne -> sahne
;; bir sahneye vectöre göre bir imaj yerleştir
;; template :
;; (define (place-image/v im v1 sahne)
;;  (... im ... (v-x v1) ... (v-y v1) ...)
;(define test-circle (circle 10 "solid" "purple"))
;(define test-square (square 100 "solid" "green"))
;
;(ÖRNEK (place-image/v  test-circle (v 5 5) test-square)
;       (place-image/align test-circle 5 5 "center" "center" test-square))
;(ÖRNEK (place-image/v test-circle (v 3 8) test-square)
;       (place-image/align test-circle 3 8 "center" "center" test-square))
;(ÖRNEK (place-image/v test-circle (v 1 2) test-square)
;       (place-image/align test-circle 1 2 "center" "center" test-square))
;(ÖRNEK (place-image/v test-circle (v 2 8) test-square)
;       (place-image/align test-circle 2 8 "center" "center" test-square))
;
;(define (place-image/v im v1 sahne)
;  (place-image/align im (v-x v1) (v-y v1) "center" "center"  sahne))
;
;; place-line/v v v color görüntü -> görüntü
;; v1'den v2'e giden bir çizgi arka imajına yerleştir
;(ÖRNEK (place-line/v (v 2 3) (v 5 1) "red" test-square)
;       (add-line test-square 2 3 5 1 "red")) 
;
;(define (place-line/v v1 v2 renk arka)
;  (add-line arka (v-x v1) (v-y v1) (v-x v2) (v-y v2) renk)) 
;
;; place-text/v v metin sayı color görüntü -> görüntü
;; v pozisyonda  verilen metni arka imajına yerleştir
;(ÖRNEK (place-text/v (v 20 30) "Hello" 15 "red" test-square)
;       (place-image/v (text "Hello" 15 "red") (v 20 30) test-square))
;(define (place-text/v v metin size col arka)
;  (place-image/v (text metin size col) v arka))


; STRUCT nesne
;; imaj : görüntü - nesneini imajı
;; yer : v - nesnenin ekrandaki yeri
;; hız : v - nesnenin hızı
;; ivme : v - nesnenin ivmesi



;; STRUCT evren
;; arkaplanı : görüntü - oyun arka planı
;;
(STRUCT evren (arkaplanı))

(define (evren-güncelle e)
  e)

(define (evren-çiz e)
  (evren-arkaplanı e))

(define (evren-tuş e t)
  e)

(define (evren-fare e x y m)
  e)


(define BACKGROUND (bitmap "imaj/kutuphane.jpg")) 

(define FRAME-RATE 12)

(define yaradılış (evren BACKGROUND))

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

