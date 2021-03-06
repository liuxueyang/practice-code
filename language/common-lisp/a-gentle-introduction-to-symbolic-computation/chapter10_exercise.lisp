;;; ##############################
;;;                              #
;;;     chapter 10 Assignment    #
;;;         Exercise Code        #
;;;                              #
;;; ##############################


;; 10.3

(setf *met-more-than-once* 0)

(setf *friends* nil)

(defun meet (person)
  (cond ((equal person (first *friends*))
	 (incf *met-more-than-once*)
	 'we-just-met)
	((member person *friends*)
	 (incf *met-more-than-once*)
	 'we-know-each-other)
	(t (push person *friends*)
	   'pleased-to-see-y0u)))

(meet 'fred)

(meet 'cindy)

(meet 'cindy)

(meet 'joe)

(meet 'fred)

*friends*

*met-more-than-once*

;; 10.4

(defun forget (person)
  (if (member person *friends*)
      (setf *friends* (remove person *friends*))
      (format t "~S is not friends..." person)))

(forget 'fred)

(forget 'little)

;; 10.5
(defun ugly (x y)
  (let* ((newx (if (< x y) x y))
	 (newy (if (< y x) x y))
	 (avg (/ (+ newx newy) 2.0))
	 (pct (* 100 (/ avg newy))))	
    (list 'average avg 'is pct 'percent 'of
	  'max newy)))

(ugly 20 2)

;; 10.6
(setf x nil)
(push x x) ;=> (nil) 
(push x x) ;=> ((nil) nil)
(push x x) ;=> (((nil) nil) (nil) nil)


;; 10.8


(defun make-board ()
  (list 'board 
	0 0 0
	0 0 0
	0 0 0))

(defun convert-to-letter (v)
  (cond ((equal v 1) "O")
	((equal v 10) "X")
	(t " ")))

(defun print-row (x y z)
  (format t "~&    ~A | ~A | ~A "
	  (convert-to-letter x)
	  (convert-to-letter y)
	  (convert-to-letter z)))

(defun print-board (board)
  (format t "~%")
  (print-row
   (nth 1 board) (nth 2 board) (nth 3 board))
  (format t "~&   -----------")
  
  (print-row
   (nth 4 board) (nth 5 board) (nth 6 board))
  (format t "~&   -----------")
  
  (print-row
   (nth 7 board) (nth 8 board) (nth 9 board))
;  (format t "~&   -----------")

  (format t "~%~%"))

(setf b (make-board))

(print-board b)

(defun make-move (player pos board)
  (setf (nth pos board) player)
  board)

(setf *computer* 10)

(setf *opponent* 1)

(make-move *opponent* 3 b)

(make-move *computer* 5 b)

(print-board b)

(setf *triplets*
      '((1 2 3) (4 5 6) (7 8 9)
	(1 4 7) (2 5 8) (3 6 9)
	(1 5 9) (3 5 7)))

(defun sum-triplet (board triplet)
  (+ (nth (first triplet) board)
     (nth (second triplet) board)
     (nth (third triplet) board)))

(sum-triplet b '(3 5 7))

(sum-triplet b '(2 5 8))

(sum-triplet b '(7 8 9))

(defun compute-sums (board)
  (mapcar #'(lambda (x)
	      (sum-triplet board x))
	  *triplets*))

(compute-sums b)

(defun winner-p (board)
  (let ((sum (compute-sums board)))
    (or (member (* 3 *computer*) sum)
	(member (* 3 *opponent*) sum))))

(defun board-full-p (board)
  (not (member 0 board)))

(defun read-a-legal-move (board)
  (format t "~&Your move: ")
  (let ((pos (read)))
    (cond ((not (and (<= 1 pos 9)
		     (integerp pos)))
	   (format t "~&Invalid input.")
	   (read-a-legal-move board))
	  ((not (zerop (nth pos board)))
	   (format t
		   "~&That space is already occupied.")
	   (read-a-legal-move board))
	  (t pos))))

(defun opponent-move (board)
  (let* ((pos (read-a-legal-move board))
	 (new-board (make-move *opponent* pos board)))
    (print-board new-board)
    (cond ((winner-p new-board)
	   (format t "~&You win!"))
	  ((board-full-p new-board)
	   (format t "~&Tie game."))
	  (t (computer-move new-board)))))

(defun pick-random-empty-position (board)
  (let ((pos (1+ (random 9))))
    (if (zerop (nth pos board))
	pos
	(pick-random-empty-position board))))

(defun random-move-strategy (board)
  (list (pick-random-empty-position board)
	"random move"))

(defun choose-best-move (board)
  (or (make-three-in-a-row board)
      (block-opponent-win board)
      (block-squeeze-play board)
      (block-two-on-one board)
      (exploit-two-on-one board)
      (try-squeeze-play board)
      (try-two-on-one board)
      (random-move-strategy board)))

(defun computer-move (board)
  (let* ((best-move (choose-best-move board))
	 (pos (first best-move))
	 (strategy (second best-move))
	 (new-board (make-move *computer* pos board)))
    (format t "~&My move: ~S" pos)
    (format t "~&My strategy: ~A~%" strategy)
    (print-board new-board)
    (cond ((winner-p new-board)
	   (format t "~&I win!"))
	  ((board-full-p new-board)
	   (format t "~&Tie game."))
	  (t (opponent-move new-board)))))

(defun play-one-game ()
  (if (y-or-n-p "Would you like to go first?")
      (opponent-move (make-board))
      (computer-move (make-board))))


(defun find-empty-position (board squares)
  (find-if #'(lambda (x) (zerop (nth x board)))
	squares))

(defun win-or-block (board target-sum)
  (let ((triplet
	 (find-if #'(lambda (x) (equal (sum-triplet board x)
				       target-sum))
		  *triplets*)))
    (when triplet
      (find-empty-position board triplet))))

(defun make-three-in-a-row (board)
  (let ((pos (win-or-block board (* 2 *computer*))))
    (and pos (list pos "make three in a row"))))

(defun block-opponent-win (board)
  (let ((pos (win-or-block board (* 2 *opponent*))))
    (and pos (list pos "block opponent"))))



;; a.

(setf *corners* '(1 3 7 9))

(setf *sides* '(2 4 6 8))

;; b.

(setf *diagonal* '((1 5 9) (3 5 7)))

(defun compute-board-sum (board)
  (let ((number-board (rest board)))
    (reduce #'+ number-board)))

(defun block-squeeze-play-1 (board)
  (let ((sum (+ *computer* (* 2 *opponent*)))
	(all-sum (compute-board-sum board)))
    (when (equal sum all-sum)
      (when (member sum
		    (mapcar #'(lambda (triplet)
				(sum-triplet board triplet))
			    *diagonal*))
	(when (member (list *opponent* *computer* *opponent*)
		      (mapcar #'(lambda (triplet)
				  (list (nth (first triplet) board)
					(nth (second triplet) board)
					(nth (third triplet) board)))
			      *diagonal*) :test #'equal)
	  (list (nth (random (length *sides*)) *sides*)
		"block-squeeze-play"))))))

;; c.

(defun get-value-by-triplet (board triplets)
  (mapcar #'(lambda (trip)
	      (list (nth (first trip) board)
		    (nth (second trip) board)
		    (nth (third trip) board)))
	  triplets))

(defun block-two-on-one-1 (board)
  (let ((sum (+ *computer* (* 2 *opponent*)))
	(all-sum (compute-board-sum board)))
    (or (and (equal sum all-sum)
	     (member sum (mapcar #'(lambda (triplet)
				     (sum-triplet board triplet))
				 *diagonal*))
	     (or (member (list *opponent* *opponent* *computer*)
			 (get-value-by-triplet board *diagonal*)
			 :test #'equal)
		 (member (list *computer* *opponent* *opponent*)
			 (get-value-by-triplet board *diagonal*)
			 :test #'equal))
	     (dolist (trip *diagonal*)
	       (if (equal (sum-triplet board trip)
			  sum)
		   (return (list (nth (random (length (set-difference
						       *corners* trip)))
				      (set-difference *corners* trip))
				 "block-two-on-one")))))
	(let ((corner-center (cons 5 *corners*)))
	  (and (equal *opponent* all-sum)
	       (let ((position
		      (- (length board)
			 (length (member *opponent* board)))))
		 (and (member position corner-center)
		      (setf select-list (remove position corner-center))
		      (list (nth (random (length select-list))
				 select-list)
			    "block-two-on-one"))))))))

;; d.
;; modify choose-best-move function...

;; e.
;; I didn't write it...


;; Following is the EXCELLENT program written author!!!

(defun sq-helper (board c1 c2 val strategy pool)
  (when (equal val (sum-triplet
		    board (list c1 5 c2)))
    (let ((pos (find-empty-position board
				    (or pool (list c1 c2)))))
      (and pos (list pos strategy)))))

(defun sq-and-2 (board player pool v strategy)
  (when (equal player (nth 5 board))
    (or (sq-helper board 1 9 v strategy pool)
	(sq-helper board 3 7 v strategy pool))))

(defun block-squeeze-play (board)
  (sq-and-2 board *computer* *sides* 12 "block squeeze play"))

(defun block-two-on-one (board)
  (sq-and-2 board *opponent* *corners* 12 "block two-on-one"))

(defun try-squeeze-play (board)
  (sq-and-2 board *opponent* nil 11 "set up a squeeze play"))

(defun try-two-on-one (board)
  (sq-and-2 board *computer* nil 11 "set up a two-on-one"))

(defun exploit-two (board pos d1 d2 c1 c2)
  (and (equal (sum-triplet board
			   (list c1 5 c2)) 21)
       (zerop (nth pos board))
       (zerop (nth d1 board))
       (zerop (nth d2 board))
       (list pos "exploit two-on-one")))

(defun exploit-two-on-one (board)
  (when (equal *computer* (nth 5 board))
    (or (exploit-two board 1 2 4 3 7)
	(exploit-two board 3 2 6 1 9)
	(exploit-two board 7 4 8 1 9)
	(exploit-two board 9 6 8 3 7))))

;; 10.9

(defun chop (lst)
  (setf (rest lst) nil)
  lst)

;; 10.10

(defun ntack (lst item)
  (nconc lst (list item)))

;; 10.11 
;; draw something.

;; 10.12 
;; critical difference between append and nconc

