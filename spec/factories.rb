# -*- encoding : utf-8 -*-
FactoryGirl.define do
  initialize_with { new(attributes) }

  factory :repo, class: GitStats::GitData::Repo do
    path "repo_path"
    factory :test_repo do
      path 'spec/integration/test_repo'
    end
    factory :test_repo_tree do
      path 'spec/integration/test_repo_tree'
    end
  end

  factory :author, class: GitStats::GitData::Author do
    sequence(:name) { |i| "author#{i}" }
    sequence(:email) { |i| "author#{i}@gmail.com" }
    association :repo, strategy: :build
  end

  factory :commit, class: GitStats::GitData::Commit do
    sequence(:sha) { |i| i }
    sequence(:stamp) { |i| i }
    sequence(:date) { |i| Date.new(i) }
    association :repo, strategy: :build
    association :author, strategy: :build
  end

  factory :tree, class: GitStats::GitData::Tree do
    association :repo, strategy: :build
  end

end
