# php_software

说明：给身边php新手在服务器安装php环境时候使用的。会的小伙伴不需要看

服务器操作系统: centos 7.4
安装php5.6、redis扩展、memcache扩展、yaf框架安装

目录结构：
/home/xxxx/software
下载后需要在software目录下
先执行 ./php_install.sh php   (安装php5.6.38)
成功后
手工依次执行
./php_install.sh redis   (安装redis4.1.1)
./php_install.sh yaf   (安装yaf2.3.5)
./php_install.sh memcache   (安装memcache2.2.0  libmemcached1.0.18)

最后修改
/usr/local/php/etc/php.ini
增加如下内容：
[yaf]
extension=yaf.so
yaf.lowcase_path=1

extension=redis.so
extension=memcached.so





