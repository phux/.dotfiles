#!/bin/sh

if which composer >/dev/null; then
    echo "Updating composer"
    sudo composer self-update
else
    echo "Installing composer"
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
fi

composerDir="$HOME/.composer"
composerJson="$composerDir/composer.json"

if ! grep -q "$composerDir/vendor/bin" "$HOME/.zshrc"; then
    echo "PATH=$PATH:$composerDir/vendor/bin" >> ~/.zshrc
else
    echo "composer path already set"
fi

if ! grep -q "hirak/prestissimo" "$composerJson"; then
    sudo apt-get install -y php-curl
    composer global require "hirak/prestissimo:^0.3"
fi

echo "setting up phpcs"
# if ! grep -q "object-calisthenics/phpcs-calisthenics-rules" "$composerJson"; then
#     composer global require "object-calisthenics/phpcs-calisthenics-rules"
# fi
if ! grep -q "endouble/symfony3-custom-coding-standard" "$composerJson"; then
    composer global require "endouble/symfony3-custom-coding-standard"
fi
phpcs --config-set encoding utf-8
# phpcs --config-set installed_paths "$composerDir/vendor/object-calisthenics/phpcs-calisthenics-rules/src,$composerDir/vendor/endouble/symfony3-custom-coding-standard"
phpcs --config-set installed_paths "$composerDir/vendor/endouble/symfony3-custom-coding-standard"

if ! grep -q "phpmd/phpmd" "$composerJson"; then
    composer global require "phpmd/phpmd"
fi

if ! grep -q "phpstan/phpstan" "$composerJson"; then
    composer global require "phpstan/phpstan"
fi

if ! grep -q "mkusher/padawan" "$composerJson"; then
    composer global require "mkusher/padawan"
fi

if ! grep -q "jakub-onderka/php-parallel-lint" "$composerJson"; then
    composer global require "jakub-onderka/php-parallel-lint"
fi

if ! grep -q "sebastian/phpcpd" "$composerJson"; then
    composer global require "sebastian/phpcpd"
fi

if ! grep -q "phpro/grumphp" "$composerJson"; then
    composer global require "phpro/grumphp"
fi

if ! grep -q "sensiolabs/security-checker" "$composerJson"; then
    composer global require "sensiolabs/security-checker"
fi

echo "Installing phars"
if [ ! -d "$HOME/bin" ]; then
    mkdir -p "$HOME/bin"
fi

typehintPhar="$HOME/bin/phpdoc-to-typehint.phar"
if [ ! -f $typehintPhar ]; then
    wget -O $typehintPhar https://github.com/dunglas/phpdoc-to-typehint/releases/download/v0.1.0/phpdoc-to-typehint.phar
    chmod +x $typehintPhar
    echo "Installed $typehintPhar"
fi

refactoringPhar="$HOME/bin/refactor.phar"
if [ ! -f $refactoringPhar ]; then
    wget -o $refactoringPhar https://github.com/QafooLabs/php-refactoring-browser/releases/download/v0.1/refactor.phar
    chmod +x $refactoringPhar
    echo "Installed $refactoringPhar"
fi

phpactorExecutable="$HOME/bin/phpactor"
if [ ! -f $phpactorExecutable ]; then
    mkdir ~/.tooling/
    git clone https://github.com/phpactor/phpactor.git ~/.tooling/phpactor
    cd ~/.tooling/phpactor && composer install
    cd -
    ln -fs ~/.tooling/phpactor/bin/phpactor $phpactorExecutable
    chmod +x $phpactorExecutable
    echo "Installed $phpactorExecutable"
fi

echo "PHP tooling complete"
