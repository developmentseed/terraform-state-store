# Terraform: AWS Remote State configuration

Create a terraform state and lock store ([terraform.io](https://www.terraform.io/docs/state/)) using S3/DynamoDB backends


## How to use this module

```terraform
module "store" {
  source = "github.com/developmentseed/terraform-state-store"

  region = "${var.region}"

  table_name  = "${var.table_name}"
  bucket_name = "${var.bucket_name}"
}
```

## Inputs

| Name        | Description                    | Required  | Default                      |
|-------------|--------------------------------|-----------|------------------------------|
| region      | The AWS region                 | yes       |                              |
| table_name  | The name of the dynamoDB table | yes       |                              |
| bucket_name | The name of the s3 bucket      | yes       |                              |

## Outputs

| Name        | Description                     |
| ------------| --------------------------------|
| table_name  | The name of the dynamoDB table. |
| bucket_name | The name of the s3 bucket.      |


# Deployment

#### Install terraform
```bash
$ brew install terraform
```


#### Init terraform config

⚠️ Set ${AWS_ACCESS_KEY_ID} and ${AWS_SECRET_ACCESS_KEY} in your env

```bash
$ terraform init
```

#### Deploy stack (create s3 bucket and dynamoDB table)

```bash
$ terraform apply \
  --var region=us-east-1 \
  --var bucket_name=my-bucket-terraform-state \
  --var table_name=my-table-terraform-lock
```

# Terraform Backend configuration

Include this block in your terraform file (or in a `terraform.tf` file)
```terraform
# terraform.tf

terraform {
  backend "s3" {
    bucket         = "my-bucket-terraform-state"
    key            = "my-project/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "my-table-terraform-lock"
  }
}
```

