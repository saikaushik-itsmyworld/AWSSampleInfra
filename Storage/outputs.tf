output "bucketname" {
  value = "${aws_s3_bucket.tf_code.id}"
}

output "bucketARN" {
  value = "${aws_s3_bucket.tf_code.arn}"
}
