# Contributing to banager
<!--LLM DISCLOSER: duck.ai was used with making an outline for this-->
<!--Some of these are just taken from eza's CONTRIBUTING.md but modified to work with this project-->
Banager is a bash plugin manager, similar to zsh's Oh My Zsh or zinit. This handles all your bash in 
a simple and manageable way and can be used with minimal installation.

Before contributing to banager, please familiarize yourself with these documents.
- [Banager Code of Conduct](CODE_OF_CONDUCT.md)
- Requirements of conformance to [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
- Requirements of [Semantic Versioning](https://www.conventionalcommits.org/en/v1.0.0/)
- The [Bash documentation](https://www.gnu.org/software/bash/manual/bash.html) (or do `$ man bash`)
- The [Security Police](SECURITY.md)
- [Free and Open Source software (FOSS)](https://www.gnu.org/philosophy/free-sw.en.html)

By contributing you are agreeing to the [Code of Conduct](CODE_OF_CONDUCT.md)
# Contributing
## Creating a PR [Pull Request]
First you should use the pull request template. Also keep your PRs to one fix at a time.

Please make sure that the work you worked on actually does work (it is recommended to do this is a temporary bash
shell environment or in a Virtual Machine). Also use shellcheck to ensure no errors are present. Make sure to 
also add how you ensured this in the PR description. Further, it's expected that you do your best to check for
regressions.

If your PR introduces a flag, you MUST:
- Add documentation to it of it in the [command](terminal/banager) file.
- Add your option to the help flag.
- If your flag has other arguments, make sure there is an addition help flag.
- Add your flag to the 
Wiki <!--This is currently unimplemented but is going to be added-->
- Explain the flag's purpose in the PR's long description option.

Before submitting you should have run shellcheck on all files.

#### Commit messages
A common commit message contains at least a summary and reference with closing action to the corresponding issue if any, 
and may also include a description and signature.
#### Summary 
For your commit messages, please use the first line for a brief summary what the commit changes. Try to stay within the 72 char limit and prepend what type of change. See the following list for some guidance:
- feat: adds a new feature to banager 
- refactor: revises parts of the code
- docs(readme): revise the [README](README.md)
- fix: bugfix in the code base.
- ...

Note that this list is not complete and there may be cases where a commit could be characterized by different types, so just try to make your best guess. This spares the maintainers a lot of work when merging your PR.
#### Description
If you commit warrants it due to complexity or external information required to follow it, you should add a more detailed description of the changes, reasoning and also link external documentation if necessary. This description should go two lines below the summary and except for links stay in the 80 char limit.
#### Issue reference
If the commit resolves an issue: add `Resolves: #xyz` where `xyz` is the issue number. In case of a bug fix you can also use `Fixes: #xyz`.
#### Signature 
You may add a signature at the end two lines below the description or issue reference. 
<!--TODO: Add an example to this-->
## Creating an Issue
When you make an issue, follow the standard procedures outlined in the Issue tab of the repository.
#### Issue Report
For an issue report please provide the following things:
- The title be what your problem is without being vague 
- Tag your issue with what it relates to (i.e. *`plugin`* or *`core`*)
- Describe the issue  
- Gives replication steps
#### Bug Report
For a bug report please provide the following things
- Title your bug report with `BUG:`
- Tag the issue with the *`bug`* tag
- Short description of what the bug is.
- What the bug is in detail.
- What error messages are displayed.
#### Feature Suggestion
For a feature request, please provide the following:
- Title of the report with `FEAT REQUEST:`
- Tag the issue with the *`feature`* tag 
- Short description of the feature 
- What you want it to do.

