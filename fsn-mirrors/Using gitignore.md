# Ignoring a previously committed file

If you want to ignore a file that you've committed in the past, you'll need to delete the file from your repository and then add a .gitignore rule for it. Using the --cached option with git rm means that the file will be deleted from your repository, but will remain in your working directory as an ignored file.

$ echo debug.log >> .gitignore
$ git rm --cached debug.log
rm 'debug.log'
$ git commit -m "Start ignoring debug.log"

You can omit the --cached option if you want to delete the file from both the repository and your local file system.

# Committing an ignored file

It is possible to force an ignored file to be committed to the repository using the -f (or --force) option with git add:

            $ cat .gitignore
            *.log
            $ git add -f debug.log
            $ git commit -m "Force adding debug.log"

You might consider doing this if you have a general pattern (like *.log) defined, but you want to commit a specific file. However a better solution is to define an exception to the general rule:

            $ echo !debug.log >> .gitignore
            $ cat .gitignore
            *.log
            !debug.log
            $ git add debug.log
            $ git commit -m "Adding debug.log"


# Stashing an ignored file

git stash is a powerful Git feature for temporarily shelving and reverting local changes, allowing you to re-apply them later on. As you'd expect, by default git stash ignores ignored files and only stashes changes to files that are tracked by Git. However, you can invoke git stash with the --all option to stash changes to ignored and untracked files as well.

# Debugging .gitignore files

If you have complicated .gitignore patterns, or patterns spread over multiple .gitignore files, it can be difficult to track down why a particular file is being ignored. You can use the git check-ignore command with the -v (or --verbose) option to determine which pattern is causing a particular file to be ignored:

            $ git check-ignore -v debug.log
            .gitignore:3:*.log debug.log

The output shows:

            <file containing the pattern> : <line number of the pattern> : <pattern> <file name>

You can pass multiple file names to git check-ignore if you like, and the names themselves don't even have to correspond to files that exist in your repository.
