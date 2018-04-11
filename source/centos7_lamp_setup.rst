CentOS 7: LAMP セットアップ手順
===============================

参考文献
--------

-  `Example: Changing the default character set to UTF-8 - Setting
   Character Sets and Collations - MariaDB Knowledge
   Base <https://mariadb.com/kb/en/library/setting-character-sets-and-collations/#example-changing-the-default-character-set-to-utf-8>`__
-  `PHP Insert Data Into
   MySQL <https://www.w3schools.com/php/php_mysql_insert.asp>`__
-  `PHP Select Data From
   MySQL <https://www.w3schools.com/php/php_mysql_select.asp>`__

パッケージインストール
----------------------

1. yum でパッケージをインストールする。

   -  ``$ sudo yum -y install php php-mysqlnd mariadb-server``

MariaDB
-------

文字コード設定
~~~~~~~~~~~~~~

1. 作業ディレクトリーを変更する。

   -  ``$ cd /etc/my.cnf.d; pwd``

client.cnf
^^^^^^^^^^

1. 設定ファイルをバックアップする。

   -  ::

          $ sudo cp -aiv client.cnf client.cnf.`date +%Y%m%d`

2. 設定ファイルがバックアップされたことを確認する。

   -  ::

          $ ls -l client.cnf client.cnf.`date +%Y%m%d`

      -  ::

             -rw-r--r--. 1 root root 295  4月 30  2017 client.cnf
             -rw-r--r--. 1 root root 295  4月 30  2017 client.cnf.20180409

   -  ::

          $ ls -Z client.cnf client.cnf.`date +%Y%m%d`

      -  ::

             -rw-r--r--. root root system_u:object_r:mysqld_etc_t:s0 client.cnf
             -rw-r--r--. root root system_u:object_r:mysqld_etc_t:s0 client.cnf.20180409

3. 設定ファイルを編集する。

   -  ``$ sudo vi client.cnf``

4. 差分を確認する。

   -  ::

          $ diff -u client.cnf.`date +%Y%m%d` client.cnf

      -  .. code:: diff

             --- client.cnf.20180409 2017-04-30 20:09:34.000000000 +0900
             +++ client.cnf  2018-04-09 16:08:00.813968051 +0900
             @@ -5,6 +5,7 @@


              [client]
             +default-character-set=utf8mb4

              # This group is not read by mysql client library,
              # If you use the same .cnf file for MySQL and MariaDB,

mysql-clients.cnf
^^^^^^^^^^^^^^^^^

1. 設定ファイルをバックアップする。

   -  ::

          $ sudo cp -aiv mysql-clients.cnf mysql-clients.cnf.`date +%Y%m%d`

2. 設定ファイルがバックアップされたことを確認する。

   -  ::

          $ ls -l mysql-clients.cnf mysql-clients.cnf.`date +%Y%m%d`

      -  ::

             -rw-r--r--. 1 root root 232  4月 30  2017 mysql-clients.cnf
             -rw-r--r--. 1 root root 232  4月 30  2017 mysql-clients.cnf.20180409

   -  ::

          $ ls -Z mysql-clients.cnf mysql-clients.cnf.`date +%Y%m%d`

      -  ::

             -rw-r--r--. root root system_u:object_r:mysqld_etc_t:s0 mysql-clients.cnf
             -rw-r--r--. root root system_u:object_r:mysqld_etc_t:s0 mysql-clients.cnf.20180409

3. 設定ファイルを編集する。

   -  ``$ sudo vi mysql-clients.cnf``

4. 差分を確認する。

   -  ::

          $ diff -u mysql-clients.cnf.`date +%Y%m%d` mysql-clients.cnf

      -  .. code:: diff

             --- mysql-clients.cnf.20180409  2017-04-30 20:09:34.000000000 +0900
             +++ mysql-clients.cnf   2018-04-09 16:08:38.159235163 +0900
             @@ -4,6 +4,7 @@
              #

              [mysql]
             +default-character-set=utf8mb4

              [mysql_upgrade]

