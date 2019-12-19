import json
from django.http import JsonResponse
from django.shortcuts import render
from django.db import connection
    


def homeUI(request):
    # with connection.cursor() as check:
    check = connection.cursor()
    check.execute('SELECT Mon.*, Hinh.HinhAnh FROM dbo.Mon, (SELECT TenMon, MIN(HinhAnh) HinhAnh FROM dbo.HinhAnhMon GROUP BY TenMon) Hinh WHERE Mon.TenMon = Hinh.TenMon')
    data = {
        'mon': check.fetchall(),
    }
    return render(request, 'home/home.html', {'da': data})

def addDrink(request):
    return render(request, 'home/addDrink.html')

def addDrink_request(request):
    check = connection.cursor()
    check.execute('SELECT Mon.*, Hinh.HinhAnh FROM dbo.Mon, (SELECT TenMon, MIN(HinhAnh) HinhAnh FROM dbo.HinhAnhMon GROUP BY TenMon) Hinh WHERE Mon.TenMon = Hinh.TenMon')
    menu = check.fetchall()
    check.execute('SELECT Loai FROM dbo.mon GROUP BY Loai')
    ptype = check.fetchall()
    data = {
        'mon': menu,
        'type': ptype
    }
    return JsonResponse(data)

def changedata(request):
    check = connection.cursor()
    dataget = request.POST
    check.execute('SELECT Mon.*, Hinh.HinhAnh FROM dbo.Mon, (SELECT TenMon, MIN(HinhAnh) HinhAnh FROM dbo.HinhAnhMon GROUP BY TenMon) Hinh WHERE Mon.TenMon = Hinh.TenMon AND Mon.TenMon = %s', [dataget['name']])
    menu = check.fetchall()
    check.execute('SELECT Loai FROM dbo.mon GROUP BY Loai')
    ptype = check.fetchall()
    data = {
        'mon': menu,
        'type': ptype
    }
    return JsonResponse(data)

def change(request):
    check = connection.cursor()
    dataget = request.POST
    check.execute('''UPDATE dbo.Mon SET TenMon = %s, Soluongban = %s, Loai = %s WHERE TenMon = %s''', [dataget['name'], dataget['amount'], dataget['type'], dataget['key']])
    data = {
        'success': 1
    }
    return JsonResponse(data)

def addDrink_add(request):
    check = connection.cursor()
    dataget = request.POST
    check.execute('''EXEC Insert_Mon %s, %s, %s''', [dataget['name'], dataget['amount'], dataget['type']])
    check.execute('''INSERT INTO dbo.HinhAnhMon VALUES (%s, %s)''', [dataget['name'], dataget['image']])
    data = {
        'success': 1
    }
    return JsonResponse(data)

def delDrink_del(request):
    check = connection.cursor()
    dataget = request.POST
    listDel = list(dataget['name'].split(","))
    for i in listDel:
        check.execute("""DELETE FROM dbo.HinhAnhMon WHERE TenMon = %s""", [i])
        check.execute("""DELETE FROM dbo.pOption WHERE TenMon = %s""", [i])
        check.execute("""DELETE FROM dbo.DonHangGom WHERE TenMon = %s""", [i])
        check.execute("""DELETE FROM dbo.Mon WHERE TenMon = %s""", [i])
    data = {
        'success': 1
    }
    return JsonResponse(data)

def test2(request):
    return render(request, 'home/test2.html')
