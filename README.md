# GitStats [![Build Status](https://secure.travis-ci.org/tomgi/git_stats.svg)](https://secure.travis-ci.org/tomgi/git_stats) [![Build Status](https://codeclimate.com/badge.png)](https://codeclimate.com/github/tomgi/git_stats)

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

### Existing ruby/gem environment

    $ gem install git_stats
    
### debian stretch (9.*)

    # apt-get install ruby ruby-nokogiri ruby-nokogiri-diff ruby-nokogumbo
    # gem install git_stats
    
### Ubuntu

    $ sudo apt-get install ruby ruby-dev gcc zlib1g-dev make
    $ sudo gem install git_stats

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
      p, [--path=PATH]                          # Path to repository from which statistics should be generated.
                                                # Default: .
      o, [--out-path=OUT_PATH]                  # Output path where statistics should be written.
                                                # Default: ./git_stats
      l, [--language=LANGUAGE]                  # Language of written statistics.
                                                # Default: en
      f, [--first-commit-sha=FIRST_COMMIT_SHA]  # Commit from where statistics should start.
      t, [--last-commit-sha=LAST_COMMIT_SHA]    # Commit where statistics should stop.
                                                # Default: HEAD
      s, [--silent], [--no-silent]              # Silent mode. Don't output anything.
      d, [--tree=TREE]                          # Tree where statistics should be generated.
                                                # Default: .
      c, [--comment-string=COMMENT_STRING]      # The string which is used for comments.
                                                # Default: //

    Generates the statistics of a repository



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

