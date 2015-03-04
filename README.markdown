# votes

Votes!

## models

* `vote_counts` - `task_id`, `amount`
* `votes` - `task_id`, `user_id`

## Development setup

1. Assumed `rbenv` is used for rubies. One can `brew install rbenv ruby-build` on a Mac.
2. `brew install postgresql` if it's not already installed.
3. `make install` will install any necessary dependencies.
4. `make start` will use foreman to boot everything.
