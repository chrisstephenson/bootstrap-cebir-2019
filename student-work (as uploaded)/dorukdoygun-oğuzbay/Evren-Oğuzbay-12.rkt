#lang racket
(require "teachpacks/evren-teachpack.rkt")






;; STRUCT v - vektör
;; x : sayı - x koordinatı
;; y : sayı - y koordinatı
(STRUCT v  (x y))
;; v+ - vektör toplama

(ÖRNEK (v+ (v 2 3) (v 2 4)) (v 4 7))
(ÖRNEK (v+ (v 6 8) (v 3 6)) (v 9 14))
(define (v+ v1 v2)
  (v
   (+ ( v-x v1) ( v-x v2))
   (+ ( v-y v1) ( v-y v2))))
;; v- - vektör çıkartma
(ÖRNEK (v- (v 4 6) (v 1 2)) (v 3 4))
(ÖRNEK (v- (v 8 9) (v 1 2)) (v 7 7))
(define (v- v1 v2)
  (v
   (- ( v-x v1) ( v-x v2))
   (- ( v-y v1) ( v-y v2))))

;; v* - vektör sayıyla çarpma
(ÖRNEK (v* (v 2 -3) 4) (v 8 -12))
(ÖRNEK (v* (v 7 13 ) 0) (v 0 0))
 (define (v* v1 x)
   (v
   (* (v-x v1)  x)
   (* (v-y v1)  x)))

;; v. - vektör dot çarpma
(ÖRNEK (v. (v 2 4) (v 5 6)) 34)
(ÖRNEK (v. (v 5 8) (v 8 9)) 112)
(define (v. v1 v2) 
   (+ (* (v-x v1) (v-x v2)) (* (v-y v1) (v-y v2))))


;; v-mag - vektör uzunluğu
;; v-mag: v -> sayı
(ÖRNEK (v-mag   (v 3 4) )(sqrt 25))
(ÖRNEK (v-mag (v 5 12) )(sqrt 169))
(define (v-mag v)
  (sqrt (+ (sqr (v-x v)) (sqr (v-y v)))))



;nesne-çiz nesne görüntü -> görüntü
;nesneyi verilen arkaplanına çizmek



;(define ateş (rectangle 50 5 "solid" "red"))
(define  ateş-adım 50)
(ÖRNEK ( ateş-güncelle 80) (+ 80 50))
(ÖRNEK ( ateş-güncelle 100) (+ 100 50))
(define ( ateş-güncelle x) (+ x 50))




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


 (STRUCT nesne (imaj yer hız ivme))
; imaj : görüntü - nesnenin imajı
; yer : v - nesnenin ekrandaki yeri
; hız : v - nesnenin hızı
; ivme : v - nesnenin ivmesi


;(define BACKGROUND (bitmap "imaj/arkaplan.jpg"))
(define oyuncu  (nesne (scale 0.2 (bitmap "imaj/oyuncuson.png")) (v 30 600) (v 0 0) (v 0 0)))
(define düşman1 (nesne (scale 0.5 (bitmap "imaj/duşmanbüyükson.png")) (v 970 300) (v 0 0) (v 0 0)))
(define düşman2 (nesne (scale 0.05 (bitmap "imaj/düşmanküçükson.png")) (v 350 550) (v 0 0) (v 0 0)))
(define ateş (nesne (rectangle 50 5 "solid" "red") (v 80 600) (v 0 0) (v 0 0)))


(define (nesne-çiz n ap)
  (place-image/v (nesne-imaj n)
  (nesne-yer n)ap))
    
;nesne-fizik-güncelle nesne -> nesne
;nesneyi bit sonraki haline getirmek için yer hız ivme kullanacak
(ÖRNEK (nesne-fizik-güncelle (nesne (circle 10 "solid" "red") (v 50 50) (v 2 3) (v 4 5)))
       (nesne (circle 10 "solid" "red") (v 52 53) (v 6 8) (v 4 5)))


(define (nesne-fizik-güncelle n)
  (nesne
       (nesne-imaj n)
      (v+ (nesne-yer n) (nesne-hız n))
       (v+ (nesne-hız n) (nesne-ivme n))
       (nesne-ivme n)))
    







 ;STRUCT evren
; arkaplanı : görüntü - oyun arka planı
;
(define BACKGROUND (bitmap "imaj/arkaplan.jpg"))
(STRUCT evren (bg n1 n2 n3 n4))

;; evren-çiz evren -> görüntü
;; evreni çiziyor

(ÖRNEK
 (evren-çiz (evren BACKGROUND
                    oyuncu
                                 
                    düşman1
                                 
                    düşman2
                                 
                    ateş)) 
                   (nesne-çiz  oyuncu
                                 
                   (nesne-çiz  düşman1
                                 
                   (nesne-çiz  düşman2
                                 
                   (nesne-çiz  ateş  BACKGROUND)))))

(define (evren-çiz e) (nesne-çiz (evren-n1 e) (nesne-çiz (evren-n2 e) (nesne-çiz (evren-n3 e) (nesne-çiz (evren-n4 e) (evren-bg e))))))

 (define yaradılış
   (evren BACKGROUND
          oyuncu
          düşman1 
          düşman2
          ateş ))

;; evren-güncelle evren -> evren
;; evrenin bir frame sonraki değerini vermek

(ÖRNEK
 (evren-güncelle yaradılış)
 (evren BACKGROUND
         oyuncu
         düşman1 
         düşman2
         ateş ))

(define (evren-güncelle e)
  (evren (evren-bg e)
         (nesne-fizik-güncelle (evren-n1 e))
         (nesne-fizik-güncelle (evren-n2 e))
         (nesne-fizik-güncelle (evren-n3 e))
         (nesne-fizik-güncelle (evren-n4 e))))


(define tuş-adım-boyutu 50)
(ÖRNEK (oyuncu-güncelle 320 "up") (+ 320 tuş-adım-boyutu))
(ÖRNEK (oyuncu-güncelle 100 "down") (- 100 tuş-adım-boyutu))
(ÖRNEK (oyuncu-güncelle 200 "up") (+ 200 tuş-adım-boyutu))
(ÖRNEK (oyuncu-güncelle 300 "down") (- 300 tuş-adım-boyutu))


(define arkaplan-boyu 768)
(define oyuncu-boyu 100)
(define (oyuncu-güncelle konum yön)
  (cond
    [(string=? yön "up")
     (cond
       [(< (+ konum (/ oyuncu-boyu 2)) arkaplan-boyu ) (+ konum tuş-adım-boyutu)]
       [else konum])]
    [(string=? yön "down")
     (cond
       [(> (- konum (/ oyuncu-boyu 2)) 0 ) (- konum tuş-adım-boyutu)]
       [else konum])]
    [else konum]))










;;(define (evren-güncelle e)e)
  


  

(define (evren-tuş e t)
  e)

(define (evren-fare e x y m)
  e)


 

(define FRAME-RATE 12)

;(define yaradılış (evren BACKGROUND))

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

