from django.urls import path
import attendance.views as views
urlpatterns = [
  path("mark-attendance/", views.mark_attendance),
  path("get-attendance/", views.get_attendance),
  path("submit-face/", views.submit_face),
  path("get-students/", views.get_students),
]