# Model Import Tutorial using Modelica, FMI and PowerFactory

[![DOI](https://zenodo.org/badge/1068483966.svg)](https://doi.org/10.5281/zenodo.19859079)

Provides a tutorial on how to build and export models developed in a Modelica tool and import them into PowerFactory.

## **📖 Tutorial Overview**

This repository is designed around the visual guide `PowerFactoryFMI_Tutorial.pdf`, which provides step-by-step instructions for integrating open-source Modelica components (such as those from the OpenIPSL library) into commercial power system simulation tools.

The tutorial is split into two distinct workflows:

* **Part I: Controller-Only Coupling**  
  Demonstrates exporting an OpenIPSL SCRX excitation system from OpenModelica as an FMU and coupling it with a native PowerFactory synchronous machine using scalar AVR signals.  
* **Part II: Full-Machine Coupling**  
  Demonstrates packaging an entire machine-and-controls subsystem (GENROU \+ SCRX) into a single FMU, interfacing it into the PowerFactory grid via a voltage/power (P/Q) boundary.

## **📂 Repository Structure**

* `PowerFactoryFMI_Tutorial.pdf`: The step-by-step visual instruction guide.  
* `/Sources/FMUs/`: Pre-compiled FMI 2.0 (Model Exchange) files.  
* `/Sources/Modelica/`: OpenIPSL source files and export setups for OpenModelica.  
* `/Sources/PowerFactory/`: DIgSILENT PowerFactory (.pfd) project files containing the pre-configured grids and Composite Model Frames.

## **🚀 Getting Started**

1. **Clone the repository:** [https://github.com/ALSETLab/Modelica-FMI-PowerFactory-ModelImport-Tutorial.git](https://github.com/ALSETLab/Modelica-FMI-PowerFactory-ModelImport-Tutorial.git)

2. **Prerequisites:** Ensure you have OpenModelica (v1.22+), the OpenIPSL library, and DIgSILENT PowerFactory (2022+).  
3. **Follow the guide:** Open `PowerFactoryFMI_Tutorial.pdf` and follow the visual steps to generate FMUs from the Modelica models, import the .pfd files and link the .fmu packages. If you want to skip generating the FMUs, you can use the ones provided under `/Sources/FMUs/`.

## **📝 Citation**

The models and methodologies utilized in this tutorial are detailed in our upcoming paper, for which you can download a pre-review pre-print from [ResearchGate, here.](https://www.researchgate.net/publication/406108844_Deploying_OpenIPSL_Models_into_DIgSILENT_PowerFactory_via_FMI_Model_Exchange)

**If you use this tutorial, the models, or the workflow in your academic or professional work, please cite:**

> H. Chang and L. Vanfretti, “Deploying OpenIPSL Models into DIgSILENT PowerFactory via FMI Model Exchange,” under review, American Modelica & FMI Conference 2026, Atlanta, GA, USA, October 12–14, 2026\.

## Acknowledgement

(2025-2026) This work was supported through the [Elia Group and Energinet Research Challenge](https://www.mccs.com/en/latest-news/20250602_update-on-elia-group-energinet-research-challenge) within the project responding to Research Question 4b (How can we, in Modelica, express and design a simplified model representation from a black-box model (dll) given an interface and an accepted error tolerance?).
