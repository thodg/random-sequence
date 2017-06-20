;;
;;  random-sequence  -  generate random sequences
;;
;;  Copyright 2017 Thomas de Grivel <thoxdg@gmail.com>
;;
;;  Permission to use, copy, modify, and distribute this software for any
;;  purpose with or without fee is hereby granted, provided that the above
;;  copyright notice and this permission notice appear in all copies.
;;
;;  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
;;  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
;;  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
;;  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
;;  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
;;  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
;;  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
;;

(in-package :common-lisp)

(defpackage :random-sequence
  (:use :common-lisp)
  (:export #:make-random-bytes
           #:make-random-string))

(in-package :random-sequence)

(defun make-random-bytes (length)
  (let ((seq (make-array length :element-type '(unsigned-byte 8))))
    (with-open-file (r #P"/dev/random" :element-type '(unsigned-byte 8))
      (read-sequence seq r))
    seq))

(defun make-random-string (length)
  (subseq (cl-base64:usb8-array-to-base64-string (make-random-bytes
                                                  (ceiling length 4/3))
                                                 :uri t)
          0 length))
