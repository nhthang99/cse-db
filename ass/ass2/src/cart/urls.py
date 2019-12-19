from django.conf.urls import url
from django.urls import path
from cart import views
from django.conf.urls.static import static
from django.conf import settings

urlpatterns = [
    path('',views.print_Donhang),
    path('insert/',views.insert_Donhang),
]