#lang racket
(require "teachpacks/evren-teachpack.rkt")


; STRUCT pasta:
; renk : color - pastanın rengi
; mesaj-rengi : color - mesajın rengi
; kat : sayı - pasta katların sayısı
; mesaj : metin - pasta üstündeki mesaj
; yarı-çap : sayı - pastanın yarıçapı
; kat-kalınlık : pasta katların kalınlığı
(STRUCT pasta (renk kat mesaj mesaj-rengi yarı-çap kat-kalınlık))

(define pasta-örneği
  (pasta "pink"  3 "" "green" 200 20))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Verilmiş kod
;;; Buraya dokunma..
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (çiz-pasta p)
  (overlay/align/offset "center" "top" (text (pasta-mesaj p) 18 (pasta-mesaj-rengi p)) 0  (- (pasta-kat-kalınlık p))
                     (çiz-katlar (pasta-kat p) (pasta-renk p) (pasta-yarı-çap p) (pasta-kat-kalınlık p))))

(define (çiz-katlar kat-sayısı renk yarı-çap kalınlık)
  (cond
    ((<= kat-sayısı 1) (çiz-kat renk yarı-çap))
    (else  (overlay/align/offset "left" "top"  (çiz-kat renk yarı-çap) 0 kalınlık 
                                     (çiz-katlar (- kat-sayısı 1) renk yarı-çap kalınlık)))))

(define (çiz-kat renk yarı-çap)
  (overlay
   (ellipse yarı-çap (/ yarı-çap 2) "outline" "black")
   (ellipse yarı-çap (/ yarı-çap 2) "solid" renk)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Verilmiş kod sonu
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;isim-ekle pasta metin -> pasta
;veilen metni pastanın mesajına eklemek
;(define (isim-ekle p m) (
;                      pasta
;                           (pasta-renk p)
;                           (pasta-kat p)
;                           m
;                           (pasta-mesaj-rengi p)
;                           (pasta-yarı-çap p)
;                           (pasta-kat-kalınlık p)))

(define (isim-ekle p m) (
                       pasta
                            (pasta-renk p)
                            (pasta-kat p)
                            m
                            (pasta-mesaj-rengi p)
                            (pasta-yarı-çap p)
                            (pasta-kat-kalınlık p)))
(check-expect (isim-ekle pasta-örneği "yass") (pasta "pink" 3 "yass" "green" 200 20))

(define (çift-kat p) (
                       pasta
                            (pasta-renk p)
                            (* (pasta-kat p) 2)
                            (pasta-mesaj p)
                            (pasta-mesaj-rengi p)
                            (pasta-yarı-çap p)
                            (pasta-kat-kalınlık p)))
(check-expect (çift-kat pasta-örneği) (pasta "pink" 6 "Mutlu Yıllar " "green" 200 20))

(define (scale-pasta p s) (
                       pasta
                            (pasta-renk p)
                            (* (pasta-kat p) s)
                            (pasta-mesaj p)
                            (pasta-mesaj-rengi p)
                            (* (pasta-yarı-çap p) s)
                            (*(pasta-kat-kalınlık p) s)))
(check-expect (çift-kat pasta-örneği 2) (pasta "pink" 6 "Mutlu Yıllar " "green" 400 40))





                            
