from django.db import models
from django.contrib.auth.models import User
# Create your models here.

# Tables for the db

class Organization(models.Model):

    user = models.OneToOneField(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=255, null=True)
    email = models.CharField(max_length=255, null=True)
    phone = models.CharField(max_length=255, null=True)
    memberCount = models.IntegerField(null=True)
    services = models.CharField(max_length=255, null=True)
    address = models.CharField(max_length=255, null=True)
    city = models.CharField(max_length=255, null=True)
    district = models.CharField(max_length=255, null=True)

    def __str__(self):

        return "id : "+ str(self.id) + "," + self.name

class ServiceProviders(models.Model):

    organization = models.ForeignKey(Organization, on_delete=models.CASCADE)
    name = models.CharField(max_length=255, null=True)
    email = models.CharField(max_length=255, null=True)
    qualification = models.CharField(max_length=255, null=True)
    skills = models.CharField(max_length=255, null=True)
    availTime = models.CharField(max_length=255, null=True)
    phone = models.CharField(max_length=255, null=True)
    address = models.CharField(max_length=255, null=True)

    def __str__(self):

        return self.name + " => " + self.organization.name

class Customers(models.Model):

    user = models.OneToOneField(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=255, null=True)
    age = models.IntegerField(null=True)
    email = models.CharField(max_length=255, null=True)
    phone = models.CharField(max_length=255, null=True)
    address = models.CharField(max_length=255, null=True)
    district = models.CharField(max_length=255, null=True)
    city = models.CharField(max_length=255, null=True)

    def __str__(self):
        return self.name

class Appointment(models.Model):

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    organization = models.ForeignKey(Organization, on_delete=models.CASCADE)
    date = models.DateTimeField(null=True)

    def __str__(self):
        
        return f"{Customers.objects.get(user=self.user).name}'s Appointment at {self.date}"