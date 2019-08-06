;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Pasta) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#lang racket
(require "teachpacks/evren-teachpack.rkt")


; STRUCT pasta:
; renk : color - pastanın rengi
; mesaj-rengi : color - mesajın rengi
; kat : sayı - pasta katların sayısı
; mesaj : metin - pasta üstündeki mesaj
; yarı-çap : sayı - pastanın yarıçapı
; kat-kalınlık : pasta katların kalınlığı
; mum-sayısı : sayı - pasta üstündeki mumların sayısı

(STRUCT pasta (renk kat mesaj mesaj-rengi yarı-çap kat-kalınlık))


(define pasta-örneği
  (pasta "blue"  3 "Mutlu Yıllar " "white" 200 20))

;; verilen isim pastanın mesajına eklendi
(define (isim-ekle p isim )
  (pasta
      (pasta-renk p)
      (pasta-kat p)
      (string-append (pasta-mesaj p) isim)
      (pasta-mesaj-rengi p)
      (pasta-yarı-çap p)
      (pasta-kat-kalınlık p)))
(define (çift-kat p)
  (pasta
      (pasta-renk p)
      (* 2 (pasta-kat p))
      (pasta-mesaj p) 
      (pasta-mesaj-rengi p)
      (pasta-yarı-çap p)
      (pasta-kat-kalınlık p)))
(define (yarı-çap p)
  (pasta
      (pasta-renk p)
      (pasta-kat p)
      (pasta-mesaj p) 
      (pasta-mesaj-rengi p)
      (/ (pasta-yarı-çap p) 2)
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


