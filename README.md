# Evaluation Awareness Probing

Code and experiment artifacts for the workshop submission:

**Representational Depth of Evaluation Awareness Shifts With Scale in Open-Weight Language Models**

This project studies evaluation awareness in open-weight language models: whether evaluation/deployment context information is linearly recoverable from residual stream activations, how the strongest probe layer shifts with scale, and how white-box probe signals compare with black-box behaviour.

## What This Adds

This repository builds on the probing setup from Nguyen et al. (2025), **Probing and steering evaluation awareness of language models** ([arXiv:2507.01786](https://arxiv.org/abs/2507.01786)).

The main additions are:

- layerwise probing across 11 models from Qwen 2.5, Gemma 2, and Llama 3.2;
- analysis of the relative layer depth where probe AUROC peaks;
- black-box evaluation on the same SAD `stages_oversight` split;
- ROUGE-L and perplexity-ratio contamination diagnostics;
- visualisations for the workshop paper.

## Main Result

The headline finding is that evaluation-awareness signals do not simply get stronger with scale. In Qwen 2.5 and Gemma 2, the layer where the signal is most linearly recoverable shifts with model size, generally moving from later layers in smaller models toward earlier layers in larger models.

White-box probe performance is usually stronger than black-box behavioural classification, and the relationship between the two varies by model family.

## Repository Layout

```text
datasets/
  contrastive_dataset.json        Contrastive evaluation/deployment prompt pairs.

notebooks/
  generate_vectors.ipynb          Build layerwise contrastive probe directions.
  probe_evaluation.ipynb          Evaluate saved probe directions on SAD.
  blackbox_evaluation.ipynb       Behavioural evaluation on SAD stages_oversight.
  contamination_diagnostic.ipynb  ROUGE-L and perplexity-ratio diagnostics.
  probe_visualisations.ipynb      Generate summary figures.

  *_CONTRASTIVE_*/                Saved raw and normalised layerwise vectors.
  *_PROBE_RESULTS/                Layerwise probe score CSVs.
  result_visualisations/          Paper/result figures.
  sad/                            Local copy of the SAD benchmark code/data tree.
```

## Setup

Install the core dependencies:

```bash
pip install -r requirements.txt
```

The experiments require access to the relevant Hugging Face model checkpoints and enough GPU memory for the selected model. Runs were performed on rented vast.ai GPU pods; the workshop paper notes that black-box evaluations were rerun under a consistent CUDA setup on H100 NVL GPUs.

## Reproduction

The workflow is notebook-based:

1. Run `notebooks/generate_vectors.ipynb` to create layerwise probe directions from `datasets/contrastive_dataset.json`.
2. Run `notebooks/probe_evaluation.ipynb` to score SAD `stages_oversight` items with the saved vectors.
3. Run `notebooks/blackbox_evaluation.ipynb` for behavioural classification.
4. Run `notebooks/contamination_diagnostic.ipynb` for contamination checks.
5. Run `notebooks/probe_visualisations.ipynb` to regenerate plots.

The current repository is a research snapshot, not a packaged library or one-command reproduction pipeline.

## Caveats

- Linear probes measure recoverability, not causal use.
- Black-box accuracy is prompt-sensitive and uses keyword matching.
- The contamination diagnostics test narrow memorisation/familiarity hypotheses; they do not rule out broad semantic exposure to AI evaluation discourse.

## Related Work and Data

- Nguyen et al. (2025), **Probing and steering evaluation awareness of language models**.
- Chaudhary et al. (2025), **Evaluation awareness scales predictably in open-weights large language models**.
- Laine et al. (2024), **The Situational Awareness Dataset (SAD) for LLMs**.
- Jordine (2025), **pivotal-test-phase-steering** contrastive dataset.
