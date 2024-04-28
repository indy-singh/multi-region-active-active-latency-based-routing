I'm going to assume if you ended up here via Google you aren't a newbie.

This a module that will deploy an entire stack to a region that includes;

* lambda
* api gateway (custom domain)
* route 53
* amazon cert manager
* route 53 health checks
* cloudfront distro

It isn't bug free. There is an order of operations that is required. I would suggest creating the `.\stack\` module first, and then the cloudfront distribution.

Again, I'm assuming you know that the cert for the cloudfront distribution has to be issued in us-east-1. This isn't included because I was cheeky I reused the cert from the us-east-1 stack creation hence the hard coded string.

A deploy to each region will create around 16 resources. Most of it is boring mudane mapping stuff. But it is enough to get you going.

Inspired by:

- https://aws.amazon.com/blogs/networking-and-content-delivery/latency-based-routing-leveraging-amazon-cloudfront-for-a-multi-region-active-active-architecture/

But that didn't support wildcards and our use case requires that, ergo this.

Also worth reading:-

- https://aws.amazon.com/blogs/architecture/disaster-recovery-dr-architecture-on-aws-part-i-strategies-for-recovery-in-the-cloud/
- https://aws.amazon.com/blogs/architecture/disaster-recovery-dr-architecture-on-aws-part-ii-backup-and-restore-with-rapid-recovery/
- https://aws.amazon.com/blogs/architecture/disaster-recovery-dr-architecture-on-aws-part-iii-pilot-light-and-warm-standby/
- https://aws.amazon.com/blogs/architecture/disaster-recovery-dr-architecture-on-aws-part-iv-multi-site-active-active/

License is do whatever you want, no support that being said I will be adding fixes as I come across them. So raise an issue if you feel like this is urgently misleading or massively incorrect.

Peace.
