---
layout: post
title: evens-only*&co 推导过程
date: 2014-04-20
---

```scheme
(evens-only*&co '((9 1 2 8) 3 10) the-last-friend)
;=> '(13 160 (2 8) 10)

(evens-only*&co '(9 1 2 8)
		(lambda (al ap as)
		  (evens-only*&co '(3 10)
				  (lambda (dl dp ds)
				    (the-last-friend (cons al dl)
						     (x ap dp)
						     (+ as ds))))))




(evens-only*&co '(1 2 8)
		(lambda (newl p s)
		  ((lambda (al ap as)
		     (evens-only*&co '(3 10)
				     (lambda (dl dp ds)
				       (the-last-friend
					(cons al dl)
					(x ap dp)
					(+ as ds)))))
		   newl p (+ 9 s))))




(evens-only*&co '(2 8)
		(lambda (newl p s)
		  ((lambda (newl p s)
		     ((lambda (al ap as)
			(evens-only*&co '(3 10)
					(lambda (dl dp ds)
					  (the-last-friend
					   (cons al dl)
					   (x ap dp)
					   (+ as ds)))))
		      newl p (+ 9 s)))
		   newl p (+ 1 s))))



(evens-only*&co '(8)
		(lambda (newl p s)
		  ((lambda (newl p s)
		     ((lambda (newl p s)
			((lambda (al ap as)
			   (evens-only*&co '(3 10)
					   (lambda (dl dp ds)
					     (the-last-friend
					      (cons al dl)
					      (x ap dp)
					      (+ as ds)))))
			 newl p (+ 9 s)))
		      newl p (+ 1 s)))
		   (cons 2 newl)
		   (x 2 p)
		   s)))

(evens-only*&co '()
		(lambda (newl p s)
		  ((lambda (newl p s)
		     ((lambda (newl p s)
			((lambda (newl p s)
			   ((lambda (al ap as)
			      (evens-only*&co '(3 10)
					      (lambda (dl dp ds)
						(the-last-friend
						 (cons al dl)
						 (x ap dp)
						 (+ as ds)))))
			    newl p (+ 9 s)))
			 newl p (+ 1 s)))
		      (cons 2 newl) (x 2 p) s))
		   (cons 8 newl) (x 8 p) s)))



((lambda (newl p s)
   ((lambda (newl p s)
      ((lambda (newl p s)
	 ((lambda (newl p s)
	    ((lambda (al ap as)
	       (evens-only*&co '(3 10)
			       (lambda (dl dp ds)
				 (the-last-friend
				  (cons al dl)
				  (x ap dp)
				  (+ as ds)))))
	     newl p (+ 9 s)))
	  newl p (+ 1 s)))
       (cons 2 newl) (x 2 p) s))
    (cons 8 newl) (x 8 p) s))
 '() 1 0)



((lambda (newl p s)
   ((lambda (newl p s)
      ((lambda (newl p s)
	 ((lambda (newl p s)
	    ((lambda (al ap as)
	       (evens-only*&co '(10)
			       (lambda (newl p s)
				 ((lambda (dl dp ds)
				    (the-last-friend
				     (cons al dl)
				     (x ap dp)
				     (+ as ds)))
				  newl p (+ 3 s)))))
	     newl p (+ 9 s)))
	  newl p (+ 1 s)))
       (cons 2 newl) (x 2 p) s))
    (cons 8 newl) (x 8 p) s))
 '() 1 0)



((lambda (newl p s)
   ((lambda (newl p s)
      ((lambda (newl p s)
	 ((lambda (newl p s)
	    ((lambda (al ap as)
	       (evens-only*&co '()
			       (lambda (newl p s)
				 ((lambda (newl p s)
				    ((lambda (dl dp ds)
				       (the-last-friend
					(cons al dl)
					(x ap dp)
					(+ as ds)))
				     newl p (+ 3 s)))
				  (cons 10 newl) (x 10 p) s))))
	     newl p (+ 9 s)))
	  newl p (+ 1 s)))
       (cons 2 newl) (x 2 p) s))
    (cons 8 newl) (x 8 p ) s))
 '() 1 0)



((lambda (newl p s)
   ((lambda (newl p s)
      ((lambda (newl p s)
	 ((lambda (newl p s)
	    ((lambda (al ap as)
	       ((lambda (newl p s)
		  ((lambda (newl p s)
		     ((lambda (dl dp ds)
			(the-last-friend
			 (cons al dl)
			 (x ap dp)
			 (+ as ds)))
		      newl p (+ 3 s)))
		   (cons 10 newl) (x 10 p) s))
		'() 1 0))
	     newl p (+ 9 s)))
	  newl p (+ 1 s)))
       (cons 2 newl) (x 2 p) s))
    (cons 8 newl) (x 8 p ) s))
 '() 1 0)



((lambda (newl p s)
   ((lambda (newl p s)
      ((lambda (newl p s)
	 ((lambda (al ap as)
	    ((lambda (newl p s)
	       ((lambda (newl p s)
		  ((lambda (dl dp ds)
		     (the-last-friend
		      (cons al dl)
		      (x ap dp)
		      (+ as ds)))
		   newl p (+ 3 s)))
		(cons 10 newl) (x 10 p) s))
	     '() 1 0))
	  newl p (+ 9 s)))
       newl p (+ 1 s)))
    (cons 2 newl) (x 2 p) s))
 '(8) 8 0)


((lambda (newl p s)
   ((lambda (newl p s)
      ((lambda (al ap as)
	 ((lambda (newl p s)
	    ((lambda (newl p s)
	       ((lambda (dl dp ds)
		  (the-last-friend
		   (cons al dl)
		   (x ap dp)
		   (+ as ds)))
		newl p (+ 3 s)))
	     (cons 10 newl) (x 10 p) s))
	  '() 1 0))
       newl p (+ 9 s)))
    newl p (+ 1 s)))
 '(2 8) 16 0)


((lambda (newl p s)
   ((lambda (al ap as)
      ((lambda (newl p s)
	 ((lambda (newl p s)
	    ((lambda (dl dp ds)
	       (the-last-friend
		(cons al dl)
		(x ap dp)
		(+ as ds)))
	     newl p (+ 3 s)))
	  (cons 10 newl) (x 10 p) s))
       '() 1 0))
    newl p (+ 9 s)))
 '(2 8) 16 1)



((lambda (al ap as)
   ((lambda (newl p s)
      ((lambda (newl p s)
	 ((lambda (dl dp ds)
	    (the-last-friend
	     (cons al dl)
	     (x ap dp)
	     (+ as ds)))
	  newl p (+ 3 s)))
       (cons 10 newl) (x 10 p) s))
    '() 1 0))
 '(2 8) 16 10)

;现在，al ap as这三个参数的具体值得到了
;它们就是上面的'(2 8) 16 10
;现在，可以代入下面的计算了

((lambda (newl p s)
   ((lambda (newl p s)
      ((lambda (dl dp ds)
	 (the-last-friend
	  (cons '(2 8) dl)
	  (x 16 dp)
	  (+ 10 ds)))
       newl p (+ 3 s)))
    (cons 10 newl) (x 10 p) s))
 '() 1 0)


((lambda (newl p s)
   ((lambda (dl dp ds)
      (the-last-friend (cons '(2 8) dl) (x 16 dp) (+ 10 ds)))
    newl p (+ 3 s)))
 '(10) 10 0)

((lambda (dl dp ds)
   (the-last-friend (cons '(2 8) dl) (x 16 dp) (+ 10 ds)))
 '(10) 10 3)

;现在,dl dp ds的值也确定了，代入计算：
(the-last-friend (cons '(2 8) '(10)) (x 16 10) (+ 10 3))
(the-last-friend '((2 8) 10) 160 13)

;OK, 现在进入函数 the-last-friend 的逻辑
(cons 13 (cons 160 '((2 8) 10)))
;=>'(13 160 (2 8) 10)
```