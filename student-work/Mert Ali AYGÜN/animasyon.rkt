#lang racket
(require "teachpacks/evren-teachpack.rkt")
(STRUCT anim ( devamlı değişim-sıklığı zaman resimler))

(STRUCT mod (s1 s2 s3))

(define m-run (anim true 4 12 (list (bitmap "megaman sprites/running-shooting-1.png")
                                         (bitmap "megaman sprites/running-shooting-2.png")
                                         (bitmap "megaman sprites/running-shooting-3.png")
                                         (bitmap "megaman sprites/running-shooting-2.png"))))

;anim-çiz anim sayı -> görüntü
(define (anim-çiz a f) (list-ref (anim-resimler a) (modulo (- f 1) 4)))