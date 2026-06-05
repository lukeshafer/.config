# Luke's Config Files

This zsh function lets you download a given folder from this repo automatically.
```zsh
dlfolder() { curl -L "https://github.com/lukeshafer/.config/archive/refs/heads/main.tar.gz" | tar xz --strip-components=1 ".config-main/$1"; }
```

