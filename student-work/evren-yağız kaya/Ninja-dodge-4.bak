#lang racket
(require "teachpacks/evren-teachpack.rkt")

;; STRUCT v - vektör
;; x : sayı - x koordinatı
;; y : sayı - y koordinatı
(STRUCT v (x y))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;define: görüntü 


(define BACKGROUND (bitmap "imaj/arkaplan.png")) 

(define oyuncu-yüksekliği (image-height (scale 0.4 (bitmap "imaj/pufi.png"))))

(define nesne-yüksekliği (image-height (triangle 50 "solid" "red")))


;karakterin konumu:

  




















(define göz (scale 0.5(bitmap "imaj/göz.png")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; v+ - vektör toplama
;; 
;;

       
(define (v+ v1 v2)
  (v (+ (v-x v1) (v-x v2)) (+ (v-y v1) (v-y v2))))

;; v- - vektör çıkartma

(define (v- v1 v2)
  (v (- (v-x v1) (v-x v2)) (- (v-y v1) (v-y v2))))



;; v* - vektör sayıyla çarpma
;; 
;;
(ÖRNEK (v* (v 2 -3) 4) (v 8 -12))
(ÖRNEK (v* (v 7 13) 0) (v 0 0))

(define (v* vk s)
  (v
      (* (v-x vk) s)
      (* (v-y vk) s)))
         
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

;;v-unit vektör aynı yöne unit vektörüne çevirmek
;(ÖRNEK (v-unit (v 3 4)) (v 0.6 0.8)) 
(define (v-unit v) (v* v (max 0.0001 (/ 1 (v-mag v)))))

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
;
(ÖRNEK (place-image/v  test-circle (v 5 5) test-square)
       (place-image/align test-circle 5 5 "center" "center" test-square))
(ÖRNEK (place-image/v test-circle (v 3 8) test-square)
       (place-image/align test-circle 3 8 "center" "center" test-square))
(ÖRNEK (place-image/v test-circle (v 1 2) test-square)
       (place-image/align test-circle 1 2 "center" "center" test-square))
(ÖRNEK (place-image/v test-circle (v 2 8) test-square)
       (place-image/align test-circle 2 8 "center" "center" test-square))
;
(define (place-image/v im v1 sahne)
  (place-image/align im (v-x v1) (v-y v1) "center" "center"  sahne))
;
;; place-line/v v v color görüntü -> görüntü
;; v1'den v2'e giden bir çizgi arka imajına yerleştir
;(ÖRNEK (place-line/v (v 2 3) (v 5 1) "red" test-square)
;       (add-line test-square 2 3 5 1 "red")) 
;
(define (place-line/v v1 v2 renk arka)
  (add-line arka (v-x v1) (v-y v1) (v-x v2) (v-y v2) renk)) 
;
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

(STRUCT nesne (imaj yer hız ivme))

;; STRUCT evren
;; arkaplanı : görüntü - oyun arka planı
;;
(STRUCT evren (arkaplanı n1 n2 n3 n4 n5 fare-v))

(define  (evren-çiz e)
               (gözler-ekle (evren-n1 e) (evren-fare-v e)
                (nesne-çiz (evren-n1 e)
               (nesne-çiz (evren-n1 e)
               (nesne-çiz (evren-n3 e)
               (nesne-çiz (evren-n4 e)
               (nesne-çiz (evren-n5 e)             
               (place-image/v (circle 0 "solid" "black") (evren-fare-v e)
                          (evren-arkaplanı e)))))))))










(define (nesne-fizik-güncelle n)
         (nesne
          (nesne-imaj n)
          (v+ (nesne-yer n) (nesne-hız n))
          (v+ (nesne-hız n) (nesne-ivme n))
          (nesne-ivme n)))

(define (evren-güncelle e)
  (evren (evren-arkaplanı e)
         (nesne-fizik-güncelle (evren-n1 e))
         (nesne-fizik-güncelle (evren-n2 e))
         (nesne-fizik-güncelle (evren-n3 e))
         (nesne-fizik-güncelle (evren-n4 e))
         (nesne-fizik-güncelle (evren-n5 e))
         (evren-fare-v e)))



;nesne-çiz: nesne görüntü ---> görüntü

(define (nesne-çiz n ap)
       (place-image/v (nesne-imaj n)
     (nesne-yer n) ap))




(ÖRNEK (nesne-çiz
        (nesne (circle 10 "solid" "red") (v 20 20) (v 0 0) (v 0 0))
        (square 100 "solid" "light yellow"))
        (place-image/v (circle 10 "solid" "red") (v 20 20)
                       (square 100 "solid" "light yellow")))
;gözler-ekle: nesne im ---> im
;karakter nesnesi
;mouse v
;dirken imaj
;sözler imaja çiziliyor

(define (gözler-ekle n mv im)
  (let
      ((göz-merkezi-1 (v+ (nesne-yer n)
                          (v 0 -18)))
       (göz-merkezi-2 (v+ (nesne-yer n)
                          (v +11 -18)))
       (gb-mesafesi 3))
    (göz-bebek-çiz göz-merkezi-1 gb-mesafesi mv
                   (göz-bebek-çiz göz-merkezi-2 gb-mesafesi mv im))))

(define (göz-bebek-çiz gm gbm mv im)
  (place-image/v göz
                 (göz-bebek-vektörü gm mv gbm) im))

;; göz-bebek-vektörü v v sayı
;; gözbebeğin yerin belirle
;; gözmerkezi, mouse vektörü ve göz bebk nesafesinden
;(ÖRNEK (göz-bebek-vektörü (v 10 10) (v 40 50) 5) (v 13 14))

(define (göz-bebek-vektörü gm mv gbm)
  (v+ (v* (v-unit (v- mv gm)) gbm) gm))
                     





;nesne-fizik-güncelle: nesne ---> nesne

 

;evren: v ---> v


      


;evren-güncelle: evren ---> evren


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;oyuncu-güncelle: x y yön --->










;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (alt-güvenli? y) (> y (- 0 (/ nesne-yüksekliği 2))))
(define (üst-güvenli? y) (< y (+ 480 (/ nesne-yüksekliği 2))))






(define (ekranda-mı? x y) (and (alt-güvenli? x) (üst-güvenli? x)))



(define (evren-tuş e t)
  e)


(define (göz-bebeği-vektörü göz-merkez-vektörü mouse-vektörü gb-mesafe)

  (v+ (v* (v-unit (v- göz-merkez-vektörü mouse-vektörü)) gb-mesafe) göz-merkez-vektörü))



(define (evren-fare e x y m)
  (evren
   (evren-arkaplanı e)
   (evren-n1 e)
   (evren-n2 e)
   (evren-n3 e)
   (evren-n4 e)
   (evren-n5 e)
   (v x y)))
 

(define OYUNCU (nesne (scale 0.4 (bitmap "imaj/pufi.png")) 
  (v 3 4) (v 0 0) (v 0 0)))
  
(define TEHLİKE-1 (nesne (triangle 100 "solid" "red") (v 254 -300) (v -20 -25) (v 0 0)))
(define TEHLİKE-2 (nesne (triangle 100 "solid" "red") (v 40 -550) (v 5 -18) (v 0 0)))
(define TEHLİKE-3 (nesne (triangle 100 "solid" "red") (v 0 240) (v 5 20) (v 0 0)))
(define TEHLİKE-4 (nesne (triangle 100 "solid" "red") (v 320 240) (v 5 20) (v 0 0)))


(define nesne-genişliği (image-width (triangle 100 "solid" "red")))



  (define FRAME-RATE 120)

(define yaradılış (evren BACKGROUND
                 (nesne (scale 0.4 (bitmap "imaj/pufi.png")) (v 320 240) (v 0 0) (v 0 0))
                 (nesne (triangle 50 "solid" "red") (v  (random 1 640) 10) (v 0 10) (v 0 0))
                 (nesne (triangle 50 "solid" "red") (v  (random 1 640) 10) (v 0 8) (v 0 0))
                 (nesne (triangle 50 "solid" "red") (v  (random 1 640) 10) (v 0 4) (v 0 0))
                 (nesne (triangle 50 "solid" "red") (v  (random 1 640) 10) (v 0 6) (v 0 0))
                 (v 0 0)))


(define (n2-güncelle n)
  (nesne (nesne-imaj
          (cond
            [(> (v-y (nesne-yer n))) 480 (v (random 1 640) 10)]
            (else (nesne-yer n)))
          (nesne-hız n) (nesne-ivme n))))






;; SES herhangbirşey ses-dosyası-metin -> herhangibirşey
;; birinci paramatresini aynen dönsürüyor, sesi çalarak
(ÖRNEK (SES 0 "ses/goblin-army.mp3") 0)

(test)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sabit kod bundan sonra                               ;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(yut (big-bang yaradılış
  (on-tick evren-güncelle (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)
  (on-mouse evren-fare)))






 
                          
                         
