 #lang racket
(require "teachpacks/evren-teachpack.rkt")
;; STRUCT v - vektör
;; x : sayı - x koordinatı
;; y : sayı - y koordinatı

( define OYUNCU-imaj ( scale 0.50( bitmap "imaj/ghostbustertrue.PNG")))
( define TEHLİKE-imaj( scale 0.60(bitmap "imaj/billyghost.PNG")))
( define SORU-imaj   ( bitmap "imaj/bubbletrue.PNG"))
( define TEHLİKE-2   ( scale 0.75( bitmap "imaj/aristotle-real.PNG")))
( define TEHLİKE-3   ( scale 0.75( bitmap "imaj/Berilhayalet.PNG")))
( define TEHLİKE-4   ( scale 0.75( bitmap "imaj/Sahrahayalet.PNG")))
( define TEHLİKE-5   ( scale 0.75( bitmap "imaj/ALINESIN-hayalet.PNG")))
( define ODA-1       ( bitmap "imaj/room4.JPG")) 
( define cevap-a1-imaj( scale 0.101( bitmap "imaj/adalovelaceşık.PNG")))
( define cevap-b1-imaj( scale 0.101( bitmap "imaj/billgatesşık.PNG")))
( define cevap-c1-imaj( scale 0.101( bitmap "imaj/aristotleşık.PNG")))
( define doğru-imaj  ( scale  0.25(bitmap "imaj/doğrutik.PNG")))
( define yanlış-imaj ( scale  0.25(bitmap "imaj/yanlıştik.PNG")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;STRUCT
;; v->vektör
;; x-> sayı
;; y-> sayı 
(STRUCT v ( x y ) )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; v+ - vektör toplama
;; v: vektör vektör --> vektör
;; ( define ( v+ vt vk )
;;    ( v
;;        ... v-x vt)(v-x vk)
;;        ... v-y vt)(v-y vk))))
(ÖRNEK   ( v+ (v 2 -3) (v 7 9))
         ( v 9 6  ))
(ÖRNEK   ( v+ (v -7 0) (v 4 5))
         ( v -3 5 ))
( define ( v+ vt vk )
    ( v
         ( + (v-x vk) (v-x vt))
         ( + (v-y vk) (v-y vt))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; v* - vektör çıkartma
;; v: vektör vektör--> vektör
;; ( define ( v- vt vk )
;;    ( v
;;        ... v-x vt) (v-x vk)
;;        ... v-y vt) (v-y vk)))))
(ÖRNEK ( v- (v 2 -3 ) (v 12 4))
       ( v -10 -7))
(ÖRNEK ( v- (v 7 9 ) (v 0 10))
       ( v 7 -1 ))
 ( define ( v- vt vk )
    ( v
        (- (v-x vt) (v-x vk))
        (- (v-y vt) (v-y vk))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; v* - vektör sayıyla çarpma
;; v: sayı vektör --> vektör
;; ( define ( v * S vk )
;;    ( v
;;        ... v-x vk)
;;        ... v-y vk)))))
(ÖRNEK ( v*  (v 2 -3 ) 4)
       ( v 8 -12))

