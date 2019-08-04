 #lang racket
(require "teachpacks/evren-teachpack.rkt")
;; STRUCT v - vektör
;; x : sayı - x koordinatı
;; y : sayı - y koordinatı
(STRUCT v (x y))

;; v+ - vektör toplama  
;; v+ : v v ->
(ÖRNEK (v+ (v 5 7) (v 8 4))(v 13 11))
 (define (v+ v1 v2)
    (v (+ (v-x v1) (v-x v2))(+ (v-y v1) (v-y v2))))
;(ÖRNEK ....)
;(ÖRNEK ....)

;; v- - vektör çıkartma
;; v- : v v ->
(ÖRNEK (v- (v 9 8) (v 4 6 )) (v 5 2))
 (define (v- v1 v2) 
   (v (- (v-x v1) (v-x v2))(- (v-y v1) (v-y v2))))
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)

;; v* - vektör sayıyla çarpma
;; v* : v v ->
(ÖRNEK (v* (v 8 6) 2) (v 16 12))
  (define (v* v1 s)
    (v (* (v-x v1) s)(* (v-y v1)s)))
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)

;; v. - vektör dot çarpma
;; v. : v v -> 
(ÖRNEK (v. (v 2 5 ) (v 4 3)) 23)
 (define (v. v1  v2)
   (+ (* (v-x v1) (v-x v2)) (* (v-y v1) (v-y v2))))

    
;;
;(ÖRNEK ....)
;(ÖRNEK ....)

;; v-mag - vektör uzunluğu
;; v -> sayı
(ÖRNEK (v-mag (v 3 4)) 5)
  (define (v-mag v1 )
    (sqrt (+ (sqr (v-x v1)) (sqr (v-y v1)))))
;;
;(ÖRNEK ....)
;(ÖRNEK ....)

(STRUCT nesne (imaj yer hız ivme))

(ÖRNEK (nesne-çiz (nesne (circle 10 "solid" "red" )
                               (v 50 50) (v 0 0) (v 0 0))
                         (square 100 "solid" "yellow"))
       (place-image/v (circle 10 "solid"  "red")
                               (v 50 50)
                         (square 100 "solid" "yellow")))
(define (nesne-çiz n ap)
  (place-image/v (nesne-imaj n)
        (nesne-yer n) ap))


(define (nesne-fizik-güncelle n)
  (nesne
    (nesne-imaj n)
    (v+ (nesne-yer n) (nesne-hız n))
    (v+ (nesne-hız n) (nesne-ivme n))
    (nesne-ivme n)))
      
(STRUCT evren (arkaplanı galp m1 m2 m3 m4 m5 kalp skor))
; evren-çiz : evren -> görüntü
 
 (define (evren-çiz e)
   (nesne-çiz (evren-galp e)
              (nesne-çiz (evren-m1 e)
                         (nesne-çiz (evren-m2 e)
                                    (nesne-çiz (evren-m3 e)
                                               (nesne-çiz (evren-m4 e)
                                                          (nesne-çiz (evren-m5 e)
                                                                     (nesne-çiz(evren-kalp e)
                                                                               (place-text/v (v 100 50)(string-append "SKOR: "(number->string (evren-skor e))) 22 "black"
                                                                                             (place-text/v (v 625 50) "AVOID THE DEVİL" 22 "black"
                                                                                                           (evren-arkaplanı e)))))))))))


                        
            
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

(define test-square (square 100 "solid" "green"))
(define test-circle (circle 10 "solid" "red"))
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


 ;STRUCT nesne
; imaj : görüntü - nesneini imajı
; yer : v - nesnenin ekrandaki yeri
; hız : v - nesnenin hızı
; ivme : v - nesnenin ivmesi



;; STRUCT evren
;; arkaplanı : görüntü - oyun arka planı
;;

(define (evren-güncelle e)
  (cond ((< (evren-skor e) 0) (evren (bitmap "imaj/IMG_0112.png")
                          (nesne (nesne-imaj (evren-galp e))(v 900 900) (v 0 0) (v 0 0))
                          (nesne (nesne-imaj (evren-m1 e))(v 900 900)(v 0 0 ) (v 0 0))
                          (nesne (nesne-imaj (evren-m2 e))(v 900 900) (v 0 0) (v 0 0))
                          (nesne (nesne-imaj (evren-m3 e))(v 900 900) (v 0 0) (v 0 0))
                          (nesne (nesne-imaj (evren-m4 e))(v 900 900) (v 0 0) (v 0 0))
                          (nesne (nesne-imaj (evren-m5 e))(v 900 900) (v 0 0) (v 0 0))
                          (nesne (nesne-imaj (evren-kalp e))(v 900 900) (v 0 0) (v 0 0))
                          (evren-skor e)))
                                 
           (else (evren (evren-arkaplanı e)
              (nesne-fizik-güncelle (evren-galp e))
              (döndür (nesne-fizik-güncelle (evren-m1 e)))
              (döndür (nesne-fizik-güncelle (evren-m2 e)))
              (döndür (nesne-fizik-güncelle (evren-m3 e)))
              (döndür (nesne-fizik-güncelle (evren-m4 e)))
              (döndür (nesne-fizik-güncelle (evren-m5 e)))
              (döndür (nesne-fizik-güncelle (evren-kalp e))) (evren-skor e)))))
  
