#!/bin/bash
for repo_path in ~/workspace/test_repos/*; do
  project_name="$(basename $repo_path)"
  output_path=$(readlink -m ~/workspace/git_stats/examples/$project_name)
  
  git_stats generate -p $repo_path -o $output_path
done
