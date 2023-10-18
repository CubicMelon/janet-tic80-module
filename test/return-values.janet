(import ../tic80)

# nil returns (special cases only)
(assert (nil? (tic80/pix 0 0 1))) # returns nil if a color is specified
(assert (nil? (tic80/pmem 0 1))) # returns nil if a value is specified

# boolean returns
(assert (boolean? (tic80/btn 0)))
(assert (boolean? (tic80/btnp 0)))
(assert (boolean? (tic80/fget 0 1)))
(assert (boolean? (tic80/key 0)))
(assert (boolean? (tic80/keyp 0)))

# numeric returns
(assert (number? (tic80/mget 4 5)))
(assert (number? (tic80/peek 0 1)))
(assert (number? (tic80/peek 0 2)))
(assert (number? (tic80/peek 0 3)))
(assert (number? (tic80/peek 0 4)))
(assert (number? (tic80/peek1 0)))
(assert (number? (tic80/peek2 0)))
(assert (number? (tic80/peek4 0)))
(assert (number? (tic80/pix 0 0))) # returns a color if no set color is specified
(assert (number? (tic80/pmem 0))) # returns a number if no set value is specified
(assert (number? (tic80/tstamp))) # not going to try and call os/time twice and make sure they match or anything

# complex returns
(let [[x y left middle right scrollx scrolly] (tic80/mouse)]
  (assert (number? x))
  (assert (number? y))
  (assert (boolean? left))
  (assert (boolean? middle))
  (assert (boolean? right))
  (assert (number? scrollx))
  (assert (number? scrolly)))

# returns we can check for specific values
(assert (= 24 (tic80/font "text" 0 0 0 5 5))) # width = (char-width + 1) * length of string
(assert (= 25 (tic80/print "hello"))) # width = 5 * length of string
(assert (= 1 (tic80/time)))
(assert (= 2 (tic80/time)))
(assert (= 3 (tic80/time)))
(assert (= 4 (tic80/time))) # each subsequent call to time should return +1
(assert (= 0 (tic80/vbank 1)))
(assert (= 1 (tic80/vbank 0))) # each subsequent call to vbank should return value of last call (starting with default 0)