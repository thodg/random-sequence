
(in-package :common-lisp)

(defpackage :random-sequence
  (:use :common-lisp)
  (:export #:make-random-bytes
	   #:make-random-string))

(in-package :random-sequence)

(defun make-random-bytes (length)
  (let ((seq (make-array length :element-type '(unsigned-byte 8))))
    (with-input-from-file (r #P"/dev/random" :element-type '(unsigned-byte 8))
      (read-sequence seq r))
    seq))

(defun make-random-string (length)
  (subseq (cl-base64:usb8-array-to-base64-string (make-random-bytes
						  (ceiling length 4/3))
						 :uri t)
	  0 length))
