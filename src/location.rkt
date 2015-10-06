#lang racket/base

(require racket/cmdline
         
         "mapzen-api/mapzen-search.rkt")

(define country (make-parameter #f))

(define (get-commandline-options)
  (command-line
    #:once-each
    [("-c" "--country") c "Specify country to search in" (country c)]
    #:args (location)
    location))

(module+ main
  (define location (get-commandline-options))

  (define r (mapzen-search->lat+long/city location))
  
  (printf "lat\t~a~nlong\t~a~n"
          (car r) (cdr r)))
