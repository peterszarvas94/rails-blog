# Agent Guidelines

This document outlines the guidelines for agentic coding in this repository.

## Build/Lint/Test Commands

- **Build**: `bin/rails db:test:prepare`
- **Lint**: `bin/rubocop -f github`
- **Test**: `bin/rails test test:system`
- **Single Test**: To run a single test file, use `bin/rails test <path/to/test_file.rb>`. For example, `bin/rails test test/models/user_test.rb`

## Code Style Guidelines

This project adheres to the [rubocop-rails-omakase](https://github.com/rails/rubocop-rails-omakase) style guide for Ruby code. Refer to the `.rubocop.yml` file for any project-specific overrides.

## Cursor/Copilot Rules

No specific Cursor or Copilot rule files were found in this repository.

