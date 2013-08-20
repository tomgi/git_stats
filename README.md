# GitStats [![Build Status](https://secure.travis-ci.org/tomgi/git_stats.png)](https://secure.travis-ci.org/tomgi/git_stats) [![Build Status](https://codeclimate.com/badge.png)](https://codeclimate.com/github/tomgi/git_stats)

GitStats is a git repository statistics generator.
It browses the repository and outputs html page with statistics.

## Examples
* [devise](http://tomgi.github.com/git_stats/examples/devise/index.html)
* [devise_invitable](http://tomgi.github.com/git_stats/examples/devise_invitable/index.html)
* [john](http://tomgi.github.com/git_stats/examples/john/index.html)
* [jquery](http://tomgi.github.com/git_stats/examples/jquery/index.html)
* [merit](http://tomgi.github.com/git_stats/examples/merit/index.html)
* [paperclip](http://tomgi.github.com/git_stats/examples/paperclip/index.html)
* [rails](http://tomgi.github.com/git_stats/examples/rails/index.html)

## Installation

    $ gem install git_stats

## Usage

### Generator

#### Print help

    $ git_stats
    Commands:
      git_stats generate        # Generates the statistics of a repository
      git_stats help [COMMAND]  # Describe available commands or one specific command

#### Print help of the generate command

    $ git_stats help generate
    Usage:
      git_stats generate

    Options:
      p, [--path=PATH]          # Path to repository from which statistics should be generated.
                                # Default: .
      o, [--output=OUTPUT]      # Output path where statistics should be written.
                                # Default: ./git_stats
      l, [--language=LANGUAGE]  # Language of written statistics.
                                # Default: en
      f, [--from=FROM]          # Commit from where statistics should start.
      t, [--to=TO]              # Commit where statistics should stop.
                                # Default: HEAD

#### Start generator with default settings

    $ git_stats generate
      git rev-list --pretty=format:'%h|%at|%ai|%aE' HEAD | grep -v commit
      git shortlog -se HEAD
      ...

#### Start generator with some parameters in long and short form.

    $ git_stats generate -o stats --langugage de
      git rev-list --pretty=format:'%h|%at|%ai|%aE' HEAD | grep -v commit
      git shortlog -se HEAD
      ...

### API usage example

    > repo = GitStats::GitData::Repo.new(path: '.', first_commit_sha: 'abcd1234', last_commit_sha: 'HEAD')
    > repo.authors
    => [...]
    > repo.commits
    => [...]
    > commit.files
    => [...]


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
