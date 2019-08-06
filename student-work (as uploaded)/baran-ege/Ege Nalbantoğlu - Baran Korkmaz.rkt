#lang racket
(require "teachpacks/evren-teachpack.rkt")
;; STRUCT v - vektör
;; x : sayı - x koordinatı
;; y : sayı - y koordinatı

(STRUCT v(x y))

;; v+ - vektör toplama
;; v+ : v v = v
(ÖRNEK(v+ (v 2 3) (v 4 5))(v 6 8))
(define (v+ v1 v2)
  (v
   (+ (v-x v1)(v-x v2))
   (+ (v-y v1)(v-y v2))))


;; v- - vektör çıkartma
;; v : v v = v
(ÖRNEK(v- (v 3 5)(v 9 2))(v -6 3))
(ÖRNEK(v- (v 2 5)(v 3 2))(v -1 3))
(define (v- v1 v2)
  (v
   (- (v-x v1)(v-x v2))
   (- (v-y v1)(v-y v2))))


;; v* - vektör sayıyla çarpma
;; v* : sayı v = v
(ÖRNEK (v* 4 ( v 2 -3 ))(v 8 -12))
(ÖRNEK (v* 0 ( v 7 13 ))(v 0 0))
(define (v* s vk)
  (v
   (* s (v-x vk))
   (* s (v-y vk))))


;; v. - vektör dot çarpma
;; v. : v v = sayı
(ÖRNEK (v. (v 2 3) (v 0 2)) 6)
(ÖRNEK (v. (v 6 0) (v 5 2)) 30)
(define (v. v1 v2)
             (+(* ( v-x v1)(v-x v2))
               (* ( v-y v1)(v-y v2))))
            



;; v-mag - vektör uzunluğu
;; v-mag : v = sayı
(ÖRNEK (v-mag (v 3 4)) 5)
(ÖRNEK (v-mag (v 5 12)) 13)
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


; STRUCT nesne
; imaj : görüntü - nesneini imajı
; yer : v - nesnenin ekrandaki yeri
; hız : v - nesnenin hızı
; ivme : v - nesnenin ivmesi

(STRUCT nesne(imaj yer hız ivme))
;;nesne-çiz : nesne görüntü = görüntü
;;nesneyi verilen arkaplanda çizmek
(ÖRNEK(nesne-çiz (nesne(circle 10 "solid" "red")
                       (v 50 50)(v 0 0)(v 0 0))
                 (square 100 "solid" "yellow"))
      (place-image/v (circle 10 "solid" "red") (v 50 50)
                     (square 100 "solid" "yellow")))
(define (nesne-çiz n ap)
  (place-image/v (nesne-imaj n)
                 (nesne-yer n) ap))


;nesne-fizik-güncelle : nesne = nesne
;nesneyi bir sonraki haline getirmeli , yer hız ve ivme kullanarak.
(ÖRNEK(nesne-fizik-güncelle (nesne(circle 10 "solid" "red")( v 50 50 ) (v 2 3)(v 4 5)))
      (nesne(circle 10 "solid" "red")( v 52 53 ) (v 6 8)(v 4 5)))
(define (nesne-fizik-güncelle n )
  (nesne
   (nesne-imaj n)
   (v+( nesne-yer n)(nesne-hız n))
   (v+ (nesne-hız n)(nesne-ivme n))
   (nesne-ivme n)))


  
                         

; STRUCT evren
; arkaplanı : görüntü - oyun arka planı

(STRUCT evren ( bg n1 n5 n6 n7 n8 n9 n10 n11 skor))
(define OYUNCU( nesne(scale 2(bitmap "imaj/mini-boi-(1).png"))
                       (v 75 400)(v 25 10)(v 0 0)))
(define BACKGROUND (scale 0.7(bitmap "imaj/temple1kırp.png")))
(define TEHLİKE (nesne (scale 2(bitmap "imaj/mini-boi-(2).png"))
                       (v 700 400)(v -15 0)(v 0 0)))
(define DÜŞMAN-1  (nesne (scale 0.4(bitmap "imaj/fc2.png"))
                        (v 850 75)(v -17 0)(v 0 0)))
