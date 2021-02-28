# watchdog

[![Build Status](https://travis-ci.org/bodgit/puppet-watchdog.svg?branch=master)](https://travis-ci.org/bodgit/puppet-watchdog)
[![Codecov](https://img.shields.io/codecov/c/github/bodgit/puppet-watchdog)](https://codecov.io/gh/bodgit/puppet-watchdog)
[![Puppet Forge version](http://img.shields.io/puppetforge/v/bodgit/watchdog)](https://forge.puppetlabs.com/bodgit/watchdog)
[![Puppet Forge downloads](https://img.shields.io/puppetforge/dt/bodgit/watchdog)](https://forge.puppetlabs.com/bodgit/watchdog)
[![Puppet Forge - PDK version](https://img.shields.io/puppetforge/pdk-version/bodgit/watchdog)](https://forge.puppetlabs.com/bodgit/watchdog)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with watchdog](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with watchdog](#beginning-with-watchdog)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

This module manages a hardware watchdog.
This is usually implemented as a kernel device and optionally a userspace
process to periodically reset the device to prevent it rebooting the machine.

This module ensures that the watchdog is enabled and configured to reset the
machine if it has not been reset after the specified period.
If a userspace process is required to reset the watchdog then this will be
configured to run periodically.

## Setup

### Setup Requirements

This module assumes that the appropriate hardware device is already configured
and accessible.
This could be as simple as loading a kernel module or as complex as compiling
a whole new kernel from scratch.

### Beginning with watchdog

```puppet
include watchdog
```

## Usage

If you want to use something else to manage the watchdog daemon, you can do:


```puppet
class { 'watchdog':
  service_manage => false,
}
```

## Reference

The reference documentation is generated with
[puppet-strings](https://github.com/puppetlabs/puppet-strings) and the latest
version of the documentation is hosted at
[https://bodgit.github.io/puppet-watchdog/](https://bodgit.github.io/puppet-watchdog/)
and available also in the [REFERENCE.md](https://github.com/bodgit/puppet-watchdog/blob/master/REFERENCE.md).

## Limitations

There is no standard for watchdog timeout periods so it's potentially tricky
to ship a default value that works on all hardware however hopefully a period
of 60 seconds should work in 99% of cases.

This module has been built on and tested against Puppet 5 and higher.

The module has been tested on:

* RedHat Enterprise Linux 6/7
* OpenBSD 6.7/6.8 (anything as far back as 4.9 should work)

## Development

The module relies on [PDK](https://puppet.com/docs/pdk/2.x/pdk.html) and has
[rspec-puppet](http://rspec-puppet.com) tests. Run them with:

```
$ bundle exec rake spec
```

Please log issues or pull requests at
[github](https://github.com/bodgit/puppet-watchdog).
