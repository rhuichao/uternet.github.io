---
layout: post
title: 求子列表最大值
date: 2014-12-03
---

这是浙大 PAT 上的题：

>给定K个整数组成的序列{ N1, N2, ..., NK }，“连续子列”被定义为{ Ni, Ni+1, ..., Nj }，其中 1 <= i <= j <= K。“最大子列和”则被定义为所有连续子列元素的和中最大者。例如给定序列{ -2, 11, -4, 13, -5, -2 }，其连续子列{ 11, -4, 13 }有最大的和20。现要求你编写程序，计算给定整数序列的最大子列和。
>
>输入格式：
>
>输入第1行给出正整数 K (<= 100000)；第2行给出K个整数，其间以空格分隔。
>
>输出格式：
>
>在一行中输出最大子列和。如果序列中所有整数皆为负数，则输出0。
>
>输入样例：   
>6   
>-2 11 -4 13 -5 -2   
>输出样例：   
>20   

幸好陈姥姥在视频里把四种算法都讲了，我就抄了个最快的算法，用 Scheme 实现一下，PASS！

```scheme
(define (sub-list-sum lst)
  (let iter ((lst lst) (max 0) (current 0))
    (cond ((null? lst) (list max start end))
          (else
           (let ((tmp (+ current (car lst))))
             (cond ((> tmp max)
                    (iter (cdr lst) tmp tmp))
                   ((< tmp 0)
                    (iter (cdr lst) max 0))
                   (else
                    (iter (cdr lst) max tmp))))))))
```

再看第二题，在原来的要求上加了点东西，不但要输入出最大子列合，还要输出该子列的头尾成员。

这题目是考研题，还是全英文的，好家伙！

>Given a sequence of K integers { N1, N2, ..., NK }. A continuous subsequence is defined to be { Ni, Ni+1, ..., Nj } where 1 <= i <= j <= K. The Maximum Subsequence is the continuous subsequence which has the largest sum of its elements. For example, given sequence { -2, 11, -4, 13, -5, -2 }, its maximum subsequence is { 11, -4, 13 } with the largest sum being 20.
>
>Now you are supposed to find the largest sum, together with the first and the last numbers of the maximum subsequence.
>
>Input Specification:
>
>Each input file contains one test case. Each case occupies two lines. The first line contains a positive integer K (<= 10000). The second line contains K numbers, separated by a space.
>
>Output Specification:
>
>For each test case, output in one line the largest sum, together with the first and the last numbers of the maximum subsequence. The numbers must be separated by one space, but there must be no extra space at the end of a line. In case that the maximum subsequence is not unique, output the one with the smallest indices i and j (as shown by the sample case). If all the K numbers are negative, then its maximum sum is defined to be 0, and you are supposed to output the first and the last numbers of the whole sequence.
>
>Sample Input:   
>10   
>-10 1 2 3 4 -5 -23 3 7 -21   
>Sample Output:   
>10 1 4

