# Repo cleanup proposal

This document proposes cleanup items to address before a release. **Nothing is changed until you approve each item.** Co-authors should be consulted on anything marked "verify with the team."

## Repository snapshot

Total checkout: ~34 MB. Git history: ~21 MB. The history is small and does not warrant a rewrite.

> [!NOTE]
> Deleting files now does **not** shrink `.git` — the blobs remain in history. To reclaim space from history you would need a history rewrite (`git filter-repo`) plus a coordinated force-push. That is a separate, sign-off-required operation and is not proposed here.

---

## Clear-cut (safe to remove)

### `Sources/Modelica/Archive/`

Contains two files: `SCRX.mo` and `SCRX_.mo`. Both are superseded drafts of the SCRX model. Neither is referenced by any experiment or active model in the repo (confirmed by grepping the source tree — `TestSCRX.mo` uses `TestSCRX.Components.SCRXwInitAsInput` and `OpenIPSL.Electrical.Controls.PSSE.ES.SCRX`, not the Archive copies). The active SCRX source is `Sources/Modelica/SCRX.mo`.

**Proposed action:** `git rm -r Sources/Modelica/Archive/`

---

## Verify with the team

### `TestSCRX.Experiments.genInterfaceCurrent` (in `Sources/Modelica/TestSCRX.mo`)

This experiment packages GENROU + SCRXwInitAsInput + PwPin2PF and outputs injected current magnitude (`imag`, kA) and angle (`iang`, rad) rather than active/reactive power. It is not cited in the paper (Pattern B uses the P/Q interface, `genInterfacePQ.fmu`). It may be useful background work or a candidate for a future coupling pattern.

**Question for team:** Is `genInterfaceCurrent` intended for future work or can it be removed? If kept, should it be documented in the README?

---

## No action needed

- `Sources/FMUs/` — Pre-compiled FMUs are intentional repo artifacts (reproducibility). The `.gitignore` does not exclude `.fmu` files, which is correct.
- `PowerFactoryFMI_Tutorial.pdf` — Core deliverable; keep.
- `.gitignore` — Well-curated Modelica/Dymola ignore list; no changes needed.
