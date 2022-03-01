#!/bin/bash

set -ex

rm app/assets/javascripts/app/controllers/layout_ref.coffee
rm -rf app/assets/javascripts/app/views/layout_ref/
rm app/assets/javascripts/app/controllers/karma.coffee

# tests
rm -rf test
rm -rf spec
rm .rspec
rm -rf app/frontend/tests

# CI
rm -rf .github
rm .gitlab-ci.yml

# linting
rm -rf .rubocop
rm .stylelintrc.json
rm .eslintignore
rm .eslintrc
rm .eslintrc.js
rm .rubocop.yml
rm coffeelint.json
rm .overcommit.yml
rm .prettierrc.json
# Since the .eslint folder is a dependency in package.json (requied by assets:precompile),
#   it cannot be removed.

# misc
rm .codeclimate.yml
