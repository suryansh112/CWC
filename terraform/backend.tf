terraform{
backend "s3"{
    bucket = "suryanshredshiftbucket"
    key = "cwc_backend.tf"
    region = "us-east-1"
    use_lockfile = true
}
}