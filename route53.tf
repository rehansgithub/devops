resource "aws_route53_zone" "private" {
  name = "vprofile.com"

  vpc {
    vpc_id = aws_security_group.backend.vpc_id
  }
}

/*
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "mysql.vprofile.com"
  type    = "A"
  ttl     = 300
  records = ["172.31.31.187"]
}
*/

/*
module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_id = aws_route53_zone.private.zone_id

  records = [
    {
      name    = "db01.vprofile.com"
      type    = "A"
      ttl = 300
      records = [aws_instance.instances["centos2"].private_ip]
    },
    {
      name    = "mc01.vprofile.com"
      type    = "A"
      ttl     = 300
      records = [aws_instance.instances["centos3"].private_ip]
    },
     {
      name    = "rmq01.vprofile.com"
      type    = "A"
      ttl     = 300
      records = [aws_instance.instances["centos1"].private_ip]
    },
  ]
}


*/