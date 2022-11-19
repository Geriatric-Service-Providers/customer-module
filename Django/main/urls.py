from django.urls import path, include
from main import views as mainView

urlpatterns = [
    path("registration/", mainView.Registration.as_view(), name="Registration"),
    path("login/", mainView.Login.as_view(), name="Login"),
    path("dashboard/", mainView.Dashboard.as_view(), name = "Dashboard"),
    path("book/", mainView.Appointments.as_view(), name="Book Appointment"),
    path("members/", mainView.Members.as_view(), name="Members List")
]