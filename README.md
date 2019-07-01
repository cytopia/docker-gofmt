# Docker image for `gofmt`

[![Build Status](https://travis-ci.com/cytopia/docker-gofmt.svg?branch=master)](https://travis-ci.com/cytopia/docker-gofmt)
[![Tag](https://img.shields.io/github/tag/cytopia/docker-gofmt.svg)](https://github.com/cytopia/docker-gofmt/releases)
[![](https://images.microbadger.com/badges/version/cytopia/gofmt:latest.svg?&kill_cache=1)](https://microbadger.com/images/cytopia/gofmt:latest "gofmt")
[![](https://images.microbadger.com/badges/image/cytopia/gofmt:latest.svg?&kill_cache=1)](https://microbadger.com/images/cytopia/gofmt:latest "gofmt")
[![](https://img.shields.io/badge/github-cytopia%2Fdocker--gofmt-red.svg)](https://github.com/cytopia/docker-gofmt "github.com/cytopia/docker-gofmt")
[![License](https://img.shields.io/badge/license-MIT-%233DA639.svg)](https://opensource.org/licenses/MIT)

> #### All [#awesome-ci](https://github.com/topics/awesome-ci) Docker images
>
> [ansible](https://github.com/cytopia/docker-ansible) **•**
> [ansible-lint](https://github.com/cytopia/docker-ansible-lint) **•**
> [awesome-ci](https://github.com/cytopia/awesome-ci) **•**
> [black](https://github.com/cytopia/docker-black) **•**
> [checkmake](https://github.com/cytopia/docker-checkmake) **•**
> [eslint](https://github.com/cytopia/docker-eslint) **•**
> [file-lint](https://github.com/cytopia/docker-file-lint) **•**
> [gofmt](https://github.com/cytopia/docker-gofmt) **•**
> [goimports](https://github.com/cytopia/docker-goimports) **•**
> [golint](https://github.com/cytopia/docker-golint) **•**
> [jsonlint](https://github.com/cytopia/docker-jsonlint) **•**
> [phpcbf](https://github.com/cytopia/docker-phpcbf) **•**
> [phpcs](https://github.com/cytopia/docker-phpcs) **•**
> [php-cs-fixer](https://github.com/cytopia/docker-php-cs-fixer) **•**
> [pycodestyle](https://github.com/cytopia/docker-pycodestyle) **•**
> [pylint](https://github.com/cytopia/docker-pylint) **•**
> [terraform-docs](https://github.com/cytopia/docker-terraform-docs) **•**
> [terragrunt](https://github.com/cytopia/docker-terragrunt) **•**
> [yamllint](https://github.com/cytopia/docker-yamllint)


> #### All [#awesome-ci](https://github.com/topics/awesome-ci) Makefiles
>
> Visit **[cytopia/makefiles](https://github.com/cytopia/makefiles)** for seamless project integration, minimum required best-practice code linting and CI.

View **[Dockerfile](https://github.com/cytopia/docker-gofmt/blob/master/Dockerfile)** on GitHub.

[![Docker hub](http://dockeri.co/image/cytopia/gofmt?&kill_cache=1)](https://hub.docker.com/r/cytopia/gofmt)

Tiny Alpine-based multistage-build dockerized version of [gofmt](https://godoc.org/cmd/gofmt)<sup>[1]</sup>,
which adds the **additional `--ci` argument<sup>[2]</sup>** via a shell wrapper to ensure to exit > 0 if file diffs occur.
The image is built nightly against multiple stable versions and pushed to Dockerhub.

* <sup>[1] Official project: https://godoc.org/cmd/gofmt</sup>
* <sup>[2] See [Usage](#usage) for help</sup>


## Available Docker image versions

| Docker tag | Build from |
|------------|------------|
| `latest`   | Latest stable gofmt version |


## Docker mounts

The working directory inside the Docker container is **`/data/`** and should be mounted locally to
the root of your project.


## Usage

### General

```bash
$ docker run --rm cytopia/gofmt --help

Usage: cytopia/gofmt [flags] [path...]
       cytopia/gofmt [--ci] [-r rule] [-se] [path...]
       cytopia/gofmt --help

Dockerized version of gofmt with an addition to fail (exit 1) in case of file changes.

Additional wrapper features:
----------------------------
--ci      This option will print the diff to stdout (similar to '-d') and if a diff
          exists it will fail with exit 1.
          Can only be combined with '-r rule', '-s' and '-e'.
          To be used in continuous integration with explicit failing.

Default gofmt flages:
----------------------------
-d        Do not print reformatted sources to standard output.
          If a file's formatting is different than gofmt's, print diffs
          to standard output.
-e        Print all (including spurious) errors.
-l        Do not print reformatted sources to standard output.
          If a file's formatting is different from gofmt's, print its name
          to standard output.
-r rule   Apply the rewrite rule to the source before reformatting.
-s        Try to simplify code (after applying the rewrite rule, if any).
-w        Do not print reformatted sources to standard output.
          If a file's formatting is different from gofmt's, overwrite it
          with gofmt's version. If an error occurred during overwriting,
          the original file is restored from an automatic backup.
```

### Default gofmt usage
```bash
# Print diff to stdout and exit 0
$ docker run --rm -v $(pwd):/data cytopia/gofmt -d .
```

### CI wrapper usage
```bash
# Print diff to stdout and exit > 0 if diff occurs
$ docker run --rm -v $(pwd):/data cytopia/gofmt --ci .
```


## Related [#awesome-ci](https://github.com/topics/awesome-ci) projects

### Docker images

Save yourself from installing lot's of dependencies and pick a dockerized version of your favourite
linter below for reproducible local or remote CI tests:

| Docker image | Type | Description |
|--------------|------|-------------|
| [awesome-ci](https://github.com/cytopia/awesome-ci) | Basic | Tools for git, file and static source code analysis |
| [file-lint](https://github.com/cytopia/docker-file-lint) | Basic | Baisc source code analysis |
| [jsonlint](https://github.com/cytopia/docker-jsonlint) | Basic | Lint JSON files **<sup>[1]</sup>** |
| [yamllint](https://github.com/cytopia/docker-yamllint) | Basic | Lint Yaml files |
| [ansible](https://github.com/cytopia/docker-ansible) | Ansible | Multiple versoins of Ansible |
| [ansible-lint](https://github.com/cytopia/docker-ansible-lint) | Ansible | Lint  Ansible |
| [gofmt](https://github.com/cytopia/docker-gofmt) | Go | Format Go source code **<sup>[1]</sup>** |
| [goimports](https://github.com/cytopia/docker-goimports) | Go | Format Go source code **<sup>[1]</sup>** |
| [golint](https://github.com/cytopia/docker-golint) | Go | Lint Go code |
| [eslint](https://github.com/cytopia/docker-eslint) | Javascript | Lint Javascript code |
| [checkmake](https://github.com/cytopia/docker-checkmake) | Make | Lint Makefiles |
| [phpcbf](https://github.com/cytopia/docker-phpcbf) | PHP | PHP Code Beautifier and Fixer |
| [phpcs](https://github.com/cytopia/docker-phpcs) | PHP | PHP Code Sniffer |
| [php-cs-fixer](https://github.com/cytopia/docker-php-cs-fixer) | PHP | PHP Coding Standards Fixer |
| [black](https://github.com/cytopia/docker-black) | Python | The uncompromising Python code formatter |
| [pycodestyle](https://github.com/cytopia/docker-pycodestyle) | Python | Python style guide checker |
| [pylint](https://github.com/cytopia/docker-pylint) | Python | Python source code, bug and quality checker |
| [terraform-docs](https://github.com/cytopia/docker-terraform-docs) | Terraform | Terraform doc generator (TF 0.12 ready) **<sup>[1]</sup>** |
| [terragrunt](https://github.com/cytopia/docker-terragrunt) | Terraform | Terragrunt and Terraform |

> **<sup>[1]</sup>** Uses a shell wrapper to add **enhanced functionality** not available by original project.


### Makefiles

Visit **[cytopia/makefiles](https://github.com/cytopia/makefiles)** for dependency-less, seamless project integration and minimum required best-practice code linting for CI.
The provided Makefiles will only require GNU Make and Docker itself removing the need to install anything else.


## License

**[MIT License](LICENSE)**

Copyright (c) 2019 [cytopia](https://github.com/cytopia)
