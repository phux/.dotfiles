# Installation

Clone the repository:

```shell
git clone https://github.com/phux/.dotfiles.git
```

Install ansible:

```shell
cd .dotfiles && make
```

If you want to execute installation in vagrant:

```shell
make test
```

To install on localhost (will override your files, no backup!):

```shell
make provision
```

## Some tasks it does

- pip
- rbenv & ruby
- nvm & node
- gvm & go
- composer
- linking dotfiles
- antibody (zsh)
- php & golang linters


## TODOs
- go get -u github.com/high-moctane/nextword
