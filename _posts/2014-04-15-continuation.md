---
layout: post
title: 被The Little Schemer 第八章的 multirember&co 噎住了
date: 2014-04-15
---
经过前面的递归思维训练，我觉得前面7章都没什么难度嘛，兀地看到了这个函数，一下子就凌乱了，人肉解释器有些吃不消。

```scheme
(define multirember&co
  (lambda (a lat col)
    (cond
      ((null? lat)
       (col (quote ()) (quote ())))
      ((eq? (car lat) a)
       (multirember&co a (cdr lat)
                       (lambda (newlat seen)
                         (col newlat
                              (cons (car lat) seen)))))
      (else
        (multirember&co a (cdr lat)
                        (lambda (newlat seen)
                          (col (cons (car lat) newlat)
                               seen)))))))

(define a-friend
  (lambda (x y)
    (null? y)))
```        

我知道这里边用到的概念是continuation，我很早就知道这是scheme中一个很重要的概念，但是真的遇见了，才知道很难懂。

我觉得这个函数的精密程度就象个闹钟，这让我想起了小时候因为好奇而拆开闹钟，由于无法装回去导致的惶恐与不安。

不论如何，还是要搞懂的！