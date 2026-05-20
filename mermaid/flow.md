%% C.R.A.F.T. Framework — Simple Workflow
%% Clarify -> Record -> Assemble -> Forge -> Test & Tune
flowchart TD

    START([Idea]):::se

    C1["① CLARIFY<br/>Interviewer"]:::stage
    C2["② RECORD<br/>Strategist"]:::stage
    C3["③ ASSEMBLE<br/>Planner"]:::stage
    C4["④ FORGE<br/>Builder"]:::stage
    C5["⑤ TEST &amp; TUNE<br/>Reviewer"]:::stage

    G1{Approve?}:::gate
    G2{Approve?}:::gate
    G3{Approve?}:::gate
    G4{Review OK?}:::gate
    G5{Ship?}:::gate

    SHIP([Ship]):::se
    SUP[("Memory + Skills<br/>support every stage")]:::sup

    %% main flow — artifacts move along the arrows
    START --> C1
    C1 -->|"Brief"| G1
    G1 -->|"yes"| C2
    G1 -.->|"revise"| C1
    C2 -->|"Spec"| G2
    G2 -->|"yes"| C3
    G2 -.->|"revise"| C2
    C3 -->|"Plan + Tasks"| G3
    G3 -->|"yes"| C4
    G3 -.->|"revise"| C3
    C4 -->|"Artifacts"| G4
    G4 -->|"yes"| C5
    G4 -.->|"fix"| C4
    C5 -->|"Review Report"| G5
    G5 ==>|"PASS"| SHIP
    G5 -.->|"loop back to refine"| C1

    %% supporting layer
    SUP -.-> C1 & C2 & C3 & C4 & C5

    classDef se    fill:#1e293b,stroke:#0f172a,color:#ffffff,font-weight:bold
    classDef stage fill:#dbeafe,stroke:#2563eb,color:#1e3a8a,font-weight:bold
    classDef gate  fill:#fee2e2,stroke:#dc2626,color:#7f1d1d,font-weight:bold
    classDef sup   fill:#dcfce7,stroke:#16a34a,color:#14532d
