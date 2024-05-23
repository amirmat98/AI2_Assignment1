# README: AI Course Assignment - Coffee Making - Amirmahdi Matin 5884715
# Description
[Università degli studi di Genova](https://unige.it/en/ "University of Genova")

[ARTIFICIAL INTELLIGENCE FOR ROBOTICS II](https://corsi.unige.it/en/off.f/2023/ins/66544)

Professor: [Fulvio Mastrogiovanni](fulvio.mastrogiovanni@unige.it "Fulvio Mastrogiovanni")

Student: [AmirMahdi Matin](https://github.com/amirmat98 "AmirMahdi Matin")  - 5884715 - Robotics Engineering

## This the test Branch

# Table of Content
- [Context](#Context)
- [Scenario](#Scenario)
   - [Steps for Making Coffee](#steps-for-making-coffee)
- [PDDL Domain and Problem](#pddl-domain-and-problem)
   - [Domain](#Domain)
   - [Problem](#Problem)
- [Running](#Running)
   - [Running via Terminal](#Running-via-Terminal)
   - [Running via Vscode](#Running-via-Vscode)
- [Output](#Output)

## Context

In a context of home assistance for elderly people, a next-generation domestic assistant robot, named AR-1, is designed to perform a series of household tasks, including meal preparation and general kitchen work. Equipped with a flexible structure and a wide range of advanced sensors (including cameras, tactile and pressure sensors, temperature sensors), AR-1 can operate partially autonomously within the home environment, of which it has a 3D mapping obtained during an initial calibration phase.

This project focuses on AR-1's capability to make coffee using an Italian moka machine in the kitchen. The process involves several steps, each utilizing AR-1's various skills.

## Scenario

### Steps for Making Coffee

1. **Prepare Ingredients:** 
   - Gather coffee beans or ground coffee, filtered water, and optionally sugar or milk. The ingredients are located in various parts of the kitchen.
   - Skills: pick-up, put-down, open and close cabinets/closets, open and close containers, operate kitchen appliances.

2. **Grind Coffee (if using coffee beans):**
   - Pour coffee beans into the grinder and operate the grinder.
   - Skills: manipulate objects, operate grinder.

3. **Fill Water Reservoir:**
   - Unscrew the top part of the moka kettle and fill the bottom reservoir with filtered water.
   - Skills: manipulate moka kettle, pour water.

4. **Insert Filter and Coffee:**
   - Place the filter basket into the bottom chamber of the moka kettle, add ground coffee, distribute it evenly, and level it off with a tool.
   - Skills: extract and level ground coffee, fill filter basket.

5. **Assemble Moka Pot and Heat:**
   - Screw the top portion of the moka kettle onto the bottom reservoir and place the moka kettle on the stovetop burner set to medium heat.
   - Skills: manipulate moka kettle, operate stovetop burner.

6. **Serve:**
   - Unscrew the top portion of the moka kettle and pour the freshly brewed coffee into mugs or mugs.
   - Skills: manipulate moka kettle, pour liquids.

## PDDL Domain and Problem

### Domain: `domain.pddl`

The `domain.pddl` file defines the actions that AR-1 can perform, the objects it can interact with, and the preconditions and effects of each action. The actions include picking up items, grinding coffee, filling the water reservoir, inserting the filter and coffee, assembling the moka kettle, heating it, and serving the coffee.

### Problem: `problem.pddl`

The `problem.pddl` file specifies the initial state of the kitchen, the place of ingredients, and the goal state where the coffee is prepared and served. This file defines a specific scenario for AR-1 to execute, ensuring that all necessary steps are performed in sequence.

## Running

To generate and execute the plan for making coffee, we use the LPG-td (Local search for Planning Graphs - temporary goals) planner. Here’s how you can run the planner with the provided PDDL files.

### Run via Terminal

1. **Download and Install LPG-td:**
   - You can download the LPG-td planner from [LPG-td official site](http://lpg.unibs.it/).
   - Follow the installation instructions provided on the site.

2. **Prepare Your Files:**
   - Place the `domain.pddl` and `problem.pddl` files in the same directory.

3. **Run the Planner:**
   - Open a terminal and navigate to the directory containing the PDDL files.
   - Execute the following command:
     ```bash
     ./lpg-td -o domain.pddl -f problem.pddl
     ```
   - The planner will output a sequence of actions that AR-1 can follow to make coffee.

### Run via Vscode

You can run the planner using the lpg++ file that is located in the folder. In order to do this, you need to install 'PDDL' extension in vscode and configure this extension with lpg++ file as planning engine.

## Output

You can see the output of the this PDDL as a plan in directory. Moreover here is the link of the [Plan report.html](https://htmlpreview.github.io/?https://github.com/amirmat98/AI2_Assignment1/blob/main/Plan%20report.html)

