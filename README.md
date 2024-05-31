# Poster App

## File Structure

- constants
- features
    - authentication
        - data
            - repository 
        - domain
        - presentation
            - pages
            - widgets
    - poster
        - data
            - repository 
        - domain
        - presentation
            - pages
            - widgets
- utils
- main


## Problem Statement

The Poster App aims to provide users with a platform to create personalized posters. Users should be able to perform the following actions:

1. **Signup and Login**: Users should be able to sign up and log in to the app securely.

2. **Home Screen**: Upon logging in, users should be directed to the home screen where they can see a "Generate Poster" button.

3. **Generate Poster**: Users can click on the "Generate Poster" button to proceed to the select template screen.

4. **Select Template**: On the select template screen, users can choose a template to use for their poster.

5. **Add Photo**: Users should be able to add a photo from their gallery and adjust it as needed.

6. **Merge Photo with Template**: Once the photo selection is done, the selected photo should be merged with the chosen template.

7. **Download Poster**: Users should have the option to download the merged poster.

## Usage

- Clone the repository: `git clone <repository_url>`
- Navigate to the project directory: `cd Poster-App`
- Install dependencies: `flutter pub get`
- Start the application: `flutter run`
