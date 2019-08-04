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
;;evren-yon-guncelle evren -> evren
              


 ;STRUCT evren
; arkaplanı : görüntü - oyun arka planı
(define BACKGROUND (scale 0.5(bitmap "imaj/forest3.jpg")) )
(define OYUNCU (nesne
                (scale 0.5(bitmap "imaj/kiz.png"))
                (v 80 445)(v 0 0)(v 0 0)))
                       
(define TEHLIKE (nesne
                 (scale 0.15(bitmap "imaj/chara.png"))
                 (v 900 445)(v -14 0)(v 0 0)))
(define TEHLIKE2 (nesne
                 (scale 0.15(bitmap "imaj/chara.png"))
                 (v 900 130)(v 0 0)(v 0 0)))
(define ODUL (nesne         
              (scale 0.3(bitmap "imaj/strawberry.png"))
              (v 800 455)(v -14 0)(v 0 0)))
(define KALP1 (nesne
               (scale 0.2(bitmap "imaj/heart.png"))
               (v 420 20)(v 0 0)(v 0 0)))
(define KALP2 (nesne
               (scale 0.2(bitmap "imaj/heart.png"))
               (v 450 20)(v 0 0)(v 0 0)))
(define KALP3 (nesne
               (scale 0.2(bitmap "imaj/heart.png"))
               (v 480 20)(v 0 0)(v 0 0)))

                     
                     
;(define KALP (bitmap "imaj/heart.png"))
;(define KALP2 (bitmap "imaj/heart.png"))
;(define KALP3 (bitmap "imaj/heart.png"))
(STRUCT evren (bg oyuncu tehlike tehlike2 odul kalp1 kalp2 kalp3))

;;evren-güncelle evren -> evren
;;Evrenin bir frame sonraki degerini vermek
(ÖRNEK (evren-güncelle yaradılış)
       (evren
       BACKGROUND
        OYUNCU
       (nesne-fizik-güncelle TEHLIKE)
       (nesne-fizik-güncelle TEHLIKE2)
       (nesne-fizik-güncelle ODUL)
       KALP1 KALP2 KALP3))
              
              

      
(define (evren-güncelle e)
  (evren
   (evren-bg e)
   (evren-oyuncu e)
   (nesne-fizik-güncelle (evren-tehlike e))
   (nesne-fizik-güncelle (evren-tehlike2 e))
   (nesne-fizik-güncelle (evren-odul e))
   (evren-kalp1 e)
   (evren-kalp2 e)
   (evren-kalp3 e)))
  
;;evren-ciz evren -> goruntu
;;evreni cizer
(ÖRNEK(evren-çiz (evren BACKGROUND OYUNCU TEHLIKE TEHLIKE2 ODUL KALP1 KALP2 KALP3))              
      (place-text/v (v 350 20)"Health:" 30 "red"
      (place-text/v (v 600 20)"Score:" 30 "Gold"
      (nesne-çiz OYUNCU
      (nesne-çiz TEHLIKE
      (nesne-çiz TEHLIKE2
      (nesne-çiz ODUL
      (nesne-çiz KALP1
      (nesne-çiz KALP2                
      (nesne-çiz KALP3  BACKGROUND))))))))))
(define (evren-çiz e)
  (place-text/v (v 350 20) "Health:" 30 "red" 
                (place-text/v (v 600 20) "Score:" 30 "Gold"
                              (nesne-çiz(evren-oyuncu e)
                              (nesne-çiz(evren-tehlike e)
                              (nesne-çiz(evren-tehlike2 e)          
                              (nesne-çiz(evren-odul e)
                              (nesne-çiz(evren-kalp1 e)
                              (nesne-çiz(evren-kalp2 e)
                              (nesne-çiz(evren-kalp3 e)
                              (evren-bg e)))))))))))
  
;;yaradilis evren -> evren
(define yaradılış
  (evren BACKGROUND OYUNCU TEHLIKE TEHLIKE2 ODUL KALP1 KALP2 KALP3))

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;;oyuncu hareket
;;oyuncu-guncelle sayi metin -> sayi
(define  oyuncu-adim 105)
(ÖRNEK (oyuncu-guncelle (evren-oyuncu yaradılış) "up")(nesne
                                                       (nesne-imaj (evren-oyuncu yaradılış))
                                                        (v (v-x (nesne-yer(evren-oyuncu yaradılış)))(- (v-y(nesne-yer (evren-oyuncu yaradılış))) oyuncu-adim))
                                                       (nesne-hiz (evren-oyuncu yaradılış))
                                                       (nesne-ivme (evren-oyuncu yaradılış))))
(ÖRNEK (oyuncu-guncelle (evren-oyuncu yaradılış)  "down")(nesne
                                                          (nesne-imaj (evren-oyuncu yaradılış))
                                                           (v (v-x (nesne-yer(evren-oyuncu yaradılış)))(+ (v-y(nesne-yer (evren-oyuncu yaradılış))) oyuncu-adim))
                                                           (nesne-hiz (evren-oyuncu yaradılış))
                                                           (nesne-ivme (evren-oyuncu yaradılış))))
       

(define (oyuncu-guncelle n yon)
 (nesne
   (nesne-imaj n)
   
               (cond
    ((string=? yon "up")(v (v-x (nesne-yer n))(-(v-y (nesne-yer n)) oyuncu-adim)))
    ((string=? yon "down")(v (v-x (nesne-yer n))(+ (v-y (nesne-yer n)) oyuncu-adim)))
    (else (nesne-yer n)))
               (nesne-hiz n)
               (nesne-ivme n)))
               
               
  


;;evren-tus evren metin -> evren    
         
(define (evren-tuş e t)
  (evren
   (evren-bg e)
   (oyuncu-guncelle (evren-oyuncu e) t)
   (evren-tehlike e)
   (evren-tehlike2 e)
   (evren-odul e)
   (evren-kalp1 e)
   (evren-kalp2 e)
   (evren-kalp3 e)))
   
  
   
(define (evren-fare e x y m)
  e)




(define FRAME-RATE 12)


;SES herhangbirşey ses-dosyası-metin -> herhangibirşey
; birinci paramatresini aynen dönsürüyor, sesi çalarak
;(ÖRNEK (SES 0 "ses/bark.wav") 0)

(test)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sabit kod bundan sonra                               ;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(yut (big-bang yaradılış
  (on-tick evren-güncelle (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)
  (on-mouse evren-fare)))

