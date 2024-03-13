-- Tạo cơ sở dữ liệu cho DVWA
CREATE DATABASE IF NOT EXISTS dvwa;

-- Sử dụng cơ sở dữ liệu dvwa
USE dvwa;

-- Tạo bảng cấu hình nếu chưa tồn tại
CREATE TABLE IF NOT EXISTS config (
    id INT AUTO_INCREMENT PRIMARY KEY,
    setting_name VARCHAR(255) NOT NULL,
    setting_value VARCHAR(255) NOT NULL
);

-- Thêm thông tin kết nối với cơ sở dữ liệu DVWA vào bảng cấu hình
INSERT INTO config (setting_name, setting_value) VALUES ('db_server', 'dvwa_db');
INSERT INTO config (setting_name, setting_value) VALUES ('db_database', 'dvwa');
INSERT INTO config (setting_name, setting_value) VALUES ('db_user', 'dvwa');
INSERT INTO config (setting_name, setting_value) VALUES ('db_password', 'dvwa1234');

-- Cấp quyền cho người dùng dvwa
GRANT ALL PRIVILEGES ON dvwa.* TO 'dvwa'@'%' IDENTIFIED BY 'dvwa1234';
