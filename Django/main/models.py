from django.db import models
from django.contrib.auth.models import User
# Create your models here.

class Mobile_Registration(models.Model):

    user = models.OneToOneField(User, on_delete = models.CASCADE)
    name = models.CharField(max_length=255, null=True)
    age = models.IntegerField(null=True)
    email = models.CharField(max_length=255, null=True)
    mobile = models.CharField(max_length=255, null=True)

    def __str__(self):
        return f"{self.name}"