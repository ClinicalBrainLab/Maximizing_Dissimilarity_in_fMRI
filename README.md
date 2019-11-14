# Maximizing_Dissimilarity_in_fMRI
Please Refer to our paper for details.
Kashyap et al, (2019)- Maximizing Dissimilarity in Resting State detects Heterogeneous Subtypes in Healthy population associated with High Substance-Use and Problems in Antisocial Personality. Human Brain Mapping

In this work- We developed a strategy to classify subjects whose resting state pattern is most dissimilar in a large dataset of healthy individuals
For this- We use multisession (or multirun) resting state fMRI data of 788 subjects from the Human Connectome Project

## Algorithm Development strategy
(1) We use Common and orthogonal Basis Extraction (Technique) to extract the common COBE component of every Subject
(2) COBE is an Tensor decomposition Technique that runs on multi-session data and gives an output matrix that is shared by all the sessions
(3) The common COBE Component of a subject can be cosidered as the signature of an indivdual's resting state (since it is present in all sessions)
(4) We correlate the Common COBE component of all the subjects to obtain the COBE Correlation Matrix
(5) We then classify those subjects whose correlation with all other subjects is lowest across the group. We name this group as MCD (Maximal COBE Dissimilarity)
(6) Subsequently remaining Subjects form the COBE Similarity (CS) Group

## Results
(1) The two groups were different in their "strength of activation" (determined by Common COBE component weights) in Default Mode Network- particularly in Posterior Cingulate gyrus
(2) We then compare the scores of 68 Behavioural Measures between the two groups (MCD and CS)
    We found MCD group to consume higher amount of (i) Marijuana, (ii) Illicit drugs (Cocaine, hallucinogen, etc), (iii) Alcohol, (iv)Tobacco; and (v) to show higher traits of antisocial personality disorder
    
## Impact
Neuroimaging based Comparison studies that recruit healthy subjects pays due weightage to factors like AGE, SEX, BMI of an individual.
However, factors like substance use, psychological deficits are often ignored. Very less attention is paid to the "psyche" of a healthy 
person or the factors that can influence the resting state scans.
We show the impact these factors have in shaping the resting state pattern of healthy indivuals (as well). When the scans of these
healthy individuals are considered in the groug for comparison with patients, they can lead to erroneous conclusion.
     

