---
layout: post
title:  SBCL生成可执行代码的方法
date:   2014-03-16
---
在SBCL中有一个内置函数 save-lisp-and-die 可以将正在运行的整个SBCL环境dump为一个文件。语法：

    (save-lisp-and-die "filename" :toplevel 'main  :executable t :compression t)
    
其中：

+ filename        是导出后的文件名
+ :toplevel 'main 指定程序的入口点为 main 函数，并且在程序运行完毕后退出，而不是进入REPL。
+ :executable t   导出为可执行文件
+ :compression t  压缩core image，可以大大压缩导出后的文件体积，如果不加这个参数，一个单纯的hello world有将近30M那么大，加上compresson后被压缩到只有9M左右。要使用本参数，需要在编译SBCL时打开开关。我没有尝试过官网的预编译版本，不过可以确定的是Debian仓库中的SBCL是没有打开这个开关的。最后下载了SBCL的源码自己编译解决。

具体用法：<http://www.sbcl.org/manual/#Saving-a-Core-Image>

示例(fib.lisp)：

```scheme
    (defun fib (n)
      (if (< n 2) 1
        (+ (fib (- n 1))
           (fib (- n 2)))))
           
    (defun main ()
      (format t "~a~%" (fib 40)))
```

然后在SBCL中load:

    $ sbcl
    This is SBCL 1.1.16, an implementation of ANSI Common Lisp.
    More information about SBCL is available at <http://www.sbcl.org/>.

    SBCL is free software, provided as is, with absolutely no warranty.
    It is mostly in the public domain; some portions are provided under
    BSD-style licenses.  See the CREDITS and COPYING files in the
    distribution for more information.
    
    * (load "fib.lisp")

    T
    * (save-lisp-and-die "fib" :toplevel 'main :executable t :compression t)
    [undoing binding stack and other enclosing state... done]
    [saving current Lisp image into fib:
    writing 3528 bytes from the read-only space at 0x0x1000000
    compressed 4096 bytes into 1227 at level -1
    writing 2272 bytes from the static space at 0x0x1100000
    compressed 4096 bytes into 933 at level -1
    writing 29634560 bytes from the dynamic space at 0x0x9000000
    compressed 29634560 bytes into 9021703 at level -1
    done]
    
    ls -l 
    -rwxr-xr-x 1 user user 9891868  3月 16 11:05 fib
    
    $ time ./fib
    165580141

    real    0m5.051s
    user    0m4.984s
    sys     0m0.048s
    
编译SBCL源码的方法：

要编译SBCL，需要系统中先有一个可运行的SBCL来实现自举，`apt-get install sbcl`安装源里的包就行。  
编译选项上要打开compression开关，prefix不用指定，默认为`/usr/local`，我认为把编译安装的软件安装到/usr/local底下是个好习惯。  
不会同apt安装的软件发生冲突。

    sh make.sh --with-sb-core-compression
    
编译完全后可以运行下测试看看：

    cd tests && sh run-tests.sh
    
我测试了一下，有错误发生。Google得到的回答是MS没有大问题。。。   
如果要安装文档（man info 等）

    cd doc/manual && make

一切准备停当后可以卸载掉apt安装的SBCL，然后运行install.sh脚本进行安装自己编译的版本。


