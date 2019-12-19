from django.shortcuts import render, redirect
from django.db import connection
from django.http import HttpResponse

# Create your views here.
def index(request):
    news = None
    with connection.cursor() as curs:
        news = curs.execute("EXEC [dbo].[ShowNewsAndImages]")
        news = news.fetchall()

    if request.GET:
        if 'add' in request.GET:
            data = (
            request.GET['title'], 
            request.GET['type'],
            request.GET['time'],
            request.GET['content'],
            request.GET['staff_id']
        )
            # NewsObject.objects.create_in_bulk([data])
            with connection.cursor() as curs:
                query = "EXEC [dbo].[InsertNews] N'{}', N'{}', '{}', N'{}', {}".format(data[0], data[1], data[2], data[3], data[4])
                curs.execute(query)
            return redirect('news')

        elif 'search' in request.GET:
            with connection.cursor() as curs:
                query = "SELECT * FROM dbo.searchTitleNews(N'{}', getdate() - 1, getdate() + 5)".format(request.GET['keyword'])
                data = curs.execute(query)
                data = data.fetchall()
            return render(request, 'news/search.html', {'news_search': data})

        elif 'edit' in request.GET:
            return redirect('show')


    args = {
        'news': news,
    }
    return render(request, 'news/index.html', args)

def search(request, news_search):
    return render(request, 'news/search.html', {'news_search': news_search})

def show(request):  
    news = None
    with connection.cursor() as curs:
        news = curs.execute("SELECT * FROM dbo.Tintuc")
        news = news.fetchall()

    return render(request,"news/show.html", {'news': news})  
    
def edit(request, id):  
    if request.POST:
        data = (
            request.POST['nid'],
            request.POST['title'], 
            request.POST['ntype'],
            request.POST['time'],
            request.POST['content'],
            request.POST['staff_id']
        )
        with connection.cursor() as curs:
            query = "UPDATE dbo.TinTuc SET \
            Tieude = N'{}',                        \
            Loai = N'{}',                          \
            Thoigian = '{}',                      \
            Noidung = N'{}',                       \
            IDNhanVien = {}                    \
            WHERE MaBV = '{}'".format(data[1], data[2], data[3], data[4], data[5], id)
            curs.execute(query)
        return redirect('show')

    news = None
    with connection.cursor() as curs:
        id_top = curs.execute("SELECT TOP 1 MaBV FROM dbo.Tintuc WHERE Thoigian <= GETDATE()")
        id_top = id_top.fetchall()[0][0]
        news = curs.execute("EXEC [dbo].[ShowNews]")
        news = news.fetchall()
        id = id - id_top
    return render(request,'news/edit.html', {'news': news[id]})

def delete(request, id):
    with connection.cursor() as curs:
        curs.execute("DELETE FROM dbo.Tintuc WHERE MaBV = {}".format(id))
    
    return redirect('show')