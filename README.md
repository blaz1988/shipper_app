
# ShipperApp

## Overview

ShipperApp is a Ruby on Rails application designed for managing bids on delivery routes. It allows carriers to submit bids for transporting goods while providing an easy-to-use interface for managing and viewing those bids. 

### Technologies Used

- Ruby 3.1.2
- Rails 7.1.4.2
- Turbo and Stimulus for frontend solutions

## Setup

To get the application up and running locally, follow these steps:

1. Clone the repository:
   ```bash
   git clone git@github.com:your_username/downhome.git
   cd downhome
   ```

2. Install the required gems:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rake db:create
   rake db:migrate
   rake db:seed
   ```

4. Start the Rails server:
   ```bash
   rails s
   ```

5. Run tests using RSpec:
   ```bash
   rspec
   ```

## High-Level Architecture

The application follows a modular architecture where different components are separated for better maintainability and scalability. 

### Key Components

- **Controllers**: Handle incoming requests and manage the flow of data to and from the models. They process user inputs and prepare data for views.

- **Models**: Represent the core business logic and interact with the database. Models define the structure of the data, validation rules, and relationships between different data entities.

- **FetchResults Module**: This module encapsulates the logic for retrieving bids based on the carrier's name. It consists of an entry point that initializes the action and manages the process of fetching bids.

- **SubmitBid Module**: Responsible for creating or updating bids based on user input. It handles the logic for determining whether a bid is winning and manages database transactions to ensure data integrity.

### Frontend

The application uses Turbo and Stimulus for minimal JavaScript usage, enhancing user experience by providing fast, interactive features without complex JavaScript frameworks.

### Database Schema

The application uses a PostgreSQL database with the following key entities:
- **Carriers**: Represents the carriers submitting bids.
- **Bids**: Contains information about bids including price, associated carrier, route, and load type.
- **Routes**: Represents the delivery routes available in the system.
- **Load Types**: Defines the different types of loads that can be transported.

### Screenshots
![image](https://github.com/user-attachments/assets/ccf5b993-1bfe-401c-8d02-0b165f691357)

![image](https://github.com/user-attachments/assets/f13b64a9-b574-4f95-b433-64413d05df62)

![image](https://github.com/user-attachments/assets/02521f37-f1c9-4995-9466-5b35e3ad5722)



## Contributing

If you would like to contribute to the project, please fork the repository and create a pull request with your changes.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
