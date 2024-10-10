# Hướng dẫn triển khai hạ tầng tự động với Terraform và CloudFormation

## Clone mã nguồn

    Clone mã nguồn từ GitHub bằng lệnh sau:
    ```bash
    git clone http://abc.github.com/
    ```

### Terraform
    
#### Bước 1: Kết nối với AWS:
       
        ```bash
        aws configure
    
#### Bước 2: Di chuyển đến thư mục modules của Terraform bằng lệnh
    
    ```bash
    cd Lab01/Terraform/modules/

#### Bước 3: Khởi tạo Terraform
    
    ```bash
    terraform init
    terraform plan 
    terraform apply
