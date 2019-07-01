FROM centos:7.6.1810

RUN yum install -y yum-utils epel-release
RUN yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional
RUN rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum install -y --enablerepo=remi --enablerepo=remi-php72 php-cli php-zts php-intl php-mbstring php-dom php-pdo php-mysql php-pgsql php-devel php-gd php-zip composer php-pecl-xdebug
RUN composer global require phing/phing phpmd/phpmd
RUN ln -s /root/.composer/vendor/bin/phing /usr/local/bin/phing
RUN ln -s /root/.composer/vendor/bin/phpmd /usr/local/bin/phpmd
RUN yum install -y git wget unzip libXext libXrender xorg-x11-fonts-75dpi xorg-x11-fonts-Type1 openssl sudo
RUN wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
RUN rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
RUN yum install -y jenkins java-1.8.0-openjdk
RUN rpm -i https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox-0.12.5-1.centos7.x86_64.rpm
RUN wget https://oscdl.ipa.go.jp/IPAexfont/IPAexfont00301.zip && unzip IPAexfont00301.zip && mv IPAexfont00301 /usr/share/fonts && rm -f IPAexfont00301.zip && fc-cache -fv
RUN wget https://phar.phpunit.de/phpcpd.phar && chmod +x phpcpd.phar && mv phpcpd.phar /usr/local/bin/phpcpd

EXPOSE 8080

ENV JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8"
CMD java -jar /usr/lib/jenkins/jenkins.war
