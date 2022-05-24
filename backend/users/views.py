from django.db import IntegrityError
from django.forms import ValidationError
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from .serializers import UserSerializer
from .models import CustomUser

from django.contrib.auth import authenticate, login
from rest_framework.authtoken.models import Token
from rest_framework.permissions import AllowAny
from rest_framework.status import HTTP_200_OK


@api_view(['POST'])
@permission_classes((AllowAny,))
def create_user(request):
  # serializer = UserSerializer(data=request.data)
  # if serializer.is_valid():
  #   serializer.save()
  #   return Response(serializer.data)
  # return Response(serializer.errors)
  try:
        data = {}
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            print(serializer.validated_data)
            if(CustomUser.objects.filter(username=serializer.validated_data['username']).exists()):
                data['status'] = 'failed'
                data['message'] = 'Username already exists'
                return Response(data)
            account = serializer.save()
            account.save()
            token = Token.objects.get_or_create(user=account)[0].key
            data["message"] = "user registered successfully"
            data["email"] = account.email
            data["username"] = account.username
            data["token"] = token
        else:
            data = serializer.errors
        return Response(data)
  except IntegrityError as e:
        account=CustomUser.objects.get(username='')
        account.delete()
        raise ValidationError({"400": f'{str(e)}'})


@api_view(["GET"])
@permission_classes((AllowAny,))
def get_user(request):
  # username = request.data.get("username")
  # password = request.data.get("password")
  # if username is None or password is None:
  #   return Response({'error': 'Please provide both username and password'}, status=HTTP_400_BAD_REQUEST)
  # user = authenticate(username=username, password=password)
  # if not user:
  #   return Response({'error': 'Invalid Credentials'}, status= HTTP_404_NOT_FOUND)
  # token, _ = Token.objects.get_or_create(user=user)
  # return Response({'token': token.key}, status= HTTP_200_OK)
  data = {}
  # reqBody = json.loads(request.headers)
  email1 = request.headers.get('Email')
  password = request.headers.get('Password')
  try:
    Account = CustomUser.objects.get(email=email1)
  except BaseException as e:
      raise ValidationError({"400": f'{str(e)}'})
  token = Token.objects.get_or_create(user=Account)[0].key
  if (password!=Account.password):
      raise ValidationError({"message": "Incorrect Login credentials"})

  if Account:
    login(request, Account)
    data["message"] = "user logged in"
    data["email_address"] = Account.email

    Res = {"data": data, "token": token}

    return Response(Res, content_type='application/json', status=HTTP_200_OK)

  else:
      raise ValidationError({"400": f'Account doesnt exist'})
