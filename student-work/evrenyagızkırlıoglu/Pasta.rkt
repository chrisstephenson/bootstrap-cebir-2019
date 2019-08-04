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

;;isim-ekle pasta metin -> pasta
;;Verilen ismi pastanin ustune ekle 
(ÖRNEK (isim-ekle pasta-örneği "merhaba") (pasta "pink"  3 "Mutlu Yıllar merhaba" "green" 200 20))         
(define (isim-ekle p isim)
  (pasta
   (pasta-renk p)
   (pasta-kat p)
   (string-append (pasta-mesaj p )isim)
   (pasta-mesaj-rengi p)
   (pasta-yarı-çap p)
   (pasta-kat-kalınlık p)))

;;ciftkat pasta -> pasta
;;pastanin katini ikiye cikaricak

(ÖRNEK (ciftkat pasta-örneği)(pasta "pink"  6 "Mutlu Yıllar merhaba" "green" 200 20))
(define (ciftkat p )
  (pasta
   (pasta-renk p)
   (* 2 (pasta-kat p))
   (pasta-mesaj p )
   (pasta-mesaj-rengi p)
   (pasta-yarı-çap p)
   (pasta-kat-kalınlık p)))

;scale-pasta pasta sayi -> pasta
;pastanin yaricapini carpicak

(ÖRNEK (scale-pasta pasta-örneği 3)(pasta "pink" 3 "Mutlu Yıllar merhaba" "green" 600 20))
(define (scale-pasta p x )
  (pasta
   (pasta-renk p)
   (pasta-kat p)
   (pasta-mesaj p )
   (pasta-mesaj-rengi p)
   (* x (pasta-yarı-çap p))
   (pasta-kat-kalınlık p)))
   



         

   













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
