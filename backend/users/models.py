  
from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager

   
class CustomUserManager(BaseUserManager): # CustomUserManager
    def create_user(self, username, email, password, is_teacher, is_student):
        if not email:
            raise ValueError("Users must have an email address")
        user = self.model(
            username=username,
            email=self.normalize_email(email),
            is_teacher=is_teacher,
            is_student=is_student,
        )
        user.set_password(password)
        user.save(using=self._db)
        return user
    
    def create_superuser(self, username, email, password, is_teacher=True, is_student=False):
        user = self.create_user(
            username=username,
            email=email,
            password=password,
            is_teacher=is_teacher,
            is_student=is_student,
        )
        user.is_admin = True
        user.is_staff = True
        user.is_superuser = True
        user.save(using=self._db)
        return user 
        
class CustomUser(AbstractBaseUser):  # A custom user model for users to be classied as teachers and students
    is_teacher = models.BooleanField(default=False)
    is_student = models.BooleanField(default=False)
    username = models.CharField(max_length=50, unique=True)
    email = models.EmailField(max_length=255, unique=True)
    password = models.CharField(max_length=255)
    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['email']
    is_staff = models.BooleanField(default=False)
    is_admin = models.BooleanField(default=False)

    objects = CustomUserManager()

    def __str__(self):
        return self.username
    
    def has_perm(self, perm, obj=None):
        return self.is_admin

    def has_module_perms(self, app_label):
        return True
    