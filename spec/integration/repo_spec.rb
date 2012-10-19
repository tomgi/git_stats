require 'spec_helper'

describe GitStats::GitData::Repo do
  let(:repo) { build(:repo, path: 'spec/integration/test_repo', last_commit: '81e8be') }
  let(:expected_authors) { [
      build(:author, repo: repo, name: "Tomasz Gieniusz", email: "tomasz.gieniusz@gmail.com"),
      build(:author, repo: repo, name: "John Doe", email: "john.doe@gmail.com"),
  ] }

  it 'should return all authors' do
    repo.authors.should =~ expected_authors
  end

end