# URL Shortener

This is a simple URL Shortener service built as a microservice. It maps a short-form URL ("Short URL") to a user-provided target URL ("Target URL"), similar to services like bit.ly and tinyurl.com. It also provides a simple usage report for the application where it tracks the number of clicks, originating geolocation and timestamp of each visit to a Short URL.

## Deployed Application URL

You can access the deployed application at [https://url-shortener-assessment-2a1611018c4a.herokuapp.com](https://url-shortener-assessment-2a1611018c4a.herokuapp.com)

## Installation Guide

### Prerequisites

- Ruby (version 3.x)
- Rails (version 7.x)
- PostgreSQL (version 16)

### Setup

1. **Clone the repository**:
   ```sh
   git clone https://github.com/leonjensentan/url-shortener-assessment.git
   cd url-shortener
   ```

2. **Install Dependencies**
   ```sh
   bundle install
   ```

3. **Set up the database:**
   Make sure you have PostgreSQL installed and running. Then run:
   ```sh
   rails db:create
   rails db:migrate
   ```

4. **Run the server**
   ```sh
   rails s
   ```

5. **Visit the Application**
   Open your browser and go to http://localhost:3000

## Dependencies and Other Relevant Information
PostgreSQL : RDBMS for the web application
Geocoder : IP address geocoding
Nokogiri : DOM Parser for HTML
FactoryBot : For Test Data
TailWind CSS : CSS framework for rapid UI development

## Tests
To run the tests, use the following command:
   ```sh
   bundle exec rspec
   ```
