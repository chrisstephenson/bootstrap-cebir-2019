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

(define (v-mag v1 )
  (sqrt (+ (sqr (v-x v1))(sqr (v-y v1)))))


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

;evren-güncelle : evren -> evren

(define (evren-güncelle e)
  (çarpışma (evren  (evren-score e) (evren-arkaplanı e)
         (evren-n1 e)
         (nesne-fizik-güncelle (evren-n2 e))
         (nesne-güncelle-y (nesne-fizik-güncelle (evren-n3 e)))
         (nesne-güncelle-x (nesne-fizik-güncelle (evren-n4 e)))
         (nesne-fizik-güncelle (evren-n5 e))
         (nesne-fizik-güncelle (evren-n6 e)))))


;nesne-güncelle : nesne -> nesne
;nesneyi alıp koordinat sisteminde başka bir yerde çıkar

;nesne-güncelle-y : nesne -> nesne

(define (nesne-güncelle-y n)
  (nesne (nesne-imaj n)
  (cond
    ((> (v-y (nesne-yer n))(image-height BACKGROUND))
     (v (random 0 (image-width BACKGROUND)) 0))
    (else (nesne-yer n)))
  (nesne-hız n)(nesne-ivme n)))



;nesne-güncelle-x : nesne -> nesne

(define (nesne-güncelle-x n)
  (nesne (nesne-imaj n)
         (cond
           ((> (v-x (nesne-yer n))(image-width BACKGROUND))
            (v 0 (random 20 (image-height BACKGROUND))))
           (else (nesne-yer n)))
         (nesne-hız n)(nesne-ivme n)))







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