(define DÜŞMAN-2  (nesne (scale 0.4(bitmap "imaj/fc2.png"))
                        (v 850 150)(v -15 0)(v 0 0)))
(define DÜŞMAN-3  (nesne (scale 0.4(bitmap "imaj/fc2.png"))
                        (v 850 225)(v -10 0)(v 0 0)))
(define DÜŞMAN-4  (nesne (scale 0.4(bitmap "imaj/fc2.png"))
                        (v 850 300)(v -5 0)(v 0 0)))
(define DÜŞMAN-5 (nesne (scale 0.4(bitmap "imaj/fc2.png"))
                         (v 850 375)(v -20 0)(v 0 0)))
(define ÖDÜL      (nesne (scale 0.5(bitmap "imaj/pc1.png"))
                        (v 850 50)(v 0 0)(v 0 0)))



;; evren-çiz : evren = görüntü
;; evreni çiziyor

                                
(place-text/v (v 585 30)(string-append "Skor :" (number->string 0)) 25 "pink" 
              
(nesne-çiz (nesne(scale 2(bitmap "imaj/mini-boi-(1).png"))(v 75 450)(v 0 0)(v 0 0))
(nesne-çiz     (nesne(scale 2(bitmap "imaj/mini-boi-(2).png"))(v 700 450)(v 0 0)(v 0 0))
(nesne-çiz               (nesne(scale 0.4(bitmap "imaj/fc2.png"))(v 850 250)(v 0 0)(v 0 0))
(nesne-çiz                 (nesne(scale 0.4(bitmap "imaj/fc2.png"))(v 850 200)(v 0 0)(v 0 0))
(nesne-çiz               (nesne(scale 0.4(bitmap "imaj/fc2.png"))(v 850 250)(v 0 0)(v 0 0))
(nesne-çiz                 (nesne(scale 0.4(bitmap "imaj/fc2.png"))(v 850 200)(v 0 0)(v 0 0))
(nesne-çiz                   (nesne(scale 0.4(bitmap "imaj/fc2.png"))(v 850 150)(v 0 0)(v 0 0))
(nesne-çiz                     (nesne(scale 0.5(bitmap "imaj/pc1.png"))(v 850 50)(v 0 0)(v 0 0)) BACKGROUND)))))))))

(define (evren-çiz e) (place-text/v (v 585 30)(string-append "Skor :" (number->string (evren-skor e))) 25 "pink"
                                    (nesne-çiz (evren-n1 e)
                                    (nesne-çiz(evren-n5 e)
                                    (nesne-çiz(evren-n6 e)       
                                    (nesne-çiz(evren-n7 e)
                                    (nesne-çiz(evren-n8 e)
                                    (nesne-çiz(evren-n9 e)
                                    (nesne-çiz(evren-n10 e)                                                                                               
                                    (nesne-çiz(evren-n11 e)
                                    (evren-bg e)))))))))))                                                                                                                                                                                                                                                                                
                                                                       
                                                                                                                                            
                                                                                                                   

(define yaradılış
  (evren BACKGROUND
         OYUNCU
         TEHLİKE
         DÜŞMAN-1
         DÜŞMAN-2
         DÜŞMAN-3
         DÜŞMAN-4
         DÜŞMAN-5
         ÖDÜL
         50))

;;evren-güncelle : evren = evren
;;evrenin bir frame sonraki değerini vermek
(ÖRNEK
 (evren-güncelle yaradılış)
 (evren BACKGROUND
        OYUNCU
       TEHLİKE
       DÜŞMAN-1
       DÜŞMAN-2
       DÜŞMAN-3
       DÜŞMAN-4
       DÜŞMAN-5
       ÖDÜL
       0))

(define (evren-güncelle e)
  (cond ((or (<= (evren-skor e) 0)(>= (evren-skor e) 200)) e)
        (else
        (çarpışma(evren (evren-bg e)
         (evren-n1 e)
         (tehlike-güncelle(nesne-fizik-güncelle (evren-n5 e)))
         (tehlike-güncelle(nesne-fizik-güncelle (evren-n6 e)))
         (ana-tehlike-güncelle(nesne-fizik-güncelle (evren-n7 e)))
         (tehlike-güncelle(nesne-fizik-güncelle (evren-n8 e)))
         (tehlike-güncelle(nesne-fizik-güncelle (evren-n9 e)))
         (tehlike-güncelle(nesne-fizik-güncelle (evren-n10 e)))
         (nesne-fizik-güncelle (evren-n11 e))
        (evren-skor e))))))






