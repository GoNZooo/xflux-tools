#lang racket/base

(require racket/port
         racket/string
         net/url
         json

         gonz/doto

         "mapzen-key.rkt"
         "mapzen-feature.rkt")

(define (mapzen-search/city city)
  (call/input-url (string->url (format mapzen-api-url
                                       (mapzen-api-key)
                                       city))
                  get-pure-port
                  read-json))

(define (mapzen-search/city&country city country)
  (call/input-url (string->url (format mapzen-api-url/country
                                       (mapzen-api-key)
                                       city
                                       country))
                  get-pure-port
                  read-json))

(provide mapzen-search->lat+long/city)
(define (mapzen-search->lat+long/city city)
  (define r
    (highest-confidence (map json->feature
                             (results->features (mapzen-search/city city)))))
  
  (cons (doto r
              feature-geometry
              geometry-coordinates
              coordinates-latitude)
        (doto r
              feature-geometry
              geometry-coordinates
              coordinates-longitude)))

(define (highest-confidence rs)
  (car (sort rs
             >
             #:key (lambda (r)
                     (properties-confidence (feature-properties r))))))

(define (results->features rs)
  (hash-ref rs 'features))
