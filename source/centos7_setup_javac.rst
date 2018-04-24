Java コンパイル環境セットアップ手順
===================================

参考文献
--------

-  `HelloWorld.java <https://introcs.cs.princeton.edu/java/11hello/HelloWorld.java.html>`__

パッケージインストール
----------------------

1. Java のパッケージをインストールする。

   -  ``$ sudo yum -y install java-1.8.0-openjdk-devel vim-enhanced emacs-nox``
   -  ::

          読み込んだプラグイン:fastestmirror
          Loading mirror speeds from cached hostfile
          (中略)

          完了しました!

2. インストールしたコンパイラーのバージョンが表示されることを確認する。

   -  ``$ javac -version``
   -  ::

          javac 1.8.0_161

作業用ディレクトリー作成
------------------------

1. 作業用のディレクトリーを作成する。

   -  ``$ mkdir -v ~/java``
   -  ::

          mkdir: ディレクトリ `/home/ryo-sato/java' を作成しました

2. 作業用ディレクトリーに移動する。

   -  ``$ cd ~/java; pwd``
   -  ::

          /home/ryo-sato/java

Java プログラム作成
-------------------

1. プログラムを作成する。

   -  ``$ vim HelloWorld.java`` もしくは ``$ emacs HelloWorld.java``
   -  .. code:: java

          public class HelloWorld {
              public static void main(String[] args){
                  // Prints "Hello, World" to the terminal window.
                  System.out.println("Hello, World");
              }
          }

コンパイル, 実行
----------------

1. プログラムをコンパイルする。

   -  ``$ javac -Xlint:all HelloWorld.java``
   -  ``-Xlint:all`` はエラーだけでなく警告も表示させるオプション。

2. プログラムを実行する。

   -  ``$ java HelloWorld``
   -  実行時はファイルの拡張子: ``.class`` を付けないのがポイント。
   -  ::

          Hello, World

どっとはらい。