;tehlike-güncelle: nesne-> nesne
(define(tehlike-güncelle n)(nesne(nesne-imaj n)
                                 (cond
                                   ((< (v-x(nesne-yer n)) 0)(v (image-width BACKGROUND)(random 20 430)))
                                   (else (nesne-yer n)))
                                 (v -17 0)(v 0 0)))

;ana-tehlike-güncelle: nesne->nesne
(define(ana-tehlike-güncelle n)(nesne(nesne-imaj n)
                                     (cond
                                       ((< (v-x(nesne-yer n))0)(v (image-width BACKGROUND) 400))
                                       (else (nesne-yer n)))
                                       (v -20 0)(v 0 0)))
                                                                                         
                                  
;uzaklık: vektör vektör-> sayı
(define (uzaklık v1 v2)(sqrt (+ (sqr (- (v-x v1) (v-x v2))) (sqr (- (v-y v1) (v-y v2))))))



(define arkadış (+ (image-width(evren-bg yaradılış)) (/ (image-width(nesne-imaj(evren-n7 yaradılış))) 2)))






;çarpışma: evren->evren
(define(çarpışma e)
  (cond
 ((< (uzaklık(nesne-yer(evren-n1 e))(nesne-yer(evren-n5 e)))
     (+ (/ (image-width (nesne-imaj(evren-n5 e))) 4) (/ (image-width (nesne-imaj(evren-n1 e))) 4)))
        (evren (evren-bg e)
        (evren-n1 e)
        (nesne(nesne-imaj(evren-n5 e))
                         (v arkadış 300)(v -5 0)(v 0 0))
        (evren-n6 e)
        (evren-n7 e)
        (evren-n8 e)
        (evren-n9 e)
        (evren-n10 e)
        (evren-n11 e)
        (- (evren-skor e) 10)))

    ((< (uzaklık(nesne-yer(evren-n1 e))(nesne-yer(evren-n6 e)))
     (+ (/ (image-width (nesne-imaj(evren-n6 e))) 4) (/ (image-width (nesne-imaj(evren-n1 e))) 4)))
        (evren (evren-bg e)
        (evren-n1 e)
        (evren-n5 e)
        (nesne(nesne-imaj(evren-n6 e))
                         (v arkadış 375)(v -20 0)(v 0 0))
        (evren-n7 e)
        (evren-n8 e)
        (evren-n9 e)
        (evren-n10 e)
        (evren-n11 e)
        (- (evren-skor e) 10)))



    ((< (uzaklık(nesne-yer(evren-n1 e))(nesne-yer(evren-n7 e)))
     (+ (/ (image-width (nesne-imaj(evren-n7 e))) 4) (/ (image-width (nesne-imaj(evren-n1 e))) 4)))
        (evren (evren-bg e)
        (evren-n1 e)
        (evren-n5 e)
        (evren-n6 e)
        (nesne(nesne-imaj(evren-n7 e))
                       (v arkadış 400)(v -15 0)(v 0 0))
        (evren-n8 e)
        (evren-n9 e)
        (evren-n10 e)
        (evren-n11 e)
        (- (evren-skor e) 20)))

    ((< (uzaklık(nesne-yer(evren-n1 e))(nesne-yer(evren-n8 e)))
     (+ (/ (image-width (nesne-imaj(evren-n8 e))) 4) (/ (image-width (nesne-imaj(evren-n1 e))) 4)))
        (evren (evren-bg e)
        (evren-n1 e)
        (evren-n5 e)
        (evren-n6 e)
        (evren-n7 e)
        (nesne(nesne-imaj(evren-n8 e))
              (v arkadış 75)(v -17 0)(v 0 0))
        (evren-n9 e)
        (evren-n10 e)
        (evren-n11 e)
        (- (evren-skor e) 10)))

    ((< (uzaklık(nesne-yer(evren-n1 e))(nesne-yer(evren-n9 e)))
     (+ (/ (image-width (nesne-imaj(evren-n9 e))) 4) (/ (image-width (nesne-imaj(evren-n1 e))) 4)))
        (evren (evren-bg e)
        (evren-n1 e)
        (evren-n5 e)
        (evren-n6 e)
        (evren-n7 e)
        (evren-n8 e)
        (nesne(nesne-imaj(evren-n9 e))
                       (v arkadış 150)(v -15 0)(v 0 0))
        (evren-n10 e)
        (evren-n11 e)
        (- (evren-skor e) 10)))


 ((< (uzaklık(nesne-yer(evren-n1 e))(nesne-yer(evren-n10 e)))
     (+ (/ (image-width (nesne-imaj(evren-n10 e))) 4) (/ (image-width (nesne-imaj(evren-n1 e))) 4)))
        (evren (evren-bg e)
        (evren-n1 e)
        (evren-n5 e)
        (evren-n6 e)
        (evren-n7 e)
        (evren-n8 e)
        (evren-n9 e)
        (nesne(nesne-imaj(evren-n10 e))
                       (v arkadış 225)(v -10 0)(v 0 0))
        (evren-n11 e)
        (- (evren-skor e) 10)))

    



((< (uzaklık(nesne-yer(evren-n1 e))(nesne-yer(evren-n11 e)))
     (+ (/ (image-width (nesne-imaj(evren-n11 e))) 4) (/ (image-width (nesne-imaj(evren-n1 e))) 4)))
        (evren (evren-bg e)
        (evren-n1 e)
       (evren-n5 e)
        (evren-n6 e)
        (evren-n7 e)
        (evren-n8 e)
         (evren-n9 e)
        (evren-n10 e)
        (nesne (nesne-imaj(evren-n11 e))
               (v (random 0 1049) (random 0 458)) (v 0 0) (v 0 0)) 
         (+ (evren-skor e) 20)))

   





  (else
     (evren (evren-bg e)
        (evren-n1 e)
        (evren-n5 e)
        (evren-n6 e)
        (evren-n7 e)
        (evren-n8 e)
        (evren-n9 e)
        (evren-n10 e)
        (evren-n11 e)
        (evren-skor e)))))
        
 






  ;;oyuncu hareket
