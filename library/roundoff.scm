#lang scheme/base

(provide round-off)

(define (round-off my-num digits)
  (let ((power (expt 10 digits)))
    (/ (round (* power my-num)) power)))
