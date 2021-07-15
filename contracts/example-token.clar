;; Implement the `ft-trait` trait defined in the `ft-trait` contract
(impl-trait .ft-trait.sip-010-trait)

(define-fungible-token example-token)

;; get the token balance of owner
(define-read-only (get-balance (owner principal))
  (begin
    (ok (ft-get-balance example-token owner))))

;; returns the total number of tokens
(define-read-only (get-total-supply)
  (ok (ft-get-supply example-token)))

;; returns the token name
(define-read-only (get-name)
  (ok "Example Token"))

;; the symbol or "ticker" for this token
(define-read-only (get-symbol)
  (ok "EXAMPLE"))

;; the number of decimals used
(define-read-only (get-decimals)
  (ok u8))

;; Transfers tokens to a recipient
(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
  (if (is-eq tx-sender sender)
    (begin
      (try! (ft-transfer? example-token amount sender recipient))
      (print memo)
      (ok true)
    )
    (err u4)))

(define-public (get-token-uri)
  (ok (some u"https://example.com")))

;; mint to the treasury
(ft-mint? example-token u100000000000000 'SP32XCD69XPS3GKDEXAQ29PJRDSD5AR643GNEEBXZ)
