module "stack_virginia" {
  source = "./stack"

  providers = {
    aws.region = aws.virginia
  }
}

# module "stack_ohio" {
#   source = "./stack"

#   providers = {
#     aws.region = aws.ohio
#   }
# }

# module "stack_californa" {
#   source = "./stack"

#   providers = {
#     aws.region = aws.californa
#   }
# }

# module "stack_oregon" {
#   source = "./stack"

#   providers = {
#     aws.region = aws.oregon
#   }
# }