;STRUCT
;evren
;bg : görüntü- evren arkaplanı
;n1 : nesne (oyuncu)
;n2 : nesne (tehlike1)
;n3 : nesne (tehlıke2)
;n4 : nesne (
;n5 : nesne
;n6 : nesne
;; STRUCT evren
;; arkaplanı : görüntü - oyun arka planı
;;
(STRUCT evren (score arkaplanı n1 n2 n3 n4 n5 n6))

;evren-çiz : evren -> görüntü
;evreni çiziyor

(ÖRNEK (evren-çiz (evren-score BACKGROUND
       (nesne (circle 10 "solid" "red")(v 50 50)(v 0 0)(v 0 0))
       (nesne (square 20 "solid" "green")(v 100 150)(v 0 0)(v 0 0))
       (nesne (triangle 30 "solid" "yellow")(v 200 500)(v 0 0)(v 0 0))
       (nesne (circle 40 "solid" "blue")(v 100 100)(v 0 0)(v 0 0))
       (nesne (square 50 "solid" "dark blue")(v 200 250)(v 0 0)(v 0 0))
       (nesne (triangle 60 "solid" "green")(v 100 300)(v 0 0)(v 0 0))))
(nesne-çiz (nesne (circle 10 "solid" "red")(v 50 50)(v 0 0)(v 0 0))
           (nesne-çiz (nesne (square 20 "solid" "green")(v 100 150)(v 0 0)(v 0 0))
                      (nesne-çiz (nesne (triangle 30 "solid" "yellow")(v 200 500)(v 0 0)(v 0 0))
                                 (nesne-çiz (nesne (circle 40 "solid" "blue")(v 100 100)(v 0 0)(v 0 0))
                                            (nesne-çiz (nesne (square 50 "solid" "dark blue")(v 200 250)(v 0 0)(v 0 0))
                                                       (nesne-çiz (nesne (triangle 60 "solid" "green")(v 100 300)(v 0 0)(v 0 0)) BACKGROUND )))))))


(define (evren-çiz e) 
 (place-text/v
  (v 300 20) (string-append "SCORE " (number->string (evren-score e))) 30 "white" (nesne-çiz (evren-n1 e)
            (nesne-çiz (evren-n2 e)
                         (nesne-çiz (evren-n3 e)
                                    (nesne-çiz (evren-n4 e)
                                               (nesne-çiz (evren-n5 e)
                                                          (nesne-çiz (evren-n6 e) (evren-arkaplanı e)))))))))


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

       

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ekranda? : Sayı -> Mantıksal
; Koordinat ekranın içinde mi belirler
; sol-güvenli? : Sayı -> Mantıksal
; Karakter oyun ekranının solundan içeride mi?
; sağ-güvenli? : Sayı -> Mantıksal
; Karakter oyun ekranının sağından içeride mi?



;uzaklık : nesne nesne -> sayı

(define (uzaklık n1 n2)
  (v-mag (v-  n1  n2)))


(define BACKGROUND( scale 6 (bitmap "imaj/arkaplan-001.png")))
(define OYUNCU(nesne ( scale 20 (bitmap "imaj/oyuncu1.png"))(v 30 100)(v 30 -33)(v 0 1)))
(define ATACK(nesne ( scale 20 (bitmap "imaj/atack1.png"))(v 970 300)(v -70 -75)(v 0 1)))
(define ENEMY1(nesne ( scale 20 (bitmap "imaj/bat.png"))(v 350 550)(v 5 -16)(v 0 1)))
(define ENEMY2(nesne (scale 20 (bitmap "imaj/goblin.png"))(v 100 100)(v 0 0)(v 0 2)))
(define ÖDÜL(nesne ( scale 20 (bitmap "imaj/coin.png"))(v 200 250)(v 0 0)(v 0 3)))
(define POTİON(nesne ( scale 20 (bitmap "imaj/my-potion.png"))(v 100 300)(v 0 0)(v 0 1)))


;carpışma : evren -> evren

(define (çarpışma e)
  (cond
    ((< (uzaklık (nesne-yer (evren-n1 e)) (nesne-yer (evren-n3 e))) 30 )    
  (evren (- (evren-score e) 10) (evren-arkaplanı e)
         (evren-n1 e)
         (evren-n2 e)
         (nesne (nesne-imaj (evren-n3 e))
                (v (image-width BACKGROUND)
                   (random 20 (image-height BACKGROUND)))
                (nesne-hız (evren-n3 e))(nesne-ivme (evren-n3 e)))
         (evren-n4 e)
         (evren-n5 e)
         (evren-n6 e)))
    ((< (uzaklık (nesne-yer (evren-n1 e)) (nesne-yer (evren-n4 e))) ( + (/ (image-height (nesne-imaj (evren-n1 e))) 2)
              (/ (image-height (nesne-imaj (evren-n4 e))) 2)))
     (evren (- (evren-score e) 10) (evren-arkaplanı e)
            (evren-n1 e)
            (evren-n2 e)
            (evren-n3 e)
            (nesne (nesne-imaj (evren-n4 e))
                   (v (image-width BACKGROUND)
                      (random 20 (image-height BACKGROUND)))
                   (nesne-hız (evren-n4 e))(nesne-ivme (evren-n4 e)))
            (evren-n5 e)
            (evren-n6 e)))
    ((< (uzaklık (nesne-yer (evren-n1 e)) (nesne-yer (evren-n5 e))) ( + (/ (image-height (nesne-imaj (evren-n5 e))) 2)
              (/ (image-height (nesne-imaj (evren-n5 e))) 2)))
     (evren (+ (evren-score e) 5) (evren-arkaplanı e)
            (evren-n1 e)
            (evren-n2 e)
            (evren-n3 e)
            (evren-n4 e)
            (nesne (nesne-imaj (evren-n5 e))
                   (v (random 20 (image-width BACKGROUND))
                      (random 20 (image-height BACKGROUND)))
                   (nesne-hız (evren-n5 e))(nesne-ivme (evren-n5 e)))
            (evren-n6 e)))
    (else e)))
            
         
 

;ETKİLEŞİM
;evren-tuş : evren metin -> evren
; "left"



(define (oyuncu-güncelle n t)
  (nesne (nesne-imaj n)
         [cond
            ((string=? t "up") (v (v-x (nesne-yer n))
                                 (- (v-y (nesne-yer n))(v-y(nesne-hız n)))))
            ((string=? t "left")(v (- (v-x (nesne-yer n)) (v-x (nesne-hız n))) (v-y (nesne-yer n))))
            ((string=? t "right")(v (+ (v-x (nesne-hız n)) (v-x (nesne-yer n)))(v-y (nesne-yer n))))
            ((string=? t "down") (v (v-x (nesne-yer n))
                                 (+ (v-y (nesne-yer n))(v-y(nesne-hız n)))))
            (else (nesne-yer n))]
                                  (nesne-hız n)
                                  (nesne-ivme n)))



;atack : ?????????????
;ama bunu yapmayı çok istiyodum


;evren tuş oyuncu hareketleri (evren-n1)

(define (evren-tuş e t)
 ( evren (evren-score e) (evren-arkaplanı e) (oyuncu-güncelle (evren-n1 e) t) (evren-n2 e)(evren-n3 e)(evren-n4 e)(evren-n5 e)(evren-n6 e)))



  
(define (evren-fare e x y m) 
  e)





(define FRAME-RATE 12)

(define yaradılış
  (evren  0 BACKGROUND 
  (nesne (scale 4(bitmap "imaj/oyuncu1.png"))(v 30 (- (image-height BACKGROUND) 10))(v 30 6)(v 0 1))
  (nesne (scale 3(bitmap "imaj/atack1.png"))(v 100 300)(v -70 -75)(v 0 0))
  (nesne (scale 3(bitmap "imaj/bat.png"))(v 350 550)(v 5 16)(v 0 0))
  (nesne (scale 4(bitmap "imaj/goblin.png"))(v 100 100)(v 5 0)(v 0 0))
  (nesne (scale 4(bitmap "imaj/coin.png"))(v 20 250)(v 0 0)(v 0 0))
  (nesne (scale 3(bitmap "imaj/my-potion.png"))(v 100 300)(v 0 0)(v 0 0))))


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




