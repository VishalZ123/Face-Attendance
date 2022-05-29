# Face-Attendance
Face Attendance App for Microsoft Engage 2022

## Setup Flutter Frontend
- Make sure you have the Flutter SDK installed on your PC. If not you can install it from here - [Flutter Install](https://docs.flutter.dev/get-started/install?gclid=CjwKCAjws8yUBhA1EiwAi_tpERasP7zGkx56vkgkQyofqJOX8KYs0ujEts63QFI-bi-g7WrgLbKHcBoCxkEQAvD_BwE&gclsrc=aw.ds).
- After flutter is succesfully setup. Go to `frontend/face_attendance/`.
- Open you terminal and run `ipconfig` command. this should give you the IPv4 Address,<br />
`Wireless LAN adapter Wi-Fi:`<br />. <br />. <br />`IPv4 Address. . . . . . . . . . . : xxx.xxx.xxx.xxx`
- Replace the keyword - `IP_ADDRESS` in the folowing locations in the project with your IPv4 Address.
  - `lib\attendance\attendancesheet.dart` - Line 115 - `      'http://IP_ADDRESS:8000/attendance/get-attendance/';`
  - `lib\auth\login.dart` - Line 200 - `String url = 'http://IP_ADDRESS:8000/users/login/';`
  - `lib\dashboard\student_list.dart` - Line 79 - `  String url = 'http://IP_ADDRESS:8000/attendance/get-students/';`
  - `lib\dashboard\teacher.dart` - Line 57 - `'http://IP_ADDRESS:8000/attendance/mark-attendance/',`
  - `lib\auth\signup.dart` - Line 354 - String url = `'http://IP_ADDRESS:8000/users/signup/';`
  - `lib\main.dart` - Line 26 - `link:'http://IP_ADDRESS:8000/attendance/submit-face/',`

- Connect an Android phone using USB, make sure you have **USB Debugging On** on your phone. (Since you need to scan your face, it can't be done on a Virtual Emulator, thus a phone is required.)
- If you have an IDE (such as VS Code or Android Studio), you can run it from the Run Button. Alternatively you can run it using the <br />`flutter run -d "device name or id"` command.

## Setup for Backend
- Python version 3.9 is required.
- Open terminal at `/Face-Attendance/backend/`.
- Run `pipenv shell`.
- Install the required dependencies using the `pip install -r requirements.txt` command.
- Open the terminal > Run `python` <br />
- and then run the following-<br />
`from django.utils.crypto import get_random_string`
<br />`chars = 'abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)'`<br />`get_random_string(50, chars)`<br />
<br />Make a `.env` file with- <br />
`SECRET_KEY = the secret key generated above`<br>
`DEBUG=True`
- Run `python manage.py makemigrations`
- Run `python manage.py migrate --run-syncdb`
- Then run, `python manage.py runserver 0.0.0.0:8000`.
<br />
The server should start running.
