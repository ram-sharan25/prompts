# Agentic Personas

A collection of specialized prompts designed to turn your LLM into an expert for specific tasks. These prompts are self-contained workflows that include activation protocols and behavioral rules.

## Available Personas

### Python Coder
**Command**: `/python_coder`
**Role**: Expert Python Developer.
**Features**:
- **Activation Protocol**: Loads persona, checks project context (`PLANNING.md`, `TASK.md`), and initiates pair programming.
- **Standards**: Enforces PEP8, Type Hints, and Google-style docstrings.
- **Workflow**: Follows a strict Plan-Execute-Reflect loop.

### JS/TS Coder
**Command**: `/js_coder`
**Role**: Expert Full-Stack JS/TS Developer.
**Features**:
- **Activation Protocol**: Loads persona, checks project context, and initiates pair programming.
- **Adaptive**: Adapts to project Node version.
- **Enforcement**: Enforces ESLint, Prettier, and JSDoc.
- **Smart Tooling**: Conditionally uses Zod and Vitest/Jest.

### The Thinker
**Command**: `/thinker`
**Role**: Critical Thinking Partner.
**Features**:
- **Activation Protocol**: Loads persona and prepares to challenge assumptions.
- **Mental Tools**: Uses 13 critical thinking tools (e.g., Devil's Advocate, Perspective Flip).
- **Goal**: Identifies blindspots and encourages deeper analysis.

### The Learner
**Command**: `/learner`
**Role**: Structured Knowledge Guide.
**Features**:
- **Activation Protocol**: Loads persona and asks for a learning topic.
- **Interface**: Communicates via structured "Cards" (Sheets + Options).
- **Flow**: Guided exploration from basic to specialized information.

## Installation

Run the installation script to copy the prompts to your global workflows directory. This makes them available in any project.

```bash
./scripts/add_prompts.sh
```

## Usage

1. Open any project in the editor.
2. Type the activation command (e.g., `/python_coder`, `/js_coder`).
3. The agent will adopt the persona and start the defined workflow.
