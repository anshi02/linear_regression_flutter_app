# Linear Regression Flutter App


A simple Flutter application for performing linear regression on CSV data. The app allows users to upload a CSV file, calculate the linear regression model, and visualize the regression line on a chart.

## Features

- Upload a CSV file with X and Y columns.
- Calculate and display the linear regression line in `y = mx + c` format.
- Visualize the data and regression line on a chart.
- User-friendly interface for easy interaction.

## Getting Started

Follow these steps to set up and run the Linear Regression Flutter App on your local machine.

### Prerequisites

- Flutter SDK installed on your machine. You can [install Flutter here](https://flutter.dev/docs/get-started/install).

### Installation
 Clone the repository:

   ```shell
   git clone https://github.com/your-username/linear-regression-flutter-app.git
```
Navigate to the project directory:
```shell
cd linear-regression-flutter-app
```
Get the dependencies:
```shell
flutter pub get
```
## Usage
Run the app:
```shell
flutter run
```
1. Open the app on an emulator or physical device.

2. Click the "Upload CSV File" button and select a CSV file with X and Y columns.

3. The app will calculate the linear regression model and display the regression line on the chart.

4. View the linear regression equation below the chart in y = mx + c format.



## How It Works
The app uses the csv package to parse the uploaded CSV file. It calculates the linear regression model based on the X and Y values in the file. The regression line is visualized on a chart using the fl_chart package.
