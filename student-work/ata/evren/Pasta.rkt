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

;SÖZLEŞME isim-ekle pasta ve metin -> pasta
;ŞEKİL:(define (isim-ekle p isim ) (p (pasta-mesaj isim)))
(ÖRNEK (isim-ekle pasta-örneği "Anne") (pasta "pink"  3 "Mutlu Yıllar Anne " "green" 200 20))
(define (isim-ekle p isim)  (pasta
                             (pasta-renk p)
                             (pasta-kat p)
                             (string-append (pasta-mesaj p) isim)       
                             (pasta-mesaj-rengi p)
                             (pasta-yarı-çap p)
                             (pasta-kat-kalınlık p))) 

;SÖZLEŞME çift-kat pasta -> pasta
;ŞEKİL:(define (çift-kat p ) (pasta (* pasta-kat 2)))
(ÖRNEK (çift-kat pasta-örneği) (pasta "pink"  6 "Mutlu Yıllar  " "green" 200 20))
(define (çift-kat p)  (pasta
                             (pasta-renk p)
                             (* (pasta-kat p) 2)
                             (pasta-mesaj p)       
                             (pasta-mesaj-rengi p)
                             (pasta-yarı-çap p)
                             (pasta-kat-kalınlık p)))
;SÖZLEŞME şekillendir pasta sayı -> pasta
;ŞEKİL:(define (şekllendir p x ) (scale x pasta)
(ÖRNEK (şekillendir pasta-örneği 4 ) (pasta "pink"  3 "Mutlu Yıllar" "green" 800 20))
(define (şekillendir p x)  (pasta
                             (pasta-renk p)
                             (pasta-kat p)
                             (pasta-mesaj p)       
                             (pasta-mesaj-rengi p)
                             (* (pasta-yarı-çap p) x)
                             (pasta-kat-kalınlık p)))
                             
;(çiz-pasta (isim-ekle pasta-örneği "Anne"))
;(çiz-pasta (çift-kat pasta-örneği))
;(çiz-pasta (şekillendir pasta-örneği 2))


