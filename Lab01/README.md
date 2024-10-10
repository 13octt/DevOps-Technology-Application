# Hướng dẫn triển khai hạ tầng tự động với Terraform và CloudFormation

## Clone source code

- Clone mã nguồn từ GitHub bằng lệnh sau:

```bash
https://github.com/13octt/DevOps-Technology-Application.git
```

## Terraform
    
#### Bước 1: Kết nối với AWS:
       
```bash
aws configure
``` 
- Nhập access key và secret key để xác thực với AWS

####  Bước 2: Di chuyển đến thư mục modules của Terraform bằng lệnh
    
```bash
cd Lab01/Terraform/modules/
```

#### Bước 3: Khởi tạo và chạy Terraform
    
```bash
terraform init
terraform plan 
terraform apply
```
- File main.tf trong thư mục modules sẽ gọi tới module VPC và EC2 để tạo các resources và tự động triển khai các hạ tầng tương ứng.

> Lưu ý: Nếu muốn SSH tới các Instance thì phải thay đường dẫn public key trong resource key_pair

## CloudFormation

####  Bước 1: Di chuyển đến thư mục modules của CloudFromation bằng lệnh

```bash
cd Lab01/Cloudformation/modules
```

#### Bước 2: Tạo 1 Bucket trên AWS S3
- Upload 3 file trong thư mục modules gồm:
    - vpc.yaml
    - ec2.yaml
    - main.yaml

> Lưu ý: Thay đổi lại parameters trong main.yaml cho giống với tên của bucket trong S3.

#### Bước 3: Tạo Stack CloudFormation trên AWS.

**Create stack --> Choose an existing template --> Amazone S3 URL**

- Nhập vào URL của file main.yaml đã upload trên S3
- main.yaml sẽ gọi VPCStack và EC2Stack chứa các TemplateUrl của ec2.yaml và vpc.yaml để khởi tạo các resource và tự động triển khai các hạ tầng tương ứng.

> Lưu ý: Nếu muốn SSH tới các instance đã tạo thì phải thay đổi public key trong AWS::EC2::KeyPair
