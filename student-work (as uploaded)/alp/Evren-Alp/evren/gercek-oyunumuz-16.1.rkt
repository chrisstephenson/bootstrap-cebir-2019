#lang racket
(require "teachpacks/evren-teachpack.rkt")
;; STRUCT v - vektör
;; x : sayı - x koordinatı
;; y : sayı - y koordinatı
(STRUCT v (x y))

;; v+ - vektör toplama
;(STRUCT (+ (v-x)(v-y))
;(define (STRUCT Vektör1 v x y)(Vektör1 v x y)) 
(ÖRNEK (v+ (v 1 2) (v 2 3))( v 3 5))
(ÖRNEK (v+ (v 1 5) (v 2 4)) (v 3 9))
(define (v+ v1 v2)
 (v (+ (v-x v1) (v-x v2)) (+ (v-y v1) (v-y v2))))
;; v- - vektör çıkartma
;; 
;;
(ÖRNEK (v- (v 7 8 ) (v 1 2))(v 6 6))
(ÖRNEK (v- (v 9 3 ) (v 5 1 )) (v 4 2))
(define (v- v1 v2)
 (v (- (v-x v1) (v-x v2)) (- (v-y v1) (v-y v2))))
;; v* - vektör sayıyla çarpma
;; 
;;
;(ÖRNEK ....)
(ÖRNEK (v* (v 3 4) 5) (v 15 20))
(define (v* v1 s) (v (* (v-x v1) s) (* (v-y v1) s)))
;; v. - vektör dot çarpma
;; 
;;
;(ÖRNEK ....)
(ÖRNEK (v. (v 1 2) (v 3 4)) 11)
(define (v. v1 v2) (+ (* (v-x v1) (v-x v2))(* (v-y v1) (v-y v2)))) 
;; v-mag - vektör uzunluğu
;; 
;;
;(ÖRNEK ....)
(ÖRNEK (v-mag (v 3 4)) 5)
(define (v-mag v1) (sqrt (+ (sqr(v-x v1)) (sqr(v-y v1))))) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Hediye vektör çizim fonksiyonları 
 ;Vektör STRUCT tanıttıktan sonra bu fonkisyonları uncomment edebilirsiniz
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;place-image/v
; resim v sahne -> sahne
; bir sahneye vectöre göre bir imaj yerleştir
; template :
; (define (place-image/v v1 sahne))
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

(STRUCT nesne (imaj yer hız ivme))
;(nesne-çiz nesne görüntü ->görüntü
;(nesneyi ve enlem arkaplanına çizmek.

(ÖRNEK (nesne-çiz
       (nesne (circle 10 "solid" " red") (v 50 50) (v 0 0) (v 0 0))
       (square 100 "solid" " yellow")) ( place-image/v (circle 10 "solid" "red") (v 50 50)
       (square 100 "solid" " yellow")))
                                                      
(define ( nesne-çiz n arkaplan) (place-image/v (nesne-imaj n) (nesne-yer n) arkaplan))
; STRUCT evren
; arkaplanı : görüntü - oyun arka planı
;
(STRUCT evren (bg n1 n2 n3 n4 n5 score-1 score-2 timer))

;
(define (nesne-fizik-güncelle e)
  (nesne (nesne-imaj e)(v+ (nesne-yer e)(nesne-hız e))(v+ (nesne-hız e)(nesne-ivme e))(nesne-ivme e))) 

(ÖRNEK (evren-çiz (evren BACKGROUN
                         (nesne (scale 0.3 (bitmap "imaj/golüst.png")) (v 320 240) (v 0 0) (v 0 0 ))
                         (nesne (scale 0.36 (bitmap "imaj/para.png")) (v 320 240) (v 0 0) ( v 0 0))
                         (nesne (scale 0.3 (bitmap "imaj/kosedeki.png")) (v 320 240) (v -192  50) ( v 128 290 ))
                         (nesne (scale 0.36 (bitmap "imaj/para.png")) (v 320 240) (v 0 0) ( v 0 0 ))
                         (nesne (scale 0.36 (bitmap "imaj/para.png")) (v 320 240) (v 0 0) (v 0 0))1 1 0))         
                  (place-text/v (v 320 55) (string-append (string-append "Score_1 : " (number->string 1)) 
                                                         (string-append " Score_2 : " (number->string 1))) 40 "red"
                                                         (nesne-çiz (nesne (scale 0.3 (bitmap "imaj/golüst.png")) (v 320 240) (v 0 0)(v 0 0))
                             (nesne-çiz (nesne (scale 0.36 (bitmap "imaj/para.png")) (v 340 240) (v 0 0) ( v 0 0 ))
                                        (nesne-çiz (nesne (scale 0.3 (bitmap "imaj/kosedeki.png")) (v 320 240) (v 0 0)(v 0 0)) 
                                        (nesne-çiz (nesne (scale 0.36 (bitmap "imaj/para.png")) (v 340 240) (v 0 0)(v 0 0)) 
                                        (nesne-çiz (nesne (scale 0.36 (bitmap "imaj/para.png")) (v 340 240) (v 0 0)(v 0 0)) 
                                        BACKGROUND)))))))
(define (evren-çiz e)
    (place-text/v (v 320 55)
                   (string-append (string-append "Score : " (number->string 
              (çarpıştı-mı? (nesne-yer (evren-n3 e)) (nesne-yer (evren-n2 e)) (evren-score-1 e))))
                                  (string-append " Score : " (number->string
              (çarpıştı-mı-2? (nesne-yer (evren-n1 e)) (nesne-yer (evren-n2 e)) (evren-score-2 e))))) 40 "red"
                   
        (nesne-çiz (evren-n1 e)
             (nesne-çiz (evren-n2 e)
                        (nesne-çiz (evren-n3 e)
                                   (nesne-çiz (evren-n4 e)
                                              (nesne-çiz (evren-n5 e)
                                                         (evren-bg e))))))))


(define (evren-tuş e t)
  (evren (evren-bg e) (oyuncu-2 (evren-n1 e) t) (evren-n2 e)(oyuncu-1 (evren-n3 e) t)
         (evren-n4 e)(evren-n5 e)(evren-score-1 e)(evren-score-2 e) (evren-timer e))) 

(define (evren-fare e x y m)
  e)


(define BACKGROUND (bitmap "imaj/arkaplan.png")) 

(define FRAME-RATE 12)

(define (mesafe n1 n2)
  (v-mag (v-  n1  n2)))

;nesne nesne ->boolean


(define (çarpıştı-mı? a b s)
(cond
((<= (mesafe a b) 40) ( + s 10))
(else s)))


(define (çarpıştı-mı-2? a b s)
(cond
((<= (mesafe a b) 40) ( + s 10))
(else s)))

(define yaradılış (evren BACKGROUND
                         (nesne (scale 0.3 (bitmap "imaj/golüst.png")) (v 480 240) (v 0 0) (v 0 0))
                         (nesne (scale 0.36 (bitmap "imaj/para.png")) (v 320 240) (v 0 0) (v 0 0))
                         (nesne (scale 0.3 (bitmap "imaj/kosedeki.png")) (v 240 240) (v 0 0) (v 0 0))
                         (nesne (scale 0.36 (bitmap "imaj/1234.png")) (v 600 600) (v 0 0) (v 0 0))
                         (nesne (scale 0.36 (bitmap "imaj/para.png")) (v 600 600) (v 0 0) (v 0 0)) 10 10 0))
(ÖRNEK
   (evren-güncelle yaradılış)
   (evren BACKGROUND
  (nesne-fizik-güncelle (nesne(scale 0.3 (bitmap "imaj/golüst.png"))(v 480 240)(v 0 0)(v 0 0)))
  (nesne-fizik-güncelle (nesne(scale 0.36 (bitmap "imaj/para.png"))(v 320 240)(v 0 0)(v 0 0)))
  (nesne-fizik-güncelle (nesne(scale 0.3 (bitmap "imaj/kosedeki.png"))(v 240 240)(v -192 50)(v 0 0)))
  (nesne-fizik-güncelle (nesne(scale 0.36 (bitmap "imaj/1234.png"))(v 320 240)(v 0 0)(v 0 0)))
  (nesne-fizik-güncelle (nesne(scale 0.36 (bitmap "imaj/para.png"))(v 320 240)(v 0 0)(v 0 0))) 10 10 0))
(define (evren-güncelle e)
  (evren (evren-bg e)
         (sağ-üste-gitme (nesne-fizik-güncelle(evren-n1 e)))
         (cond ((or (<= (mesafe (nesne-yer (evren-n1 e))(nesne-yer (evren-n5 e))) 80)
                   (<= (mesafe (nesne-yer (evren-n3 e))(nesne-yer (evren-n5 e))) 80))
                    (nesne (nesne-imaj (evren-n2 e))
                           (v 600 600)
                           (v 0 0)
                           (v 0 0)))
               (else (evren-n2 e)))
         
         (sol-alta-gitme (nesne-fizik-güncelle(evren-n3 e)))
         (nesne-fizik-güncelle(evren-n4 e))
         (nesne-fizik-güncelle(evren-n5 e))
         (çarpıştı-mı? (nesne-yer (evren-n3 e)) (nesne-yer (evren-n2 e))(evren-score-1 e))
         (çarpıştı-mı-2? (nesne-yer (evren-n1 e)) (nesne-yer (evren-n2 e))(evren-score-2 e))
         (+ (evren-timer e) 1)))


; nesne->nesne 
(define (sol-alta-gitme n)(nesne (nesne-imaj n)
(cond ((and (>= (v-x (nesne-yer n)) 120 )(<= (v-y (nesne-yer n)) 410 ))(v+ (nesne-yer n) (v -20 20)))
(else (nesne-yer n)))(nesne-hız n)(nesne-ivme n)))
; nesne->nesne
(define (sağ-üste-gitme n)(nesne (nesne-imaj n)
(cond ((and (<= (v-x (nesne-yer n)) 520 )(>= (v-y (nesne-yer n)) 70 ))(v+ (nesne-yer n) (v +20 -20)))
(else (nesne-yer n)))(nesne-hız n)(nesne-ivme n)))


(define (oyuncu-1 n t)
(nesne (nesne-imaj n)
       (cond
        ((string=? t "w") (v (v-x (nesne-yer n))(- (v-y (nesne-yer n)) 100)))
        ((string=? t "d")(v (+ (v-x (nesne-yer n)) 100) (v-y (nesne-yer n))))
        (else (nesne-yer n))) (nesne-hız n)(nesne-ivme n)))
(define (oyuncu-2 n t)
(nesne (nesne-imaj n)
       (cond
        ((string=? t "down") (v (v-x (nesne-yer n))(+ (v-y (nesne-yer n)) 100)))
        ((string=? t "left")(v (- (v-x (nesne-yer n)) 100) (v-y (nesne-yer n))))
        (else (nesne-yer n))) (nesne-hız n)(nesne-ivme n)))        


;; SES herhangbirşey ses-dosyası-metin -> herhangibirşey
;; birinci paramatresini aynen dönsürüyor, sesi çalarak
;(ÖRNEK (SES 0 "ses/glass.wav") 0)

(test)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sabit kod bundan sonra                               ;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(yut (big-bang yaradılış
  (on-tick evren-güncelle (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)
  (on-mouse evren-fare)))

;evren-güncelle evren->evren
;amaç -> evrenin bir frame sonraki değerini vermek
;(ÖRNEK (evren güncelle yaradılış)
;       (evren BACKGROUND
;       (nesne(circle 30 "solid" "red")



;nasıl hitbox definlıycaz?
;(define (oyuncu-1-çarpıştı-mı? n1 n2 n3 e ) ((cond (= (v- (nesne-yer n3) (nesne-yer n2)) (v 0 0))(+ ((score-1 e) 1))))
;(else nesne-yer e (v 0 0)))




;(define (oyuncu-2-çarpıştı-mı? n) (cond (= (v- (nesne-yer n3)(nesne-yer n2))(nesne (v 0 0))(+ (score-2 1))))
;(else nesne-yer n))

;(define (oyuncu-1-kazandı-mı? n t)) (cond (= (score-1 3)))
;((nesne-çiz (scale y (bitmap "x şey".png)))(v a b) (v c d) (v e f))


;(define (oyuncu-2-kazandı-mı? n t)) (cond (= (score-2 3)))
;((nesne-çiz (scale y (bitmap "x şey".png/jpg)))(v a b) (v c d) (v e f)
;(else )) 


;(((define (para-alındı-mı a b))(cond (or (= (- (n3 n2) 0))) (= (- (n1 n2) 0)))(else ))
;(nesne-çiz (scale u (bitmap "transparantşey.png/jpg"))))
;(birkaç saniye sonra aynı ya da eksi paranın çıkmasını nasıl sağlıyacağım?))))


;(cond (çarpıştı-mı? ) (nesne (bitmap "imaj/1234.png")))
;(else (nesne (scale 0.36 (bitmap "imaj/para.png"))))
;(define (oyuncu-1-kazandı-mı?