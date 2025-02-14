resource "tfe_workspace" "ws" {
  organization                  = var.organization
  name                          = var.workspace_name
  description                   = var.workspace_desc
  execution_mode                = var.execution_mode
  agent_pool_id                 = var.agent_pool_id
  auto_apply                    = var.auto_apply
  terraform_version             = var.terraform_version
  working_directory             = var.working_directory
  global_remote_state           = var.global_remote_state
  remote_state_consumer_ids     = var.remote_state_consumer_ids
  structured_run_output_enabled = var.structured_run_output_enabled
  ssh_key_id                    = var.ssh_key_id
  allow_destroy_plan            = var.allow_destroy_plan
  tag_names                     = var.workspace_tags

  dynamic "vcs_repo" {
    for_each = lookup(var.vcs_repo, "identifier", null) == null ? [] : [var.vcs_repo]
    content {
      identifier         = lookup(var.vcs_repo, "identifier", null)
      branch             = lookup(var.vcs_repo, "branch", null)
      oauth_token_id     = lookup(var.vcs_repo, "oauth_token_id", null)
      ingress_submodules = lookup(var.vcs_repo, "ingress_submodules", null)
      tags_regex         = lookup(var.vcs_repo, "tags_regex", null)
    }
  }

  queue_all_runs        = var.queue_all_runs
  file_triggers_enabled = var.file_triggers_enabled
  trigger_prefixes      = var.trigger_prefixes
  speculative_enabled   = var.speculative_enabled
}

