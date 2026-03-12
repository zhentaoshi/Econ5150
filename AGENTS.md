# Repository Guidelines for ECON5150

This document provides guidance for AI coding agents working in this econometrics course repository.

## Project Structure

```
econ5150/
├── lec_notes_2026/        # Primary lecture materials (Markdown, PDFs, notebooks)
│   └── code_demo/         # Standalone demo scripts for lectures
├── lyx/                   # LyX sources for lecture notes
├── code/                  # Standalone code examples (Python/R/Jupyter, .qmd slides)
├── docs/                  # Static course webpage (GitHub Pages)
├── references/            # Reading PDFs and reference materials
├── .devcontainer/         # VS Code Dev Container configuration
└── Dockerfile             # Docker image for Jupyter + R environment
```

## Environment Setup

### Dev Container (VS Code)
Open the repo in a Dev Container using `.devcontainer/devcontainer.json`.

### Docker (Jupyter + R)
```bash
docker build -t econ5150 .
docker run -p 8888:8888 -v "${PWD}:/home/jovyan/work" econ5150
```

## Build, Test, and Development Commands

This repo does not use a centralized build system. Work consists of editing notes and running notebooks/scripts.

### Running Python Scripts
```bash
# Run a single Python script
python code/MLE_normal.py
python lec_notes_2026/code_demo/09_loop.py
python lec_notes_2026/code_demo/09_parallel.py
```

### Running R Scripts
```bash
# Run a single R script
Rscript code/MLE_normal.R
Rscript code/naive.R
Rscript lec_notes_2026/code_demo/09_loop.r
```

### Running Jupyter Notebooks
Open notebooks in Jupyter or VS Code. Run cells interactively. Key notebooks include:
- `lec_notes_2026/00_intro.ipynb` - Course introduction
- `lec_notes_2026/07_optimization.ipynb` - Optimization methods
- `lec_notes_2026/12_ML_demo.ipynb` - Machine learning demos

### Rendering Quarto Slides
```bash
quarto render code/slides_02_docker.qmd
quarto render code/slides_01_git.qmd
```

### Exporting LyX to PDF
Edit `.lyx` files in `lyx/`, then export PDFs to `lec_notes_2026/` with matching base names:
- `lyx/04_asym.lyx` → `lec_notes_2026/04_asym.pdf`
- `lyx/10_gmm.lyx` → `lec_notes_2026/10_gmm.pdf`

## Code Style Guidelines

### Python Style
- **Indentation**: 4 spaces
- **Naming**: `snake_case` for functions and variables
- **Imports**: Standard library first, then third-party (numpy, pandas, matplotlib), then local modules
- **Comments**: Use `# %%` cell markers for Jupyter-style scripts
- **Functions**: Document purpose with brief docstrings
- **Parallel processing**: Use `if __name__ == '__main__':` guard on Windows

```python
import numpy as np
import matplotlib.pyplot as plt

def ci(x):
    """Calculate 95% confidence interval."""
    n = len(x)
    mu = np.mean(x)
    sig = np.std(x)
    return {"lower": mu - 1.96 * sig / np.sqrt(n), 
            "upper": mu + 1.96 * sig / np.sqrt(n)}
```

### R Style
- **Indentation**: 2 spaces
- **Naming**: `snake_case` for functions and variables
- **Assignment**: Use `<-` for assignment (consistent with codebase)
- **Comments**: Use `# %%` cell markers for notebook-style scripts
- **Functions**: Keep functions compact with explicit `return()`
- **Libraries**: Load with `library()` at the top

```r
CI <- function(x) {
  n <- length(x)
  mu <- mean(x)
  sig <- sd(x)
  upper <- mu + 1.96 / sqrt(n) * sig
  lower <- mu - 1.96 / sqrt(n) * sig
  return(list(lower = lower, upper = upper))
}
```

### Jupyter Notebooks
- Include slideshow metadata where applicable (`"slide_type": "slide"`)
- Use markdown cells for section headers and explanations
- Keep code cells focused on single logical operations
- Clear outputs before committing large notebooks

### Quarto (.qmd) Slides
- Use `revealjs` format with the custom `blue_theme.css`
- Set `echo: true`, `warning: false`, `message: false` in YAML header

## File Naming Conventions

- **Lecture notes**: Numbered by topic (e.g., `01_causality.md`, `04_asym.pdf`)
- **Code demos**: Match lecture number (e.g., `09_loop.py`, `08_newton_method_opt.R`)
- **Notebooks**: Descriptive names with lecture numbers (e.g., `12_ML_demo.ipynb`)
- **LyX sources**: Match output PDF names (e.g., `10_gmm.lyx` → `10_gmm.pdf`)

## Error Handling

- Scripts are designed for educational demonstration; prefer clarity over robustness
- Use simple error messages suitable for students
- For optimization: include tolerance and iteration limits (e.g., `epsilon <- 0.0001`, `max_iter <- 50`)

## Testing Guidelines

There is no automated test suite. Validate changes manually:

1. **Scripts**: Run end-to-end with `python` or `Rscript`
2. **Notebooks**: Open in Jupyter and run all cells
3. **LyX → PDF**: Spot-check rendered PDFs after edits
4. **Web content**: Preview `docs/index.html` locally before deploying

## Commit Guidelines

- Keep messages short and action-oriented: "add ...", "update ...", "fix ...", "move ..."
- Be specific about the lecture/topic affected
- PDF outputs in `lec_notes_2026/` are acceptable to commit
- Avoid committing Jupyter checkpoint directories (in `.gitignore`)

## Pull Request Guidelines

- Include a brief summary of changes
- List impacted paths (e.g., `lec_notes_2026/`, `lyx/`, `code/`)
- Attach screenshots or PDF diffs when changing rendered content