server.cnf
^^^^^^^^^^

1. 設定ファイルをバックアップする。

   -  ::

          $ sudo cp -aiv server.cnf server.cnf.`date +%Y%m%d`

2. 設定ファイルがバックアップされたことを確認する。

   -  ::

          $ ls -l server.cnf server.cnf.`date +%Y%m%d`

      -  ::

             -rw-r--r--. 1 root root 744  4月 30  2017 server.cnf
             -rw-r--r--. 1 root root 744  4月 30  2017 server.cnf.20180409

   -  ::

          $ ls -Z server.cnf server.cnf.`date +%Y%m%d`

      -  ::

             -rw-r--r--. root root system_u:object_r:mysqld_etc_t:s0 server.cnf
             -rw-r--r--. root root system_u:object_r:mysqld_etc_t:s0 server.cnf.20180409

3. 設定ファイルを編集する。

   -  ``$ sudo vi server.cnf``

4. 差分を確認する。

   -  ::

          $ diff -u server.cnf.`date +%Y%m%d` server.cnf

      -  .. code:: diff

             --- server.cnf.20180409 2017-04-30 20:09:34.000000000 +0900
             +++ server.cnf  2018-04-09 16:09:33.687632330 +0900
             @@ -10,6 +10,9 @@

              # this is only for the mysqld standalone daemon
              [mysqld]
             +collation-server = utf8mb4_unicode_ci
             +init-connect='SET NAMES utf8mb4'
             +character-set-server = utf8mb4

              # this is only for embedded server
              [embedded]

自動起動有効化, サービス起動
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. 現在のサービスの状態を確認する。

   -  ``$ sudo systemctl status mariadb -l``

      -  ::

             ● mariadb.service - MariaDB database server
                Loaded: loaded (/usr/lib/systemd/system/mariadb.service; disabled; vendor preset: disabled)
                Active: inactive (dead)

2. 自動起動を有効化する。

   -  ``$ sudo systemctl enable mariadb``

3. サービスを起動する。

   -  ``$ sudo systemctl start mariadb``

4. サービスが起動されたことを確認する。

   -  ``$ sudo systemctl status mariadb -l``

      -  ::

             ● mariadb.service - MariaDB database server
                Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; vendor preset: disabled)
                Active: active (running) since 月 2018-04-09 16:13:24 JST; 24s ago
               Process: 1882 ExecStartPost=/usr/libexec/mariadb-wait-ready $MAINPID (code=exited, status=0/SUCCESS)
               Process: 1803 ExecStartPre=/usr/libexec/mariadb-prepare-db-dir %n (code=exited, status=0/SUCCESS)
              Main PID: 1881 (mysqld_safe)
                CGroup: /system.slice/mariadb.service
                        tq1881 /bin/sh /usr/bin/mysqld_safe --basedir=/usr
                        mq2103 /usr/libexec/mysqld --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib64/mysql/plugin --log-error=/var/log/mariadb/mariadb.log --pid-file=/var/run/mariadb/mariadb.pid --socket=/var/lib/mysql/mysql.sock

              4月 09 16:13:21 centos7 mariadb-prepare-db-dir[1803]: MySQL manual for more instructions.
              4月 09 16:13:21 centos7 mariadb-prepare-db-dir[1803]: Please report any problems at http://mariadb.org/jira
              4月 09 16:13:21 centos7 mariadb-prepare-db-dir[1803]: The latest information about MariaDB is available at http://mariadb.org/.
              4月 09 16:13:21 centos7 mariadb-prepare-db-dir[1803]: You can find additional information about the MySQL part at:
              4月 09 16:13:21 centos7 mariadb-prepare-db-dir[1803]: http://dev.mysql.com
              4月 09 16:13:21 centos7 mariadb-prepare-db-dir[1803]: Consider joining MariaDB's strong and vibrant community:
              4月 09 16:13:21 centos7 mariadb-prepare-db-dir[1803]: https://mariadb.org/get-involved/
              4月 09 16:13:22 centos7 mysqld_safe[1881]: 180409 16:13:22 mysqld_safe Logging to '/var/log/mariadb/mariadb.log'.
              4月 09 16:13:22 centos7 mysqld_safe[1881]: 180409 16:13:22 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql
              4月 09 16:13:24 centos7 systemd[1]: Started MariaDB database server.

