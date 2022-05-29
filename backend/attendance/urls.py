from django.urls import path
import attendance.views as views
urlpatterns = [
  path("mark-attendance/", views.mark_attendance), # recieves face and check if it matches with any of the students, if yes then mark their attendance
  path("get-attendance/", views.get_attendance), # get attendance for a particular student
  path("submit-face/", views.submit_face), # recieves face and save it
  path("get-students/", views.get_students), # get all students
]