import json
from django.shortcuts import render
from django.http import JsonResponse
from django.db import connection

# Create your views here.


def print_Donhang(request):
    cursor = connection.cursor()
    dataget = request.POST
    if dataget:
        if 'search' in dataget:
            cursor.execute('''SELECT* FROM Donhang WHERE MaDH = %s
            ''',[dataget['madh']])
            data = {
            'donhang' : cursor.fetchall(),
            }
        if 'xoa' in dataget:
            cursor.execute('''DELETE donhang WHERE MaDH = %s
            ''',[dataget['madonhangxoa']])
        if 'sua' in dataget:
            cursor.execute('''UPDATE donhang SET SDT = %s WHERE MaDH = %s
            ''',[dataget['SDT'], dataget['madonhangsua']])
    if not dataget or 'search' not in dataget:
        cursor.execute('''SELECT * FROM Donhang
        ''')
        data = {
            'donhang' : cursor.fetchall(),
        }
    return render(request,'cart/index.html',{'donhang': data})

def insert_Donhang(request):
    cursor = connection.cursor()
    data = request.POST
    if data:
        cursor.execute('''DECLARE @date DATE = GETDATE()
        EXEC insertOrder @date,%s,%s,%s,%s,10000,4,1,%s''',[data['tinh'], data['sonha'], data['tenduong'], data['huyen'], data['phone']])
    quanpro = request.POST
    return render(request,'cart/form.html')

