# Sử dụng base image của Nginx
FROM nginx:latest

# Copy tệp cấu hình vào container
COPY nginx.conf /etc/nginx/nginx.conf

# Copy tệp cấu hình tùy chỉnh
COPY custom.conf /etc/nginx/conf.d/default.conf

# EXPOSE cổng mà Nginx sẽ lắng nghe
EXPOSE 4321

# Khởi động lại Nginx sau khi thay đổi cấu hình
CMD ["sh", "-c", "nginx -g 'daemon off;'"]