初期設定
~~~~~~~~

1. 初期設定を開始する。

   -  ``$ sudo mysql_secure_installation``

      -  ::

             NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
                   SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

             In order to log into MariaDB to secure it, we'll need the current
             password for the root user.  If you've just installed MariaDB, and
             you haven't set the root password yet, the password will be blank,
             so you should just press enter here.

             Enter current password for root (enter for none):
             OK, successfully used password, moving on...

             Setting the root password ensures that nobody can log into the MariaDB
             root user without the proper authorisation.

   -  MariaDB 用の root パスワードを設定する。

      -  ::

             Set root password? [Y/n]
             New password:
             Re-enter new password:

      -  ::

             Password updated successfully!
             Reloading privilege tables..
              ... Success!


             By default, a MariaDB installation has an anonymous user, allowing anyone
             to log into MariaDB without having to have a user account created for
             them.  This is intended only for testing, and to make the installation
             go a bit smoother.  You should remove them before moving into a
             production environment.

   -  匿名ユーザーを削除する。

      -  ::

             Remove anonymous users? [Y/n]

      -  ::

              ... Success!

             Normally, root should only be allowed to connect from 'localhost'.  This
             ensures that someone cannot guess at the root password from the network.

   -  root の遠隔ログインを無効化する。

      -  ::

             Disallow root login remotely? [Y/n]

      -  ::

              ... Success!

             By default, MariaDB comes with a database named 'test' that anyone can
             access.  This is also intended only for testing, and should be removed
             before moving into a production environment.

   -  テスト用データベースを削除する。

      -  ::

             Remove test database and access to it? [Y/n]

      -  ::

              - Dropping test database...
              ... Success!
              - Removing privileges on test database...
              ... Success!

             Reloading the privilege tables will ensure that all changes made so far
             will take effect immediately.

   -  権限テーブルを再読み込みする。

      -  ::

             Reload privilege tables now? [Y/n]

      -  ::

              ... Success!

             Cleaning up...

             All done!  If you've completed all of the above steps, your MariaDB
             installation should now be secure.

             Thanks for using MariaDB!

root ログイン
~~~~~~~~~~~~~

1. mysql クライアントを起動する。

   -  ``$ mysql -u root -p``

2. root パスワードを入力する。

   -  ::

          Enter password:

      -  ::

             Welcome to the MariaDB monitor.  Commands end with ; or \g.
             Your MariaDB connection id is 10
             Server version: 5.5.56-MariaDB MariaDB Server

             Copyright (c) 2000, 2017, Oracle, MariaDB Corporation Ab and others.

             Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

             MariaDB [(none)]>

文字コード確認: utf8mb4 なので OK.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. 文字コードを確認する。

   -  ``> show variables like 'char%';``
   -  *character_set_system* は **utf8** のままで OK.

      -  ::

             +--------------------------+----------------------------+
             | Variable_name            | Value                      |
             +--------------------------+----------------------------+
             | character_set_client     | utf8mb4                    |
             | character_set_connection | utf8mb4                    |
             | character_set_database   | utf8mb4                    |
             | character_set_filesystem | binary                     |
             | character_set_results    | utf8mb4                    |
             | character_set_server     | utf8mb4                    |
             | character_set_system     | utf8                       |
             | character_sets_dir       | /usr/share/mysql/charsets/ |
             +--------------------------+----------------------------+
             8 rows in set (0.00 sec)

データベース作成
~~~~~~~~~~~~~~~~

