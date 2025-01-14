#lang racket
(require "teachpacks/evren-teachpack.rkt")
;; STRUCT v - vektör
;; x : sayı - x koordinatı
;; y : sayı - y koordinatı
(STRUCT v (x y))

;; v+ - vektör toplama
;; v+ v v -> v
;;define (v+ (v x1 y1)(v x2 y2))
;;
;;
(ÖRNEK (v+ (v 2 3)(v 4 5))(v 6 8))
(ÖRNEK (v+ (v 3 6)(v 1 2))(v 4 8))
(define (v+ v1 v2)
  (v
   (+ (v-x v1)(v-x v2))
   (+ (v-y v1)(v-y v2))))

;; v- - vektör çıkartma
;; v- v v -> v
;;define (v+ (v x1 y1)(v x2 y2))
(ÖRNEK (v- (v 3 5)(v 9 2))(v -6 3))
(ÖRNEK (v- (v 1 3)(v 1 8))(v 0 -5))
(define (v- v1 v2)
  (v
   (- (v-x v1)(v-x v2))
   (- (v-y v1)(v-y v2))))

;; v* - vektör sayıyla çarpma
;; v* sayi v -> v
;; define (v* s vk)
;;(v
;;(* s (v-x vk)
;;(* s (v-y vk)
(ÖRNEK (v* 4 (v 2 -3))(v 8 -12))
(ÖRNEK (v* 0 (v 7 13))(v 0 0))
(define (v* s vk)
  (v
   (* s (v-x vk))
   (* s (v-y vk))))

;; v. - vektör dot çarpma
;; v. v v -> sayi
;;define (v. (x1 y1)(x2 y1)= x1.x2+y1.y2
(ÖRNEK (v. (v 9 10)(v 2 3))48)
(ÖRNEK (v. (v 2 5)(v 2 3))19)
(define (v. v1 v2)
  (+(*(v-x v1)(v-x v2))
    (*(v-y v1)(v-y v2))))
 
;; v-mag - vektör uzunluğu
;; v-mag v -> sayi
;;define (v-mag (x y))(sqrt(+(sqr x)(sqr y)))
(ÖRNEK (v-mag (v 3 4))5)
(ÖRNEK (v-mag (v 5 12))13)
(define (v-mag v)(sqrt(+(sqr(v-x v))(sqr(v-y v)))))

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

(STRUCT nesne (imaj yer hiz ivme))
 ;STRUCT nesne
; imaj : görüntü - nesneini imajı
; yer : v - nesnenin ekrandaki yeri
; hız : v - nesnenin hızı
; ivme : v - nesnenin ivmesi
;;nesne-ciz nesne goruntu -> goruntu
;;nesneyi verilen arkaplanina cizmek
(ÖRNEK(nesne-çiz (nesne (circle 10 "solid" "red")
                        (v 50 50)(v 0 0)(v 0 0 ))
                 (square 100 "solid" "yellow"))
      (place-image/v (circle 10 "solid" "red")(v 50 50)
                     (square 100 "solid" "yellow")))    
(define (nesne-çiz n ap)
  (place-image/v (nesne-imaj n)
  (nesne-yer n) ap))

;nesne-fizik-guncelle nesne -> nesne
;nesneyi bir sonraki haline getirmek ,yer ,hiz ,ivme kullanarak
(ÖRNEK (nesne-fizik-güncelle (nesne (circle 10 "solid" "red")(v 50 50)(v 2 3)(v 4 5)))
       (nesne (circle 10 "solid" "red")(v 52 53)(v 6 8)(v 4 5)))
(define (nesne-fizik-güncelle n )
  (nesne
   (nesne-imaj n)
   (v+ (nesne-yer n)(nesne-hiz n))
   (v+ (nesne-hiz n)(nesne-ivme n))
   (nesne-ivme n)))
              


 ;STRUCT evren
; arkaplanı : görüntü - oyun arka planı
(define BACKGROUND (bitmap "imaj/kutuphane.jpg")) 
(STRUCT evren (bg n1 n2 n3))

;;evren-güncelle evren -> evren
;;Evrenin bir frame sonraki degerini vermek
(ÖRNEK (evren-güncelle yaradılış)
       (evren BACKGROUND
              (nesne (circle 30 "solid" "red")(v 80 17)(v 30 -32)(v 0 1))
              (nesne (square 40 "solid" "green")(v 950 275)(v -20 -24)(v 0 1))
              (nesne (triangle 35 "solid" "yellow")(v 355 532)(v 5 -17)(v 0 1))))

      
(define (evren-güncelle e)
  (evren
   (evren-bg e)
   (nesne-fizik-güncelle (evren-n1 e))
   (nesne-fizik-güncelle (evren-n2 e))
   (nesne-fizik-güncelle (evren-n3 e))))
  
;;evren-ciz evren -> goruntu
;;evreni cizer
(ÖRNEK(evren-çiz (evren BACKGROUND
                 (nesne(circle 10 "solid" "red")(v 50 50)(v 30 -33)(v 0 1))
                  (nesne(square 20 "solid" "green")(v 970 300)(v -20 -25 )(v 0 1))
                  (nesne(triangle 30 "solid" "yellow")(v 350 550)(v 5 -18)(v 0 1))))
      (nesne-çiz (nesne(circle 10 "solid" "red")(v 50 50)(v 30 -33)(v 0 1))
      (nesne-çiz (nesne(square 20 "solid" "green")(v 970 300)(v -20 -25)(v 0 1))                
      (nesne-çiz (nesne(triangle 30 "solid" "yellow")(v 350 550)(v 5 -18)(v 0 1))BACKGROUND))))
(define (evren-çiz e)
  (nesne-çiz (evren-n1 e) (nesne-çiz(evren-n2 e)(nesne-çiz(evren-n3 e)(evren-bg e)))))
  
;;yaradilis evren -> evren
(define yaradılış
  (evren BACKGROUND
   (nesne(circle 30 "solid" "red")(v 50 50)(v 30 -33)(v 0 1))
    (nesne(square 40 "solid" "green")(v 970 300)(v -20 -25 )(v 0 1))
    (nesne(triangle 35 "solid" "yellow")(v 350 550)(v 5 -18)(v 0 1))))



(define (evren-tuş e t)
  e)

(define (evren-fare e x y m)
  e)


(define FRAME-RATE 12)


;SES herhangbirşey ses-dosyası-metin -> herhangibirşey
; birinci paramatresini aynen dönsürüyor, sesi çalarak
;(ÖRNEK (SES 0 "ses/bark.wav") 0)

(test)
;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;Animasyon
;;;STRUCT
;;;anim
;;;devamli -> boolean
;;;degisim-sikligi -> sayi
;;;zaman -> sayi
;;; resimler -> goruntu-listesi
;(STRUCT anim (resimler zaman degisim-sikligi devamli))
;
;
;;;anim-ciz anim -> goruntu
;;;Suanki imaj dondur
;(ÖRNEK (anim-ciz (anim true 3 13 (list (circle 10 "solid" "red")
;                                       (circle 15 "solid" "red")
;                                       (circle 20 "solid" "red")
;                                       (circle 25 "solid" "red"))))
;       (circle 10 "solid" "red"))
;(define (anim-ciz a)
;  (list-ref
;   (anim-resimler a)
;   (modulo(quohent(anim-zaman a)
;   (anim-degisim-sikligi a))(length (anim-resimler a )))))
;
;;;anim-zaman-guncelle sayi sayi boolean -> sayi
;;;eski zaman, devir uzunlugu (siklik*degisim),devamli
;(ÖRNEK (anim-zaman-guncelle 11 12 true)0)
;(ÖRNEK (anim-zaman-guncelle 11 12 false)11)
;(define (anim-zaman-guncelle z u devam)
;  (cond
;    (devam(modulo (+ z 1) u))
;    (else (max (+ z 1) (- u 1)))))
;
;;;anim-guncelle anim -> anim
;;;anim zaman artmak
;(ÖRNEK(anim-guncelle (anim true 3 11 (list (circle 10 "solid" "red")
;                                       (circle 15 "solid" "red")
;                                       (circle 20 "solid" "red")
;                                       (circle 25 "solid" "red"))))
;      (anim true 3 0 (list (circle 10 "solid" "red")
;                                       (circle 15 "solid" "red")
;                                       (circle 20 "solid" "red")
;                                       (circle 25 "solid" "red"))))
;(ÖRNEK(anim-guncelle (anim false 3 11 (list (circle 10 "solid" "red")
;                                       (circle 15 "solid" "red")
;                                       (circle 20 "solid" "red")
;                                       (circle 25 "solid" "red"))))
;      (anim false 3 11 (list (circle 10 "solid" "red")
;                                       (circle 15 "solid" "red")
;                                       (circle 20 "solid" "red")
;                                       (circle 25 "solid" "red"))))
;(define (anim-guncelle a)
;  (anim
;   (anim-devamli a)
;   (anim-degisim-sikligi a)
;   (anim-zaman-guncelle (anim-zaman a)
;
;
;                     
;                       
;







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sabit kod bundan sonra                               ;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(yut (big-bang yaradılış
  (on-tick evren-güncelle (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)
  (on-mouse evren-fare)))

