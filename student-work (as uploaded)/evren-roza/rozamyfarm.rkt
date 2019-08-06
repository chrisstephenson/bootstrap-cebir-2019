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

                                           
   
          
(define (evren-tuş e t)
  e)

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

; struct sahne1
;bg: görsel
;tahta:görsel 
;mesaj: metin
; sabit-ekran :görsel
( STRUCT sahne-1 (  sabit-ekran ))

(define bg (bitmap "imaj/çiftlik.jpg"))
(define tahta (scale 0.5 (bitmap "imaj/tahta.jpg")))
(define mesaj (place-text/v (v 20 30) "Merhaba çiftçi;\n Çiftliğim berbat durumda.\n
Yardıma geldiğin için çok teşekkürler.\n Şimdi ağaçtaki elmaları toplar mısın?" 10 "black" tahta))
(define bg-en (image-width bg ))
(define bg-ykslk (image-height bg))
( define sabit-ekran (place-image/v tahta (v 20 30) bg))

(define sahne-1-sabit-imaj
  (place-text/v (v 20 30) "Merhaba çiftçi;\n Çiftliğim berbat durumda.\n
Yardıma geldiğin için çok teşekkürler.\n Şimdi ağaçtaki elmaları toplar mısın?" 10 "black" tahta))

(define (sahne-1-çiz e)(sahne-1-sabit-ekran e))
                              
( define (sahne-1-güncelle e ) e )
;struct sahne-2
;elma:nesne
;sepet:nesne
;skor-e: sayı
;bg-iki:görsel
( STRUCT sahne-2 (  bg-iki elma sepet skor-e))
(define elma  (scale 0.3 (bitmap "imaj/elma.png")))
(define sepet (scale 0.5 (bitmap "imaj/sepet.png")))
(define bg-iki (bitmap "imaj/ağaçlar.jpg" ))
(define skor-e 0)

;sahne-2-çiz :nesne nesne sayı görsel: sahne

(ÖRNEK  (sahne-2-çiz (sahne-2 bg-iki
                    ( nesne elma ( v 40 60 )( v 0 0)( v 0 0 ))
                   (nesne  sepet (v 80 90)(v 0  0)( v 0 0 ))
                   0))
        (sahne-2 bg-iki       
             (nesne-çiz ( nesne elma ( v 40 60)( v 0 0 )( v 0 0 ))
             (nesne-çiz (nesne  sepet (v 80 90)(v 0  0)( v 0 0)))
             (place-text/v (v 50 50)
                             (string-append "Yapılacak:20 SKOR:" ( number->string (sahne-2-skor-e )) 15 "black" test-square)))))
                        

( define (sahne-2-çiz s) 
        (nesne-çiz (sahne-2-elma s )
        (nesne-çiz (sahne-2-sepet s )
                   (place-text/v (v 50 50)
                                 (string-append "Yapılacak:20 SKOR:" ( number->string (sahne-2-skor-e )))
                                 15 "black"
                                 (sahne-2-bg-iki s)))))

(ÖRNEK (sahne-2-güncelle sahne-2-çiz )
       ( sahne-2 bg-iki 
       ( nesne elma ( v 80 222 )( v 0 0)( v 0 0 ))
       (nesne  sepet (v 94 90)(v 0  0)( v 0 0 ))
       0))

( define ( sahne-2-güncelle e )
   ( sahne-2 bg-iki 
   ( nesne-fizik-güncelle (sahne-2-elma e ))
   ( nesne-fizik-güncelle (sahne-2-sepet e))
  0))
 


                              
;struct sahne-3
;bg:görsel
;tahta:görsel
;text : metin
;sabit-ekran: görsel
( STRUCT sahne-3 ( sabit-ekran ))

(define( sahne-3-sabit imaj)( sahne-3 sabit-ekran
                                      (place-text/v (v 20 30) "İyi iş çıkardın! \n Sıra yumurta toplamakta.\n
Tavuklara dikkat et!" 10 "black" tahta)))

(define (sahne-3-çiz e)(sahne-3-sabit-ekran e))

(define (sahne-3-güncelle e ) e )

;struct sahne-4 
;çiftçi:nesne
;tavuk:nesne
;yumurta:nesne
;bg-dört:görsel
;skor-y:sayı
( STRUCT sahne-4 ( çiftçi tavuk yumurta bg-dört skor-y ))
(define bg-4 ( bitmap "imaj/kümes.jpg"))
(define tavuk (scale 0.3 (bitmap "imaj/tavuk.gif")))
(define yumurta (scale 0.3 (bitmap "imaj/yumurta.png")))
(define çiftçi (scale 0.3 (bitmap "imaj/çiftçi.png")))
(define skor-y 0)

(ÖRNEK  (sahne-4-çiz (sahne-4-bg-4
                    ( nesne çiftçi ( v 400 330 )( v 0 0)( v 0 0 ))
                   (nesne  tavuk (v 192 290)(v 0  0)( v 0 0 ))
                   (nesne yumurta (v 200 170 (v 0 0 )(v 0 0))
                   0)))
        (sahne-4 bg-4       
             (nesne-çiz ( nesne çiftçi ( v 400 330)( v 0 0 )( v 0 0 )))
             (nesne-çiz (nesne  tavuk (v 192 290)(v 0  0)( v 0 0)))
             (nesne-çiz (nesne yumurta (v 200 170 )(v 0 0 )(v 0 0)))
             (place-text/v (v 50 50)
                             (string-append "Yapılacak:20 SKOR:" ( number->string (sahne-4-skor-y )) 15 "black" bg-4))))

;sahne-4-çiz:

( define (sahne-4-çiz s) 
        (nesne-çiz (sahne-4-çiftçi s ))
        (nesne-çiz (sahne-4-tavuk s ))
        (nesne-çiz (sahne-4-yumurta s ))           
                   (place-text/v (v 50 50)
                                 (string-append "Yapılacak:20 SKOR:" ( number->string (sahne-2-skor-e )))
                                 15 "black"
                                 (sahne-4 bg-4 s)))

(ÖRNEK (sahne-4-güncelle sahne-4-çiz )
       ( sahne-4 bg-4 
       ( nesne çiftçi ( v 400 330 )( v 0 0)( v 0 0 ))
       (nesne tavuk  (v 192 290)(v 0  0)( v 0 0 ))
       (nesne yumurta  (v 200 170)(v 0  0)( v 0 0 ))
       0))

( define ( sahne-4-güncelle e )
   ( sahne-4 bg-4 
   ( nesne-fizik-güncelle (sahne-4-çiftçi e ))
   ( nesne-fizik-güncelle (sahne-4-tavuk e))
   ( nesne-fizik-güncelle (sahne-4-yumurta e))
  0))



;struct sahne-5
;bg:görsel
;tahta:görsel
;text : metin
;sabit-ekran: görsel
( STRUCT sahne-5 (  sabit-ekran ))

(define sahne-5-sabit-imaj
  (place-text/v (v 20 30) "Sen çok iyi bir çiftçisin.\n
Çiftliğimi kurtardın.\n Çok teşekkür ederim:):)" 10 "black" tahta))
                              
(define (sahne-5-çiz e)(sahne-5-sabit-ekran e))

( define (sahne-5-güncelle e ) e)


( define yaradılış (evren 1
                          ( sahne-1 sahne-1-sabit-imaj )
                          (sahne-2 sahne-2-bg-iki
                                   ( nesne elma ( v 40 60 )( v 0 0)( v 0 0 ))
                                   (nesne  sepet (v 80 90)(v 0  0)( v 0 0 ))
                                   0)
                          (sahne-3 sahne-3-sabit-ekran )
                          (sahne-4 bg-4       
                                   ( nesne çiftçi ( v 40 60)( v 0 0 )( v 0 0 ))
                                   (nesne  tavuk (v 80 90)(v 0  0)( v 0 0))
                                   (nesne yumurta (v 200 170) (v 0 0 )(v 0 0))
                                   0)
                          (sahne-5 sahne-5-sabit-ekran))) 



(define (evren-güncelle e)
  (cond
    (( = ( evren-hangi-sahne e ) 1)
     (evren
      (sahne-1-güncelle(evren-sahne-1 e)))
     (evren-sahne-2 e)
     (evren-sahne-3 e)
     (evren-sahne-4 e)
     (evren-sahne-5 e))
    (( = ( evren-hangi-sahne e ) 2)
     (evren-sahne-1 e)
     (evren
      (sahne-2-güncelle(evren-sahne-2 e)))
     (evren-sahne-3 e)
     (evren-sahne-4 e)
     (evren-sahne-5 e))
    (( = ( evren-hangi-sahne e ) 3)
     (evren-sahne-1 e)
     (evren-sahne-2 e)
     (evren
      (sahne-3-güncelle(evren-sahne-3 e))) 
     (evren-sahne-4 e)
     (evren-sahne-5 e))
    (( = ( evren-hangi-sahne e ) 4)
     (evren-sahne-1 e)
     (evren-sahne-2 e)
     (evren-sahne-3 e)
     (evren
      (sahne-4-güncelle(evren-sahne-4 e)))
     (evren-sahne-5 e))
    (( = ( evren-hangi-sahne e ) 5)
     (evren-sahne-5 e)
     (evren-sahne-2 e)
     (evren-sahne-3 e)
     (evren-sahne-4 e)
     (evren
      (sahne-5-güncelle(evren-sahne-5 e))))))



(define ( evren-çiz e )
  (cond
    (( = (evren-hangi-sahne e)1)
     (sahne-1-çiz (evren-sahne-1 e)))
     (( = (evren-hangi-sahne e)2)
     (sahne-2-çiz (evren-sahne-2 e)))
      (( = (evren-hangi-sahne e)3)
     (sahne-3-çiz (evren-sahne-3 e)))
       (( = (evren-hangi-sahne e)4)
     (sahne-4-çiz (evren-sahne-4 e)))
        (( = (evren-hangi-sahne e)5)
     (sahne-5-çiz (evren-sahne-5 e)))))
     
















                    
    
    



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sabit kod bundan sonra                               ;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(yut (big-bang yaradılış
  (on-tick evren-güncelle (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)
  (on-mouse evren-fare)))

