---
description: Create conventional commits from git changes
---

Analyze the current git changes and create commits following Conventional Commits format.

## Current Changes

Git status:
!`git status`

Git diff:
!`git diff --stat`

## Requirements

- **Format**: `<type>(<scope>): <description>`
- Group related changes into logical commits
- Separate unrelated changes into different commits
- Use descriptive commit messages that explain the "why"
- Write commit messages in **Russian by default**. Use English only if explicitly specified.
- For each commit, provide a clear summary
- **Execute all git commands yourself** (git add, git commit)

## Types

- `feat` — new feature
- `fix` — bug fix
- `docs` — documentation only
- `style` — formatting, no code change
- `refactor` — code refactoring
- `perf` — performance improvement
- `test` — adding/updating tests
- `chore` — maintenance, deps, build

## Optional Arguments

$ARGUMENTS

If provided, use as hint for commit scope or message:
- `$1` — scope or topic
- `$2` — additional context

## Git Commands to Execute

### Stage specific file
```bash
git add <file>
```

### Stage all changes
```bash
git add -A
```

### Create commit
```bash
git commit -m "<message>"
```

### Amend last commit (if not pushed)
```bash
git commit --amend
```

### View history
```bash
git log --oneline -5
```

---

## Examples

### Single commit
```
feat(auth): add password reset functionality

- Add forgot password form
- Implement email sending with reset token
- Add reset password page

Closes #123
```

### Multiple commits (separate changes)
```
# Commit 1
feat(user): add user profile page

# Commit 2
fix(ui): correct button alignment in header

# Commit 3
docs(readme): update installation instructions
```

### Russian examples
```
feat(auth): добавить функцию сброса пароля

- Добавлена форма восстановления пароля
- Реализована отправка email с токеном

fix(api): исправить ошибку валидации email

- Добавлена проверка на корректность домена
- Обновлены сообщения об ошибках
```

---

## Workflow

1. Review git status and diff above
2. Group changes logically
3. For each group:
   - `git add <files>` to stage
   - `git commit -m "<type>(<scope>): <description>"` to commit
4. `git log --oneline -5` to verify commits were created
5. Display commit message for user
