from django.db import IntegrityError
from django.forms import ValidationError
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from .serializers import UserSerializer
from .models import CustomUser

from django.contrib.auth import authenticate, login
from rest_framework.authtoken.models import Token
from rest_framework.permissions import AllowAny
from rest_framework.status import HTTP_200_OK, HTTP_400_BAD_REQUEST


@api_view(['POST'])
@permission_classes((AllowAny,))
def create_user(request): # Create a new user
  try:
        data = {}
        serializer = UserSerializer(data=request.data) # Serialize the data
        if serializer.is_valid():
            if(CustomUser.objects.filter(username=serializer.validated_data['username']).exists()):
                data['status'] = 'failed'
                data['message'] = 'Username already exists'
                return Response(data, status=HTTP_400_BAD_REQUEST, headers={'Access-Control-Allow-Origin': '*'})
            account = serializer.save()
            account.save()
            token = Token.objects.get_or_create(user=account)[0].key
            data["message"] = "user registered successfully"
            data["email"] = account.email
            data["username"] = account.username
            data["token"] = token
            # Save the user and return the above info as response
            return Response(data, status=HTTP_200_OK, headers={'Access-Control-Allow-Origin': '*'})
        else:
            data = serializer.errors
            # return error message
            return Response(data, status=HTTP_400_BAD_REQUEST, headers={'Access-Control-Allow-Origin': '*'})
  except IntegrityError as e:
        account=CustomUser.objects.get(username='')
        account.delete()
        raise ValidationError({"400": f'{str(e)}'})

@api_view(["GET"])
@permission_classes((AllowAny,))
def get_user(request):
  data = {}
  # get the email and password from the request
  email1 = request.headers.get('Email')
  password = request.headers.get('Password')
  try:
    Account = CustomUser.objects.get(email=email1) # get the account with the given email
  except BaseException as e:
      return Response({"message": "No such email registered!!"}, status=HTTP_400_BAD_REQUEST, headers={'Access-Control-Allow-Origin': '*'})

  if (password!=Account.password): # compare the passwords
      return Response({"message": "Incorrect Login credentials"}, status=HTTP_400_BAD_REQUEST, headers={'Access-Control-Allow-Origin': '*'})

  # if the credentials are correct, return the token , role and username
  if Account:
    login(request, Account)
    data["message"] = "User logged in"
    data["email"] = Account.email
    token = Token.objects.get_or_create(user=Account)[0].key
    if(Account.is_student):
      role = "Student"
    else:
      role = "Teacher"
    Res = {"data": data, "token": token, "role": role, "username": Account.username}

    return Response(Res, content_type='application/json', status=HTTP_200_OK, headers={'Access-Control-Allow-Origin': '*'})

  else:
      return Response({"message": "Incorrect Login credentials"}, status=HTTP_400_BAD_REQUEST, headers={'Access-Control-Allow-Origin': '*'})
