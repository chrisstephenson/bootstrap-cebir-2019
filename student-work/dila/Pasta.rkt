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
  (pasta "light blue"  3 "Mutlu Yıllar " "purple" 200 20))

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
(ÖRNEK (isim-ekle pasta-örneği "dila")
       (pasta (pasta-renk pasta-örneği) (pasta-kat pasta-örneği) (string-append (pasta-mesaj pasta-örneği) "dila")
              (pasta-mesaj-rengi pasta-örneği) (pasta-yarı-çap pasta-örneği) (pasta-kat-kalınlık pasta-örneği)))
(ÖRNEK (isim-ekle pasta-örneği "melis")
       (pasta (pasta-renk pasta-örneği) (pasta-kat pasta-örneği) (string-append (pasta-mesaj pasta-örneği) "melis")
              (pasta-mesaj-rengi pasta-örneği) (pasta-yarı-çap pasta-örneği) (pasta-kat-kalınlık pasta-örneği)))
(define (isim-ekle pasta-örneği metin)
        (pasta (pasta-renk pasta-örneği) (pasta-kat pasta-örneği) (string-append (pasta-mesaj pasta-örneği) metin)
               (pasta-mesaj-rengi pasta-örneği) (pasta-yarı-çap pasta-örneği) (pasta-kat-kalınlık pasta-örneği)))
(çiz-pasta (isim-ekle pasta-örneği "selin"))

;;;;;;;;;;;;;;;;;;;;;;;;;
(ÖRNEK (çift-kat pasta-örneği)
       (pasta (pasta-renk pasta-örneği) (* 2(pasta-kat pasta-örneği)) (pasta-mesaj pasta-örneği)
              (pasta-mesaj-rengi pasta-örneği) (pasta-yarı-çap pasta-örneği) (pasta-kat-kalınlık pasta-örneği)))
(ÖRNEK (çift-kat pasta-örneği)
       (pasta (pasta-renk pasta-örneği) (* 2(pasta-kat pasta-örneği)) (pasta-mesaj pasta-örneği)
              (pasta-mesaj-rengi pasta-örneği) (pasta-yarı-çap pasta-örneği) (pasta-kat-kalınlık pasta-örneği)))
(define (çift-kat pasta-örneği)
        (pasta (pasta-renk pasta-örneği) (* 2(pasta-kat pasta-örneği)) (pasta-mesaj pasta-örneği)
               (pasta-mesaj-rengi pasta-örneği) (pasta-yarı-çap pasta-örneği) (pasta-kat-kalınlık pasta-örneği)))
(çiz-pasta (çift-kat pasta-örneği))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ÖRNEK (scale-pasta pasta-örneği 10)
       (pasta (pasta-renk pasta-örneği) (pasta-kat pasta-örneği) (pasta-mesaj pasta-örneği)
              (pasta-mesaj-rengi pasta-örneği) (* 10 (pasta-yarı-çap pasta-örneği)) (pasta-kat-kalınlık pasta-örneği)))
(ÖRNEK (scale-pasta pasta-örneği 15)
       (pasta (pasta-renk pasta-örneği) (pasta-kat pasta-örneği) (pasta-mesaj pasta-örneği)
              (pasta-mesaj-rengi pasta-örneği) (* 15 (pasta-yarı-çap pasta-örneği)) (pasta-kat-kalınlık pasta-örneği)))
(define (scale-pasta pasta-örneği sayı)
        (pasta (pasta-renk pasta-örneği) (pasta-kat pasta-örneği) (pasta-mesaj pasta-örneği)
               (pasta-mesaj-rengi pasta-örneği) (* sayı (pasta-yarı-çap pasta-örneği)) (pasta-kat-kalınlık pasta-örneği)))
(çiz-pasta (scale-pasta pasta-örneği 2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
