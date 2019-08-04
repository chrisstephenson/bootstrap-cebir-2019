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

; isim-ekle pasta metin --> pasta
 (ÖRNEK(isim-ekle pasta-örneği "emir") (pasta "pink" 3 "Mutlu Yıllar Emir" "green" 200 20))

(define(isim-ekle pasta-isim str)
  (pasta (pasta-renk pasta-isim)
         (pasta-kat pasta-isim)
         (string-append (pasta-mesaj pasta-isim) str)
         (pasta-mesaj-rengi pasta-isim)
         (pasta-yarı-çap pasta-isim)
         (pasta-kat-kalınlık pasta-isim)))

(define( çiftkat pasta-isim)
  (pasta (pasta-renk pasta-isim)
         (* 2 (pasta-kat pasta-isim))
         (pasta-mesaj pasta-isim)
         (pasta-mesaj-rengi pasta-isim)
         (pasta-yarı-çap pasta-isim)
         (pasta-kat-kalınlık pasta-isim)))

(define( scale-pasta pasta-bro n)
  (pasta (pasta-renk pasta-bro)
         (pasta-kat pasta-bro)
         (pasta-mesaj pasta-bro)
         (pasta-mesaj-rengi pasta-bro)
         (* n (pasta-yarı-çap pasta-bro))
         (pasta-kat-kalınlık pasta-bro)))

(isim-ekle pasta-örneği "Emir")

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

