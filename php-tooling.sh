#!/bin/sh
if [ ! -d "$HOME/bin" ]; then
    mkdir -p "$HOME/bin"
fi

if which composer >/dev/null; then
    echo "Updating composer"
    composer self-update
else
    echo "Installing composer"
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar $HOME/bin/composer
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

if ! grep -q "escapestudios/symfony2-coding-standard" "$composerJson"; then
    composer global require "escapestudios/symfony2-coding-standard"
fi
phpcs --config-set encoding utf-8
phpcs --config-set installed_paths "$composerDir/vendor/object-calisthenics/phpcs-calisthenics-rules/src,$composerDir/vendor/escapestudios/symfony2-coding-standard"
# phpcs --config-set installed_paths "$composerDir/vendor/endouble/symfony3-custom-coding-standard"

if ! grep -q "phpmd/phpmd" "$composerJson"; then
    composer global require "phpmd/phpmd"
fi

# if ! grep -q "phpstan/phpstan" "$composerJson"; then
#     composer global require "phpstan/phpstan"
# fi

if ! grep -q "symplify/easy-coding-standard" "$composerJson"; then
    composer global require "symplify/easy-coding-standard"
fi

if ! grep -q "jakub-onderka/php-parallel-lint" "$composerJson"; then
    composer global require "jakub-onderka/php-parallel-lint"
fi

if ! grep -q "sebastian/phpcpd" "$composerJson"; then
    composer global require "sebastian/phpcpd"
fi

# if ! grep -q "phpro/grumphp" "$composerJson"; then
#     composer global require "phpro/grumphp"
# fi

if ! grep -q "sensiolabs/security-checker" "$composerJson"; then
    composer global require "sensiolabs/security-checker"
fi

echo "Installing phars"

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

echo "PHP tooling complete"
