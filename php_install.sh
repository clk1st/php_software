#!/bin/bash

cd /home/xxxx/software
if [ $1 == "php" ]; then    
    tar -zxvf php-5.6.38.tar.gz
    cd php-5.6.38
    if [ $? -ne 0 ]; then
        exit 1
    else
        sudo yum install libxml2-devel
        sudo yum install openssl.x86_64 openssl-devel.x86_64 -y
        sudo yum install libcurl.x86_64 libcurl-devel.x86_64 -y
        sudo yum install libjpeg.x86_64 libpng.x86_64 freetype.x86_64 libjpeg-devel.x86_64 libpng-devel.x86_64 freetype-devel.x86_64 libjpeg-devel -y
        sudo yum install libmcrypt-devel
        ./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr-enable-xml --disable-rpath --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --enable-mbregex --enable-fpm --enable-mbstring --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --with-mysqli=mysqlnd --with-mysql=mysqlnd --with-pdo-mysql --with-memcached --disable-fileinfo
        if [ $? -ne 0 ]; then
            exit 1   
        else
            sudo make
            if [ $? -ne 0 ]; then
                exit 1
            else
                sudo make install
                if [ $? -ne 0 ]; then
                    exit 1
                else 
                    sudo cp php.ini-production /usr/local/php/etc/php.ini
                    sudo cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
                    sudo cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
                    sudo chmod +x /etc/init.d/php-fpm
                    sudo chkconfig --add php-fpm
                fi
            fi
        fi
    fi
elif [ $1 == "redis" ]; then
    tar -xvf redis-4.1.1.tgz
    cd redis-4.1.1
    if [ $? -ne 0 ]; then
        exit 1
    else
        phpize
        if [ $? -ne 0 ]; then
            sudo yum install m4 autoconf
            phpize
        fi
        
        if [ $? -ne 0 ]; then
            exit 1
        else 
            ./configure --with-php-config=/usr/local/php/bin/php-config
            if [ $? -ne 0 ]; then
                exit 1
            else
                sudo make
                if [ $? -ne 0 ]; then
                    exit 1
                else
                    sudo make install
                fi
            fi
        fi
    fi
elif [ $1 == "yaf" ]; then
    tar -xf yaf-2.3.5.tgz
    cd yaf-2.3.5
    if [ $? -ne 0 ]; then
        exit 1
    else
        phpize
        if [ $? -ne 0 ]; then
            sudo yum install m4 autoconf
            phpize
        fi

        if [ $? -ne 0 ]; then
            exit 1
        else
            ./configure --with-php-config=/usr/local/php/bin/php-config
            if [ $? -ne 0 ]; then
                exit 1
            else
                sudo make
                if [ $? -ne 0 ]; then
                    exit 1
                else
                    sudo make install
                fi
            fi
        fi
    fi
elif [ $1 == "memcache" ]; then
    tar -zxvf libmemcached-1.0.18.tar.gz
    cd libmemcached-1.0.18
    
    if [ $? -ne 0 ]; then
        exit 1
    else
        sudo yum install libevent libevent-devel
        sudo yum install libmemcached-devel
        ./configure --prefix=/usr/local/libmemcached/ --with-libmemcached-dir=/usr/local/libmemcached/
        if [ $? -ne 0 ]; then
            exit 1
        else
            sudo make
            if [ $? -ne 0 ]; then
                exit 1
            else
                sudo make install
            fi
        fi
    fi

    tar -xvf memcached-2.2.0.tgz 
    cd memcached-2.2.0

    if [ $? -ne 0 ]; then
        exit 1
    else
        phpize

        if [ $? -ne 0 ]; then
            exit 1
        else
            ./configure --enable-memcached --disable-memcached-sasl --with-php-config=/usr/local/php/bin/php-config
            if [ $? -ne 0 ]; then
                exit 1
            else
                sudo make
                if [ $? -ne 0 ]; then
                    exit 1
                else
                    sudo make install
                fi
            fi
        fi
    fi
fi

