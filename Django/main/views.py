import json
from django.contrib.auth.models import User
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework import status
from rest_framework.views import APIView
from django.contrib.auth import authenticate
from .models import Organization, Customers, ServiceProviders, Appointment
from django.db.models import Q
# Create your views here.

# Registration 2 types customer, service provider

class Registration(APIView):

    def post(self, request):

        try:

            data = json.loads(request.body.decode('utf-8'))
            
            regType = data['userType']

            if regType == 'organization':

                phone, password = data['phone'], data['password']

                user = User.objects.create_user(username=phone, password=password)

                name, email, memberCount, services, address, city, district = data.get('name'), data.get('email'), data.get('memberCount'), data.get('services'), data.get('address'), data.get('city'), data.get('district')

                # Insert organization details to db
                
                organization = Organization.objects.create(user=user, name=name, phone = phone, email=email, memberCount = memberCount, services = services, address=address, city=city, district=district)

                # Insert members into service provider table
                
                for i in data.get('members'):

                    ServiceProviders.objects.create(organization = organization, name = i.get('name'), email = i.get('email'), qualification = i.get('qualification'), skills = i.get('skills'), availTime = i.get('availTime'), phone = i.get('phone'), address = i.get('address'))

                return Response({'message':'Organization Signup Successfull'})

            elif regType == 'customer':

                phone, password = data['phone'], data['password']

                user = User.objects.create_user(username=phone, password=password)

                name, age, email, district, city = data.get('name'), data.get('age'), data.get('email'), data.get('district'), data.get('city')

                # Adding customers into customer table
                
                Customers.objects.create(user=user, name=name, age=age, email=email, phone=phone, district=district, city=city)

                return Response({'message':'Customer Signup Successfull'})

        except Exception as e:

            return Response({'message':'Error, ' + str(e)})


class Login(APIView):

    def post(self, request):

        data = json.loads(request.body.decode('utf-8'))

        username, password, loginType = data['username'], data['password'], data['loginType']

        user = authenticate(request, username = username, password = password)

        if user:

            if loginType == 'organization':

                refresh = RefreshToken.for_user(user)

                user = Organization.objects.get(user = user)

                return Response({
                    'message':'Login Successfull',
                    'username':user.name,
                    'access':str(refresh.access_token)
                })

            elif loginType == 'customer':

                refresh = RefreshToken.for_user(user)

                user = Customers.objects.get(user = user)

                return Response({
                    'message':'Login Successfull',
                    'username':user.name,
                    'access':str(refresh.access_token)
                })
                
        return Response({'message':'Login Failed'}, status = status.HTTP_500_INTERNAL_SERVER_ERROR)

# Flutter dashboard filter based on location api

class Dashboard(APIView):

    def serializeProviders(self):

        filteredOrganizations = []

        for organization in self.by_city:

            filteredOrganizations.append({
                'id':organization.id,
                'name':organization.name,
                'email':organization.email,
                'phone':organization.phone,
                'services':organization.services,
                'address':organization.address,
                'city':organization.city,
                'address':organization.address
            })

        for organization in self.by_district:

            filteredOrganizations.append({
                'id':organization.id,
                'name':organization.name,
                'email':organization.email,
                'phone':organization.phone,
                'services':organization.services,
                'address':organization.address,
                'city':organization.city,
                'address':organization.address
            })

        return filteredOrganizations

    def get(self, request):

        if request.GET.get('page') == 'home':

            user = Customers.objects.get(user = request.user)

            district, city = user.district, user.city

            # Filtering based on city

            self.by_city =  Organization.objects.filter(city = city)

            # Filtering based on district eliminating city

            self.by_district = Organization.objects.filter(~Q(city=city), district = district)

            return Response(self.serializeProviders())

        elif request.GET.get('page') == 'detail':

            organizationId = request.GET.get('id')

            organization = Organization.objects.get(id = organizationId)

            members = []

            for serviceProvider in ServiceProviders.objects.filter(organization = organization):

                members.append(
                    {
                        'name':serviceProvider.name,
                        'email':serviceProvider.email,
                        'qualification':serviceProvider.qualification,
                        'skills':serviceProvider.skills,
                        'availTime':serviceProvider.availTime,
                        'phone':serviceProvider.phone,
                        'address':serviceProvider.address
                    }
                )

            return Response(members)

# Get Member details for a given organziation

class Members(APIView):

    def post(self, request):

        organization = Organization.objects.get(user = request.user)

        serviceProviders = ServiceProviders.objects.filter(organization = organization)

        members = []

        for i in serviceProviders:

            members.append({
                "name":i.name,
                "qualification":i.qualification,
                "phone":i.phone
            })

        return Response(members)

# Appointment API Endpoint

class Appointments(APIView):

    # for Flutter

    def post(self, request):

        data = json.loads(request.body.decode('utf-8'))

        user = Customers.objects.get(user = request.user).user

        date, organization_id = data['date'], data['organization']

        # filter organization from the organization table

        organization = Organization.objects.get(id = organization_id)

        Appointment.objects.create(user = user, organization = organization, date = date)

        return Response({'message':'Appointment Booked Successfully'})

    # For Web

    def get(self, request):

        appointments = []

        organization = Organization.objects.get(user = request.user)

        for i in Appointment.objects.filter(organization = organization):

            user = Customers.objects.get(user = i.user)

            appointments.append({
                'user':user.name,
                'phone':user.phone,
                'city':user.city,
                'date':i.date,
            })

        return Response({'message':'Appointments List', 'data':appointments})