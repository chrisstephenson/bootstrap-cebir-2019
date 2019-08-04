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
(STRUCT evren( arkaplanı dünya oyuncu  t1 t2 amaç timer-benzin genel-zaman can1 can2 canSayısı))

; place-image/v görüntü vektör görüntü
(define (place-image/v im v1 sahne)
  (place-image/align im (v-x v1) (v-y v1) "center" "center"  sahne))

(define BACKGROUND (place-image/v (scale 1.5 (bitmap "imaj/earth1.png")) (v 495  785) (bitmap "imaj/uazy2.jpeg"))) 
(define DÜNYA (bitmap "imaj/earth1.png"))
(define TEHLİKE1 (scale 0.25(bitmap "imaj/meteor1.png")))
(define TEHLİKE2 (scale 0.2(bitmap "imaj/meteor2.png")))
(define OYUNCU (scale 0.1 (bitmap "imaj/game-rocket-image.png")))
(define AMAÇ (scale 0.1(bitmap "imaj/uydu.png")))
(define BENZİN-TİMER 10)
(define GENEL-ZAMAN 20)
(define CAN1 (bitmap "imaj/kalp.png"))
(define CAN2 (bitmap "imaj/kalp.png"))
(define CANSAYISI 2)
(define boşkalp (scale 0.05(bitmap "imaj/içiboşkalp.png")))

(define oyuncu-uzay-genişliği 110)


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
; n2 nesne
; n3 nesne



; evren-çiz evren --> görüntü
(define (evren-çiz e)
   (place-image/v (evren-can2 e) (v 120 65) (place-image/v (evren-can1 e) (v 35 65) (place-text/v (v 915 65) (number->string (evren-genel-zaman e)) 50 "white" (nesne-çiz (evren-oyuncu e)
             (nesne-çiz (evren-t1 e)
                        (nesne-çiz (evren-t2 e)
                                   (nesne-çiz (evren-amaç e) BACKGROUND))))))))

; yaradılış  --> evren 
(define yaradılış
  (evren BACKGROUND
         DÜNYA
         (nesne (rotate -90 OYUNCU) (v (/ (image-width BACKGROUND) 2) (/ (image-height BACKGROUND) 2)) (v 0 0) (v 0 0))
         (nesne TEHLİKE1 (v 1000 683) (v -19 -24) (v 0 1))
         (nesne TEHLİKE2 (v 980 620) (v -19 -24) (v 0 1))
         (nesne AMAÇ (v 970 650) (v -19 -24) (v 0 1))
         10 0 CAN1 CAN2 CANSAYISI))

; evren-güncelle evren --> evren
; amaç --> evrenin bir frame sonraki durumunu vermek

;nesne-fizik-güncelle
; nesne-fizik-güncelle  nesne --> nesne
;nesneyi bir sonraki haline getirmek , yer, hız ve ivme kullanarak
(ÖRNEK (nesne-fizik-güncelle (nesne (circle 10 "solid" "red") (v 50 50) (v 2 3) (v 4 5)))
              (nesne (circle 10 "solid" "red") (v 52 53) (v 6 8) (v 4 5)))

(define( nesne-fizik-güncelle n)
  (nesne
   (nesne-imaj n)
   (v+ (nesne-hız n) (nesne-yer n))
   (v+ (nesne-ivme n) (nesne-hız n))
   (nesne-ivme n)))

; mesafe ölç nesne nesne --> vektör
; iki nesne arasındaki mesafeyi ölçer
(define (mesafe-ölç n1 n2)
  (v (abs (v-x (v- (nesne-yer n1) (nesne-yer n2)))) (abs (v-y (v- (nesne-yer n1) (nesne-yer n2))))))

;çarpıştı-mı nesne nesne--> boolean
(define (çarpıştı-mı? n1 n2)
  (< (v-mag (mesafe-ölç n1 n2)) 25))
; zaman
(define (zaman-güncelle x)
  (+ 1 x))

(define (evren-güncelle e)
  (cond
    ((<= (evren-canSayısı e) 0) (evren 
                                (evren-arkaplanı e)
                                (evren-dünya e)
                                (nesne boşkalp (nesne-yer (evren-oyuncu e)) (v 0 0) (v 0 0))
                                (nesne (place-text/v (v 250 65) "oyun" 20 "white" (rectangle 200 50 "solid" "red") ) (v 250 65) (v 0 0) (v 0 0))                           
                                (nesne (place-text/v (v 750 65) "bitti" 20 "white" (rectangle 200 50 "solid" "red") ) (v 750 65) (v 0 0) (v 0 0))
                                (nesne boşkalp (v 1000 650) (v 0 0) (v 0 0))
                                BENZİN-TİMER
                                (evren-genel-zaman e)
                                boşkalp
                                boşkalp
                                0))
    (else (evren
           (evren-arkaplanı e)
           (evren-dünya e)
           (evren-oyuncu e)
           (if (çarpıştı-mı? (evren-t1 e) (evren-oyuncu e)) (nesne-terse-döndür (evren-t1 e)) (nesne-tekrarla-t1 e (evren-t1 e))  )                           
           (if (çarpıştı-mı? (evren-t2 e) (evren-oyuncu e)) (nesne-terse-döndür (evren-t2 e)) (nesne-tekrarla-t2 e (evren-t2 e))  )
           (if (and (çarpıştı-mı? (evren-amaç e) (evren-oyuncu e)) (<= (evren-canSayısı e) 2)) (nesne-terse-döndür (evren-amaç e)) (nesne-tekrarla-amaç e (evren-amaç e)))
           BENZİN-TİMER
           (zaman-güncelle (evren-genel-zaman e))
           (if (> (evren-canSayısı e) 0) CAN1 boşkalp)
           (if (> (evren-canSayısı e) 1) CAN2 boşkalp)
           (canSayısı-güncelle e)))))

