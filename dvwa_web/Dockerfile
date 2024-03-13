FROM debian:11

RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apache2 \
    php \
    php-mysql \
    php-gd \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY php.ini /etc/php/7.4/apache2/php.ini

# Sao chép mã nguồn DVWA vào thư mục html
COPY dvwa /var/www/html

# Sao chép cấu hình kết nối đến database vào DVWA
COPY config.inc.php /var/www/html/config/

# Phân quyền cho thư mục DVWA
RUN chown www-data:www-data -R /var/www/html && \
    rm /var/www/html/index.html

EXPOSE 80

# Định nghĩa lệnh khởi động container
CMD ["apache2ctl", "-D", "FOREGROUND"]
