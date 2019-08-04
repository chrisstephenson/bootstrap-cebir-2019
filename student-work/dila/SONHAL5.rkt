#lang racket
(require "teachpacks/evren-teachpack.rkt")


(define BACKGROUND (bitmap "imaj/bgseviye1.png")) 
(define PLAYER (bitmap "imaj/oyuncuseviye1.png"))
(define SHOOT (bitmap "imaj/Shoot/gizemseviye1.png"))
(define ENEMY (bitmap "imaj/tehlike-seviye-1.png"))
(define ENEMY2 (bitmap "imaj/Fx/Background/Meteor5.png"))
(define TARGET (bitmap "imaj/hedefseviye1.png"))
(define FRAME-RATE 12)
(define ekran-genişliği (image-width BACKGROUND))
(define ekran-yüksekliği (image-height BACKGROUND))
(define oyuncu-yüksekliği (image-height PLAYER))
(define oyuncu-genişliği (image-width PLAYER))
(define tehlike-yüksekliği (image-height ENEMY))
(define tehlike-genişliği (image-width ENEMY))
(define tehlike2-yüksekliği (image-height ENEMY2))
(define tehlike2-genişliği (image-width ENEMY2))
(define hedef-genişliği (image-width TARGET))
(define nesne-genişliği (max (image-width TARGET)
                             (image-width ENEMY)
                             (image-width ENEMY2)))
(define nesne-genişliği-az (min (image-width TARGET)
                             (image-width ENEMY)
                             (image-width ENEMY2)))
(define oyuncu-yüksekliği2 (/ oyuncu-yüksekliği 2))
(define oyuncu-genişliği2 (/ oyuncu-genişliği 2))
(define tehlike-yüksekliği2 (/ tehlike-yüksekliği 2))
(define tehlike-genişliği2 (/ tehlike-genişliği 2))


;STRUCT v - vektör
;x : sayı - x koordinatı
;y : sayı - y koordinatı
(STRUCT v (x y))

;; v+ - vektör toplama
;; 
;;
(ÖRNEK (v+ (v 3 5) (v 7 2)) (v (+ 3 7) (+ 5 2)))
(define (v+ v1 v2 ) (v (+ (v-x v1) (v-x v2)) (+ (v-y v1) (v-y v2))))
;(ÖRNEK ....)

;; v- - vektör çıkartma
;; 
;;
(ÖRNEK (v- (v 7 9) (v 4 2)) (v (- 7 4) (- 9 2)))
(ÖRNEK (v- (v 4 20) (v 8 3)) (v (- 4 8) (- 20 3)))
(define (v- v1 v2 ) (v (- (v-x v1) (v-x v2)) (- (v-y v1) (v-y v2))))

;; v* - vektör sayıyla çarpma
;; 
;;
(ÖRNEK (v* (v 2 -3) 4) (v 8 -12))
(ÖRNEK (v* (v 7 13) 0) (v 0 0))
(define (v* vk s)
        (v (* s (v-x vk))
           (* s (v-y vk))))

;; v. - vektör dot çarpma
;; 
;;
;v.:vektör vektör->sayı
(ÖRNEK (v. (v 6 4) (v 5 2)) (+ (* 6 5) (* 4 2)))
(ÖRNEK (v. (v 7 3) (v 9 1)) (+ (* 7 9) (* 3 1)))
(define (v. v1 v2) (+ (* (v-x v1) (v-x v2))  (* (v-y v1) (v-y v2))))