1. 目的のデータベースが存在しないことを確認する。

   -  ``> show databases;``

      -  ::

             +--------------------+
             | Database           |
             +--------------------+
             | information_schema |
             | mysql              |
             | performance_schema |
             +--------------------+
             3 rows in set (0.00 sec)

2. データベースを作成する。

   -  ``> CREATE DATABASE db01;``

      -  ::

             Query OK, 1 row affected (0.00 sec)

3. データベースが作成されたことを確認する。

   -  ``> show databases;``

      -  ::

             +--------------------+
             | Database           |
             +--------------------+
             | information_schema |
             | db01               |
             | mysql              |
             | performance_schema |
             +--------------------+
             4 rows in set (0.00 sec)

一般ユーザー作成
~~~~~~~~~~~~~~~~

1. 目的の一般ユーザーが存在しないことを確認する。

   -  ``> SELECT host,user FROM mysql.user;``

      -  ::

             +-----------+------+
             | host      | user |
             +-----------+------+
             | 127.0.0.1 | root |
             | ::1       | root |
             | localhost | root |
             +-----------+------+
             3 rows in set (0.00 sec)

2. 一般ユーザーを作成する。

   -  ``> GRANT ALL ON db01.* TO user01@localhost IDENTIFIED BY '********';``

      -  ::

             Query OK, 0 rows affected (0.00 sec)

3. 一般ユーザーが作成されたことを確認する。

   -  ``> SELECT host,user FROM mysql.user;``

      -  ::

             +-----------+--------+
             | host      | user   |
             +-----------+--------+
             | 127.0.0.1 | root   |
             | ::1       | root   |
             | localhost | root   |
             | localhost | user01 |
             +-----------+--------+
             4 rows in set (0.00 sec)

一般ユーザーログイン
~~~~~~~~~~~~~~~~~~~~

1. 一旦 MariaDB クライアントからログアウトする。

   -  ``> exit``

2. 一般ユーザーでログインする。

   -  ``$ mysql -u user01 -p db01``

3. 一般ユーザーのパスワードを入力する。

   -  ::

          Enter password:

      -  ::

             Welcome to the MariaDB monitor.  Commands end with ; or \g.
             Your MariaDB connection id is 11
             Server version: 5.5.56-MariaDB MariaDB Server

             Copyright (c) 2000, 2017, Oracle, MariaDB Corporation Ab and others.

             Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

             MariaDB [db01]>

データベース文字コード確認: utf8mb4 なので OK.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. データベースの文字コードを確認する。

   -  ``> show variables like 'char%';``

      -  ::

             +--------------------------+----------------------------+
             | Variable_name            | Value                      |
             +--------------------------+----------------------------+
             | character_set_client     | utf8mb4                    |
             | character_set_connection | utf8mb4                    |
             | character_set_database   | utf8mb4                    |
             | character_set_filesystem | binary                     |
             | character_set_results    | utf8mb4                    |
             | character_set_server     | utf8mb4                    |
             | character_set_system     | utf8                       |
             | character_sets_dir       | /usr/share/mysql/charsets/ |
             +--------------------------+----------------------------+
             8 rows in set (0.00 sec)

テーブル作成
~~~~~~~~~~~~

1. テーブルを作成する。

   -  ::

          > CREATE TABLE address_book (
          -> id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
          -> first_name VARCHAR(30) NOT NULL,
          -> last_name VARCHAR(30) NOT NULL,
          -> email VARCHAR(50),
          -> reg_date TIMESTAMP
          -> );

