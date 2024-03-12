FROM php:7.4-apache

# Cài đặt các gói cần thiết và cấu hình PHP
RUN apt-get update && apt-get install -y git && \
    git clone --depth 1 https://github.com/ethicalhack3r/DVWA /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    rm -rf /var/www/html/.git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy file cấu hình của DVWA vào thư mục DVWA
COPY config.inc.php /var/www/html/config/

# Mở cổng 80 để Apache có thể nhận các yêu cầu HTTP
EXPOSE 80