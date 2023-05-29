# Face Attendance App
[Demo Video](https://drive.google.com/file/d/16cFz_3BBOGVZPqIljW6sLXXThCJJZwMO/view?usp=share_link)

The project was build for Microsoft Engage Program 2022. This is a Face Attendance App that uses face recognition for marking students' attendance.<br />

**Features :-**
 - There are two types of users i.e. Teachers and Students.
 - Students have to submit the picture of thir face during signup.
 - The information of the face corresponding to a student is stored in the form of face encodings.
 - To mark the attendance, the student has to scan his face using a teacher's device.
 - The face encoding from the scanned face and stored encoding are then compared.
 - On successful matching, the student's attendance is marked for the day.
 - The teacher can view the attendance of all the students.
 - The students can view their attendance.

*Addition Information* <br />
The API for comparing faces is build using [face_recognition](https://github.com/ageitgey/face_recognition) python library.
## Table of Contents
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Getting Started
### Prerequisites

- Flutter [link to Flutter installation guide](https://flutter.dev/docs/get-started/install)
- Django [link to Django installation guide](https://docs.djangoproject.com/en/stable/intro/install/)

### Installation

1. Clone the repository

   ```bash
   git clone https://github.com/VishalZ123/Face-Attendance.git
   ```

2. **Frontend Setup**
  - Navigate to the frontend directory

    ```bash
    cd frontend/face_attendance
    ```
  - Install the dependencies
    ```bash
    flutter pub get
    ```
  - After your Backend is running, paste `localhost:port` or your IP Address (if USB Debugging) in the [constants.dart](./frontend/face_attendance/lib/constants.dart) file.
    ```dart
    const String BASE_URL = 'localhost:8000';
    ```
3. **Backend Setup**
  - Navigate to the backend directory

    ```bash
    cd backend
    ```
  - Create and activate a virtual environment (recommended)
    ```bash
    python -m venv venv
    source venv/bin/activate
    ```
  - Install the dependencies
    ```bash
    pip install -r requirements.txt
    ```
  - Run the migrations
    ```bash
    python manage.py makemigrations
    ```
  - Run the migrations
    ```bash
    python manage.py migrate
    ```
  - Create a superuser
    ```bash
    python manage.py createsuperuser
    ```
  - Copy .env.example to .env
    ```bash
    copy .env.example .env
    ```
  - Edit the .env file and add the required values (SECRET_KEY & DEBUG)manage.py runserver

## Usage

- Run the server

  ```bash
  python manage.py runserver
  ```

- Run the app
  ```bash
  flutter run
  ```
## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](https://choosealicense.com/licenses/mit/)
