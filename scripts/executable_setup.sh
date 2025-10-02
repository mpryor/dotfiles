#!/bin/bash

install_homebrew() {
    echo "Setting up brew..."

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo >>/home/matt/.zshrc
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>/home/matt/.zshrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

    echo "Homebrew installed..."
}

install_oh_my_zsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_apps() {
    brew bundle install
    if [[ "$OSTYPE" =~ "linux"* ]]; then
        sudo apt-get install -y konsole xsel libssl-dev make build-essential libssl-dev zlib1g-dev \
            libbz2-dev libreadline-dev libsqlite3-dev curl git \
            libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
            gopls shellcheck shfmt
    fi
}

install_dotfiles() {
    chezmoi init https://github.com/mpryor/dotfiles
    chezmoi apply
}

install_fonts() {
    declare -a fonts=(
        FiraCode
        FiraMono
        JetBrainsMono
        SourceCodePro
    )

    version='3.0.2'
    fonts_dir="${HOME}/.local/share/fonts"

    if [[ ! -d "$fonts_dir" ]]; then
        mkdir -p "$fonts_dir"
    fi

    for font in "${fonts[@]}"; do
        zip_file="${font}.zip"
        download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
        echo "Downloading $download_url"
        wget "$download_url"
        unzip "$zip_file" -d "$fonts_dir"
        rm "$zip_file"
    done

    find "$fonts_dir" -name '*Windows Compatible*' -delete

    fc-cache -fv
}

main() {
    install_homebrew
    install_apps
    install_oh_my_zsh
    install_dotfiles
    install_fonts
}

main
