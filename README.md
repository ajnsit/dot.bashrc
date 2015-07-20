# dot.bashrc
This is my Bash configuration that builds on the `.bashrc` supplied with Ubuntu and derivatives. I try to keep this file up to date with the latest stable version of Ubuntu.

# Quick setup

    cd ~
    clone https://github.com/ajnsit/dot.bashrc .bash
    ln -s ~/.bash/dot.bashrc.sh ~/.bashrc
    ln -s ~/.bash/dot.inputrc ~/.inputrc

# Features

On top of the standard functionality provided by default ubuntu .bashrc, this code provides -

1. Vi style input editing at the bash prompt. Use the commands `goemacs` to switch to emacs style editing, and `govi` to switch back. Look at `dot.inputrc` for some aliases provided for vi mode.

2. Sets up a customised fancy bash prompt. Look at `vendor/git-prompt/`.

3. Provides aliases `..` to go up a directory, `...` to go up 2 directory levels, and so on upto 6 levels

4. Provides a bunch of tools -

  - `pp` - Pretty print json from the stdin
  - `server` - Start a webserver from the current directory
  - `port` - List the applications using a particular port (e.g. `port 8080`). Also used to list the port being used by an application (e.g. `port httpd`). **Requires sudo**.
  - `les` - Runs either `less` or `ls`, depending on whether the argument is a file or a directory.
  - `nocolor` - Strips color codes from text
  - `spider` - Recursively fetch a website from a url
  - `updateRepos` - Recursively update all git or svn repos in the current directory
  - `searchReplace` - Replace a string across files. E.g. - searchReplace <search> <replacement> <files>
  - `renamePrefix` - Rename multiple files, by replacing a prefix. E.g. - renamePrefix <search> [<replacement>]
  - `renameSuffix` - Rename multiple files, by replacing a suffix. E.g. - renameSuffix <search> [<replacement>]
  - `genie` - Ask the genie anything! E.g. `genie where am I`