;; v-mag - vektör uzunluğu
;; 
;;
(ÖRNEK (v-mag (v 3 4)) (sqrt (+ (sqr 3) (sqr 4))))
(ÖRNEK (v-mag (v 6 8)) (sqrt (+ (sqr 6) (sqr 8))))
(define (v-mag v1) (sqrt (+ (sqr (v-x v1)) (sqr (v-y v1)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hediye vektör çizim fonksiyonları
;; Vektör STRUCT tanıttıktan sonra bu fonkisyonları uncomment edebilirsiniz
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;place-image/v
;; resim v sahne -> sahne
;; bir sahneye vectöre göre bir imaj yerleştir
;; template :
(STRUCT nesne (imaj yer hız ivme))

(ÖRNEK (nesne-çiz (nesne (circle 10 "solid" "yellow")
                          (v 50 50) (v 0 0) (v 0 0))
                  (square 100 "solid" "blue"))
       (place-image/v (circle 10 "solid" "yellow") (v 50 50)
                      (square 100 "solid" "blue")))
(define (nesne-çiz n ap) 
  (place-image/v (nesne-imaj n) (nesne-yer n) ap))



;nesne-fizik-güncelle:nesne->nesne
(ÖRNEK (nesne-fizik-güncelle
        (nesne (circle 10 "solid" "red") (v 50 50) (v 2 3) (v 4 5)))
       (nesne (circle 10 "solid" "red") (v 52 53) (v 6 8) (v 4 5)))


(define (nesne-fizik-güncelle n)
        (nesne (nesne-imaj n)
        (v+ (nesne-yer n) (nesne-hız n))
        (v+ (nesne-hız n) (nesne-ivme n))
        (nesne-ivme n)))


;(define (place-image/v im v1 sahne)
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
;
(define (place-image/v im v1 sahne)
  (place-image/align im (v-x v1) (v-y v1) "center" "center"  sahne))

;; place-line/v v v color görüntü -> görüntü
;; v1'den v2'e giden bir çizgi arka imajına yerleştir
(ÖRNEK (place-line/v (v 2 3) (v 5 1) "red" test-square)
       (add-line test-square 2 3 5 1 "red")) 
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

(define (SCORE nesne) (place-text/v (v 120 30) "SPACE EXPLORER" 20 "light blue" nesne))



; STRUCT nesne
;; imaj : görüntü - nesnenini imajı
;; yer : v - nesnenin ekrandaki yeri
;; hız : v - nesnenin hızı
;; ivme : v - nesnenin ivmesi



;; STRUCT evren
;; arkaplanı : görüntü - oyun arka planı
;;
;n1:player
;n2:enemy
;n3:enemy2
;n4:target
(STRUCT evren (score arkaplanı n1 n2 n3 n4))


               

(ÖRNEK (evren-güncelle yaradılış) (evren 1 BACKGROUND
  (nesne PLAYER (v 30 100) (v 30 -33) (v 0 0))
  (nesne ENEMY (v 350 300) (v -20 0) (v 0 0))
  (nesne ENEMY2 (v 350 146) (v 0 16) (v 0 0))
  (nesne TARGET (v 306 270) (v 6 0) (v 0 0))))
;evren-güncelle: evren:evren
(define (evren-güncelle e)
 (çarpışma  (evren
   (evren-score e)
   (evren-arkaplanı e)
   (evren-n1 e)
   (tehlike-güncelle(nesne-fizik-güncelle (evren-n2 e)))
   (tehlike2-güncelle (nesne-fizik-güncelle (evren-n3 e)))
   (hedef-güncelle (nesne-fizik-güncelle (evren-n4 e))))))
;evren-çiz: evren:evren
(ÖRNEK (evren-çiz (evren 0 BACKGROUND
                         (nesne (circle 10 "solid" "red") (v 50 50) (v 0 0) (v 0 0))
                         (nesne (square 20 "solid" "green") (v 100 150) (v 0 0) (v 0 0))
                         (nesne (triangle 30 "solid" "yellow") (v 200 500) (v 0 0) (v 0 0))
                         (nesne (circle 40 "solid" "blue") (v 300 200) (v 0 0) (v 0 0))))
 (place-text/v (v 120 30) (string-append "SCORE " (number->string 0)) 20 "light blue"
                (nesne-çiz (nesne (circle 10 "solid" "red") (v 50 50) (v 0 0) (v 0 0))
                  (nesne-çiz  (nesne (square 20 "solid" "green") (v 100 150) (v 0 0) (v 0 0)))
                             (nesne-çiz (nesne (triangle 30 "solid" "yellow") (v 200 500) (v 0 0) (v 0 0)))
                                        (nesne-çiz (nesne (circle 40 "solid" "blue") (v 300 200) (v 0 0) (v 0 0)) BACKGROUND))))
               
                
      
       
(define (evren-çiz e)
  (place-text/v (v 120 30) (string-append "SCORE " (number->string (evren-score e))) 20 "light blue"
                (nesne-çiz (evren-n1 e)
                           (nesne-çiz  (evren-n2 e)
                                      (nesne-çiz (evren-n3 e)
                                                 (nesne-çiz (evren-n4 e)
                                                            (evren-arkaplanı e)))))))

(define (evren-tuş e t) 
 (evren (evren-score e) (evren-arkaplanı e) (oyuncu-güncelle (evren-n1 e) t) (evren-n2 e) (evren-n3 e) (evren-n4 e)))

(define (evren-fare e x y m) e)




(define yaradılış (evren 0 BACKGROUND
  (nesne PLAYER (v 30 100) (v 30 -33) (v 0 0))
  (nesne ENEMY (v 340 300) (v -20 0) (v 0 0))
  (nesne ENEMY2 (v 350 130) (v 0 16) (v 0 0))
  (nesne TARGET (v 300 270) (v 6 0) (v 0 0))))


  



;evren-çiz:evren->görüntü




;anim
;devamlı:boolean
;değişim-sıklığı:sayı
;zaman:sayı
;resim:görüntü-listesi
;(list ......) herhangi herhengi....->list of herhangi
;(length () list of herhangi->sayı
;(list-ref l n) list of herhangi sayı-> herhangi

;(STRUCT anim (resimler zaman değişim-sıklığı devamlı))
;;anim-çiz:anim->görüntü
;(ÖRNEK (anim-çiz (anim (true 3 13 (list (circle 10 "solid" "red")
;                                        (circle 15 "solid" "red")
;                                        (circle 20 "solid" "red")
;                                       (circle 25 "solid" "red")))))
;                 (square "10" "solid" "red"))
;
;(define (anim-çiz a)
;        (list-ref
;                (anim-resimler a)
;                (modulo(quotient(anim-zaman a)
;                (anim-değişim-sıklığı a)))
;                (length (anim-devamlı a))))

;anim-güncelle: anim->anim
;anim zaman arttırmak
;(ÖRNEK (anim-güncelle (anim true 3 11 (list...
;       (anim true 3 0 (list...
;(ÖRNEK (anim-güncelle (anim false 3 11 (list...
;       (anim false 3 11 (list...

;(define (anim-güncelle a)
;    (anim
;         (anim-devamlı a)
;         (anim-değişim-sıklığı a)
;         (anim-zaman-güncelle (anim-zaman a) (x (anim-değişim-sıklığı a
;         ((anim-resimler a)

;(STRUCT nesne
;imaj: ya görüntü ya anim

;(define (imaj-güncelle

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                     space-explorer                                   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;OYUNCU-GÜNCELLE;;;;;;;;
(define oyuncu-adım 30)
;oyuncu-güncelle: sayı metin->sayı
(ÖRNEK (oyuncu-güncelle (nesne test-circle (v 4 105) (v 0 0) (v 0 0 )) "up") (nesne test-circle (v 4 75) (v 0 0) (v 0 0 )))
(ÖRNEK (oyuncu-güncelle (nesne test-circle (v 4 35) (v 0 0) (v 0 0 )) "down") (nesne test-circle (v 4 65) (v 0 0) (v 0 0 )))
(ÖRNEK (oyuncu-güncelle (nesne test-circle (v 60 4) (v 0 0) (v 0 0)) "left") (nesne test-circle (v 30 4) (v 0 0) (v 0 0)))
(ÖRNEK (oyuncu-güncelle (nesne test-circle (v 40 4) (v 0 0) (v 0 0)) "right") (nesne test-circle (v 70 4) (v 0 0) (v 0 0)))

(define (oyuncu-güncelle n yön)
  (nesne (nesne-imaj n)
         (cond
    ((string=? yön "down")
                           (cond
                           ((> (- ekran-yüksekliği (/ oyuncu-yüksekliği 2)) (v-y (nesne-yer n)))  (v (v-x (nesne-yer n))(+ (v-y (nesne-yer n)) oyuncu-adım)))
                           (else (nesne-yer n))))
    ((string=? yön "up")
                             (cond
                             ((> (v-y (nesne-yer n)) (/ oyuncu-yüksekliği 2)) (v (v-x (nesne-yer n))(- (v-y (nesne-yer n)) oyuncu-adım)))
                             (else (nesne-yer n))))
    ((string=? yön "left")
                            (cond
                             ((> (v-x (nesne-yer n)) (/ oyuncu-genişliği 2)) (v (- (v-x (nesne-yer n)) oyuncu-adım) (v-y (nesne-yer n))))
                             (else (nesne-yer n))))
    ((string=? yön "right")
                            (cond
                             ((> (- ekran-genişliği (/ oyuncu-genişliği 2)) (v-x (nesne-yer n))) (v (+ (v-x (nesne-yer n)) oyuncu-adım) (v-y (nesne-yer n))))
                             (else (nesne-yer n))))
    (else (nesne-yer n)))
    (nesne-hız n) (nesne-ivme n)))


(define (tehlike2-güncelle n)
  (nesne (nesne-imaj n)
         (cond
           ((> (v-y (nesne-yer n)) (image-height BACKGROUND))
           (v  (random 10 630) (/ tehlike2-yüksekliği 2)))
            (else (nesne-yer n)))
         (nesne-hız n)
         (nesne-ivme n)))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define (tehlike-güncelle n)
  (nesne (nesne-imaj n)
         (cond
           ((< (v-x (nesne-yer n)) 0)
           (v (+ (image-width BACKGROUND) (/ tehlike-genişliği 2)) (random 10 470)))
            (else (nesne-yer n)))
         (nesne-hız n)
         (nesne-ivme n)))
           

;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (hedef-güncelle n)
  (nesne (nesne-imaj n)
         (cond
           ((> (v-x (nesne-yer n)) (image-width BACKGROUND))
           (v (/ hedef-genişliği 2) (random 10 470)))
            (else (nesne-yer n)))
         (nesne-hız n)
         (nesne-ivme n)))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;UZAKLIK:nesne nesne:sayı
(ÖRNEK (uzaklık PLAYER TARGET) (v-mag (v- (v 30 100) (v 300 270))))
(define (uzaklık n1 n2) (v-mag (v- (nesne-yer n1) (nesne-yer n2))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SES herhangbirşey ses-dosyası-metin -> herhangibirşey
;; birinci paramatresini aynen dönsürüyor, sesi çalarak
;(ÖRNEK (SES 0 "ses/bark.wav") 0)
;çarpışma:evren->evren
(ÖRNEK (çarpışma (evren 20 BACKGROUND
  (nesne PLAYER (v 30 100) (v 30 -33) (v 0 0))
  (nesne ENEMY (v 340 300) (v -20 0) (v 0 0))
  (nesne ENEMY2 (v 350 130) (v 0 16) (v 0 0))
  (nesne TARGET (v 300 270) (v 6 0) (v 0 0))))
         (cond
          ((< (uzaklık PLAYER ENEMY2) 5)
     (evren 0 BACKGROUND
  (nesne PLAYER (v 30 100) (v 30 -33) (v 0 0))
  (nesne ENEMY (v 340 300) (v -20 0) (v 0 0))
  (nesne ENEMY2 (v 350 130) (v 0 16) (v 0 0))
  (nesne TARGET (v 300 270) (v 6 0) (v 0 0))))
    ((< (uzaklık PLAYER ENEMY) 5)
     (evren (- 20 1) BACKGROUND
  (nesne PLAYER (v 30 100) (v 30 -33) (v 0 0))
  (nesne ENEMY (v 340 300) (v -20 0) (v 0 0))
  (nesne ENEMY2 (v 350 130) (v 0 16) (v 0 0))
  (nesne TARGET (v 300 270) (v 6 0) (v 0 0))))
    ((< (uzaklık PLAYER TARGET) 5)
     (evren (+ 20 1) BACKGROUND
    (nesne PLAYER (v 30 100) (v 30 -33) (v 0 0))
  (nesne ENEMY (v 340 300) (v -20 0) (v 0 0))
  (nesne ENEMY2 (v 350 130) (v 0 16) (v 0 0))
  (nesne TARGET (v 300 270) (v 6 0) (v 0 0))))
    (else (evren 20 BACKGROUND
  (nesne PLAYER (v 30 100) (v 30 -33) (v 0 0))
  (nesne ENEMY (v 340 300) (v -20 0) (v 0 0))
  (nesne ENEMY2 (v 350 130) (v 0 16) (v 0 0))
  (nesne TARGET (v 300 270) (v 6 0) (v 0 0))))))

(define (çarpışma e)
  (cond
    ((< (uzaklık (evren-n1 e) (evren-n3 e)) 50)
     (evren 0 BACKGROUND
  (nesne PLAYER (v 30 100) (v 30 -33) (v 0 0))
  (nesne ENEMY (v 340 300) (v -20 0) (v 0 0))
  (nesne ENEMY2 (v 350 130) (v 0 16) (v 0 0))
  (nesne TARGET (v 300 270) (v 6 0) (v 0 0))))
    ((< (uzaklık (evren-n1 e) (evren-n2 e)) 50)
     (evren (- (evren-score e) 1) BACKGROUND
  (evren-n1 e)
  (nesne ENEMY (v 0 300) (v -20 0) (v 0 0))
  (evren-n3 e)
  (evren-n4 e)))
    ((< (uzaklık (evren-n1 e) (evren-n4 e)) 50)
     (evren (+ (evren-score e) 1) BACKGROUND
  (evren-n1 e)
  (evren-n2 e)
  (evren-n3 e)
  (nesne TARGET (v 300 (random 10 470)) (v 6 0) (v 0 0))))
    (else e)))
      
                 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sabit kod bundan sonra                               ;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(yut (big-bang yaradılış
  (on-tick evren-güncelle (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)
  (on-mouse evren-fare)))