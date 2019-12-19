from django.shortcuts import render, redirect
from django.db import connection

# Create your views here.
def login(request):
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM pUser")
    dataList = []
    for row in cursor:
        dataList.append(row)
    login = request.GET
    if request.GET:
        for row in dataList:
            if login["Username"] == row[7] and login["Password"] == row[8]:
                return render(request,'login/login.html')

    return render(request,'login/login.html')