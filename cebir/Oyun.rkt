;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Oyun) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require "Teachpacks/bootstrap-teachpack.rkt")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 0. Oyun başlığı: Oyununuzun adını burada yazın
(define BAŞLIK "Oyunum")
(define BAŞLIK-RENGİ "white")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Görüntüler - tehlike, hedef, ve oyuncu görselleri
(define ARKAPLAN (bitmap "Teachpacks/teachpack-images/bg.jpg"))
(define TEHLİKE (triangle 30 "solid" "red"))
(define HEDEF (circle 20 "solid" "green"))
(define OYUNCU (bitmap "Teachpacks/teachpack-images/ninja.png"))
(define mesafeler-göster false)


;; Bu oyunun bir ekran görüntüsü, OYUNCU (320, 240)'ta,
;; HEDEF (400 500)'ta ve TEHLİKE (150, 200)'ta
(define EKRANGÖRÜNTÜSÜ (put-image TEHLİKE
                                150 200
                                (put-image HEDEF
                                           500 400
                                           (put-image OYUNCU
                                                      320 240
                                                      ARKAPLAN))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 1. Tehlike, Hedef, ve oyuncu'yu hareket ettiriyoruz

; tehlike-güncelle: Sayı -> Sayı
; tehlike'nin x koordinatı verildiğinde bir sonraki x koordinatını döndür

;; tehlike-güncelle için örnekleri alta yazın


(define (tehlike-güncelle x)
  x)


; hedef-güncelle : Sayı -> Sayı
; hedef'in x koordinatı verildiğinde bir sonraki x koordinatını döndür

;; hedef-güncelle için örnekleri alta yazın

(define (hedef-güncelle x)
  x)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 2. Tehlike ve hedef'in ekrana geri dönmesini sağlıyoruz
;;    Nereye gittiklerini bilmemiz lazım
;;    Ekranın içindeler mi?

; ekran-solundan-çıkmamış? : Sayı -> Mantıksal
; Karakter oyun ekranının solundan içeride mi?

; Bunun doğru olduğu ve yanlış olduğu birer örnek yazın

(define (ekran-solundan-çıkmamış? x)
  true)

; ekran-sağından-çıkmamış? : Sayı -> Mantıksal
; Karakter oyun ekranının sağından içeride mi?

; Bunun doğru olduğu ve yanlış olduğu birer örnek yazın

(define (ekran-sağından-çıkmamış? x)
  true)

; ekranda? : Sayı -> Mantıksal
; Koordinat ekranın içinde mi belirler

;; ÖRNEKler:

(define (ekranda-görünüyor-mı? x)
  true)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 3. Oyuncuyu hareket ettirelim!

; oyuncu-günceller: Sayı Metin -> Sayı
; oyuncunun y koordinatı ve bir yön bilgisi verildiğinde bir sonraki y koordinatını döndürür

; ÖRNEKler:

(define (oyuncu-güncelle y yön)
  y)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 4. Çarpışmalar: Oyuncu hedefe veya tehlikeye yeterince yaklaştığında birşey olmalı!
;;    Burada "yeterince yakın"ın ne olduğunu bilmemiz gerek, ve nesnelerin birbirinden ne kadar uzak olduğunu bilmeliyiz

;; eğer mesafe-rengi "yellow" ise program oyuncu ve diğer nesneler arasında sarı bir üçgen çizer.
;; Bu üçgenin kenarlarında kenar uzunluğu gösterilir
;; ve mesafe ta hipotenüzte gösterilir (bu her renkte olur)
(define *mesafe-rengi* "")

; çizgi-uzunluğu: Sayı Sayı -> Sayı
; Bir sayı ekseni üzerinde iki nokta arasındaki çizginin uzunluğu
;; bazı örnekler - dikkat edin girdi değerlerinin sırası ne olursa olsun aynı değeri döndürmeliyiz

(define (çizgi-uzunluğu a b)
  0)
  
; mesafe : Sayı Sayı Sayı Sayı -> Sayı
; Ekrandaki iki nokta arasındaki mesafe
; Oyuncunun x ve y, ve bir nesnenin x ve y koordinatları verilmiş
; Ne kadar uzaktırlar?
; Örnekler:

(define (mesafe px py cx cy)
  0)

; çarğıştı? : Sayı Sayı Sayı Sayı -> Mantıksal
; Ne kadar yakın yeterince yakındır?
; Oyuncunun x ve y koordinatları ve bir nesnenin x ve y koordinatları verilmiş
; Aralarındaki mesafeye bakıp çarpışıp çarpışmadıklarına karar veririz.
; Örnekler:
(define (çarpıştı-mı? px py cx cy)
  false)



; son bir sır:
(define GİZEMLİ (radial-star 5 25 10 "solid" "silver"))
(define (gizemli-güncelle x) 
  200)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; VERİLEN KOD: Buraya dokunmayınız...

(define g (make-game BAŞLIK BAŞLIK-RENGİ 
                     ARKAPLAN 
                     TEHLİKE tehlike-güncelle
                     HEDEF hedef-güncelle
                     OYUNCU oyuncu-güncelle
                     GİZEMLİ gizemli-güncelle
                     mesafeler-göster çizgi-uzunluğu mesafe
                     çarpıştı-mı? ekranda-mı?))

;; bu satır oyunu otomatik olarak başlatır...
(play g)
