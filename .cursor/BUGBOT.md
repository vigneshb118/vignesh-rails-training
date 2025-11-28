# Bugbot Configuration for Rails Application

## Project Information

- **Ruby Version**: 3.4.5
- **Rails Version**: 8.0.3
- **Database**: PostgreSQL
- **Primary Key Type**: UUID

## Review Format & Style Guidelines

### Emoji Usage in Reviews

- **Critical or Severe Errors**: Use appropriate emojis to highlight severity (e.g., 🚨 🔴 ⚠️ 🐛)
- **Improvements or Enhancements**: Add more emojis to celebrate good practices (e.g., ✨ 🎉 💡 🚀 ✅ 🌟)

### Review Structure

When reviewing code changes, evaluate them in the context of the existing Rails codebase. Understand how modified code interacts with surrounding logic and related files—such as how input variables are derived, how return values are consumed, and whether the change introduces side effects or breaks assumptions elsewhere.

For each validated issue, output a nested bullet like this:

- File: `<path>:<line-range>`
  - Issue: [One-line summary of the root problem]
  - Fix: [Concise suggested change or code snippet]

Group all issues by severity in this order—Critical, Major, Minor, Enhancement—with appropriate emojis:

### Critical 🚨

- Security vulnerabilities (SQL injection, XSS, authorization bypass, exposed secrets)
- Breaking changes that could cause data loss or corruption
- Missing critical validations or error handling
- N+1 queries that could cause performance degradation

### Major ⚠️

- Performance issues (inefficient queries, missing indexes)
- Missing authorization checks (Pundit policies)
- Code that violates Rails conventions
- Missing error handling for edge cases

### Minor 💡

- Code style inconsistencies
- Missing comments for complex logic
- Opportunities for refactoring (DRY violations)
- Missing test coverage for non-critical paths

### Enhancement ✨

- Suggestions for improving code quality
- Performance optimizations
- Better naming or structure
- Additional test coverage

After the prioritized issues, include a brief bulleted list of positive findings or well-implemented patterns observed in the code.

Throughout, maintain a polite, professional tone; keep comments as brief as possible without losing clarity.

## Rails & Ruby Evaluation Criteria

When reviewing code changes, assess each change against the following Rails and Ruby-specific principles:

### Design & Architecture

- Verify the change fits Rails architectural patterns (MVC, RESTful conventions)
- Avoid unnecessary coupling or speculative features
- Enforce clear separation of concerns (controllers thin, business logic in models/services)
- Align with Rails module boundaries and directory structure
- Follow Rails naming conventions (plural controllers, singular models)

### Complexity & Maintainability

- Ensure control flow remains flat, cyclomatic complexity stays low
- Abstract duplicate logic (DRY principle)
- Remove dead or unreachable code
- Refactor dense logic into testable helper methods or service objects
- Keep methods focused on a single responsibility

### Functionality & Correctness

- Confirm new code paths behave correctly under valid and invalid inputs
- Cover all edge cases (nil values, empty collections, boundary conditions)
- Maintain idempotency for retry-safe operations
- Include robust error-handling semantics
- Validate ActiveRecord associations and callbacks work as expected

### Readability & Naming

- Check that identifiers clearly convey intent (Rails conventions)
- Comments explain *why* (not *what*)
- Code blocks are logically ordered
- No surprising side-effects hide behind deceptively simple names
- Follow Ruby style guide and Rails Omakase conventions

### Rails Best Practices & Patterns

- Validate use of Rails-specific idioms (scopes, validations, callbacks, concerns)
- Adherence to SOLID principles
- Proper resource cleanup (database connections, file handles)
- Consistent logging/tracing
- Clear separation of responsibilities across MVC layers
- Use Rails generators appropriately
- Follow Rails conventions for configuration

### Test Coverage & Quality

- Verify unit tests for both success and failure paths
- Integration tests exercising end-to-end flows
- Appropriate use of mocks/stubs (avoid over-mocking)
- Meaningful assertions (including edge-case inputs)
- Test names accurately describe behavior
- Test authorization and authentication flows

### Standardization & Style

- Ensure conformance to Rails Omakase style guide
- Consistent indentation (2 spaces)
- Single quotes for strings unless interpolation needed
- Zero new Rubocop or linter warnings
- Consistent project structure (folder/file placement)

### Documentation & Comments

- Public APIs or complex algorithms have clear in-code documentation
- README updated to reflect visible changes or configuration tweaks
- Complex business logic is documented
- Comments explain *why*, not *what*

### Security & Compliance

- Input validation and sanitization against injection attacks
- Proper output encoding (Rails auto-escapes, but check `html_safe` usage)
- Secure error handling (no sensitive data in logs)
- Strong parameters in controllers (`params.require().permit()`)
- Pundit authorization checks in controllers
- No secrets or credentials in code
- CSRF protection enabled (Rails default, but verify)
- SQL injection prevention (use parameterized queries)

### Performance & Scalability

