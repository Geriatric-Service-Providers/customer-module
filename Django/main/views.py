import requests
import json
from django.contrib.auth.models import User
from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.views import APIView
from django.contrib.auth import authenticate
from .models import Mobile_Registration
# Create your views here.

class registration(APIView):

    def post(self, request):

        data = json.loads(request.body.decode('utf-8'))
        
        name, age, email, mobile, username, password = data['name'], data['age'], data['email'], data['mobile'], data['username'], data['password']

        user = User.objects.create_user(username=username, password=password, is_active=False)

        user = Mobile_Registration.objects.create(name=name, age = age, email = email, mobile = mobile, user = user)

        return Response({"message":"Signup Successfull"})

class Login(APIView):

    def post(self, request):

        data = json.loads(request.body.decode('utf-8'))

        username, password = data['username'], data['password']

        user = authenticate(request, username = username, password = password)

        if user:

            return Response({"message":"Login Successfull"})

        return Response({"message":"Login Failed"})