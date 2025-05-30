package spacelift

track {
  affected
  input.push.branch == input.stack.branch
}

propose { affected }
propose { affected_pr }

ignore  {
    not affected
    not affected_pr
}
ignore  { input.push.tag != "" }

affected {
    filepath := input.push.affected_files[_]
    startswith(normalize_path(filepath), normalize_path(input.stack.project_root))
}

affected {
    filepath := input.push.affected_files[_]
    glob_pattern := input.stack.additional_project_globs[_]
    glob.match(glob_pattern, ["/"], normalize_path(filepath))
}

affected_pr {
    filepath := input.pull_request.diff[_]
    startswith(normalize_path(filepath), normalize_path(input.stack.project_root))
}

affected_pr {
    filepath := input.pull_request.diff[_]
    glob_pattern := input.stack.additional_project_globs[_]
    glob.match(glob_pattern, ["/"], normalize_path(filepath))
}

# Helper function to normalize paths by removing leading slashes
normalize_path(path) = trim(path, "/")

sample = true
