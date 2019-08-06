#lang racket
(require "teachpacks/evren-teachpack.rkt")

(STRUCT v (x y))

(define v-örneği (v 3 4))
(define v-örneği-2 (v 5 12))

;vector-scale vector sayı -> vector
(define (v* vector s ) (v
                             (* s (v-x vector))
                             (* s (v-y vector))))
(check-expect (v* v-örneği 2) (v 6 8))

(define (çizgi-uzunluğu a b)
  (- (max a b) (min a b)))
(ÖRNEK (çizgi-uzunluğu 5 3) 2)
(ÖRNEK (çizgi-uzunluğu 3 5) 2)

(define (mesafe px py cx cy)
  (sqrt (+ (sqr (çizgi-uzunluğu px cx)) ( sqr (çizgi-uzunluğu py cy)) ) ) )
(ÖRNEK (mesafe 4 0 0 3) 5)
(ÖRNEK (mesafe 12 0 0 5) 13)

;vector* vector vector -> sayı
(define (v. v1 v2 ) 
                         (+ (* (v-x v1) (v-x v2))
                          (* (v-y v1) (v-y v2))))
(check-expect (v. v-örneği v-örneği-2) 63)

;vector+ vector vector -> vector
(define (v+ v1 v2 ) (v
                          (+ (v-x v1) (v-x v2))
                          (+ (v-y v1) (v-y v2))))
(check-expect (v+ v-örneği v-örneği-2) (v 8 16))

;; vector- vector vector-> vector
(define (v- v1 v2) (v (- (v-x v1) (v-x v2) ) (- (v-y v1) (v-y v2))))
(check-expect (v- v-örneği v-örneği-2) (v -2 -8))

;; vector-uzunluk vector -> sayı
(define (v-mag v)  (sqrt (+ (sqr (v-x v)) ( sqr (v-y v)) ) ))
(check-expect (v-mag v-örneği) 5)

(STRUCT varlık (imaj h-box k v a))

(STRUCT enemy ( v-part guns weak-point a-i))

(STRUCT player ( v-part gun ab in))

(STRUCT bullet ( v-part dam))

(STRUCT hit-box (width height x y))

(STRUCT evren (mega wall platforms))












