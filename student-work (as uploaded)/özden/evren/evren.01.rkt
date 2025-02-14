#lang racket
(require "teachpacks/evren-teachpack.rkt")

;; STRUCT v - vektör
;; x : sayı - x koordinatı
;; y : sayı - y koordinatı
(STRUCT v (x y))

;; v+ - vektör toplama
;; 

(define (v+ v1 v2)
  (v (+ (v-x v1)(v-x v2))(+ (v-y v1)(v-y v2))))

;; v- - vektör çıkartma

(define (v- v1 v2)
  (v (- (v-x v1)(v-x v2))(- (v-y v1)(v-y v2))))

;; v* - vektör sayıyla çarpma
;; sayı v -> v 
;;


(ÖRNEK (v* (v 2 -3) 4)(v 8 -12))
(ÖRNEK (v* (v 7 13) 0)(v 0 0))

(define (v* vk s)
  (v
   (* s (v-x vk))
   (* s (v-y vk))))



;; v. - vektör dot çarpma
;; v v -> sayı
;;(define (v. (x1 y1).(x2 y2) = x1 * x2 + y1 * y2 ))

(ÖRNEK (v. (v 4 2)(v 5 3)) 26)
(define (v. v1 v2 )
  (+ (* (v-x v1)(v-x v2))
     (* (v-y v1)(v-y v2))))

;; v-mag - vektör uzunluğu
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)


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



;nesne-çiz : nesne görüntü -> görüntü
;nesneyi verilen arkaplana çizmek
(STRUCT nesne (imaj yer hız ivme))

(ÖRNEK (nesne-çiz (nesne (circle 10 "solid" "red")
                         (v 50 50) (v 0 0) (v 0 0))
                         (square 100 "solid" "yellow"))
(place-image/v (circle 10 "solid" "red") (v 50 50)
              (square 100 "solid" "yellow")))

(define (nesne-çiz n ap)
 (place-image/v (nesne-imaj n)
   (nesne-yer n) ap))





; STRUCT nesne
;; imaj : görüntü - nesneini imajı
;; yer : v - nesnenin ekrandaki yeri
;; hız : v - nesnenin hızı
;; ivme : v - nesnenin ivmesi


;STRUCT
;evren
;bg : görüntü- evren arkaplanı
;n1 : nesne
;n2 : nesne
;n3 : nesne
;; STRUCT evren
;; arkaplanı : görüntü - oyun arka planı
;;
(STRUCT evren (score arkaplanı n1 n2 n3))
;evren-çiz : evren -> görüntü
;evreni çiziyor

(ÖRNEK (evren-çiz (evren 0 BACKGROUND
       (nesne (circle 10 "solid" "red")(v 50 50)(v 0 0)(v 0 0))
       (nesne (square 20 "solid" "green")(v 100 150)(v 0 0)(v 0 0))
       (nesne (triangle 30 "solid" "yellow")(v 200 500)(v 0 0)(v 0 0))))
(nesne-çiz (nesne (circle 10 "solid" "red")(v 50 50)(v 0 0)(v 0 0))
           (nesne-çiz (nesne (square 20 "solid" "green")(v 100 150)(v 0 0)(v 0 0))
                      (nesne-çiz (nesne (triangle 30 "solid" "yellow")(v 200 500)(v 0 0)(v 0 0)) BACKGROUND ))))


(define (evren-çiz e) 
  (nesne-çiz (evren-n1 e)
            (nesne-çiz (evren-n2 e)
                         (nesne-çiz (evren-n3 e)(evren-arkaplanı e)))))


;nesne-fizik-güncelle : nesne -> nesne
;nesneyi bir sonraki haline getirmek yer hız ve ime kullanarak

(ÖRNEK (nesne-fizik-güncelle (nesne (circle 10 "solid" "red")(v 50 50)(v 2 3)(v 4 5)))
       (nesne (circle 10 "solid" "red")(v 52 53)(v 6 8)(v 4 5)))

  (define (nesne-fizik-güncelle n)
          (nesne
          (nesne-imaj n)
        (v+ (nesne-yer  n)(nesne-hız  n))
        (v+ (nesne-hız  n)(nesne-ivme n))
          (nesne-ivme n)))


(define (evren-güncelle e) 
  (evren 0 (evren-arkaplanı e)
          (nesne-fizik-güncelle (evren-n1 e))
          (nesne-fizik-güncelle (evren-n2 e))
          (nesne-fizik-güncelle (evren-n3 e))))          




;evren-tuş : evren tuş -> evren 

;(define (evren-tuş e t)
;  (evren 0 BACKGROUND
;       (nesne (bitmap "imaj/oyuncu1.png")
;              (cond
;                [(string=? t "up")
  
(define (oyuncu-güncelle n t)
  (nesne (nesne-imaj n)
         [(cond
            ((string=?
              n))
            (nesne-hız n)
            (nesne-ivme n)))]))


(define (evren-fare e x y m) 
  e)


(define BACKGROUND( scale 6 (bitmap "imaj/arkaplan-001.png")))
(define OYUNCU (bitmap "imaj/oyuncu1.png"))
(define ENEMY1 (bitmap "imaj/bat.png"))
(define ENEMY2 (bitmap "imaj/goblin.png"))





(define FRAME-RATE 12)

(define yaradılış
  (evren  0 BACKGROUND 
  (nesne (bitmap "imaj/oyuncu1.png")(v 30 600)(v 30 -33)(v 0 1))
  (nesne (bitmap "imaj/bat.png")(v 350 550)(v 5 -16)(v 0 1))
  (nesne (bitmap "imaj/goblin.png")(v 100 100)(v 0 0)(v 0 2))))


;; SES herhangbirşey ses-dosyası-metin -> herhangibirşey
;; birinci paramatresini aynen dönsürüyor, sesi çalarak
;;(ÖRNEK (SES 0 "ses/bark.wav ) 0)

(test) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sabit kod bundan sonra                               ;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(yut (big-bang yaradılış
  (on-tick evren-güncelle (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)
  (on-mouse evren-fare)))




