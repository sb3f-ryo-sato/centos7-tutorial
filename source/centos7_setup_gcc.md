# C コンパイル環境セットアップ手順

## 参考文献

- [C "Hello, World!" Program](https://www.programiz.com/c-programming/examples/print-sentence)

## パッケージインストール

1. C のパッケージをインストールする。
   - `$ sudo yum -y install gcc vim-enhanced emacs-nox`
   - ```
     読み込んだプラグイン:fastestmirror
     Loading mirror speeds from cached hostfile
     (中略)

     完了しました!
     ```

1. インストールしたコンパイラーのバージョンが表示されることを確認する。
   - `$ gcc --version`
   - ```
     gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
     Copyright (C) 2015 Free Software Foundation, Inc.
     This is free software; see the source for copying conditions.  There is NO
     warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
     ```

## 作業用ディレクトリー作成

1. 作業用のディレクトリーを作成する。
   - `$ mkdir -v ~/clang`
   - ```
     mkdir: ディレクトリ `/home/ryo-sato/clang' を作成しました
     ```

1. 作業用ディレクトリーに移動する。
   - `$ cd ~/clang; pwd`
   - ```
     /home/ryo-sato/clang
     ```

## C プログラム作成

1. プログラムを作成する。
   - `$ vim helloworld.c` もしくは `$ emacs helloworld.c`
   - ```c
     #include <stdio.h>
     int main()
     {
       /* printf() displays the string inside quotation */
       printf("Hello, World!");
       return 0;
     }
     ```

## コンパイル, 実行

1. プログラムをコンパイルする。
   - `$ gcc -Wall -pedantic helloworld.c`
   - `-Wall -pedantic` はエラーだけでなく警告も表示させるオプション。

1. プログラムを実行する。
   - `$ ./a.out`
   - ```
     Hello, World!
     ```

どっとはらい。
