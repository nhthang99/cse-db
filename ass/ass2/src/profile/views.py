import json
from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseRedirect
from django.db import connection
# Create your views here.

def manageAccount(request):
    cursor = connection.cursor()
    cursor.execute('EXEC View_pUser')
    if request.GET:
        getData =  request.GET
        print(getData)
        if 'update' in getData:
            if getData["updateID"] != '' and getData["updatePassword"] != '':
                cursor.execute('UPDATE pUser SET PasswordU = %s WHERE ID = %s',[getData["updatePassword"],getData["updateID"]])
                cursor.execute('EXEC View_pUser')
                data = {
                    'account' : cursor.fetchall(),
                }
                return render(request,'pages/manageAccount.html',{'thanh': data})
        if 'delete' in getData:
            if getData["deleteType"] != '' and getData["deleteContent"] != '':
                if getData["deleteType"] == 'ID':
                    cursor.execute('DELETE pUser WHERE ID = %s',[getData["deleteContent"]])
                    cursor.execute('EXEC View_pUser')
                    data = {
                        'account' : cursor.fetchall(),
                    }
                    return render(request,'pages/manageAccount.html',{'thanh': data})
                if getData["deleteType"] == 'Tên':
                    cursor.execute('DELETE pUser WHERE Ten = %s',[getData["deleteContent"]])
                    cursor.execute('EXEC View_pUser')
                    data = {
                        'account' : cursor.fetchall(),
                    }
                    return render(request,'pages/manageAccount.html',{'thanh': data})
                if getData["deleteType"] == 'Username':
                    cursor.execute('DELETE pUser WHERE UsenameU = %s',[getData["deleteContent"]])
                    cursor.execute('EXEC View_pUser')
                    data = {
                        'account' : cursor.fetchall(),
                    }
                    return render(request,'pages/manageAccount.html',{'thanh': data})
    data = {
        'account' : cursor.fetchall(),
    }
    return render(request,'pages/manageAccount.html',{'thanh': data})

def searchAccount(request):
    data = request.GET
    if request.GET:
        if data["content"] == '' and data["type"] == '':
            cursor = connection.cursor()
            cursor.execute('SELECT * FROM pUser')
            data = {
                'account' : cursor.fetchall(),
            }
            return render(request,'pages/resultSearchAccount.html',{'thanh': data})
        elif data["type"] == 'ID':
            cursor = connection.cursor()
            cursor.execute('SELECT * FROM pUser WHERE ID = %s',[data["content"]])
            data = {
                'account' : cursor.fetchall(),
            }
            return render(request,'pages/resultSearchAccount.html',{'thanh': data})
        elif data["type"] == 'Tên':
            cursor = connection.cursor()
            cursor.execute('SELECT * FROM pUser WHERE Ten = %s',[data["content"]])
            data = {
                'account' : cursor.fetchall(),
            }
            return render(request,'pages/resultSearchAccount.html',{'thanh': data})
        elif data["type"] == 'Giới tính':
            cursor = connection.cursor()
            cursor.execute('SELECT * FROM pUser WHERE GioiTinh = %s',[data["content"]])
            data = {
                'account' : cursor.fetchall(),
            }
            return render(request,'pages/resultSearchAccount.html',{'thanh': data})
        elif data["type"] == 'Username':
            cursor = connection.cursor()
            cursor.execute('SELECT * FROM pUser WHERE UsenameU = %s',[data["content"]])
            data = {
                'account' : cursor.fetchall(),
            }
            return render(request,'pages/resultSearchAccount.html',{'thanh': data})
    return render(request,'pages/searchAccount.html')