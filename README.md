# City Weather

#### Project Description:

This is a Flutter app that retrieves weather data from an API simulating weather conditions for multiple cities. The main screen displays the names, temperatures, and descriptions of the cities. Users can click on the **Edit** button to modify a city's information, delete a city, or add a new one using the **+** button.

The project follows the **Bloc** state management pattern and adheres to **Clean Code** and **SOLID principles**, ensuring maintainability and scalability.

#### Key Features:

- **City Weather Information**: Displays real-time weather data, including the name, temperature, and description of multiple cities.
- **City Edit Functionality**: Allows users to edit the weather data for a specific city.
- **City Deletion**: Users can delete cities from their list.
- **Add New City**: Users can easily add new cities to their list by clicking on the **+** button located on the main screen.
- **State Management with Bloc/Cubit**: Utilizes the Bloc pattern for efficient state management.
- **Clean Code Principles**: Follows Clean Code practices for maintainability and readability.
- **SOLID Principles**: Adheres to SOLID principles to ensure robust and scalable architecture.

#### Home Page

The home page displays a list of cities with their corresponding weather data. The UI is interactive, allowing users to:

- **Edit**: Click the **Edit** button to modify a city's information.
- **Delete**: Remove a city from the list by clicking the **Trash** button.
- **Add New City**: A **+** button allows users to add a new city to the list, streamlining the process of customizing their weather information display.

The buttons are visually placed for intuitive navigation and a smooth user experience, with clear separation of each action (edit, delete, add) for ease of use.

<img src="https://github.com/user-attachments/assets/d50a94ad-b9cf-46e2-a1b3-30b70f5b95b8" width="300" />

---

#### Delete Confirmation
<img src="https://github.com/user-attachments/assets/3ee98016-dd2d-4cf4-bd74-d9b54e884e6b" width="300" />

---

#### Edit Page
<img src="https://github.com/user-attachments/assets/a8f67704-ad3a-4e1a-8b10-c510bae28f6a" width="300" />

---

#### Create Page

On this page, you can add a new weather entry for any city by filling in the details below:

- **City Name**: Enter the name of the city you'd like to add.
- **Temperature**: Enter the current temperature for the city.  
- **Description**: Add a brief description of the weather conditions (e.g., sunny, rainy, cloudy, etc.).

Once you’ve filled in the details, click the **Create** button to save the new weather entry.

Alternatively, if you're feeling adventurous, click the **Random City** button to generate a random city with weather data, which you can then edit if you wish!

<img src="https://github.com/user-attachments/assets/da8de7ff-9b6c-4b26-9cde-12a80ff73368" width="300" />

---

### Handling Errors

Sometimes, things don't go as planned. In case of an error, the screen will display the following:

<img src="https://github.com/user-attachments/assets/a1bc92f1-676a-4089-b065-579b253dccc4" width="300" />

#### Error Message:

You can click the **Try Again** button to reload the data. If you'd like to see more details about the error, click the **Show Details** button below to view additional information.

- **Try Again**: Click this button to attempt to retrieve the data once more.
- **Show/Hide Details**: Click this text button to toggle the visibility of more detailed error information.

---


#### Getting Started

### Prerequisites
The app has been tested on Android using VS Code.

Before setting up the project, ensure you have the following installed on your development machine:

- Flutter SDK 3.24.1
- Dart SDK 3.5.1
- Git (to clone the repository)

### Flutter and Dart Versions
Make sure you have Flutter SDK version 3.24.1 and Dart SDK version 3.5.1 installed. You can check the versions by running the following commands:

```
flutter --version
```

If the Flutter or Dart version is different, you can download and install the specific versions using the Flutter SDK manager or by visiting the Flutter and Dart websites.


### Clone the Repository

To get started with the project, you first need to clone the repository to your local machine. Follow the steps below:

1. Open a terminal or command prompt on your machine.
2. Run the following command to clone the repository:

    ```bash
    git clone https://github.com/joaoconstancio1/city_weather.git
    ```

3. Navigate into the project directory:

    ```bash
    cd city_weather
    ```

Now you have a local copy of the project and you can start working with it!


### Get Dependencies
After cloning the repository and ensuring you have the correct Flutter and Dart versions installed, you need to get the project dependencies. Run the following command in the project root directory:

```
flutter pub get
```

---

### Coverage

To check the code coverage for this project, follow the steps below:

1. Ensure that `lcov` is installed on your system.

2. Run the following command to generate a code coverage report:

    ```bash
    ./tools/coverage.sh
    ```

This will execute the script located in the `tools` folder, generating a detailed coverage report that shows the percentage of your code covered by tests. You can use this report to identify which parts of your code are well-tested and which may require additional tests.


**Note for Windows Users:**
If you are on a Windows system, it is strongly recommended to use Git Bash to run this script. This ensures compatibility and prevents potential issues with script execution.

---

### Final Considerations

Thank you for exploring this project! We hope you found the implementation of the City Weather app useful and that it helps you better understand Flutter development, state management with Bloc, and Clean Code principles. If you have any questions or need assistance, feel free to reach out. Happy coding!





