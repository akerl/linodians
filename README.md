linodians
=========

[![Gem Version](https://img.shields.io/gem/v/linodians.svg)](https://rubygems.org/gems/linodians)
[![Build Status](https://img.shields.io/travis/com/akerl/linodians.svg)](https://travis-ci.com/akerl/linodians)
[![Coverage Status](https://img.shields.io/codecov/c/github/akerl/linodians.svg)](https://codecov.io/github/akerl/linodians)
[![Code Quality](https://img.shields.io/codacy/120497a8b57b47c2b45021c992e7b352.svg)](https://www.codacy.com/app/akerl/linodians)
[![MIT Licensed](https://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

Library for viewing public Linode employee data

## Usage

### From the command line

A `linodians` script is provided that will output the current data:

```
❯ linodians -h
Usage: linodians [-v] [-j]
    -j, --json                       Output as json
    -v, --version                    Show version
```

Running just `linodians` will print a human-readable list. For consumption by other tools, `linodians -j` will output JSON.

### From Ruby code

First, create a Linodian object

```
require 'linodians'
employees = Linodians.new
```

You now have an array of all publically listed Linodians. The following attributes are provided:

* fullname: Full name as publicized
* username: Short name as publicized
* title: Their position

Any social sites are also parsed, if provided, including 'twitter', 'linkedin', and 'github'.

A `.photo` method is also provided that pulls their public photo.

For example, if you want to follow all the Linodians on Twitter, you can quickly grab all available Twitter profiles:

```
require 'linodians'
employees = Linodians.new
twitter_profiles = employees.map { |x| x[:twitter] }.compact
puts twitter_profiles
```
Say you want to follow any of them you don't already follow? You can combine the above with [sferik's awesome "t" CLI for Twitter](https://github.com/sferik/t):

```
linodian_accounts = twitter_profiles.map { |x| x.split('/').last }
currently_following = `t followings`.split
new_accounts = linodian_accounts.reject { |x| currently_following.include? x }
new_accounts.each { |x| system "t follow #{x}" }
```

Or you can find all the listed titles and how many people have each title:

```
require 'linodians'
employees = Linodians.new
titles = employees.map(&:title).each_with_object(Hash.new(0)) { |i, o| o[i] += 1 }
titles.sort_by(&:last).each { |title, count| puts "#{count} -- #{title}" }
```

A helper ".lookup" method is provided on top of Array's usual tools, and it is a shortcut for `find { |x| x.username == username }`. As such, you can use it to look somebody up by their username:

```
employees = Linodians.new
my_friend = employees.lookup('caker')
```

#### Loading in existing data

If you already have a hash of data, like one created with `Linodians.new.to_json`, you can import it back in when making a new Linodians object:

```
require 'linodians'
require 'json'

data = File.open('data.json') { |fh| JSON.parse fh }
employees = Linodians.new(data)
```

## Installation

    gem install linodians

## License

linodians is released under the MIT License. See the bundled LICENSE file for details.

