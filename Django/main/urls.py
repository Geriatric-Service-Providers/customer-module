from django.urls import path
from main import views as main_view

urlpatterns = [
    path("registration/", main_view.registration.as_view(), name="Registration"),
    path("login/", main_view.Login.as_view(), name="Login"),
]