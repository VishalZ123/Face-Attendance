from rest_framework import serializers
from .models import CustomUser

class UserSerializer(serializers.ModelSerializer): # Serializer for the CustomUser model
    class Meta:
        model = CustomUser
        fields = ('id', 'username', 'email', 'password', 'is_teacher', 'is_student')