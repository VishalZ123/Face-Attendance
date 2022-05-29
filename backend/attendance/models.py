from django.db import models
from users.models import CustomUser
# from django.contrib.postgres.fields import ArrayField
# Create your models here.

class AttendanceManager(models.Manager): # AttendanceManager
    def create_attendance(self, student, dateTime, is_present):
        attendance = self.create(student=student, dateTime=dateTime, is_present=is_present)
        return attendance

class FaceManager(models.Manager): # FaceManager
    def save_face(self, student, face_encoding):
        face = self.create(student=student, face_encoding=face_encoding)
        return face

class Attendance(models.Model): # model for attendance
    student = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    dateTime = models.DateTimeField()
    is_present = models.BooleanField(default=False)
    objects = AttendanceManager()

class Faces(models.Model): # model for faces, face encodings are stord
    student = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    face_encoding = models.BinaryField()
    objects = FaceManager()