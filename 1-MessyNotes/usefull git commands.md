[[git]]
what are the different areas in GIT?
- **Git Repository ( `.git` directory or "The Vault"):** This is Git's database, where it stores all the commit history, objects (blobs, trees, commits), and metadata. This is the permanent record.
    
- **Staging Area (or "Index" or "Preparation Area"):** This is a file that lives in your `.git` directory. It's like a temporary holding area where you stage changes you _intend_ to include in your _next_ commit. It's a snapshot of what will go into the next commit.
    
- **Working Directory (or "Working Tree"):** This is the actual directory on your file system where you see and edit your project files. It's where you make changes.

if i want to restore the contents of a certain file from a previous commit we can use git restore:

```shell
git restore --source=<commit-hash> -- <file-path>
```

what are the levels of reset in git?

1. --soft: rewrites the history but keeps the contents of the previous commits in the staging area. and the content of the working directory will not change!!
2. --mixed: same as soft but the content of the deleted commits are no longer in the staging area. the content of the working directory is not touched.
3. --hard: the content of the working directory is reset to the content of the commit we resetted to.
