#!/bin/sh

if which composer >/dev/null; then
    echo "Updating composer"
    sudo composer self-update
else
    echo "Installing composer"
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
fi

composerDir="$HOME/.config/composer"
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
if ! grep -q "squizlabs/php_codesniffer" "$composerJson"; then
    composer global require "squizlabs/php_codesniffer=*"
fi
if ! grep -q "object-calisthenics/phpcs-calisthenics-rules" "$composerJson"; then
    composer global require "object-calisthenics/phpcs-calisthenics-rules"
fi
if ! grep -q "endouble/symfony3-custom-coding-standard" "$composerJson"; then
    composer global require "endouble/symfony3-custom-coding-standard"
fi
phpcs --config-set encoding utf-8
phpcs --config-set installed_paths "$composerDir/vendor/object-calisthenics/phpcs-calisthenics-rules/src,$composerDir/vendor/endouble/symfony3-custom-coding-standard"

if ! grep -q "phpmd/phpmd" "$composerJson"; then
    composer global require "phpmd/phpmd"
fi
