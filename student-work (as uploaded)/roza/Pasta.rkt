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
  (pasta "pink"  3 "Mutlu Yıllar " "green" 200 20))

( define ( pasta-isim pastax metin)
   (pasta ( pasta-renk pastax)
                            ( pasta-kat pastax)
                            metin
                            ( pasta-mesaj-rengi pastax )
                            ( pasta-yarı-çap pastax )
                            (pasta-kat-kalınlık pastax )))


( define ( çift-kat pastax  )
   ( pasta ( pasta-renk pastax )
           ( * (pasta-kat pastax) 2)
           (pasta-mesaj pastax )
           (pasta-mesaj-rengi pastax )
           (pasta-yarı-çap pastax)
           ( pasta-kat-kalınlık pastax)))

( define (scale-pasta pastax sayı)
   ( pasta ( pasta-renk pastax )
           ( pasta-kat pastax)
           (pasta-mesaj pastax )
           ( pasta-mesaj-rengi pastax )
           (* 2 (pasta-yarı-çap pastax))
           ( pasta-kat-kalınlık pastax)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;(
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

(çiz-pasta ( pasta-isim pasta-örneği "roza") )
(çiz-pasta (çift-kat pasta-örneği ))
(çiz-pasta ( scale-pasta pasta-örneği 3 ))
