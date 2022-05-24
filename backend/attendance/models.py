from django.db import models
from users.models import CustomUser
# from django.contrib.postgres.fields import ArrayField
# Create your models here.

class AttendanceManager(models.Manager):
    def create_attendance(self, student, time, is_present):
        attendance = self.create(student=student, time=time, is_present=is_present)
        return attendance

class FaceManager(models.Manager):
    def save_face(self, student, face_encoding):
        face = self.create(student=student, face_encoding=face_encoding)
        return face

class Attendance(models.Model):
    student = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    time = models.DateField(auto_now_add=True)
    is_present = models.BooleanField(default=False)
    objects = AttendanceManager()

class Faces(models.Model):
    student = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    face_encoding = models.BinaryField()
    objects = FaceManager()