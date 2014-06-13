---
layout: post
title: 找出指定范围内的素数
date: 2014-06-13
---

这是浙大 PAT 习题中的一题，它不要求输出素数，而是输出指定范围内，素数的个数以及求和。

用C已经写过了，再用 Scheme 写一遍：

```scheme
(define (prime? n)
  (define (iter n c)
    (cond
     ((= n 1) #t)
     ((= 0 (modulo c n)) #f)
     (else
      (iter (- n 1) c))))
  (iter (- n 1) n))

(define (find-prime start end)
  (define (iter start end l)
    (cond
     ((= start end) l)
     ((prime? start)
      (iter (add1 start) end (cons start l)))
     (else
      (iter (add1 start) end l))))
  (iter start end '()))

(define (sum_list l)
  (define (iter l r)
    (cond
     ((null? l) r)
     (else (iter (cdr l) (+ (car l) r)))))
  (iter l 0))

(define result '())

(let ((start (read)) (end (read)))
  (if (= start 1)
      (set! result
            (find-prime (add1 start) (add1 end)))
      (set! result
            (find-prime start (add1 end))))
  (display (length result))
  (display " ")
  (display (sum_list result))
  (newline))
```

其中用到了“副作用”，好象违背了函数式编程的原则了。。。

如果是在REPL中执行程序当然不用这么复杂，可是要做成脚本，或者编译成可执行文件，输出是个麻烦事，不用赋值的话我都不知道怎么把结果输出给用户看。
