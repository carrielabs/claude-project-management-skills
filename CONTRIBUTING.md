# Contributing to Claude Project Management Skills

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## 🎯 Ways to Contribute

### 1. Report Issues
- Bug reports
- Feature requests
- Documentation improvements
- Use case examples

### 2. Submit Pull Requests
- Bug fixes
- New features
- Documentation updates
- Example improvements

### 3. Share Your Experience
- Write blog posts
- Share on social media
- Present at meetups
- Help others in Discussions

---

## 🚀 Getting Started

### Fork and Clone

```bash
# Fork the repository on GitHub
# Then clone your fork
git clone https://github.com/shaobaolu/claude-project-management-skills.git
cd claude-project-management-skills
```

### Test Your Changes

Before submitting, test your changes in a real project:

```bash
# Copy skills to a test project
cp documentation-enforcer/SKILL.md /path/to/test-project/.claude/skills/
cp code-structure-enforcer/SKILL.md /path/to/test-project/.claude/skills/

# Start Claude Code and verify behavior
cd /path/to/test-project
claude
```

---

## 📝 Pull Request Process

### 1. Create a Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

### 2. Make Your Changes

- Keep changes focused and atomic
- Follow existing code style
- Update documentation if needed
- Add examples if applicable

### 3. Test Thoroughly

- Test in multiple scenarios
- Verify documentation is accurate
- Check for typos and formatting

### 4. Commit Your Changes

Use clear, descriptive commit messages:

```bash
git commit -m "Add: Support for custom date formats in documentation-enforcer"
git commit -m "Fix: Incorrect folder path in code-structure-enforcer"
git commit -m "Docs: Add example for multi-language projects"
```

### 5. Push and Create PR

```bash
git push origin feature/your-feature-name
```

Then create a Pull Request on GitHub with:
- Clear title describing the change
- Detailed description of what and why
- Screenshots or examples if applicable
- Reference any related issues

---

## 📋 Contribution Guidelines

### Documentation

- Use clear, simple language
- Provide examples for complex concepts
- Keep formatting consistent
- Update README.md if adding features

### Code (Skills)

- Follow existing structure and style
- Add comments for complex logic
- Keep skills modular and focused
- Test with Claude Code before submitting

### Examples

- Provide real-world use cases
- Include both simple and complex scenarios
- Explain the context and expected outcome

---

## 🎨 Style Guide

### Markdown

- Use ATX-style headers (`#` not `===`)
- Use fenced code blocks with language tags
- Use emoji sparingly and consistently
- Keep line length reasonable (80-120 chars)

### File Naming

- Use lowercase with hyphens: `my-new-feature.md`
- Be descriptive: `installation-guide.md` not `guide.md`
- Use `.md` extension for Markdown files

### Folder Structure

```
project-root/
├── skill-name/
│   └── SKILL.md          # Main skill file
├── examples/
│   └── example-name.md   # Example files
├── docs/                 # Additional documentation
└── README.md             # Main readme
```

---

## 🐛 Reporting Issues

### Bug Reports

Include:
- Clear description of the bug
- Steps to reproduce
- Expected behavior
- Actual behavior
- Claude Code version
- Operating system

### Feature Requests

Include:
- Clear description of the feature
- Use case / motivation
- Proposed solution (if any)
- Alternative solutions considered

---

## 💡 Suggesting Enhancements

We welcome suggestions for:
- New skills
- Improvements to existing skills
- Better documentation
- More examples
- Integration with other tools

---

## 📜 Code of Conduct

### Our Standards

- Be respectful and inclusive
- Welcome newcomers
- Accept constructive criticism
- Focus on what's best for the community
- Show empathy towards others

### Unacceptable Behavior

- Harassment or discrimination
- Trolling or insulting comments
- Personal or political attacks
- Publishing others' private information
- Other unprofessional conduct

---

## 🏆 Recognition

Contributors will be:
- Listed in the README.md
- Credited in release notes
- Thanked in the community

---

## 📞 Questions?

- **General questions**: [GitHub Discussions](https://github.com/shaobaolu/claude-project-management-skills/discussions)
- **Bug reports**: [GitHub Issues](https://github.com/shaobaolu/claude-project-management-skills/issues)
- **Security issues**: Email maintainers directly

---

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for contributing!** 🎉
