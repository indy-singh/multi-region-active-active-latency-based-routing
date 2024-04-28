# module "stack_frankfurt" {
#   source = "./stack"

#   providers = {
#     aws.region = aws.frankfurt
#   }
# }

# module "stack_ireland" {
#   source = "./stack"

#   providers = {
#     aws.region = aws.ireland
#   }
# }

module "stack_london" {
  source = "./stack"

  providers = {
    aws.region = aws.london
  }
}

# module "stack_paris" {
#   source = "./stack"

#   providers = {
#     aws.region = aws.paris
#   }
# }

# module "stack_stockholm" {
#   source = "./stack"

#   providers = {
#     aws.region = aws.stockholm
#   }
# }