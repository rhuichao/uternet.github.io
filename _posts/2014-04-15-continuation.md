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

OK! 来给它一些输入，看看发生了什么？

假设lat = ()，那么cond分支第一个就是出口，不论参数 a 的值是什么，空列表都被传递给a-friend函数，得到#t，程序运行完毕，退出。

假设传递的参数是这样：

    a = 'tuna
    lat = '(tuna and salad)

情况变得复杂了。。。

第一遍：

    (multirember&co 'tuna '(tuna and salad) a-friend)

第二遍：

因为((eq? (car lat) a)的值为真，所以，执行cond的第二个分支，实际上是对下面的表达式求值：

```scheme
(multirember&co 'tuna '(and salad)
                        (lambda (newlat seen)
                            (a-friend newlat
                                (cons (car lat) seen))))
```

继续展开  
现在  

a 还是'tuna  

lat 变成了 '(and salad)  

col 不再是a-friend，而是:

```scheme
    (lambda (newlat seen)
      (a-friend newlat
           (cons (car lat) seen)))
```

第三遍，因为((eq? (car lat) a)的值为假，所以执行第三个cond分支

展开后的表达式是：

```scheme
(multirember&co 'tuna '(salad)
                         (lambda (newlat seen)
                           ((lambda (newlat seen)
                             (a-friend newlat
                                       (cons (car lat) seen)))
                            (cons (car lat) newlat) seen)))
```

a 还是 'tuna
lat 变成了 '(salad)
col 变成了

```scheme
(lambda (newlat seen)
  ((lambda (newlat seen)
    (a-friend newlat
              (cons (car lat) seen)))
   (cons (car lat) newlat) seen))
```

第四遍，((eq? (car lat) a))值为假，执行else分支，展开后是：

```scheme
(multirember&co 'tuna '()
                         (lambda (newlat seen)
                           ((lambda (newlat seen)
                              ((lambda (newlat seen)
                                 (a-friend newlat
                                           (cons (car lat) seen)))
                               (cons (car lat) newlat) seen))
                            (cons (car lat) newlat) seen)))
```

第五遍，(null? lat)值为真，执行`(col (quote ()) (quote ()))`  
现在,col变成了

```scheme
(lambda (newlat seen)
   ((lambda (newlat seen)
      ((lambda (newlat seen)
          (a-friend newlat
                    (cons (car lat) seen)))
       (cons (car lat) newlat) seen))
    (cons (car lat) newlat) seen)
```

展开后是

```scheme
((lambda (newlat seen)
   ((lambda (newlat seen)
      ((lambda (newlat seen)
         (a-friend newlat
                   (cons (car lat) seen)))
       (cons (car lat) newlat) seen))
    (cons (car lat) newlat)seen))
 (quote ()) (quote ()))
``` 
