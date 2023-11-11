
(define (primitive-hash num)
  (modulo (+ num (* 31 num)) 1000000))

(define (verify-merkle-proof merkle-root proof target-hash index)
  (define (loop current-hash proof idx)
    (if (null? proof)
        (= current-hash merkle-root)
        (let ((next-hash (car proof)))
          (loop (primitive-hash (if (even? idx)
                                    (+ current-hash next-hash)
                                    (+ next-hash current-hash)))
                (cdr proof)
                (quotient idx 2)))))
  (loop target-hash proof index))

(define leaf1 1)
(define leaf2 2)
(define leaf3 3)
(define leaf4 4)

(define h1 (primitive-hash leaf1))
(define h2 (primitive-hash leaf2))
(define h3 (primitive-hash leaf3))
(define h4 (primitive-hash leaf4))

(define h12 (primitive-hash (+ h1 h2)))
(define h34 (primitive-hash (+ h3 h4)))

(define merkle-root (primitive-hash (+ h12 h34)))

(define target-hash h3)
(define proof (list h4 h12))
(define index 2) 

(define result (verify-merkle-proof merkle-root proof target-hash index))

(display result)
(newline)

