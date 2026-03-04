# Repository Guidelines

## Project Structure

- `lec_notes_2026/`: Primary lecture materials for Spring 2026 (Markdown, PDFs, and some demo notebooks under `lec_notes_2026/code_demo/`).
- `lyx/`: LyX sources for lecture notes. Prefer editing `.lyx` here and exporting PDFs into `lec_notes_2026/` using the same base name (e.g., `04_asym.lyx` → `lec_notes_2026/04_asym.pdf`).
- `code/`: Standalone code examples and notebooks used in class (Python/R/Jupyter, plus some `.qmd` slide sources).
- `docs/`: Static course webpage (e.g., `docs/index.html`, suitable for GitHub Pages).
- `references/`: Reading PDFs and reference material.

## Build, Test, and Development Commands

This repo does not use a single build system; most work is editing notes and running notebooks/scripts.

- Dev Container (VS Code): open the repo in a Dev Container (see `.devcontainer/devcontainer.json`).
- Docker (Jupyter + R packages):  
  - Build: `docker build -t econ5150 .`  
  - Run: `docker run -p 8888:8888 -v "${PWD}:/home/jovyan/work" econ5150`
- Run scripts:
  - Python: `python .\code\MLE_normal.py`
  - R: `Rscript .\code\MLE_normal.R`

## Coding Style & Naming Conventions

- Python: 4-space indentation, `snake_case` for functions/variables.
- R: prefer 2-space indentation and `snake_case`.
- Prefer descriptive filenames and stable lecture numbering (e.g., `lec_notes_2026/12_ML_demo.ipynb`, `lyx/10_gmm.lyx`).
- Avoid committing huge auto-generated artifacts unless they are intended course outputs (PDF notes in `lec_notes_2026/` are OK).

## Testing Guidelines

There is no automated test suite. Validate changes by:

- Opening notebooks and running key cells end-to-end.
- Smoke-running scripts you touched (`python …`, `Rscript …`).
- Spot-checking exported PDFs after editing LyX sources.

## Commit & Pull Request Guidelines

- Commit messages in history are short and action-oriented (examples: “add …”, “update …”, “fix …”, “move …”). Keep them concise and specific to the lecture/topic affected.
- PRs: include a brief summary, list impacted paths (e.g., `lec_notes_2026/`, `lyx/`), and attach screenshots or PDF diffs when changing rendered notes/web content.