; nesne-terse-döndür nesne --> nesne
(define (nesne-terse-döndür n)
  (nesne-fizik-güncelle (nesne boşkalp
                               (nesne-yer n)
                               (v (v-y (nesne-hız n)) (- (v-x (nesne-hız n)) (* 2 (v-x (nesne-hız n)))))
                               (v 0 1))))


  ; canSayısı-güncelle evren --> sayı
(define (canSayısı-güncelle e)
  (cond
    [(or (çarpıştı-mı? (evren-t1 e) (evren-oyuncu e)) (çarpıştı-mı? (evren-t2 e) (evren-oyuncu e)))  (- (evren-canSayısı e) 1)]
    [(and (çarpıştı-mı? (evren-amaç e) (evren-oyuncu e)) (< (evren-canSayısı e) 2)) (+ (evren-canSayısı e) 1)]
    (else (evren-canSayısı e))))

;oyuncuDur boolean evren tuş --> nesne
(define (oyuncuDur e t)
  (if (or (çarpıştı-mı? (evren-t1 e) (evren-oyuncu e))
          (çarpıştı-mı? (evren-t2 e) (evren-oyuncu e))
          (< (evren-canSayısı e) 0))
      (nesne boşkalp
             (nesne-yer (evren-oyuncu e))
             (v 0 0)
             (v 0 0))
      (oyuncu-güncelle (evren-oyuncu e) t)))
; evren-tuş evren --> evren
(define (evren-tuş e t)
  (cond
    [(and (<= (evren-canSayısı e) 0) (string=? t " ")) yaradılış]
              (else (evren (evren-arkaplanı e)
                            (evren-dünya e)
                            (oyuncu-güncelle (evren-oyuncu e) t)   
                            (evren-t1 e)                           
                            (evren-t2 e)
                            (evren-amaç e)
                            BENZİN-TİMER
                            (evren-genel-zaman e)
                            (evren-can1 e)
                            (evren-can2 e)
                            (evren-canSayısı e)))))

; alt-dur nesne --> boolean
(define (alt-dur n)
  (> (v-y (nesne-yer n)) (+ (/ (image-height BACKGROUND) 2) oyuncu-uzay-genişliği )))

(define(üst-dur n)
 (< (v-y (nesne-yer n)) (- (/ (image-height BACKGROUND) 2) (- oyuncu-uzay-genişliği 50))))

;(define (altÜstDur n)
 ; (if (or (alt-dur n) (üst-dur n)) (evren-oyuncu e) - (v-y (nesne-yer (evren-oyuncu e))))) 

(define (altÜstDur n e t)
 (if (and (alt-dur n) (üst-dur n)) (oyuncu-güncelle  (evren-oyuncu e) t) (evren-oyuncu e))) 

; nesne-tekrarla evren nesne --> nesne
(define(nesne-tekrarla-t1 e n)
  (if (> (v-y (nesne-yer n)) 683)  (nesne TEHLİKE1 (v (random 990 1100) (random 650 683)) (v -19 -24) (v 0 1)) (nesne-fizik-güncelle  (evren-t1 e))))

(define(nesne-tekrarla-t2 e n)
  (if (> (v-y (nesne-yer n)) 683)  (nesne TEHLİKE2 (v (random 950 970) (random 620 650)) (v -19 -24) (v 0 1)) (nesne-fizik-güncelle  (evren-t2 e))))

(define(nesne-tekrarla-amaç e n)
  (if (> (v-y (nesne-yer n)) 683) (nesne AMAÇ (v (random 860 940) (random 580 683)) (v -19 -24) (v 0 1))  (nesne-fizik-güncelle (evren-amaç e))))



(define (evren-fare e x y m)
  e)

;oyuncu-güncelle nesne tuş --> nesne
; oyuncunun y ekseni üzerinde hareket etmesini sağlar
(define (oyuncu-güncelle n yön)
  (nesne (nesne-imaj n)
         (v ( v-x (nesne-yer n))
            (cond
              [ (string=? yön "up" ) (if (üst-dur n) (v-y (nesne-yer n)) (- (v-y (nesne-yer n )) 10))]
              [ (string=? yön "down") (if (alt-dur n) (v-y (nesne-yer n)) (+ (v-y (nesne-yer n )) 10))]
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

