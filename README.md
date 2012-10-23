# GitStats

GitStats is a git repository statistics generator.
It browses the repository and outputs html page with some statistics.

## Examples
* [devise](http://tomgi.github.com/git_stats/examples/devise/index.html)
* [devise_invitable](http://tomgi.github.com/git_stats/examples/devise_invitable/index.html)
* [jquery](http://tomgi.github.com/git_stats/examples/jquery/index.html)
* [paperclip](http://tomgi.github.com/git_stats/examples/paperclip/index.html)
* [rails](http://tomgi.github.com/git_stats/examples/rails/index.html)

## Installation

    $ gem install git_stats

## Usage

### Generator

    $ git_stats repo_path output_directory
    $ favorite_browser output_directory/index.html

### API usage example

    > repo = GitStats::GitData::Repo.new(path: '.')
    > repo.authors
    => [...]
    > repo.commits
    => [...]
    > commit.files
    => [...]

## Build Status
[![Build Status](https://secure.travis-ci.org/tomgi/git_stats.png)](https://secure.travis-ci.org/tomgi/git_stats)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request