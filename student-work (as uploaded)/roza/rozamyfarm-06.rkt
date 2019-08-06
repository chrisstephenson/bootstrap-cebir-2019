#lang racket
(require "teachpacks/evren-teachpack.rkt")
( STRUCT v  ( x y ))
; x : sayı - x koordinatı
; y : sayı - y koordinatı

;; v+ - vektör toplama
;;v+ : v v -> v

(ÖRNEK ( v+ (v 5 3 )(v 5 4)) ( v 10 7 ))
(ÖRNEK ( v+ (v 2 6 )(v 8 9))( v 10 15 ))
( define ( v+  v1 v2)
              (v
               ( + (v-x v1)( v-x v2 ))
               ( +  (v-y v1)( v-y v2 ))))

;; v- - vektör çıkartma

(ÖRNEK ( v- ( v 4 6 )(v 5 8))( v -1 -2))
(ÖRNEK( v- ( v 3 7 )(v 6 2 ))( v -3 5 ))
(define (v- v1 v2 )
  ( v
    ( - (v-x v1 )( v-x v2))
    ( - (v-y v1 )(v-y v2))))

;; v* - vektör sayıyla çarpma
;;v* : sayı -> vektör

(ÖRNEK ( v* 2 ( v 5 3 ))( v 10 6 ))
(ÖRNEK ( v* 3 (v 4 6 ))( v 12 18 ))
(define (v* s vk )
  (v
   (* s (v-x vk))
   (* s  (v-y vk))))

;; v. - vektör dot çarpma
;; v. : vektör vektör -> sayı

(ÖRNEK ( v. ( v 3 5 )(v 8 6 )) 54 )
(ÖRNEK ( v. ( v 2 4 )(v 7 3 )) 26 )
( define ( v. v1 v2 )
                     ( + (* (v-x v1)( v-x v2 ))
                      ( *  (v-y v1)( v-y v2 ))))
                      
;; v-mag - vektör uzunluğu
;; v-mag vektör -> sayı

(ÖRNEK (v-mag ( v 3 4 )) 5)
(ÖRNEK (v-mag ( v 5 12 ))13 )
( define (v-mag v1 )(sqrt (+ (sqr(v-x v1))(sqr(v-y v1)))))

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
(define test-square (square 50 "solid" "grey"))

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


( STRUCT nesne (imaj yer hız ivme ))

(ÖRNEK (nesne-çiz (nesne (circle  10 "solid" "red" )
                         (v 50 50 ) ( v 0 0 )( v 0 0 ))
                         (square 100 "solid" "yellow" ))
                   (place-image/v  ( circle 10 "solid" "red")( v 50 50 )
                                   (square 100 "solid" "yellow")))

( define ( nesne-çiz n ap )
 (place-image/v ( nesne-imaj n)( nesne-yer n) ap))


; nesne-fizik-güncelle

( ÖRNEK( nesne-fizik-güncelle  ( nesne ( circle 10 "solid" "red" )( v 50 50 )( v 2 3 )(v 4 5 )))
        ( nesne ( circle 10 "solid" "red")(v 52 53)( v 6 8)( v 4 5))) 

(define ( nesne-fizik-güncelle n )
  ( nesne
    ( nesne-imaj n )
    ( v+ (nesne-hız n) ( nesne-yer n  ))
    ( v+ (nesne-ivme n) ( nesne-hız n ))
    ( nesne-ivme n))) 

                                           
   
          


(define (evren-fare e x y m)
  e)

(define FRAME-RATE 12)

(test)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                    MY FARM                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;struct evren
;hangi-sahne: sayı
;sahne-1:sahne-1
;sahne-2:sahne-2
;sahne-3:sahne-3 
;sahne-4:sahne-4
;shane-5:sahne-5
( STRUCT evren ( hangi-sahne sahne-1 sahne-2 sahne-3 sahne-4 sahne-5 ))

