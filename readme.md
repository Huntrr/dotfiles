My dotfiles.

Setup is pretty simple. Drop this folder somewhere (make sure it's in a folder;
you can probably get away with unloading all this stuff in `/home` but that'd
just be ugly...) and run

```
./install.sh
```

Then open up Vim and enter `:PluginInstall`. That should use Vundle to set up
all the plugins. If that doesn't work, try

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

in terminal, which will install Vundle (`./install.sh` should do that, though).

Finally, you're going to want to set up YouCompleteMe. You gotta do this after
running `:PluginInstall`, but it's also pretty easy, just do

```
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
```

If that doesn't work, check out [YouCompleteMe's
page](https://github.com/Valloric/YouCompleteMe)
