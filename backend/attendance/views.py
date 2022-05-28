from django.utils import timezone
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from .serializers import AttendanceSerializer, StudentSerializer
from .models import Attendance, Faces
from users.models import CustomUser
from rest_framework.permissions import AllowAny
from rest_framework.status import HTTP_200_OK, HTTP_400_BAD_REQUEST
from django.db import IntegrityError
from django.forms import ValidationError
import face_recognition, pickle, pybase64
import cv2

# @api_view(['POST'])
# @permission_classes((AllowAny,))
# def mark_attendance(request):
#     username = request.data.get("username")
#     if username is None:
#         return Response({'error': 'Please provide username'}, status=HTTP_400_BAD_REQUEST)
#     user = CustomUser.objects.get(username=username)

#     try:
#         att = Attendance.objects.get(student=user)
#         if att.time == datetime.date.today():
#             return Response({'error': 'Already Marked'}, status=HTTP_400_BAD_REQUEST)
#     except Attendance.DoesNotExist:
#         pass

#     image = request.FILES.get("image")
#     if image is None:
#         return Response({'error': 'Please provide image'}, status=HTTP_400_BAD_REQUEST)
    
#     loaded = face_recognition.load_image_file(image)
#     face_locations = face_recognition.face_locations(loaded)
#     np_array = face_recognition.face_encodings(loaded, face_locations)[0]
#     saved_encoding = Faces.objects.get(student=user).face_encoding
#     np_bytes = pybase64.b64decode(saved_encoding)
#     known_face_encodings = pickle.loads(np_bytes)
#     print(face_recognition.compare_faces([known_face_encodings], np_array, tolerance=0.5))
#     if face_recognition.compare_faces([known_face_encodings], np_array, tolerance=0.5)[0]:
#         try:
#             attendance = Attendance.objects.create_attendance(student=user, time=datetime.date.today(), is_present=True)
#             attendance.save()
#             return Response({"status":"Attendance marked"},status=HTTP_200_OK)
#         except IntegrityError:
#             return Response({'error': 'Already marked'}, status=HTTP_400_BAD_REQUEST)
#     else:
#         return Response({'error': 'Faces does not match'}, status=HTTP_400_BAD_REQUEST)

@api_view(['Post'])
@permission_classes((AllowAny,))
def get_attendance(request):
    username = request.headers.get("username")
    print(username)
    if username is None:
        return Response({'error': 'Please provide username'}, status=HTTP_400_BAD_REQUEST)
    
    user = CustomUser.objects.get(username=username)
    
    if not user:
        return Response({'error': 'Invalid username'}, status=HTTP_400_BAD_REQUEST)
    try:
        attendance = Attendance.objects.filter(student=user)
        serializer = AttendanceSerializer(attendance, many=True)
        return Response(serializer.data, status=HTTP_200_OK)
    except Exception as e:
        raise ValidationError({"400": f'{str(e)}'})


@api_view(['Post'])
@permission_classes((AllowAny,))
def submit_face(request):
    token = request.headers.get("Token")
    if token is None:
        return Response({'error': 'Please provide token'}, status=HTTP_400_BAD_REQUEST)
    user = Token.objects.get(key=token).user

    image = request.FILES.get("image")
    if image is None:
        return Response({'error': 'Please provide image'}, status=HTTP_400_BAD_REQUEST)
    
    try:
        loaded_img = face_recognition.load_image_file(image)
        loaded_img2 = cv2.rotate(loaded_img, cv2.cv2.ROTATE_90_COUNTERCLOCKWISE)
        loaded_img3 = cv2.rotate(loaded_img, cv2.cv2.ROTATE_90_CLOCKWISE)
        if(len(face_recognition.face_locations(loaded_img))!=0):
            face_locations = face_recognition.face_locations(loaded_img)
            np_array = face_recognition.face_encodings(loaded_img, face_locations)[0]
        elif(len(face_recognition.face_locations(loaded_img2))!=0):
            face_locations = face_recognition.face_locations(loaded_img2)
            np_array = face_recognition.face_encodings(loaded_img2, face_locations)[0]
        elif(len(face_recognition.face_locations(loaded_img3))!=0):
            face_locations = face_recognition.face_locations(loaded_img3)
            np_array = face_recognition.face_encodings(loaded_img3, face_locations)[0]
        else:
            return Response({'error': 'No face found'}, status=HTTP_400_BAD_REQUEST)

        np_bytes = pickle.dumps(np_array)
        face_encoding = pybase64.b64encode(np_bytes)
        face = Faces.objects.save_face(student=user, face_encoding=face_encoding)
        face.save()

        return Response({'message': 'Face submitted Succesfully!!'}, status=HTTP_200_OK)
    except Exception as e:
        print('error')
        return Response({'error': 'Something went wrong, please try again'}, status=HTTP_400_BAD_REQUEST)
        

