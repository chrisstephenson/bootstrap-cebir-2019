#lang racket
(require "teachpacks/evren-teachpack.rkt")
;; STRUCT v - vektör
;; x : sayı - x koordinatı
;; y : sayı - y koordinatı
;SÖZLEŞME: V x y
;ŞEKİL: (STRUCT V (x y))
(STRUCT v (x y))
(define vektör-örnek-1 (v 10 10))
(define vektör-örnek-2 (v 20 20))
(define vektör-örnek-3 (v 12 5))
(define vektör-örnek-4 (v 200 100) )
(define BACKGROUND (bitmap "Teachpacks/teachpack-images/arkaplan-1.png"))
(STRUCT nesne (imaj yer hız ivme))
(STRUCT evren (bg n1 n2 n3))
(define nesne-1 (nesne (circle 10 "solid" "red") (v 50 50) (v  0 0) (v 0 0)))
;STRUCT anim
;devamlı = boolean
;değişim sıklığı = sayı
;şimdiki zaman = sayı
;resimler = görüntü-list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;DİNAZOR
(define konum-dinazor (v 350 200))
(define hız-dinazor (v 5 5))
(define ivme-dinazor (v 0.1 0.1))
(define nesne-dinazor (nesne (bitmap "Teachpacks/teachpack-images/tyranosaur/tyranosaurstanding/tyranosaurstanding.png")
                             konum-dinazor
                             hız-dinazor
                             ivme-dinazor ) )


;CAVEMAN
(define konum-caveman (v 250 200))
(define hız-caveman (v 5 5))
(define ivme-caveman (v 0.1 0.1))
(define nesne-caveman (nesne (bitmap "Teachpacks/teachpack-images/caveman/cavemanstanding/cavemanstanding_1.png")
                             konum-caveman
                             hız-caveman
                             ivme-caveman ) )
;HEDEF
(define konum-hedef (v 100 200))
(define hız-hedef (v 5 5))
(define ivme-hedef (v 0.1 0.1))
(define nesne-hedef (nesne (bitmap "Teachpacks/teachpack-images/yemek-1.png")
                             konum-hedef
                             hız-hedef
                             ivme-hedef ) )
;PREDO
(define konum-predo (v 400 200))
(define hız-predo (v 5 5))
(define ivme-predo (v 0.1 0.1))
(define nesne-predo (nesne (bitmap "teachpacks/teachpack-images/predo/predoflying/predoflying-1.png")
                             konum-predo
                             hız-predo
                             ivme-predo ) )
;FLYTRAP
(define konum-flytrap (v 500 200))
(define hız-flytrap (v 5 5))
(define ivme-flytrap (v 5 5))
(define nesne-flytrap (nesne (bitmap "Teachpacks/teachpack-images/flytrap/flytrapstanding/flytrapstanding-1.png")
                             konum-flytrap
                             hız-flytrap
                             ivme-flytrap ) )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;vektörleri toplama
;v+v v v -> vektör
(define (v+v vl vk) (v (+ (v-x vl) (v-x vk)) (+ (v-y vk) (v-y vl))))
(ÖRNEK (v+v (v 250 100) (v 300 50)) (v 550 150))


;vektörleri çıkarma
;v-v v v -> vektör
(define (v-v vl vk) (v (- (v-x vl) (v-x vk)) (- (v-y vl) (v-y vk))))
(ÖRNEK (v-v (v 250 100) (v 300 50)) (v -50 50))

;; v+ - vektör toplama
;; v+ sayı v -> v
;; (define (v+ s vk) (v (+ (v-x vk) s) (+ (v-y vk) s)) )
(ÖRNEK (v+ 4 vektör-örnek-1 ) (v 14 14))
(define (v+ s vk) (v (+ (v-x vk) s) (+ (v-y vk) s)) )
;; v- - vektör çıkartma
;; v- sayı v -> v
;; (define (v- s vk) (v (- (v-x vk) s) (- (v-y vk) s)) )
(ÖRNEK (v- 4 vektör-örnek-1 ) (v 6 6))
(define (v- s vk) (v (- (v-x vk) s) (- (v-y vk) s)) )

