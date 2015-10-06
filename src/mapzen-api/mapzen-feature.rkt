#lang racket/base

(require racket/match)

(provide (struct-out coordinates))
(struct coordinates
        (longitude
          latitude)
        #:transparent)

(provide (struct-out geometry))
(struct geometry
        (type
          coordinates)
        #:transparent)

(define (json->geometry j)
  (match j
    [(hash-table
       ('type type)
       ('coordinates (list long lat)))
     (geometry type (coordinates long lat))]))

(provide (struct-out properties))
(struct properties
        (name
          id
          gid
          layer
          source
          country-abbreviation
          country
          confidence
          label)
        #:transparent)

(provide json->properties)
(define (json->properties j)
  (match j
    [(hash-table
       ('name name)
       ('id id)
       ('gid gid)
       ('layer layer)
       ('source source)
       ('country_a country-abbreviation)
       ('country country)
       ('confidence confidence)
       ('label label)
       (k v)
       ...)
     (properties
       name
       id
       gid
       layer
       source
       country-abbreviation
       country
       confidence
       label)]
    [_ j]))

(provide (struct-out feature))
(struct feature (type
                  properties
                  geometry)
        #:transparent)

(provide json->feature)
(define (json->feature j)
  (match j
    [(hash-table
       ('type type)
       ('properties properties)
       ('geometry geometry))
     (feature type
              (json->properties properties)
              (json->geometry geometry))]))
