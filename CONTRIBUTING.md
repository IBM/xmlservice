# Contributing

## Contributing In General

Our project welcomes external contributions. If you have an itch, please feel
free to scratch it.

To contribute code or documentation, please submit a [pull request](https://github.com/IBM/xmlservice/pulls).

A good way to familiarize yourself with the codebase and contribution process is
to look for and tackle low-hanging fruit in the [issue tracker](https://github.com/IBM/xmlservice/issues).
These will be marked with the [good first issue](https://github.com/IBM/xmlservice/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22) label. You may also want to look at those marked with [help wanted](https://github.com/IBM/xmlservice/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22).

**Note: We appreciate your effort, and want to avoid a situation where a contribution
requires extensive rework (by you or by us), sits in backlog for a long time, or
cannot be accepted at all!**

### Proposing new features

If you would like to implement a new feature, please [raise an issue](https://github.com/IBM/xmlservice/issues)
before sending a pull request so the feature can be discussed. This is to avoid
you wasting your valuable time working on a feature that the project developers
are not interested in accepting into the code base.

### Fixing bugs

If you would like to fix a bug, please [raise an issue](https://github.com/IBM/xmlservice/issues) before sending a
pull request so it can be tracked.

## Legal

We have tried to make it as easy as possible to make contributions. This
applies to how we handle the legal aspects of contribution. We use the
same approach - the [Developer's Certificate of Origin 1.1 (DCO)](https://github.com/hyperledger/fabric/blob/master/docs/source/DCO1.1.txt) - that the Linux® Kernel [community](https://elinux.org/Developer_Certificate_Of_Origin)
uses to manage code contributions.

We simply ask that when submitting a patch for review, the developer
must include a sign-off statement in the commit message.

Here is an example Signed-off-by line, which indicates that the
submitter accepts the DCO:

```text
Signed-off-by: John Doe <john.doe@example.com>
```

You can include this automatically when you commit a change to your
local git repository using the following command:

```bash
git commit -s
```

## Communication

Please feel free to connect with us on our [Ryver forum](https://ibmioss.ryver.com/index.html#forums/1000128). You can join the Ryver community [here](https://ibmioss.ryver.com/application/signup/members/9tJsXDG7_iSSi1Q).

## Setup

This project can only be built on an IBM i with the RPG compiler installed along with Python 3
and GNU make. You must build it from an SSH terminal and not QSH or QP2TERM.

```bash
./configure --lib MYLIBRARY

make
```

## Testing

Currently there are no XMLSERVICE-specific tests. The existing tests require the use of a downstream
toolkit (either [PHP](https://github.com/zendtech/IbmiToolkit) or [Python](https://github.com/IBM/python-itoolkit)).
There is an ongoing effort to convert these to toolkit-agnostic tests in [issue 20](https://github.com/IBM/xmlservice/issues/20)


## Coding style guidelines

Currently the code is in fixed format, but the goal is to convert to full-free format code (see
[issue 24](https://github.com/IBM/xmlservice/issues/24)).

All new contributions should be in full-free format.