;; v* - vektör sayıyla çarpma
;; v* sayı v -> v
;; (define (v* s vk) (v (* (v-x vk) s) (* (v-y vk) s)) )
(ÖRNEK (v* 4 vektör-örnek-1) (v 40 40))
(define (v* s vk) (v (* s (v-x vk) ) (* s (v-y vk) )) )

;; v. - vektör dot çarpma
;; v. v v -> sayı
;; (define (v. vl vk) (v (+ (*(v-x vk) (v-x vl))  (* (v-y vk)(v-y vl) )) )
(ÖRNEK (v. vektör-örnek-2 vektör-örnek-1 ) 400)
(define (v. vl vk)  (+ (* (v-x vk) (v-x vl))  (* (v-y vk)(v-y vl) )) )

;; v-mag - vektör uzunluğu
;; v-mag v -> sayı
;; (define (v-mag vk)  (sqrt (+ (sqr (v-x vk)) (sqr (v-y vk))))
(ÖRNEK (v-mag vektör-örnek-3 ) 13)
(define (v-mag vk)  (sqrt (+ (sqr (v-x vk)) (sqr (v-y vk)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Hediye vektör çizim fonksiyonları
; Vektör STRUCT tanıttıktan sonra bu fonkisyonları uncomment edebilirsiniz
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
; resim v sahne -> sahne
; bir sahneye vectöre göre bir imaj yerleştir
; template :
; (define (place-image/v im v1 sahne)
;  (... im ... (v-x v1) ... (v-y v1) ...)
(define test-circle (circle 100 "solid" "purple"))
;(define test-square (square 100 "solid" "green"))
;
(ÖRNEK (place-image/v  test-circle (v 5 5) BACKGROUND)
       (place-image/align test-circle 5 5 "center" "center" BACKGROUND))
(ÖRNEK (place-image/v test-circle (v 3 8) BACKGROUND)
       (place-image/align test-circle 3 8 "center" "center" BACKGROUND))
(ÖRNEK (place-image/v test-circle (v 1 2) BACKGROUND)
       (place-image/align test-circle 1 2 "center" "center" BACKGROUND))
(ÖRNEK (place-image/v test-circle (v 2 8) BACKGROUND)
       (place-image/align test-circle 2 8 "center" "center" BACKGROUND))
(define (place-image/v im v1 sahne)
  (place-image/align im (v-x v1) (v-y v1) "center" "center"  sahne))
;(place-image/v test-circle vektör-örnek-4 BACKGROUND)

; place-line/v v v color görüntü -> görüntü
; v1'den v2'e giden bir çizgi arka imajına yerleştir
;(ÖRNEK (place-line/v (v 2 3) (v 5 1) "red" test-square)
  ;     (add-line test-square 2 3 5 1 "red")

(define (place-line/v v1 v2 renk arka)
  (add-line arka (v-x v1) (v-y v1) (v-x v2) (v-y v2) renk))
;(place-line/v vektör-örnek-4 vektör-örnek-1 "pink" BACKGROUND )


;SÖZLEŞME: nesne-çiz nesne + görüntü -> görüntü
;nesneyi bir arkaplan üerine çizmek
(ÖRNEK (nesne-çiz nesne-1 (square 100 "solid" "yellow"))
       (place-image/v (circle 10 "solid" "red") (v 50 50) (square 100 "solid" "yellow")))
;ŞEKİL (define (nesne-çiz n ap)
;               .....(nesne-imaj n)
;                 ,,,,(nesne-yer n)
(define (nesne-çiz n ap) (place-image/v (nesne-imaj n) (nesne-yer n) ap))
(nesne-çiz nesne-dinazor BACKGROUND)

;; place-text/v v metin sayı color görüntü -> görüntü
;; v pozisyonda  verilen metni arka imajına yerleştir
;(ÖRNEK (place-text/v (v 20 30) "Hello" 15 "red" test-square)
;       (place-image/v (text "Hello" 15 "red") (v 20 30) test-square))
(define (place-text/v v metin size col arka)
  (place-image/v (text metin size col) v arka))
;(place-text/v vektör-örnek-4 "SELAM" 50 "purple" BACKGROUND)

;nesne-fizik-güncelle nesne -> nesne
;nesneyi bir sonraki haline getirmek

(ÖRNEK (nesne-fizik-güncelle (nesne (circle 10 "solid" "red" ) (v 50 50) (v 2 3 ) (v 4 5) ))
                             (nesne (circle 10 "solid" "red" ) (v 52 53) (v 6 8 ) (v 4 5) ))
;ŞEKİL (define (nesne-fizik-güncelle)
;                 (nesne
;                  .. (nesne-imaj  )
(define (nesne-fizik-güncelle n ) (nesne
                                (nesne-imaj n)
                                (v+v (nesne-yer n) (nesne-hız n))
                                (v+v (nesne-hız n) (nesne-ivme n))
                                (nesne-ivme n)))
(nesne-fizik-güncelle nesne-dinazor)


;SÖZLEŞME evren-> evren
;amaç evrenin bir frame sonraki halini vermek
;(ÖRNEK (evren-güncelle yaradılış) (evren BACKGROUND
;                                         (nesne (nesne-imaj nesne-dinazor) (v 400 250) (v 55 55) (v 5 5))
;                                         (nesne (nesne-imaj nesne-caveman) (v 300 250) (v 55 55) (v 5 5))
;                                         (nesne (nesne-imaj nesne-caveman) (v 150 250) (v 55 55) (v 5 5))))
;ŞEKİL (define (evren-güncelle e) (evren (evren-bg e)
;                                    ....(evren-n1 e))
(define (evren-güncelle e) (evren (evren-bg e)
                                  (nesne-fizik-güncelle (evren-n1 e))
                                  (nesne-fizik-güncelle (evren-n2 e))
                                  (nesne-fizik-güncelle (evren-n3 e))))
  

;SÖZLEŞME evren -> görüntü
;bir evren çizecek
(ÖRNEK (evren-çiz (evren BACKGROUND
                         (nesne (circle 10 "solid" "red") (v 50 50) (v 0 0) (v 0 0))
                         (nesne (circle 10 "solid" "blue") (v 150 250) (v 0 0) (v 0 0))
                         (nesne (circle 10 "solid" "purple") (v 100 200) (v 0 0) (v 0 0))))
       (nesne-çiz (nesne (circle 10 "solid" "red") (v 50 50) (v 0 0) (v 0 0))
                  (nesne-çiz (nesne (circle 10 "solid" "blue") (v 150 250) (v 0 0) (v 0 0))
                             (nesne-çiz (nesne (circle 10 "solid" "purple") (v 100 200) (v 0 0) (v 0 0)) BACKGROUND ))))

(define (evren-çiz e) (nesne-çiz (evren-n1 e)
                                 (nesne-çiz (evren-n2 e )
                                            (nesne-çiz (evren-n3 e) (evren-bg e)))))
                                

(define (evren-tuş e t)
  e)

(define (evren-fare e x y m)
  e)


 

(define FRAME-RATE 12)

(define yaradılış  (evren BACKGROUND 
                         nesne-dinazor
                         nesne-caveman
                         nesne-hedef))

;; SES herhangbirşey ses-dosyası-metin -> herhangibirşey
;; birinci paramatresini aynen dönsürüyor, sesi çalarak
;(ÖRNEK (SES 0 "ses/bark.wav" ) 0)

(test)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sabit kod bundan sonra                               ;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(yut (big-bang yaradılış
  (on-tick evren-güncelle (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)
  (on-mouse evren-fare)))