(define ( nesne-sınırlandır n sağ sol )
  (nesne
   (nesne-imaj n )
   (v (max sol (min sağ (v-x (nesne-yer n)))) (v-y (nesne-yer n)))
   (nesne-hız n )
   (nesne-ivme n))) 

(define (nesne-sınır n üst alt )
(nesne
 (nesne-imaj n)
 (v (v-x (nesne-yer n)) (max üst (min alt (v-y (nesne-yer n)))))
 (nesne-hız n)
 (nesne-ivme n)))

(define (mesafe n1 n2 )
  (v-mag
   (v- (nesne-yer n1 ) (nesne-yer n2))))

; struct sahne1
;bg: görsel
;tahta:görsel 
;mesaj: metin
; sabit-ekran :görsel
( STRUCT sahne-1 (  sabit-ekran ))

(define bg (bitmap "imaj/farm4.jpg"))
(define tahta ( scale 0.3 (bitmap "imaj/kağıt.png")))
(define bg-en (image-width bg ))
(define bg-yksklk (image-height bg))
( define sabit-ekran (place-image/v tahta (v (/ bg-en 2)(/ bg-yksklk 2)) bg))
(define mesaj (place-text/v (v 500 500) "Merhaba çiftçi;\n Çiftliğim berbat durumda.\n
Yardıma geldiğin için çok teşekkürler.\n Şimdi ağaçtaki elmaları toplar mısın?" 250 "black" sabit-ekran))



(define sahne-1-sabit-imaj
  (place-text/v (v (/ bg-en 2)(/ bg-yksklk 2)) "Merhaba çiftçi;\n Çiftliğim berbat durumda.
Yardıma geldiğin için çok teşekkürler.\n Şimdi ağaçtaki elmaları toplar mısın?" 11 "black" sabit-ekran))

(define (sahne-1-çiz e)(sahne-1-sabit-ekran e))
                              
( define (sahne-1-güncelle e ) e )
;struct sahne-2
;elma:nesne
;sepet:nesne
;skor-e: sayı
;bg-iki:görsel
( STRUCT sahne-2 (  bg-iki elma sepet skor-e))
(define elma  (scale 0.05 (bitmap "imaj/elma.png")))
(define sepet (scale 0.1 (bitmap "imaj/sepet.png")))
(define bg-iki (scale 1.4 (bitmap "imaj/ağaçlar.jpg" )))
(define skor-e 0)
(define bg-iki-yksklk (image-height bg-iki))
( define elma-yksklk (image-height elma))
(define bg-iki-en (image-width bg-iki))
( define elma-en (image-width elma))
(define sepet-en (image-width sepet))

;sahne-2-çiz :nesne nesne sayı görsel: sahne

(ÖRNEK  (sahne-2-çiz (sahne-2 bg-iki
                    ( nesne elma ( v 80 200 )( v 0 0)( v 0 0 ))
                   (nesne  sepet (v 200 90)(v 0  0)( v 0 0 ))
                   0))
        (sahne-2 bg-iki       
             (nesne-çiz ( nesne elma ( v 80 200)( v 0 0 )( v 0 0 ))
             (nesne-çiz (nesne  sepet (v 200 90)(v 0  0)( v 0 0)))
             (place-text/v (v 100 50)
                             (string-append "Yapılacak:20 \n SKOR:" ( number->string (sahne-2-skor-e )) 15 "black" test-square)))))
                        

( define (sahne-2-çiz s) 
        (nesne-çiz (sahne-2-elma s )
        (nesne-çiz (sahne-2-sepet s )
                   (place-text/v (v 150 50)
                                 (string-append "Yapılacak:10 SKOR:" ( number->string (sahne-2-skor-e s )))
                                 15 "black"
                                 (sahne-2-bg-iki s)))))

(ÖRNEK (sahne-2-güncelle sahne-2-çiz )
       ( sahne-2 bg-iki 
       ( nesne elma ( v 80 200 )( v 0 0)( v 0 0 ))
       (nesne  sepet (v 200 90)(v 0  0)( v 0 0 ))
       0))

( define ( sahne-2-güncelle s )
   (sahne-2-çarpışma ( sahne-2 bg-iki 
                               (elma-döndür ( nesne-fizik-güncelle (sahne-2-elma s )))
                               ( nesne-fizik-güncelle (sahne-2-sepet s))
                               (sahne-2-skor-e s))))

;elma-döndür nesne -> nesne
( define ( elma-döndür n )
   (cond
    ( (> (v-y (nesne-yer n)) ( + ( / elma-yksklk 2)bg-iki-yksklk))
     (nesne (nesne-imaj n)
            (v (random elma-yksklk ( - bg-iki-en elma-yksklk ))
               (-(/ elma-yksklk 2)))
            (nesne-hız n)
            (nesne-ivme n)))
   (else n )))


(define (sepet-sınırlandır n)
  (nesne-sınırlandır n
                     (- bg-iki-en ( / sepet-en 2))
                     (/ sepet-en 2)))
(define ( nesne-yer-set n v )
  (nesne
   (nesne-imaj n)
   v
   (nesne-hız n)
   (nesne-ivme n )))
 
(define ( sahne-2-çarpışma s)
  (cond
    ((<( mesafe (sahne-2-sepet s) (sahne-2-elma s) )100)
     (sahne-2
      (sahne-2-bg-iki s)
      
      ( nesne-yer-set  (sahne-2-elma s)(v (random elma-yksklk ( - bg-iki-en elma-yksklk ))
                          (-(/ elma-yksklk 2))))
      (sahne-2-sepet s)
      (+ 1 (sahne-2-skor-e s))))
    (else s )))


;struct sahne-3
;bg:görsel
;tahta:görsel
;text : metin
;sabit-ekran: görsel
( STRUCT sahne-3 ( sabit-ekran ))

(define sahne-3-sabit-imaj
  (place-text/v  (v (/ bg-en 2)(/ bg-yksklk 2)) "İyi iş çıkardın! \n Sıra yumurta toplamakta.
Tavuklara dikkat et!"  11 "black" sabit-ekran))

(define (sahne-3-çiz e)(sahne-3-sabit-ekran e))

(define (sahne-3-güncelle e ) e )





;struct sahne-4 
;çiftçi:nesne
;tavuk:nesne
;yumurta:nesne
;bg-dört:görsel
;skor-y:sayı
( STRUCT sahne-4 ( bg-4 çiftçi tavuk yumurta  skor-y ))
(define bg-4 ( bitmap "imaj/kümesyeni-1.png"))
(define tavuk (scale 0.3 (bitmap "imaj/TVK.png")))
(define yumurta (scale 0.03 (bitmap "imaj/yumurta.png")))
(define çiftçi (scale 0.3 (bitmap "imaj/çiftçi.png")))
(define skor-y 0)
(define bg-4-yksklk (image-height bg-4))
(define çiftçi-yksklk(image-height çiftçi))
(define yumurta-en (image-width yumurta ))
(define bg-4-en (image-width bg-4 ))
(define yumurta-yksklk(image-height yumurta))
(define tavuk-en ( image-width tavuk ))

(ÖRNEK  (sahne-4-çiz (sahne-4-bg-4
                    ( nesne çiftçi ( v 400 330 )( v 0 0)( v 0 0 ))
                   (nesne  tavuk (v 192 290)(v 0  0)( v 0 0 ))
                   (nesne yumurta (v 200 170 (v 0 0 )(v 0 0))
                   0)))
        (sahne-4 bg-4       
             (nesne-çiz ( nesne çiftçi ( v 400 330)( v 0 0 )( v 0 0 )))
             (nesne-çiz (nesne  tavuk (v 192 290)(v 0  0)( v 0 0)))
             (nesne-çiz (nesne yumurta (v 200 170 )(v 0 0 )(v 0 0)))
             (place-text/v (v 250 50)
                             (string-append "Yapılacak:20 SKOR:" ( number->string (sahne-4-skor-y )) 15 "black" bg-4))))

;sahne-4-çiz:

( define (sahne-4-çiz s) 
   (nesne-çiz (sahne-4-çiftçi s )
              (nesne-çiz (sahne-4-tavuk s )
                         (nesne-çiz (sahne-4-yumurta s )           
                                    (place-text/v (v 150 50)
                                                  (string-append "Yapılacak:10 SKOR:"
                                                                 ( number->string(sahne-4-skor-y s )))
                                                  15 "black"
                                                  (sahne-4-bg-4 s))))))
                                                  

(ÖRNEK (sahne-4-güncelle sahne-4-çiz )
       ( sahne-4 bg-4 
       ( nesne çiftçi ( v 400 330 )( v 0 0)( v 0 0 ))
       (nesne tavuk  (v 192 290)(v 25 0)( v 0 0 ))
       (nesne yumurta  (v 200 170)(v 20  0)( v 0 0 ))
       0))

( define ( sahne-4-güncelle e )
 (sahne-4-çarpışma  (sahne-4 ( sahne-4-bg-4 e)
            (çiftçi-sınırlandır (yerde-durdur ( nesne-fizik-güncelle (sahne-4-çiftçi e ))
                                              (- bg-4-yksklk ( / çiftçi-yksklk 2) )))
            (tavuk-döndür ( nesne-fizik-güncelle (sahne-4-tavuk e)))
            (yumurta-döndür ( nesne-fizik-güncelle (sahne-4-yumurta e)))
           ( sahne-4-skor-y e))))

(define (çiftçi-sınırlandır n)
  (nesne-sınır n
                    (/ çiftçi-yksklk 2)
                    (- bg-4-yksklk ( / çiftçi-yksklk 2))))

;yumurta-döndür nesne -> nesne
( define ( yumurta-döndür n )
   (cond
    ( (> (v-x (nesne-yer n)) ( + ( / yumurta-en 2) bg-4-en))
     (nesne (nesne-imaj n)
            (v (- (/ yumurta-en 2))
             (random (round ( / yumurta-yksklk 2)) (round( / bg-4-yksklk 2)))) 
            (nesne-hız n)
            (nesne-ivme n)))
   (else n )))
;tavuk-döndür nesne ->
(define (tavuk-döndür n)
  (cond
    ((> (v-x (nesne-yer n))(+ ( / tavuk-en 2) bg-4-en ))
     (nesne (nesne-imaj n )
            (v ( - ( / tavuk-en 2))
               (v-y ( nesne-yer n)))
            (nesne-hız n)
            (nesne-ivme n )))
  ( else n )))

(define ( yerde-durdur n y )
  (cond
    ((>= (v-y (nesne-yer n )) y)
     (nesne
      ( nesne-imaj n )
      (v (v-x (nesne-yer n))
           y )
      (v (v-x ( nesne-hız n ))
         0)
      (v (v-x (nesne-ivme n ))
         0)))
    ( else n )))

( define (zıpla n)
   (nesne
    (nesne-imaj n )
    (nesne-yer n)
    (v+ (nesne-hız n)( v 0 -15))
    (v 0 2 )))

(define ( sahne-4-çarpışma s)
  (cond
    ((<( mesafe (sahne-4-çiftçi s) (sahne-4-yumurta s) )100)
     (sahne-4
      (sahne-4-bg-4 s)
      (sahne-4-çiftçi s)
      (sahne-4-tavuk s )
      ( nesne-yer-set  (sahne-4-yumurta s)
                       (v (-(/  yumurta-en 2))(random (round ( / yumurta-yksklk 2)) (round( / bg-4-yksklk 2))))) 
      
      (+ 1 (sahne-4-skor-y s))))
    ((<( mesafe (sahne-4-çiftçi s) (sahne-4-tavuk s) )100)
     (sahne-4
      (sahne-4-bg-4 s)
      (sahne-4-çiftçi s)
      ( nesne-yer-set  (sahne-4-tavuk s)
                       (v (-(/  tavuk-en 2)) ( - bg-4-yksklk ( / tavuk-en 2) )))
      (sahne-4-yumurta s)
      
      (-  (sahne-4-skor-y s) 1 )))
    (else s )))
  
      
;struct sahne-5
;bg:görsel
;tahta:görsel
;text : metin
;sabit-ekran: görsel
( STRUCT sahne-5 (  sabit-ekran ))

(define sahne-5-sabit-imaj
  (place-text/v (v (/ bg-en 2)(/ bg-yksklk 2)) "Sen çok iyi bir çiftçisin.
Çiftliğimi kurtardın.\n Çok teşekkür ederim:):)" 11 "black" sabit-ekran))
                              
(define (sahne-5-çiz e)(sahne-5-sabit-ekran e))

( define (sahne-5-güncelle e ) e)


( define yaradılış (evren 1
                          ( sahne-1 sahne-1-sabit-imaj )
                          (sahne-2 bg-iki
                                   ( nesne elma ( v 200 50 )( v 0 10)( v 0 0 ))
                                   (nesne  sepet (v 400 350)(v 0  0)( v 0 0 ))
                                   0)
                          (sahne-3 sahne-3-sabit-imaj )
                          (sahne-4 bg-4       
                                   ( nesne çiftçi ( v 200 (- bg-4-yksklk (/ çiftçi-yksklk 2 )))( v 0 0 )( v 0 0 ))
                                   (nesne  tavuk (v 80 400)(v 25 0)( v 0 0))
                                   (nesne yumurta (v 200 170) (v 20 0 )(v 0 0))
                                   0)
                          (sahne-5 sahne-5-sabit-imaj))) 

;hareket-et: nesne v ->nesne
( define (hareket-et n v1 )
   (nesne
    (nesne-imaj n )
    (v+ (nesne-yer n) v1 )
    (nesne-hız n)
    (nesne-ivme n)))
   
(define (evren-skor-2-check e )
  (cond
    (( >= (sahne-2-skor-e (evren-sahne-2 e)) 10)
     (evren-sahne-değiştir e 3))
    (else e )))

(define (evren-skor-4-check e )
  (cond
    (( >= (sahne-4-skor-y (evren-sahne-4 e)) 10)
     (evren-sahne-değiştir e 5))
    (else e )))

( define (evren-sahne-değiştir e s)
   (evren
    s
    (evren-sahne-1 e)
    (evren-sahne-2 e)
    (evren-sahne-3 e)
    (evren-sahne-4 e)
    (evren-sahne-5 e)))

       
 

(define (evren-güncelle e)
  (cond
    (( = ( evren-hangi-sahne e ) 1)
     (evren 1
      (sahne-1-güncelle(evren-sahne-1 e))
     (evren-sahne-2 e)
     (evren-sahne-3 e)
     (evren-sahne-4 e)
     (evren-sahne-5 e)))
    (( = ( evren-hangi-sahne e ) 2)
    (evren-skor-2-check (evren 2
     (evren-sahne-1 e )
     (sahne-2-güncelle(evren-sahne-2 e))
     (evren-sahne-3 e)
     (evren-sahne-4 e)
     (evren-sahne-5 e))))
    (( = ( evren-hangi-sahne e ) 3)
     (evren 3
     (evren-sahne-1 e)
     (evren-sahne-2 e)
     (sahne-3-güncelle(evren-sahne-3 e))
     (evren-sahne-4 e)
     (evren-sahne-5 e)))
    (( = ( evren-hangi-sahne e ) 4)
    (evren-skor-4-check (evren 4
     (evren-sahne-1 e)
     (evren-sahne-2 e)
     (evren-sahne-3 e)
     (sahne-4-güncelle(evren-sahne-4 e))
     (evren-sahne-5 e))))
    (( = ( evren-hangi-sahne e ) 5)
     (evren 5
      (evren-sahne-1 e)
     (evren-sahne-2 e)
     (evren-sahne-3 e)
     (evren-sahne-4 e)
     (sahne-5-güncelle(evren-sahne-5 e))))))                



(define ( evren-çiz e )
  (cond
    ( ( = (evren-hangi-sahne e) 1 )
     (sahne-1-çiz (evren-sahne-1 e)))
     (( = (evren-hangi-sahne e) 2 )
     (sahne-2-çiz (evren-sahne-2 e)))
      (( = (evren-hangi-sahne e) 3 )
     (sahne-3-çiz (evren-sahne-3 e)))
       (( = (evren-hangi-sahne e) 4 )
     (sahne-4-çiz (evren-sahne-4 e)))
        (( = (evren-hangi-sahne e) 5 )
     (sahne-5-çiz (evren-sahne-5 e)))))

     
(define ( evren-tuş e t ) 
  (cond
    ( ( = (evren-hangi-sahne e) 1 )
     (sahne-1-tuş  e t ))
     (( = (evren-hangi-sahne e) 2 )
     (sahne-2-tuş e t ))
      (( = (evren-hangi-sahne e) 3 )
     (sahne-3-tuş e t  ))
       (( = (evren-hangi-sahne e) 4 )
     (sahne-4-tuş  e t))
        (( = (evren-hangi-sahne e) 5 )
     (sahne-5-tuş e t ))))



(define (sahne-1-tuş e t)
  (cond
    [ (string=? t " ") (evren 2 ( evren-sahne-1 e)( evren-sahne-2 e )
                              ( evren-sahne-3 e ) ( evren-sahne-4 e ) ( evren-sahne-5 e ))]))


( define ( sahne-2-tuş-s s t)
   (cond
     (( string=? t "left")
                 (sahne-2 (sahne-2-bg-iki s)(sahne-2-elma s)(sepet-sınırlandır(hareket-et ( sahne-2-sepet s )(v -5 0)))(sahne-2-skor-e s)))
       (( string=? t "right")
                 (sahne-2 (sahne-2-bg-iki s)
                          (sahne-2-elma s)
                          (sepet-sınırlandır(hareket-et ( sahne-2-sepet s )(v 5 0)))
                          (sahne-2-skor-e s)))
     (else s)))


(define (sahne-2-tuş e t )
  (evren
   (evren-hangi-sahne e)
   (evren-sahne-1 e)
   (sahne-2-tuş-s (evren-sahne-2 e) t )
   (evren-sahne-3 e)
   (evren-sahne-4 e)
   (evren-sahne-5 e)))

(define (sahne-3-tuş e t)
  (cond
    [ (string=? t " " ) (evren 4 (evren-sahne-1 e)( evren-sahne-2 e )
                               ( evren-sahne-3 e ) ( evren-sahne-4 e ) ( evren-sahne-5 e ))]
  ( else e)))


( define ( sahne-4-tuş-s s t)
   (cond
     (( string=? t "down")
      (sahne-4
       (sahne-4-bg-4 s)
       (çiftçi-sınırlandır(hareket-et( sahne-4-çiftçi s )(v 0 5)))
       (sahne-4-tavuk s)
       (sahne-4-yumurta s)
       (sahne-4-skor-y s)))
     (( string=? t "up")
      (sahne-4
      (sahne-4-bg-4 s)
      (zıpla (çiftçi-sınırlandır(hareket-et ( sahne-4-çiftçi s )(v 0 -5))))
       (sahne-4-tavuk s)
       (sahne-4-yumurta s)
       (sahne-4-skor-y s)))
     (else s)))

(define (sahne-4-tuş e t )
  (evren
   (evren-hangi-sahne e)
   (evren-sahne-1 e)
   (evren-sahne-2 e)
   (evren-sahne-3 e)
   (sahne-4-tuş-s(evren-sahne-4 e ) t)
   (evren-sahne-5 e)))

(define (sahne-5-tuş e t)e)












                    
    
    



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sabit kod bundan sonra                               ;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(yut (big-bang yaradılış
  (on-tick evren-güncelle (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)
  (on-mouse evren-fare)))

