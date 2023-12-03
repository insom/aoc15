#lang racket
(require rackunit)

(define (parse input)
  (for/sum ([i (string->list input)])
            (case i
              [(#\() 1]
              [(#\)) -1]
              [else 0]
            )))

(check-equal? (parse ")())())") -3)

(call-with-input-file "input1"
  (lambda (in)
    (display (parse (port->string in)))))
