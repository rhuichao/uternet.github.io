---
layout: post
title:  The Little Schemer
date:   2014-03-20
---
```scheme
;;测试一个对象是否是原子
;;从函数定义看，在scheme中，只要不是点对和非空的对象都是原子
;;scheme中原子是不可再分的最小单位，点对显然不是，列表也不是
;;一个空列表'()虽然不能再分成更小的组成部分，但是空列表仍然
;;不是原子
;;貌似并非所有的scheme实现中都有atom?函数，所以在本书一开头
;;就要求读者定义这样一个函数
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

;;在作者的定义中，lat是这样一种列表：
;;列表中的每一个元素都是单独的原子，没有嵌套其它列表
;;空列表也属于lat                       (p19)
(define lat?
  (lambda (l)
    (cond
     ((null? l) #t)
     ((atom? (car l)) (lat? (cdr l)))
     (else #f))))

;;测试对象a是否是列表lat的成员之一      (p22)
;;由于函数定义的局限，a不能是一个空列表
;;否则会得到错误的答案，如果传递给函数的
;;参数a是一个空列表，那以正确的结果应该是#t
(define member?
  (lambda (a lat)
    (cond
     ((null? lat) #f)
     (else (or (eq? (car lat) a)
               (member? a (cdr lat)))))))

;;在列表lat中查找对象a，如果找到就删除
;;如果在列表lat中含有不止一个a，则只删除找到的第一个（p41）
(define rember
  (lambda (a lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) a) (cdr lat))
     (else (cons (car lat)
                 (rember a (cdr lat)))))))

;;列表l类似于这样的结构：
;;'((a b) (c d) (e f))
;;firsts函数从其成员列表中取出第一个元素
;;组成一个新的列表：             (p44)
;;'(a c e)
(define firsts
  (lambda (l)
    (cond
     ((null? l) '())
     (else (cons (car (car l)) (firsts (cdr l)))))))

;;在列表lat中寻找old，找到后将new插入到old的
;;右边，组成一个新列表                (p50)
(define insertR
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? old (car lat)) (cons old (cons new (cdr lat))))
     (else
      (cons (car lat) (insertR new old (cdr lat)))))))

;;和上一个函数类似，不同的是new插入到old的左边  (p51)
(define insertL
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? old (car lat)) (cons new lat))
     (else
      (cons (car lat) (insertL new old (cdr lat)))))))

;;在列表中查找old，找到后用new替换掉，生成新列表  (p51)
(define subst
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) old) (cons new (cdr lat)))
     (else
      (cons (car lat) (subst new old (cdr lat)))))))

;;和上一个函数类似，但是old值有两个：o1和o2
;;不论在列表中找到哪一个old值，都将用new进行
;;替换                                        (p52)
(define subst2
  (lambda (new o1 o2 lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) o1) (cons new (cdr lat)))
     ((eq? (car lat) o2) (cons new (cdr lat)))
     (else (cons (car lat)
                 (subst2 new o1 o2 (cdr lat)))))))

;;rember函数类似，从列表中删除一个成员
;;不同的是，rember只删除所找到的第一个
;;成员，而本函数删除所有与a相同的成员      (p53)
(define multirember
  (lambda (a lat)
    (cond
     ((null? lat) '())
     ((eq? a (car lat)) (multirember a (cdr lat)))
     (else
      (cons (car lat) (multirember a (cdr lat)))))))

;;;(p56)
(define multiinsertR
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) old)
      (cons old (cons new
                      (multiinsertR new old (cdr lat)))))
     (else
      (cons (car lat) (multiinsertR new old (cdr lat)))))))

;;多重插入左边(p57)
(define multiinsertL
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) old)
      (cons new (cons old (multiinsertL new old (cdr lat)))))
     (else
      (cons (car lat)
            (multiinsertL new old (cdr lat)))))))

;;多重替换(p57)
(define multisubst
  (lambda (new old lat)
    (cond
     ((null? lat) (quote ()))
     ((eq? (car lat) old)
      (cons new (multisubst new old (cdr lat))))
     (else
      (cons (car lat)
            (multisubst new old (cdr lat)))))))


(define add1
  (lambda (n)
    (+ n 1)))

(define sub1
  (lambda (n)
    (- n 1)))

;;重新定义“+”号,为免与系统内置函数冲突(p60)
;;函数名改为o+
(define o+
  (lambda (m n)
    (cond
     ((zero? m) n)
     (else (add1 (o+ n (sub1 m)))))))

;;重新定义减法(p61)
(define o-
  (lambda (m n)
    (cond
     ((zero? n) m)
     (else (sub1 (o- m (sub1 n)))))))

;;将单纯由数字构成的列表相加，返回总和（p64）
(define addtup
  (lambda (tup)
    (cond
     ((null? tup) 0)
     (else
      (o+ (car tup) (addtup (cdr tup)))))))

;;重新定义乘法，通过加法来实现乘法(p65)
(define x
  (lambda (n m)
    (cond
     ((zero? m) 0)
     (else
      (o+ n (x n (sub1 m)))))))

;;将两个数字列表相加，返回一个新列表
;;(tup++ '(1 2 3) '(4 5 6))
;;=>(5 7 9)
;;此函数有个局限：作为参数的两个列表元素数量必须相同(p69)
(define tup++
  (lambda (tup1 tup2)
    (cond
     ((and (null? tup1) (null? tup2))
      '())
     (else
      (cons (o+ (car tup1) (car tup2))
            (tup+ (cdr tup1) (cdr tup2)))))))

;;与上一个函数类似，不过可以接受两个长度不同的列表作参数(p71)
(define tup+
  (lambda (tup1 tup2)
    (cond
     ((null? tup1) tup2)
     ((null? tup2) tup1)
     (else
      (cons (o+ (car tup1) (car tup2))
            (tup++ (cdr tup1) (cdr tup2)))))))

;;重新定义大于号
(define >>
  (lambda (n m)
    (cond
     ((zero? n) #f)
     ((zero? m) #t)
     (else (>> (sub1 n) (sub1 m))))))
     
```