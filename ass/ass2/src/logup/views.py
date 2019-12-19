from django.shortcuts import render
from django.db import connection

# Create your views here.

def logup(request):
    cursor = connection.cursor()
    if request.GET:
        data = request.GET
        cursor.execute("exec Insert_pUser %s, %s, %s, %s, %s, %s, %s, %s",[data["Ho"],data["Ten"],data["TenDuong"],data["SoNha"],data["TinhTP"],data["GioiTinh"],data["Username"],data["Password"]])
        #return render(request,'pages/manageAccount.html')
        cursor = connection.cursor()
        cursor.execute('SELECT * FROM pUser')
        data = {
            'account' : cursor.fetchall(),
        }
        return render(request,'pages/manageAccount.html',{'thanh': data})
    return render(request,'logup/logup.html')