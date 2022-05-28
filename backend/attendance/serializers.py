from rest_framework import serializers

from users.models import CustomUser
from .models import Attendance

class AttendanceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Attendance
        fields = ['dateTime']

class StudentSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['username']