(define (uzaklık v1 v2)
  (sqrt (+ (sqr(- (v-x v1) (v-x v2))) (sqr (- (v-y v1)(v-y v2))))))





;evren-çarpışma : evren -> evren


(define(evren-çarpışma e)
        (cond
          ((< (evren-skor e)  0) e)
          ((< (uzaklık (nesne-yer (evren-galp e)) (nesne-yer(evren-m1 e))) 54)(evren BACKGROUND
                                                                                     (nesne-fizik-güncelle (evren-galp e))
                                                                                     (nesne (rotate 241 (scale 0.1(bitmap "mızrak.png")))(v (random 25 725)0)(v 0 7)(v 0 0))
                                                                                     (nesne-fizik-güncelle (evren-m2 e))
                                                                                     (nesne-fizik-güncelle (evren-m3 e))
                                                                                     (nesne-fizik-güncelle (evren-m4 e))
                                                                                     (nesne-fizik-güncelle (evren-m5 e))
                                                                                     (nesne-fizik-güncelle (evren-kalp e))
                                                                                     (- (evren-skor e) 10)))
          ((< (uzaklık (nesne-yer (evren-galp e)) (nesne-yer(evren-m2 e))) 54)(evren BACKGROUND
                                                                                     (nesne-fizik-güncelle (evren-galp e))
                                                                                     (nesne-fizik-güncelle (evren-m1 e))
                                                                                     (nesne(rotate 241 (scale 0.1(bitmap "mızrak.png")))(v (random 25 725)0)(v 0 7)(v 0 0))
                                                                                     (nesne-fizik-güncelle (evren-m3 e))
                                                                                     (nesne-fizik-güncelle (evren-m4 e))
                                                                                     (nesne-fizik-güncelle (evren-m5 e))
                                                                                     (nesne-fizik-güncelle (evren-kalp e))
                                                                                     (- (evren-skor e) 10)))
          
          ((< (uzaklık (nesne-yer (evren-galp e)) (nesne-yer(evren-m3 e))) 54)(evren BACKGROUND
                                                                                     (nesne-fizik-güncelle (evren-galp e))
                                                                                     (nesne-fizik-güncelle (evren-m1 e))
                                                                                     (nesne-fizik-güncelle (evren-m2 e))
                                                                                     (nesne(rotate 241 (scale 0.1(bitmap "mızrak.png")))(v (random 25 725)0)(v 0 7)(v 0 0))
                                                                                     (nesne-fizik-güncelle (evren-m4 e))
                                                                                     (nesne-fizik-güncelle (evren-m5 e))
                                                                                     (nesne-fizik-güncelle (evren-kalp e))
                                                                                     (- (evren-skor e) 10)))
          ((< (uzaklık (nesne-yer (evren-galp e)) (nesne-yer(evren-m4 e))) 54)(evren BACKGROUND
                                                                                     (nesne-fizik-güncelle (evren-galp e))
                                                                                     (nesne-fizik-güncelle (evren-m1 e))
                                                                                     (nesne-fizik-güncelle (evren-m2 e))
                                                                                     (nesne-fizik-güncelle (evren-m3 e))
                                                                                     (nesne(rotate 241 (scale 0.1(bitmap "mızrak.png")))(v (random 25 725)0)(v 0 7)(v 0 0))
                                                                                     (nesne-fizik-güncelle (evren-m5 e))
                                                                                     (nesne-fizik-güncelle (evren-kalp e))
                                                                                     (- (evren-skor e) 10)))

          ((< (uzaklık (nesne-yer (evren-galp e)) (nesne-yer(evren-m5 e))) 54)(evren BACKGROUND
                                                                                     (nesne-fizik-güncelle (evren-galp e))
                                                                                     (nesne-fizik-güncelle (evren-m1 e))
                                                                                     (nesne-fizik-güncelle (evren-m2 e))
                                                                                     (nesne-fizik-güncelle (evren-m3 e))
                                                                                     (nesne-fizik-güncelle (evren-m4 e))
                                                                                     (nesne(rotate 241 (scale 0.1(bitmap "mızrak.png")))(v (random 25 725)0)(v 0 7)(v 0 0))
                                                                                     (nesne-fizik-güncelle (evren-kalp e))
                                                                                     (- (evren-skor e) 10)))
          ((< (uzaklık (nesne-yer (evren-galp e)) (nesne-yer(evren-kalp e))) 54)(evren BACKGROUND
                                                                                     (nesne-fizik-güncelle (evren-galp e))
                                                                                     (nesne-fizik-güncelle (evren-m1 e))
                                                                                     (nesne-fizik-güncelle (evren-m2 e))
                                                                                     (nesne-fizik-güncelle (evren-m3 e))
                                                                                     (nesne-fizik-güncelle (evren-m4 e))
                                                                                     (nesne-fizik-güncelle (evren-m5 e))
                                                                                     (nesne(scale 0.06(bitmap "kalp.png"))(v (random 25 725)0)(v 0 7)(v 0 0))
                                                                                     (+ (evren-skor e) 10)))
          (else
           (evren BACKGROUND
                                                                                     (nesne-fizik-güncelle (evren-galp e))
                                                                                     (nesne-fizik-güncelle (evren-m1 e))
                                                                                     (nesne-fizik-güncelle (evren-m2 e))
                                                                                     (nesne-fizik-güncelle (evren-m3 e))
                                                                                     (nesne-fizik-güncelle (evren-m4 e))
                                                                                     (nesne-fizik-güncelle (evren-m5 e))
                                                                                     (nesne-fizik-güncelle (evren-kalp e))
                                                                                     (evren-skor e)))))
          
                                                                                 
                                                                                     

       