;;oyuncu-guncelle sayi metin -> sayi
(define  oyuncu-adım 25)
(define oyuncu-adım2 25)

(define (oyuncu-güncelle n yön)
 (nesne
   (nesne-imaj n)
   
   (cond
     ((string=? yön "left")(v ( -(v-x (nesne-yer n)) (v-x(nesne-hız n)))(v-y (nesne-yer n))))
     ((string=? yön "right")(v ( +(v-x (nesne-yer n)) (v-x(nesne-hız n)))(v-y (nesne-yer n))))
     ((string=? yön "up")
     (cond
     ;(and (> (+ (v-y(nesne-yer n)) (/ (image-height(nesne-imaj n)) 2)) 0)
           ((> (v-y(nesne-yer n)) (/ (image-height (nesne-imaj n))2)) 
     (v (v-x (nesne-yer n)) (- (v-y (nesne-yer n)) oyuncu-adım)))
      (else (nesne-yer n))))


     ((string=? yön "down")
     (cond
     ((<= (v-y(nesne-yer n)) (- (image-height BACKGROUND) (/ (image-height (nesne-imaj n))2)))
      (v (v-x(nesne-yer n))(+ oyuncu-adım (v-y(nesne-yer n)))))
     (else (nesne-yer n))))


     (else (nesne-yer n)))
   (v+ (nesne-hız n) (nesne-ivme n))
   (nesne-ivme n)))

;
               
  
;;evren-tus evren metin -> evren    
         
(define (evren-tuş e t)
 (cond
      ((string=? t " ") yaradılış)
      (else
    (evren
   (evren-bg e)
   (oyuncu-güncelle (evren-n1 e) t)
   (evren-n5 e)
   (evren-n6 e)
   (evren-n7 e)
   (evren-n8 e)
   (evren-n9 e)
   (evren-n10 e)
   (evren-n11 e)
   (evren-skor e)))))
     
             




   

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
  (on-release evren-tuş)
  (on-mouse evren-fare)))
