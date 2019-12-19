from django.db import models, connection
from django import forms

# Create your models here.
class NewsManager(models.Manager):

    def create_in_bulk(self, values):
        base_sql = "INSERT INTO dbo.Tintuc (Tieude, Loai, Thoigian, Noidung, IDNhanvien) VALUES "
        values_sql = []
        values_data = []

        for value_list in values:
            placeholders = ['%s' for i in range(len(value_list))]
            values_sql.append("(%s)" % ','.join(placeholders))
            values_data.extend(value_list)

        sql = '%s%s' % (base_sql, ', '.join(values_sql))

        curs = connection.cursor()
        curs.execute(sql, values_data)
    
    def select_news(self):
        base_sql = 'SELECT * FROM dbo.Tintuc'
        curs = connection.cursor()
        curs.execute(base_sql)
        return curs

class NewsObject(models.Model):
    # model definition as usual... assume:
    title = models.CharField(max_length=200)
    ntype = models.CharField(max_length=100)
    time = models.DateField()
    content = models.CharField(max_length=2000)
    staff_id = models.IntegerField()

    # custom manager
    objects = NewsManager()

class NewsModel(models.Model):
    nid = models.IntegerField()
    title = models.CharField(max_length=200)
    ntype = models.CharField(max_length=100)
    time = models.DateField()
    content = models.CharField(max_length=2000)
    staff_id = models.IntegerField()
    image = models.CharField(max_length=300)

    class Meta:  
        db_table = "news"
