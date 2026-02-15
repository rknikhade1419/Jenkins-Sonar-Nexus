###########################################################################################
# Fetching latest AMI ID of Ubuntu 22.04
###########################################################################################
data "aws_ami" "nexus-latest" {
    most_recent = true
    filter {
      name   = "virtualization-type"
      values = ["hvm"]
    }
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
    owners = ["099720109477"] # Canonical
}

###########################################################################################
# Creating EC2 instance for Nexus Repository Manager
###########################################################################################
resource "aws_instance" "nexus-server" {
    ami           = data.aws_ami.nexus-latest.id
    instance_type = "c7i-flex.large" # Optimized 2 vCPU, 4GB RAM
    
    # Use the public subnet so we can access the UI
    subnet_id     = aws_subnet.our-public-subnet.id 
    
    # Updated to the specific Nexus Security Group you created
    vpc_security_group_ids = [aws_security_group.our-security-group-for-nexus.id] 
    
    user_data            = file("./nexus-server.sh")
    key_name             = "Jenkins-Sonar-Nexus"
    iam_instance_profile = aws_iam_instance_profile.our-instance-profile.name

    root_block_device {
      volume_size = 20
      volume_type = "gp3" # Faster and cheaper for 2026
    }

    tags = {
        Name        = "nexus-server"
        Project     = "E-commerce-DevSecOps"
        Environment = var.environment
    }
}
