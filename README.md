# LasseMT's dotfiles
based on [Overbryd's dotfiles](https://github.com/Overbryd/dotfiles).

## 1. Install xcode CLI tools
```
xcode-select --install
```

## 2. Bootstrap
On a new mac, open a Terminal and run:
```
curl -O https://raw.githubusercontent.com/lassemt/dotfiles/master/bootstrap.sh
chmod +x bootstrap.sh
./bootstrap.sh
```

### 3. Maintenance
Enter the ~/dotfiles directory, make changes and make it:

```
cd ~/dotfiles
make
```