(define (evren-tuş e t)
  (evren BACKGROUND
               (nesne (scale 0.1(bitmap "galp.png"))(cond
                                                     ((> (v-x (nesne-yer (evren-galp e))) (- 750 54)) (v (- (v-x(nesne-yer(evren-galp e))) 30) 360 ))
                                                     ((< (v-x (nesne-yer (evren-galp e))) (+ 0 54) )(v (+ (v-x(nesne-yer(evren-galp e))) 30) 360))
                                                     (else (cond
                                                             ((string=? t "right")(v  (+ 30 (v-x (nesne-yer(evren-galp e)))) 360 ))
                                                             ((string=? t "left")(v (- (v-x(nesne-yer(evren-galp e))) 30) 360))
                                                             (else (nesne-yer (evren-galp e))))))
                                                           (v 0 0)(v 0 0))
               (nesne-fizik-güncelle(evren-m1 e))
               (nesne-fizik-güncelle(evren-m2 e))
               (nesne-fizik-güncelle(evren-m3 e))
               (nesne-fizik-güncelle(evren-m4 e))
               (nesne-fizik-güncelle(evren-m5 e))
               (nesne-fizik-güncelle(evren-kalp e))
               (evren-skor e)))
(define (döndür m)
  (cond
    ((>(- (v-y (nesne-yer m)) (/ (image-height (nesne-imaj m))2))
      (image-height BACKGROUND))
     (nesne
      (nesne-imaj m)
      (v (random 25 725) (- 0 (/ (image-height (nesne-imaj m))2)))
      (nesne-hız m)
      (nesne-ivme m)))
    (else m)))

(define (evren-fare e x y m)
  e)


(define BACKGROUND (bitmap "ASKN6895.jpeg")) 

(define FRAME-RATE 30)

(define avoid-the-devil
      (evren BACKGROUND
               (nesne (scale 0.1(bitmap "galp.png"))(v 375 360 )(v 0 0)(v 0 0))
               (nesne (rotate 241(scale 0.1(bitmap "mızrak.png")))(v (random 25 725) 0)(v 0 7)(v 0 0))
               (nesne (rotate 241(scale 0.1(bitmap "mızrak.png")))(v (random 25 725) 0)(v 0 7)(v 0 0))
               (nesne (rotate 241(scale 0.1(bitmap "mızrak.png")))(v (random 25 725) 0)(v 0 7)(v 0 0))
               (nesne (rotate 241(scale 0.1(bitmap "mızrak.png")))(v (random 25 725) 0)(v 0 7)(v 0 0))
               (nesne (rotate 241(scale 0.1(bitmap "mızrak.png")))(v (random 25 725) 0)(v 0 7)(v 0 0))
               (nesne (scale 0.06(bitmap "kalp.png"))(v (random 25 275) 0)(v 0 7)(v 0 0))
               0))






;; SES herhangbirşey ses-dosyası-metin -> herhangibirşey
;; birinci paramatresini aynen dönsürüyor, sesi çalarak
;(ÖRNEK (SES 0 "ses/bark.wav) 0)

(test)
(define( evren*real-güncelle e) (evren-çarpışma (evren-güncelle e)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sabit kod bundan sonra                               ;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(yut (big-bang avoid-the-devil
  (on-tick evren*real-güncelle (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)
  (on-mouse evren-fare)))


