#lang racket
(require rackunit)
(require file/md5)

(define (parse input counter examplar)
  (let
    ([first-five-bytes
       (substring
         (bytes->string/utf-8 (md5 (string-append input (number->string counter))))
         0
         (string-length examplar))])
    (if (equal? examplar first-five-bytes)
      counter
      (parse input (+ 1 counter) examplar))))

(parse "ckczppom" 0 "00000")
(parse "ckczppom" 0 "000000")
