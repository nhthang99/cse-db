from django.conf.urls import url
from django.urls import path
from home import views
from django.conf.urls.static import static
from django.conf import settings

urlpatterns = [
    path('', views.homeUI),
    path('test2/', views.test2),
    path('addDrink/', views.addDrink),
    path('addDrink/request/', views.addDrink_request),
    path('addDrink/add/', views.addDrink_add),
    path('addDrink/changedata/', views.changedata),
    path('addDrink/change/', views.change),
    path('addDrink/del/', views.delDrink_del)
]