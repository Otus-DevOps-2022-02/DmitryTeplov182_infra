terraform {
  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "otustf"
    region                      = "ru-central1"
    key                         = "stage/terraform.tfstate"
    access_key                  = "YC"
    secret_key                  = "YCN"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
