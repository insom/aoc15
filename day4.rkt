#lang racket
(require rackunit)
(require file/md5)

(define (parse input counter)
  (let
    ([first-five-bytes (substring (bytes->string/utf-8 (md5 (string-append input (number->string counter)))) 0 5)])
    (if (equal? "00000" first-five-bytes)
      counter
      (parse input (+ 1 counter)))))

(check-equal? (parse "abcdef" 609041) 609043)
(parse "ckczppom" 0)
