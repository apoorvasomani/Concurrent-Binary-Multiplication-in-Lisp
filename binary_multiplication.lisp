(defvar num1)
(defvar num2)
(defvar answer)
(defvar n1)
(defvar n2)
(defvar ans)
(defvar len)
(defvar carry)
(defvar carry2)
(defvar iterator)
(defvar w)
(defvar temp2)
(defvar temp3)
(defvar len2)

(setq carry 0)

(defun dec-to-binary(n)
  (cond((= n 0)(list 0))
       ((= n 1)(list 1))
       (t (nconc (dec-to-binary (truncate n 2)) (list (mod n 2))))))

(defun numlist-to-string(lst)
  (when lst
    (concatenate 'string
		 (write-to-string (car lst)) (numlist-to-string (cdr lst)))))

(defun binary-to-list(n)
  (map 'list #'digit-char-p(prin1-to-string n)))

(defun multiply(n b)
  (loop for a in n
	for y = (logand a b)
	collect y))

(defun append-zeroes-after(y k)  
  (loop while (> k 0)
	do (setq y (append y '(0)))
	(setq k (- k 1)))
   (return-from append-zeroes-after y))

(defun append-zeroes-before(y k)
  (setq w '())
  (loop while(> k 0)
	do (setq w (append w '(0)))
	(setq k (- k 1)))
  (setq y (append w y))
  (return-from append-zeroes-before y))

(defun decide-carry(a b)
  (cond
   ((and (= a 0) (= b 0)) 0)
   ((and (= a 1) (= b 1)) 1)
   ((and (= a 0) (= b 1)) 0)
   ((and (= a 1) (= b 0)) 0)))

(defun binary-add(x y)
  (setq temp3 '())
  (if (> (length x) (length y))
      (setq y (append-zeroes-before y (abs (- (length x) (length y))))))
	   
  (if (> (length y) (length x))
      (setq x (append-zeroes-before y (abs (- (length x) (length y))))))

  (setq carry 0)
  (loop for a in (reverse x)
	for b in (reverse y)
	do (setq carry2 carry)
	(setq carry (decide-carry a b))
	(setq temp3 (append temp3 (list (logxor a b carry2))))

	(if (and (= carry2 1) (= (logxor a b) 1))
	    (setq carry 1)))

  (setq temp3 (reverse temp3))
  (if (= carry 1)
      (push 1 temp3))
  (return-from binary-add temp3))

(defun rotate(l c)
  (if (minusp c)
      (rotate l (+ (length l) c))
    (nconc (subseq l c) (subseq l 0 c))))

(write-line "Enter first number - ")
(setq num1 (read))
(write-line "Enter second number - ")
(setq num2 (read))

(setq n1 (dec-to-binary num1))
(setq n2 (dec-to-binary num2))

(setq len (length n1))
(setq len (- len 1))

(print n1)
(print n2)
(print '------------------------------)
 
(setq ans '())

(loop for s from 0 to (length n1)
      do (setq ans (append ans '(0))))

(setq len2 len)

(defun main(x)
      (format t "~S" sb-thread:*current-thread*)
      (setq ans (binary-add (append-zeroes-after (append-zeroes-before (multiply n2 (car n1)) x) len2) ans)))
     

(loop for x from 0 to len
      do (print ans)
      (sb-thread:join-thread (sb-thread:make-thread(lambda () (main x))))
      (setq len2 (- len2 1))
      (setq n1 (cdr n1)))

(print '-----------------------------)
(print ans)
(terpri)