(ÖRNEK ( v*  (v 7 9 ) 0)
       ( v 0 0 ))
 ( define ( v* vk S )
    ( v (* (v-x vk) S )
        (* (v-y vk) S )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; v. - vektör dot çarpma
;; v: vektör vektör --> sayı
(ÖRNEK ( v. ( v 7 9) ( v 5 6))
            89)
(ÖRNEK ( v. ( v 0 0) ( v 0 0))
            0)
(define ( v. vk vt )
  ( + (* (v-x vk) (v-x vt))
      (* (v-y vk) (v-y vt))))
      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; v-mag - vektör uzunluğu
;; v: 
(ÖRNEK (v-mag ( v 3 4 )) 5)
(define(v-mag vk)
  ( sqrt (+ ( sqr (v-x vk))
         ( sqr (v-y vk)))))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;STRUCT anim
;; devamlı : boolean
;; değişim-sıklığı : sayı;
;; zaman : sayı
;; resimler : görüntü listesi
(STRUCT anim (devamlı değişim-sıklığı zaman resimler))
;;;;
( define TEHLİKE-anim (anim false 4 0 (list ( scale 0.60(bitmap "imaj/billyghost.PNG"))
                                            ( scale 0.57(bitmap "imaj/billyghost.PNG"))
                                            ( scale 0.55(bitmap "imaj/billyghost.PNG"))
                                            ( scale 0.50(bitmap "imaj/billyghost.PNG"))
                                            ( scale 0.45(bitmap "imaj/billyghost.PNG"))
                                            ( scale 0.40(bitmap "imaj/billyghost.PNG"))
                                            ( scale 0.35(bitmap "imaj/billyghost.PNG"))
                                            ( scale 0.27(bitmap "imaj/billyghost.PNG"))
                                            ( scale 0.20(bitmap "imaj/billyghost.PNG"))
                                            ( scale 0.10(bitmap "imaj/billyghost.PNG"))
                                            ( scale 0.05(bitmap "imaj/billyghost.PNG"))
                                            ( scale 0.01(bitmap "imaj/billyghost.PNG")))))
;;;;
; anim-çiz anim -> görüntü
; bir animden uygun resim seçmek
(define (anim-çiz a)
  (list-ref (anim-resimler a)
            (modulo (quotient (anim-zaman a) (anim-değişim-sıklığı a))
                    ( length (anim-resimler a)))))

;; anim-zaman-güncelle sayı sayı sayı boolean-> sayı
;; zaman, değişim sıklığı resim sayısı devlılığından yeni zaman hesaplar 
(ÖRNEK (anim-zaman-güncelle 11 3 4 true) 0)
(ÖRNEK (anim-zaman-güncelle 11 3 4 false) 11)
(define (anim-zaman-güncelle z sık uzun devam)
  (cond
    (devam (modulo (+ z 1) (* sık uzun)))
    (else (min (+ z 1) (- (* sık uzun) 1)))))



; anim-güncelle anim -> anim
; bir animden bir sonraki anim yapmak
(define (anim-güncelle a)
  (anim
   (anim-devamlı a)
   (anim-değişim-sıklığı a)
   (anim-zaman-güncelle (anim-zaman a) (anim-değişim-sıklığı a) ( length (anim-resimler a))
                        (anim-devamlı a))
   (anim-resimler a))) 


;;UNION tipi imaj - ya görüntü ya anim
;; imaj->görüntü    : imaj -> görüntü
(define (imaj->görüntü i)
  (cond
    ((anim? i) (anim-çiz i))
    (else i)))

;; imaj-güncelle : imaj ->imaj
;; imajı güncell
(define (imaj-güncelle i)
  (cond
    ((anim? i) (anim-güncelle i))
    (else i)))


; STRUCT nesne
;; imaj : imaj - nesnenin imajı
;; yer : v - nesnenin ekrandaki yeri
;; hız : v - nesnenin hızı
;; ivme : v - nesnenin ivmesi
(STRUCT nesne (imaj yer hız ivme))

;;nesne-güncelle
;;nesne -> nesne
;;bir nesne alıp bir saniye sonraki halini üreterek yeni nesneyi verir.

;;template
;;(define (nesne-güncelle a)
;; (nesne ... (nesne-imaj a) ... (nesne-yer a) ... (nesne-hız a) ... (nesne-ivme a)... ) )
;;

;;örnekler:

(ÖRNEK (nesne-güncelle (nesne (circle 10 "solid" "purple") (v 3 5) (v 2 6) (v 3 5))) (nesne (circle 10 "solid" "purple") (v 5 11) (v 5 11) (v 3 5)))
(ÖRNEK (nesne-güncelle (nesne (star 5 "outline" "black") (v 6 7) (v 0 3) (v 2 1))) (nesne (star 5 "outline" "black") (v 6 10) (v 2 4) (v 2 1)))
(ÖRNEK (nesne-güncelle (nesne (triangle 8 "solid" "blue") (v 7 9) (v 1 5) (v 3 8))) (nesne (triangle 8 "solid" "blue") (v 8 14) (v 4 13) (v 3 8)))
(ÖRNEK (nesne-güncelle (nesne (circle 3 "outline" "yellow") (v 2 2) (v 6 3) (v 5 1))) (nesne (circle 3 "outline" "yellow") (v 8 5) (v 11 4) (v 5 1)))

(define (nesne-güncelle a) 
  (nesne (imaj-güncelle (nesne-imaj a)) (v+ (nesne-yer a) (nesne-hız a)) (v+ (nesne-hız a) (nesne-ivme a)) (nesne-ivme a)))


(ÖRNEK ( nesne-çiz ( nesne (circle 10 "solid" "red")
                           (v 50 50)
                           (v 0 0)
                           (v 0 0))
                   ( square 100 "solid" "yellow" ) )
       (place-image/v ( circle 10 "solid" "red" ) ( v 50 50 )
                      (square 100 "solid" "yellow")))
(define ( nesne-çiz n ap)
  (place-image/v
   (imaj->görüntü (nesne-imaj n))
   (nesne-yer  n)
   ap))


( define OYUNCU    ( nesne OYUNCU-imaj ( v -20 270 ) ( v 2 0 ) (v 1 0)))
;( define TEHLİKE-1 ( nesne TEHLİKE-anim ( v 600 200) ( v  -0.7 0.5 ) ( v -0.6 0 )))
( define TEHLİKE-1 ( nesne TEHLİKE-imaj ( v 600 200) ( v  0 0 ) ( v 0 0 )))
( define SORU      ( nesne SORU-imaj ( v 300 150 ) ( v 0 0 ) ( v 0 0 )))
( define Cevap-a1  ( nesne cevap-a1-imaj ( v 175 330 ) ( v 0 0 ) ( v 0 0 )))
( define Cevap-b1  ( nesne cevap-b1-imaj ( v 300 330 ) ( v 0 0 ) ( v 0 0 )))
( define Cevap-c1  ( nesne cevap-c1-imaj ( v 425 330 ) ( v 0 0 ) ( v 0 0 )))
( define doğru     ( nesne doğru-imaj    ( v 900 275 ) ( v 0 0 ) ( v 0 0)))
( define yanlış    ( nesne yanlış-imaj    ( v 900 275 ) ( v 0 0 ) ( v 0 0)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; nesne-fizik-güncelle nesne-->nesne
;; nesneyi bir sonraki haline getirmeli, yer hız ve ivme kullanarak
;; (define ( nesne-fizik-güncelle n)
;;    (nesne
;;          .... ( nesne-imaj n)
;;          .... ( nesne-yer  n)
;;          .... ( nesne-hız  n)
;;          .... ( nesne-ivme n)
( ÖRNEK (nesne-fizik-güncelle (nesne ( circle 10 "solid" "red") ( v 50 50 ) ( v 2 0 ) ( v 0 0 ) ))
        (nesne ( circle 10 "solid" "red" ) ( v 52 50 ) ( v 2 0 ) ( v 0 0 ) ) ) 
(define ( nesne-fizik-güncelle n)
  (nesne(imaj-güncelle (nesne-imaj n ))
         ( v+ (nesne-yer n) (nesne-hız  n))
         ( v+ (nesne-hız n) (nesne-ivme n))
         (nesne-ivme n)))
  
 
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
        




;; STRUCT evren
;; arkaplanı : görüntü - oyun arka planı
;;
(STRUCT evren (background oyuncu tehlike1 soru cevapa1 cevapb1 cevapc1 doğru yanlış ) )
(ÖRNEK
 ( evren-çiz ( evren background
                     (nesne (circle 10 "solid" "red" )( v 50 50 ) ( v 0 0 ) ( v 0 0 ))
                     (nesne (square 20 "solid" "green") ( v 100 150 ) ( v 0 0 ) ( v 0 0))
                     (nesne (triangle 30 "solid" "yellow") ( v 200 300 ) ( v 0 0 ) ( v 0 0 ))))
             ( nesne-çiz( nesne (circle 10 "solid" "red" )( v 50 50 ) ( v 0 0 ) ( v 0 0 ))
                        ( nesne-çiz( nesne (square 20 "solid" "green") ( v 100 150 ) ( v 0 0 ) ( v 0 0))
                                   ( nesne-çiz(nesne (triangle 30 "solid" "yellow") ( v 200 300 ) ( v 0 0 ) ( v 0 0 )) background)) )) 
                        
            
(define (evren-çiz e)
 (place-text/v (v 300 150 ) "Ilk kodlama dilini kim yarattı?" 20 "black" ( nesne-çiz (evren-oyuncu e)
  ( nesne-çiz ( evren-tehlike1 e)
              ( nesne-çiz ( evren-soru e)
                          (nesne-çiz ( evren-cevapa1 e )
                                     (nesne-çiz  ( evren-cevapb1 e)
                                                 (nesne-çiz ( evren-cevapc1 e )
                                                            ( nesne-çiz (evren-doğru e)
                                                                        ( nesne-çiz ( evren-yanlış e ) 
                                                            
  (evren-background e)))) ))))))) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; oyuncu-sağ-güncelle nesne-->nesne
;; oyuncuyu ekran dışından içine getirip belli biryerde durdurmak
(ÖRNEK ( oyuncu-sağ-güncelle OYUNCU )
       ( nesne (nesne-imaj OYUNCU) ( v 21 270 ) ( v 0 0 ) ( v 0 0 ) ))
          
                                    
 (define (oyuncu-sağ-güncelle n )
  (nesne (nesne-imaj n) (nesne-yer n)
         [cond
    [( > ( v-x (nesne-yer n)) 50 ) (v 0 0) ]
    [else ( nesne-hız n) ]] (nesne-ivme n)))

;;hayalet-sağ nesne --> nesne
;;hayaleti ekranın sağından çıkartıcak
(ÖRNEK ( hayalet-sağ TEHLİKE-1 )
       ( nesne TEHLİKE-imaj  ( v 605 200 ) ( v 5 0 ) ( v 0 0 )))
(define(hayalet-sağ h )
  ( nesne TEHLİKE-imaj ( v+ ( nesne-yer h ) (v 5 0 )) (v 5 0 ) (v 0 0 )))
          
               
            
                         
               
 


; evren-güncelle evren-->evren
; amaç : evrenin bir frame sonraki değerini vermek
(ÖRNEK
  (evren-güncelle yaradılış)
                  (evren background OYUNCU TEHLİKE-1 SORU Cevap-a1 Cevap-b1 Cevap-c1 doğru yanlış ))

  ( define (evren-güncelle e)
  ( evren  (evren-background e)
  ( oyuncu-sağ-güncelle  (nesne-fizik-güncelle (evren-oyuncu e)))
  ( nesne-fizik-güncelle (evren-tehlike1 e))
  ( nesne-fizik-güncelle (evren-soru e))
  ( nesne-fizik-güncelle (evren-cevapa1 e))
  ( nesne-fizik-güncelle (evren-cevapb1 e))
  ( nesne-fizik-güncelle (evren-cevapc1 e))
  (evren-doğru e)
  (evren-yanlış e)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;tehlike-değiştir evren nesne --> evren
;; evrenin içinde bir nesneyi ( tehlikeyi ) değiştirecek
(define (tehlike-değiştir e n)
  ( evren ( evren-background e )
          ( evren-oyuncu e )
          n  
          ( evren-soru e)
          ( evren-cevapa1 e)
          ( evren-cevapb1 e)
          ( evren-cevapc1 e)
          ( evren-doğru   e)
          ( evren-yanlış  e)
           ))
        
          
  
;; evren-tuş evren metin --> evren
;; tuş basması ile hayalet hareket edecek
(ÖRNEK ( evren-tuş yaradılış "a" )
       ( evren ( evren-background yaradılış )
               ( evren-oyuncu yaradılış )
               (evren-tehlike1 yaradılış)
               ( evren-soru yaradılış )
               ( evren-cevapa1 yaradılış )
               ( evren-cevapb1 yaradılış )
               ( evren-cevapc1 yaradılış )
               ( evren-doğru yaradılış)
               ( evren-yanlış yaradılış) ))


(define ( evren-tuş e t ) 
  (cond ((string=? t "a")(tehlike-değiştir (evren
                                            (evren-background e)
                                            ( evren-oyuncu e )
                                            ( evren-tehlike1 e)
                                            ( evren-soru e )
                                            ( evren-cevapa1 e)
                                            ( evren-cevapb1 e)
                                            ( evren-cevapc1 e)
                                            [cond
                                              [(string=? t "a") (nesne (nesne-imaj (evren-doğru  e) ) (v 600 150 ) ( v 0 0 ) ( v 0 0) )]
                                              [else ( evren-doğru e ) ]]
                                             ( evren-yanlış e ))
                                           ( nesne TEHLİKE-anim ( v 600 200) ( v  -0.7 0.5 ) ( v -0.6 0 ))))
        ((or (string=? t "b") (string=? t "c") )(tehlike-değiştir
                                                 (evren
                                                  (evren-background e)
                                                  ( evren-oyuncu e )
                                                  ( evren-tehlike1 e)
                                                  ( evren-soru e )
                                                  ( evren-cevapa1 e)
                                                  ( evren-cevapb1 e)
                                                  ( evren-cevapc1 e)
                                                   ( evren-doğru e )
                                                  [cond
                                                    [(or (string=? t "b")(string=? t "c")) (nesne (nesne-imaj (evren-yanlış  e) ) (v 600 150 ) ( v 0 0 ) ( v 0 0) )]
                                                    [else ( evren-yanlış e ) ]])
                                                 
                                                                  (nesne TEHLİKE-imaj ( v 600 200 ) ( v 5 0 ) ( v 0 0 ))))
        (else e)))



    
     

(define (evren-fare e x y m)
  e)


(define background ODA-1) 

(define FRAME-RATE 12)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define yaradılış
  (evren background OYUNCU TEHLİKE-1 SORU Cevap-a1 Cevap-b1 Cevap-c1 doğru yanlış)) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   

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


                                           

         