@api_view(['Post'])
@permission_classes((AllowAny,))
def mark_attendance(request):
    image = request.FILES.get("image")
    if image is None:
        return Response({'error': 'Please provide image'}, status=HTTP_400_BAD_REQUEST)
    try:
        loaded_img = face_recognition.load_image_file(image)
        loaded_img2 = cv2.rotate(loaded_img, cv2.cv2.ROTATE_90_COUNTERCLOCKWISE)
        loaded_img3 = cv2.rotate(loaded_img, cv2.cv2.ROTATE_90_CLOCKWISE)
        if(len(face_recognition.face_locations(loaded_img))!=0):
            face_locations = face_recognition.face_locations(loaded_img)
            np_array = face_recognition.face_encodings(loaded_img, face_locations)[0]
        elif(len(face_recognition.face_locations(loaded_img2))!=0):
            face_locations = face_recognition.face_locations(loaded_img2)
            np_array = face_recognition.face_encodings(loaded_img2, face_locations)[0]
        elif(len(face_recognition.face_locations(loaded_img3))!=0):
            face_locations = face_recognition.face_locations(loaded_img3)
            np_array = face_recognition.face_encodings(loaded_img3, face_locations)[0]
        else:
            return Response({'error': 'No face found'}, status=HTTP_400_BAD_REQUEST)

        for face in Faces.objects.all():
            saved_encoding = face.face_encoding
            np_bytes = pybase64.b64decode(saved_encoding)
            known_face_encodings = pickle.loads(np_bytes)
            if face_recognition.compare_faces([known_face_encodings], np_array, tolerance=0.5)[0]:
                try:
                    att = Attendance.objects.get(student=face.student)
                    if att.dateTime.date() == timezone.now().date():
                        return Response({'error': 'Already Marked for Today', 'user':face.student.username}, status=HTTP_400_BAD_REQUEST)
                except Attendance.DoesNotExist:
                    pass

                try:
                    attendance = Attendance.objects.create_attendance(student=face.student, dateTime=timezone.now(), is_present=True)
                    attendance.save()
                    return Response({"message":"Attendance marked", "user":face.student.username},status=HTTP_200_OK)
                except IntegrityError:
                    return Response({'error': 'Error in marking attendance, please try again!!'}, status=HTTP_400_BAD_REQUEST)
        return Response({'error': 'Faces does not match'}, status=HTTP_400_BAD_REQUEST)
    except Exception as e:
        return Response({'error': 'Something went wrong, please try again'}, status=HTTP_400_BAD_REQUEST)

@api_view(['GET'])
@permission_classes((AllowAny,))
def get_students(request):
    try:
        students = CustomUser.objects.all().filter(is_student=True)
        serializer = StudentSerializer(students, many=True)
        return Response(serializer.data, status=HTTP_200_OK)
    except Exception as e:
        return Response({'error': 'Something went wrong'}, status=HTTP_400_BAD_REQUEST)
