# The One True Holy and Apostolic Prompts

A collection of "Agentic Personas" designed to turn your LLM into a specialized expert. These prompts are designed to be "installed" into your projects to give you on-demand access to specific capabilities.

## 🎭 Available Personas

### 🐍 Python Coder
**Command**: `/activate_coder`
**Role**: Expert Python Developer & Polyglot.
**Features**:
- Enforces PEP8, Type Hints, and Google-style docstrings.
- Manages project context via `PLANNING.md` and `TASK.md`.
- Follows a strict Plan-Execute-Reflect loop.

### 📜 JS/TS Coder
**Command**: `/activate_js_coder`
**Role**: Expert Full-Stack JS/TS Developer.
**Features**:
- Adapts to your project's Node version.
- Enforces ESLint, Prettier, and JSDoc.
- Conditionally uses Zod and Vitest/Jest based on your project setup.

### 🧠 The Thinker
**Command**: `/activate_thinker`
**Role**: Personal Trainer for the Mind.
**Features**:
- Uses **13 Critical Thinking Tools** (e.g., Devil's Advocate, Perspective Flip).
- Challenges assumptions and spots blindspots.
- Does not just echo your thoughts; it pushes you to think deeper.

### 🎓 The Learner
**Command**: `/activate_learner`
**Role**: Structured Knowledge Guide.
**Features**:
- **Strict Interface**: Communicates only via "Cards" (Sheets + Options).
- **Navigation**: You explore topics by selecting numbered options.
- **Drill-down**: Go from Basic Info -> Specialized Lists -> Specialized Info.

## 🚀 Installation

You can install these personas into *any* project on your machine using the global installer.

1.  **One-time Setup**:
    Run the setup script. It will detect your shell (zsh/bash) and ask for confirmation before adding the alias.
    ```bash
    ./scripts/setup_global.sh
    # Follow the prompts, then:
    source ~/.zshrc  # or source ~/.bashrc
    ```
    *Optional: You can also pass a specific file path: `./scripts/setup_global.sh ~/.my_rc`*

2.  **Install in a Project**:
    Navigate to your target project and run:
    ```bash
    cd /path/to/my-project
    install-agents
    ```

3.  **What happens?**
    -   It creates an `.agent` directory in your project.
    -   It **copies** all prompt files to `.agent/prompts/`.
    -   It **copies** all workflow files to `.agent/workflows/`.
    -   It automatically updates the file links in the workflows to point to your project's local copies.

## 🛠️ Usage

Once installed in your project:

1.  Open your project in your AI Editor (e.g., Google Antigravity).
2.  Type the activation command in the chat:
    - `/activate_coder`
    - `/activate_js_coder`
    - `/activate_thinker`
    - `/activate_learner`
3.  The agent will adopt the persona and start the workflow.
