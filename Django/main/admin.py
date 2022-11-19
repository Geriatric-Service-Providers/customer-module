from django.contrib import admin
from . models import Organization, ServiceProviders, Customers, Appointment
# Register your models here.

admin.site.register(ServiceProviders, "")

admin.site.register(Customers, "")

admin.site.register(Appointment, "")

admin.site.register(Organization, "")