#lang racket
(require "teachpacks/evren-teachpack.rkt")



(define BACKGROUND (bitmap "imaj/arkaplan.jpg"))


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
(define düşman1 (nesne (scale 0.5 (bitmap "imaj/duşmanbüyükson.png")) (v 1300 (* (random 1 4) 150) ) (v -3 0) (v -0.03 0)))
(define düşman2 (nesne (scale 0.05 (bitmap "imaj/düşmanküçükson.png")) (v 1300 (* (random 1 4) 150 )) (v -3 0) (v -0.03 0)))
(define düşman3 (nesne (scale 0.05 (bitmap "imaj/düşmanküçükson2.png")) (v 1300 (* (random 1 4) 150 )) (v -3 0) (v -0.03 0)))
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
    
;;tanımlar
(define arkaplan-genişliği (image-width BACKGROUND))
(define arkaplan-yüksekliği (image-height BACKGROUND))
(define oyuncu-genişliği (image-width (nesne-imaj oyuncu)))
(define oyuncu-yüksekliği (image-height(nesne-imaj oyuncu)))




 ;STRUCT evren
; arkaplanı : görüntü - oyun arka planı
;

(STRUCT evren (bg n1 n2 n3 n4 n5))

;; evren-çiz evren -> görüntü
;; evreni çiziyor

(ÖRNEK
 (evren-çiz (evren BACKGROUND
                    oyuncu
                                 
                    düşman1
                                 
                    düşman2

                    düşman3
                                 
                    ateş))
                   
                   (place-text/v (v 200 50) "SKOR: " 60 "red"
                   (nesne-çiz  oyuncu
                                 
                   (nesne-çiz  düşman1
                                 
                   (nesne-çiz  düşman2

                   (nesne-çiz  düşman3            
                                 
                   (nesne-çiz  ateş  BACKGROUND)))))))

(define (evren-çiz e)
  (place-text/v (v 200 50) "SKOR: " 60 "red"(nesne-çiz (evren-n1 e) (nesne-çiz (evren-n2 e) (nesne-çiz (evren-n3 e) (nesne-çiz (evren-n4 e) (nesne-çiz (evren-n5 e) (evren-bg e))))))))

(define yaradılış
   (evren BACKGROUND
          oyuncu
          düşman1 
          düşman2
          düşman3
          ateş ))

;; evren-güncelle evren -> evren
;; evrenin bir frame sonraki değerini vermek

;(ÖRNEK
; (evren-güncelle yaradılış)
; (evren BACKGROUND
;         oyuncu
;         düşman1 
;         düşman2
;         ateş ))

(define (evren-güncelle e)
  (evren (evren-bg e)
          (nesne-fizik-güncelle (evren-n1 e))
         (soldan-döndür (nesne-fizik-güncelle (evren-n2 e)))
         (soldan-döndür (nesne-fizik-güncelle (evren-n3 e)))
         (soldan-döndür (nesne-fizik-güncelle (evren-n4 e)))
         (nesne-fizik-güncelle (evren-n5 e))))





;;oyuncu hareket
;;oyuncu-guncelle sayi metin -> sayi
(define  oyuncu-adim 25)
(ÖRNEK (oyuncu-guncelle (evren-n1 yaradılış) "up")(nesne
                                                       (nesne-imaj (evren-n1 yaradılış))
                                                        (v (v-x (nesne-yer(evren-n1 yaradılış)))(- (v-y(nesne-yer (evren-n1 yaradılış))) oyuncu-adim))
                                                       (nesne-hız (evren-n1 yaradılış))
                                                       (nesne-ivme (evren-n1 yaradılış))))
(ÖRNEK (oyuncu-guncelle (evren-n1 yaradılış)  "down")(nesne
                                                          (nesne-imaj (evren-n1 yaradılış))
                                                           (v (v-x (nesne-yer(evren-n1 yaradılış)))(+ (v-y(nesne-yer (evren-n1 yaradılış))) oyuncu-adim))
                                                           (nesne-hız (evren-n1 yaradılış))
                                                           (nesne-ivme (evren-n1 yaradılış))))
       

(define (oyuncu-guncelle n yon)
 (nesne
   (nesne-imaj n)
   
               (cond
    ((string=? yon "up")(v (v-x (nesne-yer n))(-(v-y (nesne-yer n)) oyuncu-adim)))
    ((string=? yon "down")(v (v-x (nesne-yer n))(+ (v-y (nesne-yer n)) oyuncu-adim)))
    (else (nesne-yer n)))
               (nesne-hız n)
               (nesne-ivme n)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (soldan-döndür n)
  (cond
    ( (< (v-x (nesne-yer n)) (- 0 (/ (image-width (nesne-imaj n)) 2)))
      (nesne (nesne-imaj n) (v (+ (image-width BACKGROUND) (/ (image-width (nesne-imaj n)) 2)) (random 50 430 )) (nesne-hız n) (nesne-ivme n )))
    (else n))) 
      
               
               
  


;;evren-tus evren metin -> evren    
         
(define (evren-tuş e t)
  (evren
   (evren-bg e)
   (oyuncu-guncelle (evren-n1 e) t)
   (evren-n2 e)
   (evren-n3 e)
   (evren-n4 e)
   (evren-n5 e)))

(define (evren-fare e x y m)
  e)
 

(define FRAME-RATE 12)

;(define yaradılış (evren BACKGROUND))

;; SES herhangbirşey ses-dosyası-metin -> herhangibirşey
;; birinci paramatresini aynen döndürüyor, sesi çalarak


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sabit kod bundan sonra                               ;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(yut (big-bang yaradılış
  (on-tick evren-güncelle (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)
  (on-mouse evren-fare)))

