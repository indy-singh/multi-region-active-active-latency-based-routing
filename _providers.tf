terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      configuration_aliases = [
        aws.virginia,
        aws.ohio,
        aws.californa,
        aws.oregon,

        aws.frankfurt,
        aws.ireland,
        aws.london,
        aws.paris,
        aws.stockholm,
      ]
    }
  }
}