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
(define sahne3 (bitmap "Teachpacks/teachpack-images/oyunsonu.png"))
(define sahne0 (bitmap "Teachpacks/teachpack-images/giriş-ekranı.png"))
(define BACKGROUND2 (bitmap "Teachpacks/teachpack-images/arkaplan-2.png"))
(STRUCT nesne (imaj yer hız ivme))
;imaj görüntü
;yer vektör
;hız vektör
;ivme vektör
(STRUCT evren ( sahne0 sahne1 sahne2 sahne3 sahne-sayı))
(STRUCT sahne (bg tehlike oyuncu hedef predo zemin skor))
;bg görüntü
;n1 nesne dinazor
;n2 nesne caveman
;n3 nesne hedef
;n4 nesne predo
;n5 nesne zemin
;skor sayı
(define nesne-1 (nesne (circle 10 "solid" "red") (v 50 50) (v  0 0) (v 0 0)))
(define zemin-adam-eksi-yakınlık 0)
(define adam-dinazor-eksi-yakınlık 30)
(define daire (circle 0 "solid" "pink"))
(define nesne-daire (nesne daire (v 0 0) (v 0 0 ) (v 0 0)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
;STRUCT anim
;devamlı = boolean
;değişim sıklığı = sayı
;şimdiki zaman = sayı
;resimler = görüntü-list
;(STRUCT anim (resimler zaman değişim-sıklığı devamlı))

;anim-çiz anim-> görüntü
;(ÖRNEK (anim-çiz
;        (anim true 3 13 (list (bitmap "Teachpacks/teachpack-images/caveman/cavemanrunning/cavemanrunning_1.png")
;                             (bitmap "Teachpacks/teachpack-images/caveman/cavemanrunning/cavemanrunning_2.png")
;                              (bitmap "Teachpacks/teachpack-images/caveman/cavemanrunning/cavemanrunning_3.png")
;                              (bitmap "Teachpacks/teachpack-images/caveman/cavemanrunning/cavemanrunning_4.png"))))
;       (bitmap "Teachpacks/teachpack-images/caveman/cavemanrunning/cavemanrunning_1.png"))
;
;(define (anim-çiz a) (list-ref
;                      (anim-resimler a)
;                      (modulo (quotient (anim-zaman a)
;                                        (anim-değişim-sıklığı a)) (length (anim-resimler a)))))

;anim-güncelle anim -> anim
;anim zaman artmak
;(ÖRNEK (anim-güncelle (anim #true 3 11 (list (bitmap "Teachpacks/teachpack-images/caveman/cavemanrunning/cavemanrunning_1.png")
;                                           (bitmap "Teachpacks/teachpack-images/caveman/cavemanrunning/cavemanrunning_2.png")
;                                          (bitmap "Teachpacks/teachpack-images/caveman/cavemanrunning/cavemanrunning_3.png")
;                                           (bitmap "Teachpacks/teachpack-images/caveman/cavemanrunning/cavemanrunning_4.png"))))
;     (anim #true 3 0 (list (bitmap "Teachpacks/teachpack-images/caveman/cavemanrunning/cavemanrunning_1.png")
;                                           (bitmap "Teachpacks/teachpack-images/caveman/cavemanrunning/cavemanrunning_2.png")
;                                            (bitmap "Teachpacks/teachpack-images/caveman/cavemanrunning/cavemanrunning_3.png")
;                                            (bitmap "Teachpacks/teachpack-images/caveman/cavemanrunning/cavemanrunning_4.png"))))
;anim-güncelle anim -> anim
;(define (anim-güncelle a)
;  (anim
;   (anim-devamlı a)
;   (anim-değişim-sıklığı a)
;   (anim-zaman-güncelle (anim-zaman a) (* (anim-değişim-sıklığı a) (length (anim-resimler a))) (anim-devamlı a))
;   (anim-resimler a)))
;(define (anim-zaman-güncelle z a devam)
;                      (cond
;                        (devam (modulo (+ z  1) a))
;                        (else (max (+ z 1 ) (- a 1)))))
;nesneye imaj da ekle görüntü ya da anim
;imaj-güncelle
;(define (imaj-güncele i)
; (cond
;   ((anim? 1) (anim-güncelle i))
;              (else i)))
;(define (imaj-çiz i)
; (cond
;   ((anim? 1) (anim-çiz i))
;              (else i)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;TEHLİKE
(define konum-dinazor (v 350 438))
(define hız-dinazor (v -10 0))
(define ivme-dinazor (v 0 0))
(define nesne-dinazor (nesne (bitmap "Teachpacks/teachpack-images/tyranosaur/tyranosaurstanding/tyranosaurstanding.png")
                             konum-dinazor
                             hız-dinazor
                             ivme-dinazor ) )


;CAVEMAN
(define konum-caveman (v 320 440))
(define hız-caveman (v 0 0))
(define ivme-caveman (v 0 0))
(define nesne-caveman (nesne (bitmap "Teachpacks/teachpack-images/caveman/cavemanstanding/cavemanstanding_1.png")
                             konum-caveman
                             hız-caveman
                             ivme-caveman ) )
;HEDEF
(define konum-hedef (v 100 480))
(define hız-hedef (v 0 9))
(define ivme-hedef (v 0 0))
(define nesne-hedef (nesne (bitmap "Teachpacks/teachpack-images/yemek-1.png")
                             konum-hedef
                             hız-hedef
                             ivme-hedef ) )
;PREDO
(define konum-predo (v 640 200))
(define hız-predo (v -9 0))
(define ivme-predo (v 0 0))
(define nesne-predo (nesne (flip-horizontal (bitmap "teachpacks/teachpack-images/predo/predoflying/predoflying-1.png"))
                             konum-predo
                             hız-predo
                             ivme-predo ) )
;FLYTRAP
(define konum-flytrap (v 350 438))
(define hız-flytrap (v -10 0))
(define ivme-flytrap (v 0 0))
(define nesne-flytrap (nesne (flip-horizontal (bitmap "Teachpacks/teachpack-images/flytrap/flytrapstanding/flytrapstanding-1.png"))
                             konum-flytrap
                             hız-flytrap
                             ivme-flytrap ) )

;GROUND
(define konum-zemin (v 320 473))
(define hız-zemin (v 0 0))
(define ivme-zemin (v 0 0))
(define nesne-zemin (nesne (bitmap "Teachpacks/teachpack-images/zemin-1.png")
                             konum-zemin
                             hız-zemin
                             ivme-zemin ) )
;ZEMİN-TAŞ
(define konum-taşzemin (v 320 473))
(define hız-taşzemin (v 0 0))
(define ivme-taşzemin (v 0 0))
(define nesne-taşzemin (nesne (bitmap "Teachpacks/teachpack-images/zemin-2.png")
                             konum-taşzemin
                             hız-taşzemin
                             ivme-taşzemin ) )
;SAHNE 0
(define sahne-0 (sahne sahne0
                       nesne-daire
                       nesne-daire
                       nesne-daire
                       nesne-daire
                       nesne-daire
                       0))




;SAHNE-1
(define sahne-1 (sahne BACKGROUND 
                         nesne-dinazor
                         nesne-caveman
                         nesne-hedef
                         nesne-predo
                         nesne-zemin
                         0))

;SAHNE-2
(define sahne-2 (sahne BACKGROUND2 
                         nesne-flytrap
                         nesne-caveman
                         nesne-hedef
                         nesne-predo
                         nesne-taşzemin
                         0))
;SAHNE-3
(define sahne-3 (sahne sahne3
                        nesne-daire
                        nesne-daire
                        nesne-daire
                        nesne-daire
                        nesne-daire
                       0))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;vektörleri toplama
;v+v v v -> vektör
(define (v+v vl vk) (v (+ (v-x vl) (v-x vk)) (+ (v-y vk) (v-y vl))))
(ÖRNEK (v+v (v 250 100) (v 300 50)) (v 550 150))

;v-y-uzunluk
;v-y-uzunluk v v -> sayı
(define (v-y-uzunluk v1 v2) (abs (- (v-y v1) (v-y v2))))

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

;vektörler arası uzunluk hesaplama v-uzunluk v -> sayı
(define (v-uzunluk v1 v2) (v-mag (v-v v1 v2)))
(v-uzunluk (v 12 16) (v 36 -16))

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
                           

;sözleşme nesne -> nesne
(define (nesne-fizik-güncelle-oyuncu n)(cond
                                         ((> (- (v-y (nesne-yer n)) (/ (image-height (nesne-imaj n)) 2)) 0)
                                          (nesne-fizik-güncelle n))
                                         (else (nesne-fizik-güncelle (nesne
                                                                      (nesne-imaj n)
                                                                      (nesne-yer n)
                                                                      (v 0 10)
                                                                      (v 0 4 )
                                                                            )))))

;SÖZLEŞME nesne-soldan-döndür bg n sayı sayı_> n
(define (nesne-soldan-döndür bg n sayı1 sayı2) (cond
                                                 ((< (+ (v-x (nesne-yer n)) (/ (image-width (nesne-imaj n))2)) 0)
                                                  (nesne (nesne-imaj n)
                                                         (v (+ (image-width bg)(/ (image-width (nesne-imaj n))2) ) (random sayı1 sayı2))
                                                         (nesne-hız n)
                                                         (nesne-ivme n)))
                                                 (else n)))
(ÖRNEK (nesne-soldan-döndür BACKGROUND nesne-1 20 30)
       nesne-1)


;SÖZLEŞME nesne-aşağıdan-döndür bg n sayı sayı _> n
(define (nesne-aşağıdan-döndür bg n sayı1 sayı2) (cond
                                                   ((> (v-y (nesne-yer n)) (image-height bg) )
                                                    (nesne (nesne-imaj n)
                                                           (v (random sayı1 sayı2)  (/ (image-height (nesne-imaj n))2) ) 
                                                           (nesne-hız n)
                                                           (nesne-ivme n)))
                                                   (else n)))

;SÖZLEŞME çarpışmalar evren->evren
;bir evren alıp çarpışmaları kontrol eder ve bir evren üretir
(define (çarpışmalar e) (cond
;oyuncu-tehlike
                          ((< (v-uzunluk (nesne-yer (sahne-oyuncu e)) (nesne-yer (sahne-tehlike e)))
                              (- (+ (/ (image-width (nesne-imaj (sahne-tehlike e) ))2)  (/ (image-width (nesne-imaj (sahne-oyuncu e) ))2)) adam-dinazor-eksi-yakınlık ))
                           (sahne (sahne-bg e)
                                  (nesne (nesne-imaj (sahne-tehlike e)) (v (+ (image-width (sahne-bg e))(/ (image-width (nesne-imaj (sahne-tehlike e)))2) ) 437)
                                         (nesne-hız (sahne-tehlike e))(nesne-ivme (sahne-tehlike e)))
                                  (nesne (nesne-imaj (sahne-oyuncu e)) (v 320 440)
                                         (nesne-hız (sahne-oyuncu e))(nesne-ivme (sahne-oyuncu e)))
                                  (sahne-hedef e)
                                  (sahne-predo e)
                                  (sahne-zemin e)
                                  (- (sahne-skor e) 50)))
;oyuncu ve hedef
                          ((< (v-uzunluk (nesne-yer (sahne-oyuncu e)) (nesne-yer (sahne-hedef e)))
                              (+ (/ (image-width (nesne-imaj (sahne-hedef e) ))2)  (/ (image-width (nesne-imaj (sahne-oyuncu e) ))2)))
                           (sahne (sahne-bg e)
                                  (sahne-tehlike e)
                                  (sahne-oyuncu e)
                                  (nesne (nesne-imaj (sahne-hedef e)) (v (random 20 620)  (/ (image-height (nesne-imaj (sahne-hedef e)))2) )
                                         (nesne-hız (sahne-hedef e))(nesne-ivme (sahne-hedef e)))
                                  (sahne-predo e)
                                  (sahne-zemin e)
                                  (+ (sahne-skor e) 100)))
;hedef ve zemin                         
                          ((< (v-y-uzunluk (nesne-yer (sahne-hedef e)) (nesne-yer (sahne-zemin e)))
                              (+ (/ (image-height (nesne-imaj (sahne-hedef e) ))2)   (image-height (nesne-imaj (sahne-zemin e) ))))
                           (sahne (sahne-bg e)
                                  (sahne-tehlike e)
                                  (sahne-oyuncu e)
                                  (nesne (nesne-imaj (sahne-hedef e)) (v  (v-x (nesne-yer (sahne-hedef e))) 460)
                                         (nesne-hız (sahne-hedef e))(nesne-ivme (sahne-hedef e)))
                                  (sahne-predo e)
                                  (sahne-zemin e)
                                  (sahne-skor e)))
         
                          (else e)))

;

;SÖZLEŞME evren-> evren
;amaç evrenin bir frame sonraki halini vermek
;ŞEKİL (define (evren-güncelle e) (evren (evren-bg e)
;                                    ....(evren-n1 e))
(define (sahne0-güncelle e) e)

(define (sahne1-güncelle e) (çarpışmalar (sahne (sahne-bg e)
                                                (nesne-soldan-döndür (sahne-bg e)(nesne-fizik-güncelle (sahne-tehlike e))  437 438)
                                                (nesne-yerde-durdur (nesne-fizik-güncelle-oyuncu (sahne-oyuncu e))
                                                                    (- (image-height (sahne-bg e))
                                                                       (/ (image-height (nesne-imaj (sahne-oyuncu e))) 2)
                                                                       (/ (image-height (nesne-imaj (sahne-zemin e))) 2)))
                                                (nesne-aşağıdan-döndür (sahne-bg e) (nesne-fizik-güncelle (sahne-hedef e)) 20 620)
                                                (nesne-soldan-döndür (sahne-bg e)(nesne-fizik-güncelle (sahne-predo e))  75 250 )
                                                (sahne-zemin e)
                                                (sahne-skor e))))


;nesne-yerde-durdur nesne sayı -> sayı
; nesnenin aşağı doğru harektini durdur
(define (nesne-yerde-durdur n y-limit)
  (cond
    ((>= (v-y (nesne-yer n)) y-limit)
     (nesne (bitmap "Teachpacks/teachpack-images/caveman/cavemanstanding/cavemanstanding_1.png")
            (v (v-x (nesne-yer n)) y-limit)
            (v (v-x (nesne-hız n)) 0)
            (v (v-x (nesne-ivme n)) 0)))
    (else n)))


;SÖZLEŞME evren -> görüntü
;bir evren çizecek
(ÖRNEK (sahne-çiz (sahne BACKGROUND
                         (nesne (circle 10 "solid" "red") (v 50 50) (v 0 0) (v 0 0))
                         (nesne (circle 10 "solid" "blue") (v 150 250) (v 0 0) (v 0 0))
                         (nesne (circle 10 "solid" "purple") (v 100 200) (v 0 0) (v 0 0))
                         (nesne (circle 10 "solid" "purple") (v 100 200) (v 0 0) (v 0 0))
                         (nesne (circle 10 "solid" "purple") (v 100 200) (v 0 0) (v 0 0))
                          200      ))
      (nesne-çiz (nesne (circle 10 "solid" "red") (v 50 50) (v 0 0) (v 0 0))
                  (nesne-çiz (nesne (circle 10 "solid" "blue") (v 150 250) (v 0 0) (v 0 0))
                             (nesne-çiz (nesne (circle 10 "solid" "purple") (v 100 200) (v 0 0) (v 0 0))
                                        (nesne-çiz (nesne (circle 10 "solid" "purple") (v 100 200) (v 0 0) (v 0 0))
                                                   (nesne-çiz (nesne (circle 10 "solid" "purple") (v 100 200) (v 0 0) (v 0 0)) BACKGROUND ))))))
(define (sahne-çiz e) (nesne-çiz (sahne-tehlike e)
                                 (nesne-çiz (sahne-oyuncu e )
                                            (nesne-çiz (sahne-hedef e)
                                                       (nesne-çiz (sahne-predo e)
                                                                  (nesne-çiz (sahne-zemin e) (sahne-bg e)))))))

;zıplat nesne -> nesne
; bir nesnenin yukarı hızını arttırmak ve aşağı ivme vermek
(define (zıplat n) (cond
                     ((> (- (v-y (nesne-yer n)) (/ (image-height (nesne-imaj n)) 2)) 0)
                      (nesne
                       (bitmap "Teachpacks/teachpack-images/caveman/cavemanjumping/cavemanjumping_1.png")
                       (nesne-yer n)
                       (v+v (nesne-hız n) (v  0 -8))
                       (v 0 1.5)))
                     (else n)))





;define sahnetuştan-evren s


(define (sahne1-tuş e t) 
  (cond
    ((string=? t "up") 
                         
                          (sahne (sahne-bg e)
                                 (sahne-tehlike e)
                                 (zıplat (sahne-oyuncu e))
                                 (sahne-hedef e)
                                 (sahne-predo e)
                                 (sahne-zemin e)
                                 (sahne-skor e)))
                         
                         
    ((string=? t "down") (cond
                           ( (< (- (+ (v-y(nesne-yer(sahne-oyuncu e)))
                                      (/(image-height(nesne-imaj(sahne-oyuncu e)))2)
                                      (image-height (nesne-imaj(sahne-zemin e)))) zemin-adam-eksi-yakınlık)
                                (image-height (sahne-bg e)))
                             (sahne (sahne-bg e)
                                    (sahne-tehlike e)
                                    (nesne (nesne-imaj (sahne-oyuncu e))
                                           (v+v (nesne-yer (sahne-oyuncu e)) (v 0 10))
                                           (nesne-hız (sahne-oyuncu e))
                                           (nesne-ivme (sahne-oyuncu e)) )
                                    (sahne-hedef e)
                                    (sahne-predo e)
                                    (sahne-zemin e)
                                    (sahne-skor e)))
                           (else e)))
                                                
    ((string=? t "right") (cond
                            ( (< (+ (v-x(nesne-yer(sahne-oyuncu e))) (/(image-width (nesne-imaj(sahne-oyuncu e)))2)) (image-width  (sahne-bg e)))
                              (sahne (sahne-bg e)
                                     (sahne-tehlike e)
                                     (nesne (nesne-imaj (sahne-oyuncu e))
                                            (v+v (nesne-yer (sahne-oyuncu e)) (v 10 0))
                                            (nesne-hız (sahne-oyuncu e))
                                            (nesne-ivme (sahne-oyuncu e))) 
                                     (sahne-hedef e)
                                     (sahne-predo e)
                                     (sahne-zemin e)
                                     (sahne-skor e)))
                            (else e)))
                                                  
    ((string=? t "left")(cond
                          ( (> (- (v-x(nesne-yer(sahne-oyuncu e))) (/(image-width (nesne-imaj(sahne-oyuncu e)))2)) 0)
                            (sahne (sahne-bg e)
                                   (sahne-tehlike e)
                                  (nesne (nesne-imaj (sahne-oyuncu e))
                                          (v+v (nesne-yer (sahne-oyuncu e)) (v -10 0))
                                          (nesne-hız (sahne-oyuncu e))
                                          (nesne-ivme (sahne-oyuncu e)) )
                                   (sahne-hedef e)
                                   (sahne-predo e)
                                   (sahne-zemin e)
                                   (sahne-skor e)))
                          (else e)))
    (else e )))

  (define (evren-fare e x y m)
    e)



(define (evren-çiz e) (cond
                        ((= (evren-sahne-sayı e) 0) (sahne-çiz (evren-sahne0 e)))
                        ((= (evren-sahne-sayı e) 1) (sahne-çiz (evren-sahne1 e)))
                        ((= (evren-sahne-sayı e) 2) (sahne-çiz (evren-sahne2 e)))
                        ((= (evren-sahne-sayı e) 3) (sahne-çiz (evren-sahne3 e)))
                        (else e)))

(define (evren-güncelle e) (cond
                             ((= (evren-sahne-sayı e) 0) (evren
                                                          (sahne0-güncelle (evren-sahne0 e))
                                                          (evren-sahne1 e)
                                                          (evren-sahne2 e)
                                                          (evren-sahne3 e)
                                                          (evren-sahne-sayı e)))

                             ((and (= (evren-sahne-sayı e) 1) (< (sahne-skor (evren-sahne1 e)) 500)
                                   (evren
                                    (evren-sahne0 e)
                                    (sahne1-güncelle (evren-sahne1 e))
                                    (evren-sahne2 e)
                                    (evren-sahne3 e)
                                    (evren-sahne-sayı e))))

                             ((and (= (evren-sahne-sayı e) 1) (>= (sahne-skor (evren-sahne1 e)) 500)
                                   (evren
                                    (evren-sahne0 e)
                                    (sahne1-güncelle (evren-sahne1 e))
                                    (evren-sahne2 e)
                                    (evren-sahne3 e)
                                    (+ 1 (evren-sahne-sayı e)))))

                             ((and (= (evren-sahne-sayı e) 2) (< (sahne-skor (evren-sahne2 e)) 500)
                                   (evren
                                                          (evren-sahne0 e)
                                                          (evren-sahne1 e)
                                                          (sahne1-güncelle (evren-sahne2 e))
                                                          (evren-sahne3 e)
                                                          (evren-sahne-sayı e))))
                             ((and (= (evren-sahne-sayı e) 2) (>= (sahne-skor (evren-sahne2 e)) 500)
                                   (evren
                                                          (evren-sahne0 e)
                                                          (evren-sahne1 e)
                                                          (sahne1-güncelle (evren-sahne2 e))
                                                          (evren-sahne3 e)
                                                          (+ 1 (evren-sahne-sayı e)))))
                             
                             ((= (evren-sahne-sayı e) 3) (evren
                                                          (evren-sahne0 e)
                                                          (evren-sahne1 e)
                                                          (evren-sahne2 e)
                                                          (sahne0-güncelle (evren-sahne3 e))
                                                          (evren-sahne-sayı e)))))
;
  (define (evren-tuş e t) (cond
                            ((and (= (evren-sahne-sayı e) 0) 
                                  (string=? t  " "))
                             (evren (evren-sahne0 e)
                                    (evren-sahne1 e)
                                    (evren-sahne2 e)
                                    (evren-sahne3 e)
                                    (+ 1 (evren-sahne-sayı e))))
                                                        
                            ((= (evren-sahne-sayı e) 1)  (evren
                                                          (evren-sahne0 e)
                                                          (sahne1-tuş (evren-sahne1 e) t)
                                                          (evren-sahne2 e)
                                                          (evren-sahne3 e)
                                                          (evren-sahne-sayı e)))
                            ((= (evren-sahne-sayı e) 2) (evren
                                                          (evren-sahne0 e)
                                                          (evren-sahne1 e)
                                                          (sahne1-tuş (evren-sahne2 e) t)
                                                          (evren-sahne3 e)
                                                          (evren-sahne-sayı e)))
                            (else e)))

 

(define FRAME-RATE 20)

(define yaradılış  (evren sahne-0
                         sahne-1
                         sahne-2
                         sahne-3
                         0))

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