- Identify N+1 query patterns - use `includes`, `preload`, or `eager_load`
- Missing database indexes for foreign keys and frequently queried columns
- Inefficient I/O operations
- Memory management concerns
- Heavy hot-path computations
- Suggest caching, batching, memoization, or background jobs (Solid Queue)
- Optimize database queries - suggest using `explain` to analyze query plans

### ActiveRecord & Database

- Use UUIDs for primary keys (already configured)
- Database constraints (NOT NULL, UNIQUE, etc.) in addition to model validations
- Avoid N+1 queries
- Use database transactions for multi-step operations
- Proper database migrations with `up` and `down` methods
- Never modify existing migrations - create new ones instead
- Appropriate use of `dependent: :destroy` or `dependent: :nullify` for associations

### Controllers

- Keep controllers thin - move business logic to models or service objects
- Use strong parameters with `params.require(:model).permit(:attributes)`
- Follow RESTful conventions
- Use appropriate HTTP status codes
- Handle errors gracefully with proper error messages
- Use Turbo Streams for real-time updates (already configured)
- Check authorization using Pundit (`authorize`)

### Models

- Keep models focused on a single responsibility
- Use validations to ensure data integrity
- Use scopes for common queries
- Use callbacks sparingly and document their purpose
- Prefer `before_validation` over `before_save` when possible
- Appropriate use of associations and validations

### Views & Templates

- Use partials for reusable view components
- Keep views simple - move complex logic to helpers or presenters
- Use Turbo Frames and Turbo Streams for dynamic updates (already configured)
- Follow ERB best practices
- Use Tailwind CSS for styling (already configured)
- Ensure all user-facing text is internationalization-ready (use I18n)
- Semantic HTML and accessibility considerations

### Authorization (Pundit)

- Always check authorization in controllers using `authorize`
- Create policy classes for each model that needs authorization
- Use scopes in policies for collection queries
- Keep policy logic simple and testable

### Authentication (Devise)

- Use Devise helpers and methods appropriately
- Protect routes that require authentication
- Use `authenticate_user!` in controllers when needed
- Follow Devise conventions for customizations

### JavaScript & Frontend

- Use Stimulus controllers for JavaScript (already configured)
- Keep JavaScript minimal and focused
- Use Turbo for navigation and form submissions
- Follow Stimulus conventions (targets, actions, values)
- Ensure JavaScript is accessible and works without JavaScript enabled when possible

### Observability & Logging

- Key events emit appropriate log messages
- Logs use appropriate levels (debug, info, warn, error)
- Sensitive data is redacted from logs
- Contextual information included to support debugging

## Common Issues to Watch For

1. **N+1 Queries** 🚨: Always check for missing `includes` or `joins` when accessing associations
2. **Missing Validations** ⚠️: Ensure models have appropriate validations for data integrity
3. **Security Vulnerabilities** 🚨: Check for SQL injection, XSS, missing CSRF protection, exposed secrets
4. **Missing Authorization** ⚠️: Ensure Pundit policies are used where needed
5. **Performance Issues** ⚠️: Watch for inefficient queries or missing indexes
6. **Code Duplication** 💡: Look for opportunities to extract shared logic
7. **Missing Error Handling** ⚠️: Ensure errors are handled gracefully
8. **Inconsistent Naming** 💡: Follow Rails naming conventions
9. **Missing Tests** ⚠️: Critical functionality should have test coverage
10. **Hardcoded Values** 💡: Use constants or configuration instead
11. **Thick Controllers** 💡: Move business logic to models or service objects
12. **Missing Strong Parameters** 🚨: Always use `params.require().permit()` in controllers
13. **Improper Callback Usage** 💡: Use callbacks sparingly and document their purpose
14. **Missing Database Indexes** ⚠️: Add indexes for foreign keys and frequently queried columns

## Project-Specific Notes

- This application uses **Rails 8.0.3** with **Ruby 3.4.5**
- Turbo Rails for SPA-like behavior
- Stimulus is used for JavaScript interactivity
- Tailwind CSS is used for styling
- Pundit is used for authorization
- Devise is used for authentication
- UUIDs are used for primary keys
- Solid Queue is configured for background jobs
- PostgreSQL database
- Follow Rails Omakase style guide (Rubocop configured)

## Review Focus Areas

When reviewing pull requests, pay special attention to:

- **Security vulnerabilities** 🚨 (SQL injection, XSS, authorization bypass, exposed secrets)
- **Performance issues** ⚠️ (N+1 queries, missing indexes, inefficient queries)
- **Code quality and maintainability** (DRY, SOLID principles, Rails conventions)
- **Adherence to Rails conventions** (naming, structure, patterns)
- **Proper error handling** (graceful failures, user-friendly messages)
- **Test coverage** (critical functionality, edge cases)
- **Documentation** (complex logic, public APIs)
- **Authorization** (Pundit policies, authentication checks)

**Remember**: Use emojis appropriately—critical/severe issues should have warning emojis (🚨 🔴 ⚠️ 🐛), while improvements and enhancements should have celebratory emojis (✨ 🎉 💡 🚀 ✅ 🌟).
