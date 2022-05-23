from django.urls import path
import users.views as views
urlpatterns = [
  path("login/", views.get_user),
  path('signup/', views.create_user),
]