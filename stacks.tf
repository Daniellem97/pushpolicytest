############################################
# 1.  Push policy definition
############################################
resource "spacelift_policy" "default_push_policy" {
  name        = "default push policy"
  type = "GIT_PUSH"
  body        = file("${path.module}/policies/default-push-policy.rego")
}

############################################
# 2.  Stack A  – watches projects/service_a + lib/**
############################################
resource "spacelift_stack" "stack_a" {
  name                     = "service-a"
  branch                   = "main"
  repository               = "pushpolicytest"
  project_root             = "projects/service_a"
  additional_project_globs = ["lib/**"]
  description              = "Demo stack for Service A"
}

############################################
# 3.  Stack B  – watches projects/service_b + shared/**
############################################
resource "spacelift_stack" "stack_b" {
  name                     = "service-b"
  branch                   = "main"
  repository               = "pushpolicytest"
  project_root             = "projects/service_b"
  additional_project_globs = ["shared/**"]
  description              = "Demo stack for Service B"
}

############################################
# 4.  Manual policy attachments
############################################
resource "spacelift_policy_attachment" "stack_a_push" {
  stack_id  = spacelift_stack.stack_a.id
  policy_id = spacelift_policy.default_push_policy.id
}

resource "spacelift_policy_attachment" "stack_b_push" {
  stack_id  = spacelift_stack.stack_b.id
  policy_id = spacelift_policy.default_push_policy.id
}
