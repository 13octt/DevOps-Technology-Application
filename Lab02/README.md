# Hướng dẫn quản lý và triển khai hạ tầng AWS và ứng dụng microservices với Terraform, CloudFormation, GitHub Actions, AWS CodePipeline và Jenkins

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
cd Lab02/Cloudformation/
```

#### Bước 2: Tạo Repository CodeCommit trên AWS
- Cấu hình IAM CodeCommit Credential để xác thực với username và password
- Clone Repository
- Push 5 file trong thư mục CloudFormation gồm lên CodeCommit Repository:
    - vpc.yaml
    - ec2.yaml
    - main.yaml
    - .taskcat.yml
    - buildspec.yml
- vpc.yaml, ec2.yaml, main.yaml chứa mã nguồn ClouFormation triển khai các dịch vụ AWS bao gồm: VPC, Route Tables, NAT Gateway, EC2, Security Group.
- buildspec.yml định nghĩa cấu hình cho CodeBuild và taskcat để kiểm tra tính đúng đắn của mã nguồn CloudFormation
- Tạo một S3 bucket trên AWS 

<p align="center">
  <img src="images/codecommit.png" alt="Mô tả hình ảnh">
  <br>
  <em>Tạo AWS CodeCommit</em>
</p>


> Lưu ý: Thay đổi lại tên của S3 trong main.yaml và .taskcat.yml cho giống với tên của bucket trong S3.

#### Bước 3: Tạo CodeBuild trên AWS để build và test code.

**Create project --> Chọn Source provider --> Chọn Repository và branch**

- Source Provider là AWS CodeCommit.
- Chọn Repository và branch đã tạo từ CodeCommit.
- Start build để tiến hành build và test code.

<p align="center">
  <img src="images/codebuild.png" alt="Mô tả hình ảnh">
  <br>
  <em>Build và test code với AWS CodeBuild</em>
</p>

<p align="center">
  <img src="images/phase-details.png" alt="Mô tả hình ảnh">
  <br>
  <em>Build và test code thành công</em>
</p>

#### Bước 4: Tạo CodePipeline trên AWS để để tự động hóa quy trình build và deploy từ mã nguồn trên CodeCommit.

**Create pipeline --> Choose creation option --> Add source stage -->  Add deploy stage**

- Tạo custom pipeline.
- Chọn Repository và branch đã tạo từ CodeCommit.
- Start build để tiến hành build và test code.

<p align="center">
  <img src="images/codepipeline.png" alt="Mô tả hình ảnh">
  <br>
  <em>Chạy thành công Pipeline với AWS CodePipeline</em>
</p>

#### Bước 5: Check kết quả Log của Pipeline với AWS CloudFormation

<p align="center">
  <img src="images/codepipeline-log.png" alt="Mô tả hình ảnh">
  <br>
  <em>Check log AWS pipeline</em>
</p>

<p align="center">
  <img src="images/nhom14-stack.png" alt="Mô tả hình ảnh">
  <br>
  <em>Check CloudFormation Stack </em>
</p>
- Hạ tầng AWS được triển khai với CloudFormation và tự động hóa quy trình deploy với AWS CodePipeline

