#lang racket/base

(require racket/port
         racket/string

         net/url
         json)

(define (key/env)
  (getenv "MAPZEN_KEY"))

(define (key/loc-env-or-default)
  (call-with-input-file (or (getenv "MAPZEN_KEY_FILE")
                            (expand-user-path "~/.local/share/mapzen/key"))
    port->string))

(provide mapzen-api-key)
(define (mapzen-api-key)
  (string-replace (or (key/env)
                      (key/loc-env-or-default))
                  "\n"
                  ""))

(provide mapzen-api-url)
(define mapzen-api-url "https://search.mapzen.com/v1/search?api_key=~a&text=~a")
(provide mapzen-api-url/country)
(define mapzen-api-url/country "https://search.mapzen.com/v1/search?api_key=~a&text=~a&boundary.country=~a")
