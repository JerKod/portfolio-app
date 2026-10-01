terraform {
  backend "s3" {
    bucket                      = "portfolio-tfstate"
    key                         = "prod/infra.tfstate"
    region                      = "eu-frankfurt-1"
    endpoints                   = { s3 = "https://frpwsda5ztd1.compat.objectstorage.eu-frankfurt-1.oraclecloud.com" }
    use_path_style              = true
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
  }
}
