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
  (pasta "pink"  2 "Mutlu Yıllar" "green" 200 20))

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
;(isim-ekle metin pasta -> pasta)
;(pastanın metnini değiştirmek)
;üst üste binmiş circlelar
;(define (isim-ekle p)
  ;(pasta
       ;(pasta-çapı p)
       ;(pasta-renk p)
       ;(pasta-mum-sayısı p)
       ;(pasta-mesaj p)
       ;(pasta-katsayısı)))
(ÖRNEK (ikinci-pasta pasta-örneği "anne") (pasta "pink"  2 "Mutlu Yıllar anne" "green" 200 20))
(ÖRNEK (ikinci-pasta pasta-örneği "baba") (pasta "pink"  2 "Mutlu Yıllar baba" "green" 200 20))
(define (ikinci-pasta p isim) (pasta (pasta-renk p)(pasta-kat p)(string-append (pasta-mesaj p)isim)(pasta-mesaj-rengi p)(pasta-yarı-çap p)(pasta-kat-kalınlık p)))
(ÖRNEK (üçüncü-pasta pasta-örneği 4)(pasta "pink" 2 "Mutlu Yıllar" "green" 200 20))
(ÖRNEK (üçüncü-pasta pasta-örneği 16)(pasta "pink" 8 "Mutlu Yıllar" "green" 200 20))
(define (üçüncü-pasta u kat) (pasta (pasta-renk u) (pasta-kat u) kat)(string-append (pasta-mesaj u)(pasta-mesaj-rengi u)(pasta-yarı-çap u)(pasta-kat-kalınlık u))) 
(pasta "pink" 2 "Mutlu Yıllar" "green" 200 20)
(scale 2(çiz-pasta (ikinci-pasta pasta-örneği " Alp")))
(scale 2(çiz-pasta (üçüncü-pasta pasta-örneği 4)))