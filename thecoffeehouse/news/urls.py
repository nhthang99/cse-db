from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='news'),
    path('show/', views.show, name="show"),
    path('edit/<int:id>', views.edit),
    path('delete/<int:id>', views.delete)
]