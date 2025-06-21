;; Parameter Monitoring Contract
;; Monitors external data feeds and parametric triggers

(define-constant ERR_UNAUTHORIZED (err u200))
(define-constant ERR_INVALID_PARAMETER (err u201))
(define-constant ERR_PARAMETER_EXISTS (err u202))

;; Parameter types
(define-constant WEATHER_PARAM u1)
(define-constant EARTHQUAKE_PARAM u2)
(define-constant FLOOD_PARAM u3)

;; Parameter data structure
(define-map parameters
  { param-id: uint }
  {
    param-type: uint,
    location: (string-ascii 50),
    threshold: uint,
    current-value: uint,
    last-updated: uint,
    is-triggered: bool
  }
)

(define-data-var next-param-id uint u1)
(define-data-var oracle-address principal tx-sender)

;; Create new parameter to monitor
(define-public (create-parameter (param-type uint) (location (string-ascii 50)) (threshold uint))
  (let ((param-id (var-get next-param-id)))
    (asserts! (or (is-eq param-type WEATHER_PARAM)
                  (is-eq param-type EARTHQUAKE_PARAM)
                  (is-eq param-type FLOOD_PARAM)) ERR_INVALID_PARAMETER)

    (map-set parameters
      { param-id: param-id }
      {
        param-type: param-type,
        location: location,
        threshold: threshold,
        current-value: u0,
        last-updated: block-height,
        is-triggered: false
      }
    )

    (var-set next-param-id (+ param-id u1))
    (ok param-id)
  )
)

;; Update parameter value (oracle function)
(define-public (update-parameter (param-id uint) (new-value uint))
  (let ((param (unwrap! (map-get? parameters { param-id: param-id }) ERR_INVALID_PARAMETER)))
    (asserts! (is-eq tx-sender (var-get oracle-address)) ERR_UNAUTHORIZED)

    (let ((is-triggered (>= new-value (get threshold param))))
      (map-set parameters
        { param-id: param-id }
        (merge param {
          current-value: new-value,
          last-updated: block-height,
          is-triggered: is-triggered
        })
      )
      (ok is-triggered)
    )
  )
)

;; Check if parameter is triggered
(define-read-only (is-parameter-triggered (param-id uint))
  (match (map-get? parameters { param-id: param-id })
    param (get is-triggered param)
    false
  )
)

;; Get parameter details
(define-read-only (get-parameter (param-id uint))
  (map-get? parameters { param-id: param-id })
)

;; Set oracle address
(define-public (set-oracle (new-oracle principal))
  (begin
    (asserts! (is-eq tx-sender (var-get oracle-address)) ERR_UNAUTHORIZED)
    (var-set oracle-address new-oracle)
    (ok true)
  )
)
