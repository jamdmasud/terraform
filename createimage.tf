provider "aws" {
  region     = "region-1"
  access_key = "#[access_key]#"
  secret_key = "#[secret_key]#"
}

resource "aws_ami_from_instance" "priyoshop_image" {
  name               = "priyoshop_AMI"
  source_instance_id = "#[instance_id]#"
}

resource "aws_launch_configuration" "priyoshop_launch_configuration" {
  name_prefix       = "priyoshop_launch_configuration_1"
  image_id          = "${aws_ami_from_instance.priyoshop_image.id}"
  instance_type     = "t2.micro"
  security_groups   = ["#[security_group_id]#"]
  enable_monitoring = false
  key_name          = "#[key_name]#"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "priyosho_autoscaling_group" {
  name                 = "priyosho_autoscaling_group_1"
  launch_configuration = "${aws_launch_configuration.priyoshop_launch_configuration.name}"
  min_size             = 1
  max_size             = 2
  desired_capacity     = 1
  availability_zones   = ["region-1", "region-2", "region-3"]
  target_group_arns    = ["#[target_group_arn]#"]
  lifecycle {
    create_before_destroy = true
  }
}