2. テーブルが作成されたことを確認する。

   -  ``> show CREATE TABLE address_book;``

      -  ::

             +--------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
             | Table        | Create Table                                                                                                                                                                                                                                                                                                                                                                                                                                               |
             +--------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
             | address_book | CREATE TABLE `address_book` (
               `id` int(6) unsigned NOT NULL AUTO_INCREMENT,
               `first_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
               `last_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
               `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
               `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
               PRIMARY KEY (`id`)
             ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci |
             +--------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
             1 row in set (0.00 sec)

ログアウト
~~~~~~~~~~

1. ログアウトする。

   -  ``> exit``

Apache HTTP Server
------------------

サーバー名設定
~~~~~~~~~~~~~~

1. 作業ディレクトリーを変更する。

   -  ``$ cd /etc/httpd/conf; pwd``

2. 設定ファイルをバックアップする。

   -  ::

          $ sudo cp -aiv httpd.conf httpd.conf.`date +%Y%m%d`

3. 設定ファイルがバックアップされたことを確認する。

   -  ::

          $ ls -l httpd.conf httpd.conf.`date +%Y%m%d`

      -  ::

             -rw-r--r--. 1 root root 11753 10月 20 01:44 httpd.conf
             -rw-r--r--. 1 root root 11753 10月 20 01:44 httpd.conf.20180409

   -  ::

          $ ls -Z httpd.conf httpd.conf.`date +%Y%m%d`

      -  ::

             -rw-r--r--. root root system_u:object_r:httpd_config_t:s0 httpd.conf
             -rw-r--r--. root root system_u:object_r:httpd_config_t:s0 httpd.conf.20180409

4. 設定ファイルを編集する。

   -  ``$ sudo vi httpd.conf``

5. 差分を確認する。

   -  ::

          $ diff -u httpd.conf.`date +%Y%m%d` httpd.conf

      -  .. code:: diff

             --- httpd.conf.20180409 2017-10-20 01:44:27.000000000 +0900
             +++ httpd.conf  2018-04-09 16:32:10.296471166 +0900
             @@ -92,7 +92,7 @@
              #
              # If your host doesn't have a registered DNS name, enter its IP address here.
              #
             -#ServerName www.example.com:80
             +ServerName centos7.localdomain:80

              #
              # Deny access to the entirety of your server's filesystem. You must

初期コンテンツ作成
~~~~~~~~~~~~~~~~~~

1. 作業ディレクトリーを変更する。

   -  ``$ cd /var/www/html; pwd``

2. チュートリアル用ディレクトリーを作成する。

   -  ``$ sudo mkdir -v tutorial``

3. ディレクトリーのオーナーを変更する。

   -  ::

          $ sudo chown -v `whoami` tutorial

4. ディレクトリーの状態を確認する。

   -  ``$ ls -ld tutorial``

      -  ::

             drwxr-xr-x. 2 ryo-sato root 6  4月  9 16:58 tutorial

   -  ``$ ls -dZ tutorial``

      -  ::

             drwxr-xr-x. ryo-sato root unconfined_u:object_r:httpd_sys_content_t:s0 tutorial

5. 作業ディレクトリーを変更する。

   -  ``$ cd tutorial; pwd``

6. PHP ファイルを作成する。

   -  ``$ echo '<?php phpinfo(); ?>' > index.php``

7. PHP ファイルの状態を確認する。

   -  ``$ ls -l index.php``

      -  ::

             -rw-r--r--. 1 ryo-sato users 20  4月  9 17:01 index.php

   -  ``$ ls -Z index.php``

      -  ::

             -rw-r--r--. ryo-sato users unconfined_u:object_r:httpd_sys_content_t:s0 index.php

   -  ``$ cat index.php``

      -  ::

             <?php phpinfo(); ?>

.. 自動起動有効化-サービス起動-1:

自動起動有効化, サービス起動
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. 現在のサービスの状態を確認する。

   -  ``$ sudo systemctl status httpd -l``

      -  ::

             ● httpd.service - The Apache HTTP Server
                Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
                Active: inactive (dead)
                  Docs: man:httpd(8)
                        man:apachectl(8)

2. 自動起動を有効化する。

   -  ``$ sudo systemctl enable httpd``

3. サービスを起動する。

   -  ``$ sudo systemctl start httpd``

4. サービスが起動されたことを確認する。

   -  ``$ sudo systemctl status httpd -l``

      -  ::

             ● httpd.service - The Apache HTTP Server
                Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
                Active: active (running) since 月 2018-04-09 16:34:40 JST; 4s ago
                  Docs: man:httpd(8)
                        man:apachectl(8)
              Main PID: 5813 (httpd)
                Status: "Processing requests..."
                CGroup: /system.slice/httpd.service
                        tq5813 /usr/sbin/httpd -DFOREGROUND
                        tq5814 /usr/sbin/httpd -DFOREGROUND
                        tq5815 /usr/sbin/httpd -DFOREGROUND
                        tq5816 /usr/sbin/httpd -DFOREGROUND
                        tq5817 /usr/sbin/httpd -DFOREGROUND
                        mq5818 /usr/sbin/httpd -DFOREGROUND

              4月 09 16:34:40 centos7 systemd[1]: Starting The Apache HTTP Server...
              4月 09 16:34:40 centos7 systemd[1]: Started The Apache HTTP Server.

パケットフィルタリング設定
~~~~~~~~~~~~~~~~~~~~~~~~~~

1. 現在許可されているサービスを確認する。

   -  ``$ sudo firewall-cmd --list-services``

      -  ::

             ssh dhcpv6-client

2. http を許可する。

   -  ``$ sudo firewall-cmd --permanent --add-service=http``

      -  ::

             success

3. 現在の firewalld の状態を確認する。

   -  ``$ sudo systemctl status firewalld -l``

4. firewalld を再起動する。

   -  ``$ sudo systemctl condrestart firewalld``

5. firewalld が再起動されたことを確認する。

   -  ``$ sudo systemctl status firewalld -l``

6. http が許可されたことを確認する。

   -  ``$ sudo firewall-cmd --list-services``

      -  ::

             ssh dhcpv6-client http

7. ``http://<IP アドレス>/tutorial/`` にアクセスし, phpinfo
   が表示されることを確認する。

   -  IP アドレスは ``$ ip addr show`` コマンドで確認できる。
   -  例えば IP アドレスが *192.168.56.126* の場合, URL は
      ``http://192.168.56.126/tutorial/`` となる。

データ登録用コンテンツ作成
~~~~~~~~~~~~~~~~~~~~~~~~~~

1. データ登録用コンテンツを作成する。

   -  ``$ vi insert.php``

2. PHP ファイルの状態を確認する。

   -  ``$ ls -l insert.php``

      -  ::

             -rw-r--r--. 1 ryo-sato users 628  4月  9 17:02 insert.php

   -  ``$ ls -Z insert.php``

      -  ::

             -rw-r--r--. ryo-sato users unconfined_u:object_r:httpd_sys_content_t:s0 insert.php

   -  ``$ cat insert.php``

      -  .. code:: php

             <?php
             $servername = "localhost";
             $username = "user01";
             $password = "********";
             $dbname = "db01";

             // Create connection
             $conn = new mysqli($servername, $username, $password, $dbname);
             // Check connection
             if ($conn->connect_error) {
                 die("Connection failed: " . $conn->connect_error);
             }

             $sql = "INSERT INTO address_book (first_name, last_name, email)
             VALUES ('John', 'Doe', 'john@example.com')";

             if ($conn->query($sql) === TRUE) {
                 $last_id = $conn->insert_id;
                 echo "New record created successfully. Last inserted ID is: " . $last_id;
             } else {
                 echo "Error: " . $sql . "<br>" . $conn->error;
             }

             $conn->close();
             ?>

3. ``http://<IP アドレス>/tutorial/insert.php`` にアクセスすると,
   以下のメッセージが表示される。

   -  ``New record created successfully. Last inserted ID is: 1``

データ登録確認
~~~~~~~~~~~~~~

1. MariaDB に接続する。

   -  ``$ mysql -u user01 -p db01``

2. 先ほど登録したデータが存在することを確認する。

   -  ``> SELECT * FROM address_book;``

      -  ::

             +----+------------+-----------+------------------+---------------------+
             | id | first_name | last_name | email            | reg_date            |
             +----+------------+-----------+------------------+---------------------+
             |  1 | John       | Doe       | john@example.com | 2018-04-09 16:47:52 |
             +----+------------+-----------+------------------+---------------------+
             1 row in set (0.00 sec)

3. ログアウトする。

   -  ``> exit``

データ参照用コンテンツ作成
~~~~~~~~~~~~~~~~~~~~~~~~~~

1. データ参照用コンテンツを作成する。

   -  ``$ vi select.php``

2. PHP ファイルの状態を確認する。

   -  ``$ ls -l select.php``

      -  ::

             -rw-r--r--. 1 ryo-sato users 644  4月  9 17:05 select.php

   -  ``$ ls -Z select.php``

      -  ::

             -rw-r--r--. ryo-sato users unconfined_u:object_r:httpd_sys_content_t:s0 select.php

   -  ``$ cat select.php``

      -  .. code:: php

             <?php
             $servername = "localhost";
             $username = "user01";
             $password = "********";
             $dbname = "db01";

             // Create connection
             $conn = new mysqli($servername, $username, $password, $dbname);
             // Check connection
             if ($conn->connect_error) {
                 die("Connection failed: " . $conn->connect_error);
             }

             $sql = "SELECT id, first_name, last_name FROM address_book";
             $result = $conn->query($sql);

             if ($result->num_rows > 0) {
                 // output data of each row
                 while($row = $result->fetch_assoc()) {
                     echo "id: " . $row["id"]. " - Name: " . $row["first_name"]. " " . $row["last_name"]. "<br>";
                 }
             } else {
                 echo "0 results";
             }
             $conn->close();
             ?>

3. ``http://<IP アドレス>/tutorial/select.php`` にアクセスすると,
   以下のメッセージが表示される。

   -  ``id: 1 - Name: John Doe``

登録用コンテンツ修正
~~~~~~~~~~~~~~~~~~~~

1. 登録用コンテンツをコピーする。

   -  ``$ cp -aiv insert.php insert2.php``
   -  ``$ ls -l insert.php insert2.php``

      -  ::

             -rw-r--r--. 1 ryo-sato users 628  4月  9 17:02 insert.php
             -rw-r--r--. 1 ryo-sato users 628  4月  9 17:02 insert2.php

   -  ``$ ls -Z insert.php insert2.php``

      -  ::

             -rw-r--r--. ryo-sato users unconfined_u:object_r:httpd_sys_content_t:s0 insert.php
             -rw-r--r--. ryo-sato users unconfined_u:object_r:httpd_sys_content_t:s0 insert2.php

2. VALUES 行の内容を修正する。(データは適当です。)

   -  ``$ vi insert2.php``
   -  ``$ cat insert2.php``

      -  .. code:: php

             <?php
             $servername = "localhost";
             $username = "user01";
             $password = "********";
             $dbname = "db01";

             // Create connection
             $conn = new mysqli($servername, $username, $password, $dbname);
             // Check connection
             if ($conn->connect_error) {
                 die("Connection failed: " . $conn->connect_error);
             }

             $sql = "INSERT INTO address_book (first_name, last_name, email)
             VALUES ('霖之助', '森近', 'rinnosuke@example.com')";

             if ($conn->query($sql) === TRUE) {
                 $last_id = $conn->insert_id;
                 echo "New record created successfully. Last inserted ID is: " . $last_id;
             } else {
                 echo "Error: " . $sql . "<br>" . $conn->error;
             }

             $conn->close();
             ?>

3. ``http://<IP アドレス>/tutorial/insert2.php`` にアクセスすると,
   以下のメッセージが表示される。

   -  ``New record created successfully. Last inserted ID is: 2``

4. その後, ``http://<IP アドレス>/tutorial/select.php``
   にアクセスすると, 以下のメッセージが表示される。

   -  ::

          id: 1 - Name: John Doe
          id: 2 - Name: 霖之助 森近

どっとはらい。
