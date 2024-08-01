# EEG Seizure Detection Using CNN

**EEG Seizure Detection Using Convolutional Neural Networks**

## Overview

This repository contains the work from my thesis on detecting epileptic seizures using EEG signals with Convolutional Neural Networks (CNN). The goal is to leverage deep learning techniques to improve the accuracy and reliability of seizure detection, providing valuable insights and tools for medical diagnosis and treatment.

## Abstract

Epilepsy is a chronic disorder of the central nervous system that disrupts normal function and leads to recurrent seizures. During epileptic seizures, temporary abnormalities in the brain's electrical activity occur, which can cause various symptoms such as loss of attention and memory, sensory variations, or even spasms throughout the body. In many cases, the use of antiepileptic drugs is not sufficient to control seizures, posing a serious risk of injury, limiting independence and mobility, and negatively affecting individuals' social and economic well-being. Electroencephalogram (EEG) is commonly used for epilepsy diagnosis, detecting small abnormalities called epileptic discharges that aid in identifying the problem.

This thesis explores techniques for detecting the onset of seizures from EEG data, with a particular focus on developing a Convolutional Neural Network (CNN) model. The data used in this study are sourced from the research published by Andrzejak, Ralph G., and colleagues in 2001. The data categories include recordings from normal volunteers with eyes open and closed, as well as recordings from patients with epilepsy, both seizure-free and during seizures. These data provide an opportunity to explore the development of machine learning models for predicting the onset of epileptic discharges from EEG signals.

## Table of Contents

- [Introduction](#introduction)
- [Technologies](#technologies)
- [Setup](#setup)
- [Usage](#usage)
- [Files](#files)
- [Results](#results)
- [Future Work](#future-work)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Introduction

This project focuses on detecting epileptic seizures using EEG signals and Convolutional Neural Networks (CNN). The work is based on my thesis from Aristotle University of Thessaloniki (AUTH), where I graduated with a degree in Computer Science in 2024. The aim is to leverage deep learning techniques to enhance the accuracy and reliability of seizure detection, contributing valuable insights and tools for medical diagnosis and treatment.

## Technologies

- Python
- MATLAB
- Convolutional Neural Networks (CNN)
- EEG Data Analysis

## Setup

1. Clone the repository:
    ```bash
    git clone https://github.com/tfysekis/EEG-Seizure-Detection-Using-CNN.git
    ```
2. Navigate to the project directory:
    ```bash
    cd EEG-Seizure-Detection-Using-CNN
    ```
3. Open the files with Matlab

4. Run the program in the terminal:
    ```bash
    main
    ```

## Usage

- Prepare the EEG data by running `prepareEEGData.m`.
- Load the EEG data using `loadEEGData.m`.
- Train the CNN model using `trainSPN.m`.
- Evaluate the model performance using `plotConfusionMatrix.m`.
- Main script to execute the project is `main.m`.

## Files

- **EEG Seizure Detection Analysis.pdf**: Detailed analysis and results of the study.
- **createSPN.m**: Script to create the Signal Processing Network.
- **loadEEGData.m**: Script to load EEG data.
- **main.m**: Main script to run the project.
- **plotConfusionMatrix.m**: Script to plot confusion matrix.
- **prepareEEGData.m**: Script to prepare EEG data.
- **trainSPN.m**: Script to train the Signal Processing Network.

## Results

The CNN model achieved an accuracy of 90% in classifying EEG signals into categories such as Normal, Pre-seizure, and Seizure. The model was selected for its balanced performance and avoidance of overfitting. The detailed performance metrics, including precision, recall, and F1 score, can be found in the EEG Seizure Detection Analysis.pdf file.

## Future Work

1. Expand Data Sets: Incorporate larger and more diverse datasets to improve the model's performance and generalizability.
2. Improve Architecture: Experiment with advanced neural network architectures like LSTM and Transformer models to enhance the analysis and classification of EEG signals.
3. Transfer Learning: Apply transfer learning techniques to leverage pre-trained models for faster and more efficient training.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

Fysekis Thomas  
Computer Science,  
Aristotle University of Thessaloniki, Greece  
[GitHub](https://github.com/tfysekis)
