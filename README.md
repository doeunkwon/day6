# Monte Carlo Poker Odds Calculator

**Poker Texas Holdem Odds Calculator** is a simple iOS app that calculates your odds of winning in Texas Hold'em poker. I built this as a fun day project to practice **Unit Testing** and **UICollectionViews**, and to implement a Monte Carlo simulation for calculating poker hand odds. The app offers a clean interface for selecting your hole cards and community cards, and then calculates your odds of success.

## How the App Works
The way this app works is incredibly simple:
- You're presented with a grid of cards, neatly organized in 4 columns, each representing a suit (♠️, ♥️, ♦️, ♣️), and arranged in descending order from 2 to Ace.
- **Select your two hole cards**: The first two cards you select will glow with a blue border to signify that they are your hole cards.
- **Select 3 to 5 community cards**: These are your flop, turn, and river cards. Community cards will have a red border.
- Once you've selected all your cards, tap the **"get odds"** button, and the app will calculate and display your odds of success.

https://github.com/user-attachments/assets/93658cca-e1e8-417f-b089-f371565bfb0d

https://github.com/user-attachments/assets/48333198-e971-4927-843f-8aba48ca21af

The app uses a **Monte Carlo simulation** to estimate your odds, a technique that simulates thousands of random poker hands to provide a statistically accurate result.

## Monte Carlo Simulation
Monte Carlo simulations are a statistical technique used to model and predict outcomes by running random simulations repeatedly. In the context of this app, Monte Carlo is used to simulate random hands for your opponents and possible outcomes for the remaining cards. Based on these simulations, the app calculates the probability of your hand being the strongest.

By running a large number of simulations (in this case, 100,000+), the app provides a reliable estimate of your odds of success in a poker game.

## Features
- **Unit Testing**: I focused on testing the functions that determine the strength of hands, ensuring accurate odds calculation.
- **UICollectionView**: The app uses a clean and responsive UICollectionView to display the cards in a grid, allowing you to easily select your hole and community cards.
- **Monte Carlo Simulation**: The core of the app's functionality, providing statistically accurate odds of success by simulating thousands of random poker hands.
- **Visual Selection Feedback**: Hole cards are highlighted with a blue border, and community cards with a green border, making it clear which cards you've selected.
- **Simple Interface**: The app’s UI is clean and intuitive, making it easy to select cards and calculate your odds with a single tap.

## How to Run the App
1. Download and install [Xcode](https://developer.apple.com/xcode/).
2. Clone this repository:
   ```bash
   git clone https://github.com/doeunkwon/day6.git
3. Open the project in Xcode:
   ```bash
   open day4.xcodeproj
4. Select your preferred iOS Simulator or connect your physical iOS device.
5. Build and run the app using the play button in Xcode.
