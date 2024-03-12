FROM nginx:latest

# Copy file cấu hình của bạn vào thư mục /etc/nginx/conf.d/
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy các tài nguyên của website vào thư mục /usr/share/nginx/html/
COPY html /usr/share/nginx/html

# Expose cổng 80 để Nginx có thể nhận các yêu cầu HTTP
EXPOSE 4321