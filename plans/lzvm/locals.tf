# locals {
#     for_each = toset(var.stages)   
#     caf_prefix = regex("^(dev|tst|acc)$", each.value) ? "${var.caf_prefix}-np" : "${var.caf_prefix}-p"
# }